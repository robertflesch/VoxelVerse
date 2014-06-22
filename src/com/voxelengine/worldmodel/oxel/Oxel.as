/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.oxel
{
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	import flash.utils.getTimer;

	import com.developmentarc.core.tasks.tasks.ITask;
	import com.developmentarc.core.tasks.groups.TaskGroup;
	
	import flash.display3D.Context3D;
	import flash.geom.Vector3D;
	import flash.utils.ByteArray;
	import flash.geom.Matrix3D;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.events.ImpactEvent;
	import com.voxelengine.utils.Plane;
	import com.voxelengine.renderer.VertexIndexBuilder;
	import com.voxelengine.renderer.VertexManager;
	import com.voxelengine.renderer.Quad;
	import com.voxelengine.renderer.shaders.Shader;
	import com.voxelengine.pools.*;
	import com.voxelengine.worldmodel.InteractionParams;
	import com.voxelengine.worldmodel.TypeInfo;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.models.ModelStatisics;
	import com.voxelengine.worldmodel.models.EditCursor;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.tasks.landscapetasks.TreeGenerator;
	import com.voxelengine.worldmodel.tasks.lighting.LightRemove;
	import com.voxelengine.worldmodel.tasks.lighting.LightAdd;
	import com.voxelengine.worldmodel.tasks.flowtasks.Flow;
	import com.voxelengine.worldmodel.tasks.flowtasks.FlowFlop;

	/**
	 * ...
	 * @author Robert Flesch RSF Oxel - An OctTree / Voxel - model
	 */
	public class Oxel extends OxelData
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     Static Variables
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		private static const OXEL_CHILD_COUNT:int = 8;
		
		private static		const ALL_NEGZ_CHILD:uint						= 0x0f;
		private static		const ALL_POSZ_CHILD:uint						= 0xf0;
		private static		const ALL_NEGY_CHILD:uint						= 0x33;
		private static		const ALL_POSY_CHILD:uint						= 0xcc;
		private static		const ALL_NEGX_CHILD:uint						= 0x55;
		private static		const ALL_POSX_CHILD:uint						= 0xaa;
		
		private static		const MAX_BUILD_TIME:int                           	= 14000;
		
		static private 		var _s_scratchGrain:GrainCursor 				= new GrainCursor();
		static private 		var _s_scratchVector:Vector3D 					= null;
		static private 		var _s_oxelIntersections:Vector.<Oxel> 			= new Vector.<Oxel>; // used to filter oxels already tested in raycast

		// How do I manage this for unique values for each face?
		static private 		var _s_nodes:int 								= 0;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     Member Variables
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _gc:GrainCursor 			= null; // Object that give us our location allocates memory for the grain
		private var _parent:Oxel 				= null;	// passed to use when created
		private var _children:Vector.<Oxel> 	= null; // These are created when needed
		private var _neighbors:Vector.<Oxel>	= null;	// 8 children but 6 neighbors, created when needed
		private var _quads:Vector.<Quad> 		= null;	// Quads that are drawn on card, created when needed
		private var _vertMan:VertexManager 		= null;  // created when needed
		private var _brightness:Brightness		= null;
		private var _flowInfo:FlowInfo 			= null; // used to count up and out in flowing oxel ( only uses 2 bytes, down, out )
		override public function set dirty( $isDirty:Boolean ):void { 
			super.dirty = $isDirty;
			if ( $isDirty )
			{
				// recursively mark all the parents as dirty
				if ( _parent && !_parent.dirty ) 
					_parent.dirty = true;
			}
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     Getters/Setters
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function get quads():Vector.<Quad> { return _quads; }
		public function get children():Vector.<Oxel> { return _children; }

		// Type is stored in the lower 2 bytes ( or 1 ) of the _data variable
		// TODO, I am using 16 bits here, I think the dirty faces are using some of these already.
		// need to reduce it down to 10 bits
		override public function set type( $val:int ):void { 
			// Make sure its not the same as current type
			if ( $val != type ) 
			{
				if ( Globals.INVALID == $val )
				{
					Log.out( "Oxel.type - Trying to set type on oxel to INVALID" );
					return;
				}
				if ( childrenHas() && Globals.AIR != $val )
					Log.out( "Oxel.type - Trying to set type on oxel with children" );
					
				// uses the OLD type since _data has not been set yet
				if ( Globals.AIR != type )
					vertManRemoveOxel();
				
				super.type = $val;
				
				if ( Globals.AIR == $val ) 
				{
					faces_clean_all_face_bits();
					// Todo - this CAN leave behind empty oxels, need to add some kind of flag or check for them.
					//if ( _parent ) 
					//	return _parent.mergeRecursive()					
				}
				else
					faces_mark_all_dirty();
			}
		}

		public function get gc():GrainCursor { return _gc; }
		public function set gc(val:GrainCursor):void { _gc = val; throw new Error( "Oxel - trying to assign new GC to existing" ); }
		
		// Using a static here since I dont want to carry around the huge guid string with each oxel
		// Am I being penny wise and pound foolish??? RSF
		
		static public function get nodes():int { return _s_nodes; }
		static public function set nodes(value:int):void { _s_nodes = value; }
		
		public function get flowInfo():FlowInfo { return _flowInfo; }
		public function set flowInfo(value:FlowInfo):void { _flowInfo = value; }
		
		public function get brightness():Brightness { return _brightness; }
		public function set brightness(value:Brightness):void { _brightness = value; }
		
		public function get parent():Oxel { return _parent; }
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     End Online liners
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function vm_get():VertexManager { return _vertMan ? _vertMan : _parent ? _parent.vm_get() : null; }
		
		public function vm_initialize( $stats:ModelStatisics ):void {
			if ( null == _parent )
			{
				//Log.out( "Oxel.vm_initialize - This should only happen ONCE PER MODEL --------------------------------------" );
				_vertMan = new VertexManager();
				// Only set minGrain for root oxel
				if ( 8 < gc.bound  )
				{
					if ( 4 <= $stats.range )
						_vertMan.minGrain = $stats.largest; 
						// TODO I still dont like how this causes delay if too large.
						// On g12 island, if 
						//minGrain is 10
						//VoxelVerse.enterFrame - update time: 16
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 34800(98280)  _vertices:278400(786240)  quadsToProcess: 16380  took: 37
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 24222(98280)  _vertices:193776(786240)  quadsToProcess: 16380  took: 27
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 25458(98280)  _vertices:203664(786240)  quadsToProcess: 16380  took: 30
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 27792(98280)  _vertices:222336(786240)  quadsToProcess: 16380  took: 31
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 33504(98280)  _vertices:268032(786240)  quadsToProcess: 16380  took: 70
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 1164(2016)  _vertices:9312(16128)  quadsToProcess: 336  took: 6
						//VertexIndexBuilder.buffersBuildFromOxels -  processed 13706 oxels  took: 222
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 354(828)  _vertices:2832(6624)  quadsToProcess: 138  took: 1
						//VertexIndexBuilder.buffersBuildFromOxels -  processed 23 oxels  took: 3
						//VoxelVerse.enterFrame - render time: 231
						//VoxelVerse.enterFrame - total time: 250
						//
						//minGrain is 9
						//VoxelVerse.enterFrame - update time: 16
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 30744(98280)  _vertices:245952(786240)  quadsToProcess: 16380  took: 35
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 24918(98280)  _vertices:199344(786240)  quadsToProcess: 16380  took: 28
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 26352(98280)  _vertices:210816(786240)  quadsToProcess: 16380  took: 31
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 14352(47268)  _vertices:114816(378144)  quadsToProcess: 7878  took: 38
						//VertexIndexBuilder.buffersBuildFromOxels -  processed 9503 oxels  took: 144
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 510(1152)  _vertices:4080(9216)  quadsToProcess: 192  took: 6
						//VertexIndexBuilder.buffersBuildFromOxels -  processed 32 oxels  took: 8
						//VoxelVerse.enterFrame - render time: 159
						//VoxelVerse.enterFrame - total time: 179
						//
						// minGrain is 8
						//VoxelVerse.enterFrame - update time: 19
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 4362(13536)  _vertices:34896(108288)  quadsToProcess: 2256  took: 6
						//VertexIndexBuilder.buffersBuildFromOxels -  processed 376 oxels  took: 8
						//VertexIndexBuilder.quadsCopyToBuffers - _offsetIndices: 384(900)  _vertices:3072(7200)  quadsToProcess: 150  took: 1
						//VertexIndexBuilder.buffersBuildFromOxels -  processed 25 oxels  took: 3
						//VoxelVerse.enterFrame - render time: 22
						//VoxelVerse.enterFrame - total time: 46
						
					else
						_vertMan.minGrain = $stats.rootSize;
				}

				else
				{
					if ( 11 < gc.bound )
						_vertMan.minGrain = gc.bound - 2;
				}
			}
			else if ( vm_get() )
			{
				// If this is exactly the same size the the min grain, then give it it's own vertexManager
				if ( vm_get().minGrain == gc.grain )
				{
					// We should inherit the min grain size from our parent
					var minGrain:int = vm_get().minGrain
					//Log.out( "Oxel.vm_initialize - Grabbing sub vertex manager: gc.grain: " + gc.grain + "  vm_get().minGrain: " + vm_get().minGrain );
					_vertMan = new VertexManager();
					_vertMan.minGrain = minGrain;
				}
			}		
		}

		// This defines a one (1) meter cube in world
		public function size_in_world_coordinates():uint { return GrainCursor.get_the_g0_size_for_grain(gc.grain); }
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     Member Functions 
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get hasAlpha():Boolean { return Globals.hasAlpha( type ); }
		public function get isFlowable():Boolean { return Globals.Info[type].flowable; }
		public function get isSolid():Boolean { return Globals.Info[type].solid; }
		public function get isLight():Boolean { return Globals.Info[type].light; }
		
		// Intentionally empty, since these are allocated enmase in pool
		public function Oxel() {
		}
		
		public function validate():void
		{
			// validate gc?
			if ( childrenHas() )
			{
				if ( Globals.AIR != type )
					throw new Error( "Oxel.validate - Bad type for parent" );
				// what else needs to be true for a parent?	
				for each ( var child:Oxel in children )
				{
					if ( null == child )
						throw new Error( "Oxel.validate - null child" );
					
					child.validate();
				}
			}
			else
			{
				// type is valid
				// flow for correct types
				// brightness if needed
				Log.out("Oxel.validate - need checks" );
			}
		}
		
		// release all vertex buffer assests and send back to the pool
		public function release():void	{
			//trace( "Oxel.release" + gc.toString() );

			_flowInfo = null; // might need a pool for these.
			if ( _brightness ) { 
				BrightnessPool.poolReturn( _brightness );
				_brightness = null;
			}
			
			// kill any existing family, you can be parent type OR physical type, not both
			if ( childrenHas() )
			{
				// If there are children, then the neighbors might point to the children
				// Since they are being deleted, we have to make sure any pointers to them are removed.
				childrenPrune();
			}
			
			// removes all quad and the quads vector
			// removed the brightness
			vertManRemoveOxel();
			
			if ( _vertMan )
			{
				_vertMan.release();
				_vertMan = null;
			}

			if ( gc )
			{
				GrainCursorPool.poolDispose( gc );
				_gc = null;
			}
			
			resetData();
			_parent = null;
			if ( _neighbors )
			{
				NeighborPool.poolDispose( _neighbors );
				_neighbors = null;
			}
			OxelPool.poolDispose( this );
		}
		
		// This is used to initialize all oxel nodes that are read from the byte array
		public function initialize( $parent:Oxel, $gc:GrainCursor, $byteData:uint, $stats:ModelStatisics ):void {

			_parent = $parent;
			dataRaw = $byteData;
			_gc = GrainCursorPool.poolGet( $gc.bound );
			_gc.copyFrom( $gc );
			
			if ( facesHas() )
				dirty = true;
				
			if ( Globals.Info[type].flowable )
			{
				if ( $parent.flowInfo )
					flowInfo = $parent.flowInfo.clone();
				else
					flowInfo = Globals.Info[type].flowInfo.clone();
			}
				
			if ( $stats )
				vm_initialize( $stats );
		}
		
		// This is used to initialize all oxel nodes that are read from the byte array
		public function initializeVersionedData( $version:String, $parent:Oxel, $gc:GrainCursor, $byteData:uint, $stats:ModelStatisics ):void {

			if ( $version == Globals.VERSION_003 || $version == Globals.VERSION_002 || $version == Globals.VERSION_001 || $version == Globals.VERSION_000 )
			{
				initialize( $parent, $gc, $byteData, $stats );	
				return;
			}
			throw new Error( "Oxel.initialVersionedData - UNKNOWN VERSION" );
		}
		
		// This is used to initialize oxel nodes created via children create
		private function initializeAndMarkDirty( $parent:Oxel, $gc:GrainCursor, $byteData:uint, $stats:ModelStatisics ):void {
			initialize( $parent, $gc, $byteData, $stats );
			super.faces_mark_all_dirty();
			dirty = true;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Children function START
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/*
		// This function only finds within the children of the current oxel
		private function select_child( $gc:GrainCursor ):Oxel	{
			if ( false == childrenHas() )
				return Globals.BAD_OXEL;
				
			// WARNING: Using the gc_static, is_equal doesn't overwrite
			var kn:GrainCursor = $gc.get_ancestor( gc.grain - 1 - $gc.grain );
			for each ( var child:Oxel in _children ) 
			{
				if ( kn.is_equal( child.gc ) ) 
					return child;
			}
			return Globals.BAD_OXEL;
		}
		*/
		public function childGetOrCreate( $gc:GrainCursor ):Oxel {
			if ( !$gc.is_inside( gc ) )
				return Globals.BAD_OXEL;
				
			if ( $gc.is_equal( gc ) )
				return this;
				
			if ( !childrenHas() )
			{
				// become octa-mom
				childrenCreate();
			}
			
			for each ( var child:Oxel in _children )
			{	
				if ( $gc.is_equal( child.gc ) )
					return child;
				if ( $gc.is_inside( child.gc ) )
					return child.childGetOrCreate( $gc );
			}

			return Globals.BAD_OXEL;
		}

		// find locates a oxel within a tree
		// return can be 
		// 1) the oxel bring searched for ( is_equal )
		// 2) parent oxel that contains the searched for oxel ( is_inside )
		// 3) BAD_OXEL - not found for some reason
		
		// this could be called childGetClosest
		public function childFind( $gc:GrainCursor ):Oxel {
			if ( $gc.grain > gc.grain )
			{
				throw new Error("Looking for a larger grain within a smaller grain");
				return Globals.BAD_OXEL;
			}
				
			if ( $gc.is_equal( gc ) ) 
				return this;

			if ( 0 == gc.grain || $gc.grain == gc.grain )
				return Globals.BAD_OXEL;
			
			for each ( var child:Oxel in _children ) 
			{
				if ( $gc.is_equal( child.gc ) )
					return child;
				if ( $gc.is_inside( child.gc ) ) 
					return child.childFind( $gc );
			}
			
			// $gc is inside of a grain that doesnt have children at that level, so return the topmost grain that holds that child
			if ( $gc.is_inside( gc ) )
				return this;

			return Globals.BAD_OXEL;
		}
		
		
		// this get the children in that direction whether they exist or not. if not makes them
		public function childGetFromDirection( $dir:int, $level:int, opposite:Boolean ):Oxel {
			
			if ( !childrenHas() )
				childrenCreate();

			if ( opposite )
			{
				if ( 0 == $level )
				{
					if ( Globals.POSX == $dir )
						return _children[5];
					else if ( Globals.NEGX == $dir )
						return _children[0];
					else if ( Globals.POSZ == $dir )
						return _children[4];
					else if ( Globals.NEGZ == $dir )
						return _children[1];
				}
				else
				{
					if ( Globals.POSX == $dir )
						return _children[6];
					else if ( Globals.NEGX == $dir )
						return _children[3];
					else if ( Globals.POSZ == $dir )
						return _children[7];
					else if ( Globals.NEGZ == $dir )
						return _children[2];
				}
			}
			else 
			{
				if ( 0 == $level )
				{
					if ( Globals.POSX == $dir )
						return _children[1];
					else if ( Globals.NEGX == $dir )
						return _children[4];
					else if ( Globals.POSZ == $dir )
						return _children[5];
					else if ( Globals.NEGZ == $dir )
						return _children[0];
				}
				else
				{
					if ( Globals.POSX == $dir )
						return _children[3];
					else if ( Globals.NEGX == $dir )
						return _children[6];
					else if ( Globals.POSZ == $dir )
						return _children[7];
					else if ( Globals.NEGZ == $dir )
						return _children[2];
				}
			}
				
			return Globals.BAD_OXEL;
		}

		public function childrenForDirection( dir:int ):Vector.<Oxel> {
			
			if ( !childrenHas() )
				childrenCreate();

			var childrenDirectional:Vector.<Oxel> = new Vector.<Oxel>;
			var mask:uint = 0;
			if      ( Globals.POSX == dir )	mask = ALL_POSX_CHILD
			else if ( Globals.NEGX == dir ) mask = ALL_NEGX_CHILD
			else if ( Globals.POSY == dir ) mask = ALL_POSY_CHILD
			else if ( Globals.NEGY == dir ) mask = ALL_NEGY_CHILD
			else if ( Globals.POSZ == dir ) mask = ALL_POSZ_CHILD
			else if ( Globals.NEGZ == dir ) mask = ALL_NEGZ_CHILD

			for ( var i:int = 0; i < OXEL_CHILD_COUNT; i++)
			{
				if( mask & ( 1 << i ) ) // is bit i set
					childrenDirectional.push( _children[i] );
			}
			
			return childrenDirectional;
		}
		
		// Get just the IDs of the children in that direction, used in getting brightness
		static public function childIDsForDirection( dir:int ):Vector.<uint> {
			
			var childIDsDirectional:Vector.<uint> = new Vector.<uint>;
			var mask:uint = 0;
			if      ( Globals.POSX == dir )	mask = ALL_POSX_CHILD
			else if ( Globals.NEGX == dir ) mask = ALL_NEGX_CHILD
			else if ( Globals.POSY == dir ) mask = ALL_POSY_CHILD
			else if ( Globals.NEGY == dir ) mask = ALL_NEGY_CHILD
			else if ( Globals.POSZ == dir ) mask = ALL_POSZ_CHILD
			else if ( Globals.NEGZ == dir ) mask = ALL_NEGZ_CHILD

			for ( var i:int = 0; i < OXEL_CHILD_COUNT; i++)
			{
				if( mask & ( 1 << i ) ) // is bit i set
					childIDsDirectional.push( i );
			}
			
			return childIDsDirectional;
		}
		
		public function childrenHas():Boolean { return null != _children; }
		
		// this releases the children
		public function childrenPrune():void {
			if ( null != _children )
			{
				for  ( var i:int = 0; i < OXEL_CHILD_COUNT; i++ ) 
				{
					if ( children[i] )
					{
						children[i].release();
						children[i] = null;
					}
				}
				
				ChildOxelPool.poolReturn( _children );
				_children = null;
			}
			
			parentClear();
		}
		
		public function childrenCreate( $invalidateNeighbors:Boolean = true ):void {
			if ( childrenHas() )
			   return;

			//trace( "childrenCreate to grain: " + gc.grain+ " (" + gc.size() + ") to grain: " + (gc.grain- 1) + );
			_children = ChildOxelPool.poolGet();
			var gct:GrainCursor = GrainCursorPool.poolGet(root_get().gc.bound );

			for ( var i:int = 0; i < OXEL_CHILD_COUNT; i++ )
			{
				_children[i]  = OxelPool.poolGet();
				gct.copyFrom( gc );
				gct.become_child( i );   
				// this sets the RAW data, used here only sets the type
				_children[i].initializeAndMarkDirty( this, gct, type, null );
				if ( _brightness )
				{
					_children[i].brightness = BrightnessPool.poolGet();
					brightness.childGetAllLights( gct.childId(), _children[i].brightness );
					// child should attenuate light at same rate.
					_children[i].brightness.fallOffPerMeter = brightness.fallOffPerMeter;
				}
				// use the super so you dont start a flow event on flowable types.
				if ( Globals.GRASS == type )
					_children[i].type = Globals.DIRT;
			}

			this.parentMarkAs();
			// Dont do this when generating terrain
			if ( $invalidateNeighbors )
				this.neighborsInvalidate();
			this.type = Globals.AIR;
			this.dirty = true;

			GrainCursorPool.poolDispose( gct );
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Children function END
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// This only writes into empty voxel.
		public function write_empty( $guid:String, $gc:GrainCursor, $type:int ):Boolean {
			// have we arrived?
			if ( $gc.is_equal( gc ) )
			{			
				// this only writes into empty voxels
				if ( type != Globals.AIR )
					return true;
					
				// If we are not changing anything, head home.
				// RSF - This doesnt handle the grain size change done in editCursor
				if ( $type == type && $gc.bound == gc.bound && !childrenHas() )
					return true;
					
				// kill any existing family, you can be parent type OR physical type, not both
				if ( childrenHas() )
				{
					// If there are children, then the neighbors might point to the children
					// Since they are being deleted, we have to make sure any pointers to them are removed.
					childrenPrune();
					neighborsInvalidate();
				}
				
				// set our material type
				type = $type;
				
				faces_mark_all_dirty();
				return true;
			}
			
			var child:Oxel = childGetOrCreate( $gc );
			if ( Globals.BAD_OXEL == child )
				return false;
			
			return child.write_empty( $guid, $gc, $type );
			
		}
		
		private function writeInternal( $guid:String, $newType:int, $onlyChangeType:Boolean ):Oxel {
			
			// kill any existing family, you can be parent type OR physical type, not both
			if ( childrenHas() )
			{
				// If there are children, then the neighbors might point to the children
				// Since they are being deleted, we have to make sure any pointers to them are removed.
				childrenPrune();
				neighborsInvalidate();
			}
			
			// check current type
			if ( Globals.Info[type].light )
			{
				if ( "" == $guid )
					throw new Error( "Oxel.type - no active model guid" );
				if ( EditCursor.EDIT_CURSOR != $guid )
				{
					if ( null != brightness )
						LightRemove.addTask( $guid, gc, brightness.lightIDGet() );
					else
						throw new Error( "Oxel.type - no active model guid" );
					
					// TODO - dispatch event starting light regeneration from other lights
				}
			}
			
			if ( Globals.Info[$newType] )
			{
				if ( Globals.Info[$newType].flowable )
				{
					if ( null == _flowInfo ) // if it doesnt have flow info, get some! This is from placement of flowable oxels
					{
						_flowInfo = Globals.Info[$newType].flowInfo.clone();
					}
				}
				else
				{
					if ( Globals.getTypeId( "obsidian" ) != $newType )
						_flowInfo = null;  // If it has flow info, release it, no need to check first
				}
				
				//if ( Globals.Info[$newType].light )
				//{
					//if ( "" == $guid )
						//throw new Error( "Oxel.type - no active model guid" );
					//if ( EditCursor.EDIT_CURSOR != $guid )
					//{
						// keep any existing brightness Info
						//if ( !_brightness ) {
							//_brightness = BrightnessPool.poolGet();
							//_brightness.colorAdd(   );
						//}
					//}
				//}
			}
			else
				Log.out( "Oxel.writeInternal - No type information found for typeID: " + $newType, Log.ERROR );
			
			additionalDataClear();
			
			type = $newType;
			
			// This is only used by terrain builder scripts.
			if ( $onlyChangeType ) 
				return this;
			
			// anytime oxel changes, neighbors need to know
			neighborsMarkDirtyFaces( $guid );
			
			if ( Globals.AIR == type && _parent )
			{
				// make a copy since this oxel may be going away.
				var p:Oxel = _parent;
				if ( _parent.checkForMerge() )
					return p;
			}
			
			return this;
		}
		
		public function writeFromHeightMap( $gc:GrainCursor, $newType:int ):void {
			
			var co:Oxel = childGetOrCreate( $gc );
			super.type = $newType;
			dirty = true;
		}

		// This write to a child if it is a valid child of the oxel
		// if the child does not exist, it is created
		public function write( $guid:String, $gc:GrainCursor, $newType:int, $onlyChangeType:Boolean = false ):Oxel	{
			
			var co:Oxel = childGetOrCreate( $gc );
			if ( Globals.BAD_OXEL == co )
			{
				Log.out( "Oxel.write - cant find child!", Log.ERROR );
				return co;
			}
			
			if ( $newType == co.type && $gc.bound == co.gc.bound && !co.childrenHas() )
				return co;
				
			return co.writeInternal( $guid, $newType, $onlyChangeType );
		}
				
		public function dispose():void {
			if ( _vertMan )
			{
				_vertMan.dispose();
			}
			
			if ( vm_get().minGrain <= gc.grain )
			{
				if ( childrenHas() ) 
				{
					for each ( var cchild:Oxel in _children ) 
						cchild.dispose();
				}
			}
		}
		
		public function drawNew( $mvp:Matrix3D, $vm:VoxelModel, $context:Context3D, $shaders:Vector.<Shader>, $selected:Boolean, $isChild:Boolean ):void {
			if ( _vertMan )
			{
				_vertMan.drawNew( $mvp, $vm, $context, $shaders, $selected, $isChild );

				if ( _vertMan.minGrain < gc.grain )
				{
					for each ( var pchild:Oxel in _children )
						pchild.drawNew( $mvp, $vm, $context, $shaders, $selected, $isChild );
				}
			}
			else
			{
				if ( vm_get() && vm_get().minGrain < gc.grain )
				{
					for each ( var cchild:Oxel in _children ) 
						cchild.drawNew( $mvp, $vm, $context, $shaders, $selected, $isChild );
				}
			}		
			
		}
		
		public function drawNewAlpha( $mvp:Matrix3D, $vm:VoxelModel, $context:Context3D, $shaders:Vector.<Shader>, $selected:Boolean, $isChild:Boolean ):void	{
			if ( _vertMan )
			{
				_vertMan.drawNewAlpha( $mvp, $vm, $context, $shaders, $selected, $isChild );

				if ( _vertMan.minGrain < gc.grain )
				{
					for each ( var pchild:Oxel in _children )
						pchild.drawNewAlpha( $mvp, $vm, $context, $shaders, $selected, $isChild );
				}
			}
			else
			{
				if ( vm_get() && vm_get().minGrain < gc.grain )
				{
					for each ( var cchild:Oxel in _children ) 
						cchild.drawNewAlpha( $mvp, $vm, $context, $shaders, $selected, $isChild );
				}
			}		
			
		}
		
		public function mergeAndRebuild():void {
			var _timer:int = getTimer();
			Oxel.nodes = 0;
			mergeRecursive();
			Log.out("Oxel.mergeAndRebuild - merge took: " + (getTimer() - _timer) + " count " + Oxel.nodes );
			
			_timer = getTimer();
			Oxel.nodes = 0;
			mergeRecursive();
			Log.out("Oxel.mergeAndRebuild - merge 2 took: " + (getTimer() - _timer) + " count " + Oxel.nodes );
			
			_timer = getTimer();
			rebuildAll();
			Log.out("Oxel.mergeAndRebuild - rebuildAll took: " + (getTimer() - _timer));
		}
		
		public function mergeAirAndRebuild():void {
			var _timer:int = getTimer();
			Oxel.nodes = 0;
			mergeAirRecursive();
			Log.out("Oxel.mergeAirAndRebuild - merge took: " + (getTimer() - _timer) + " count " + Oxel.nodes );
			
			_timer = getTimer();
			rebuildAll();
			Log.out("Oxel.mergeAirAndRebuild - rebuildAll took: " + (getTimer() - _timer));
		}

		public function checkForMerge():Boolean	{
			const childType:uint = _children[0].type;
			var hasBrightnessData:Boolean = false;
			// see if all of the child are the same type of node
			for each ( var child:Oxel in _children ) 
			{
				if ( childType != child.type )
					return false; // Not the same, get out
				if ( child.childrenHas() )
					return false; // Dont delete parents!
				
				if ( null != child._brightness )
					hasBrightnessData = true;
			}
			
			//Log.out( "Oxel.merge - removed children with type: " + Globals.Info[child.type].name + " of grain: " + gc.grain );
			
			/// merge the brightness data into parent.
			if ( hasBrightnessData ) {
				if ( null == _brightness )
					_brightness = BrightnessPool.poolGet();
				for each ( var childForBrightness:Oxel in _children ) 
				{
					if ( childForBrightness._brightness ) {
						_brightness.childAddAll( childForBrightness.gc.childId(), childForBrightness._brightness, childForBrightness.gc.size() );
						// Need to set this from a valid child
						// Parent should have same brightness attn as children did.
						_brightness.fallOffPerMeter = childForBrightness.brightness.fallOffPerMeter;
					}
				}
			}
			nodes += 8;
			childrenPrune();
			neighborsInvalidate();
			
			if ( childType != type )
				type = childType;
				
			return true;	
		}
		
		public function mergeRecursive():Boolean {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in _children ) 
				{
					if ( child.mergeRecursive() )
					return false;
				}
			}
			else
			{
				if ( _parent )
					return _parent.checkForMerge();
			}
			return false;
		}
		
		public function mergeAirRecursive():Boolean {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in _children ) 
				{
					if ( child.mergeRecursive() )
					return false;
				}
			}
			else
			{
				if ( _parent && Globals.AIR == type )
					return _parent.checkForMerge();
			}
			return false;
		}
		
		public function changeGrainSize( changeSize:int, newBound:int ):void {
			if ( _vertMan )
				_vertMan.minGrain =  _vertMan.minGrain + changeSize;
			if ( childrenHas() )
			{
				gc.bound = newBound;
				gc.grain = gc.grain + changeSize;
				//  if our new size is 0, and we have children, prune them
				if ( 0 == gc.grain )
				{
					childrenPrune();
					neighborsInvalidate();
					return;
				}
					
				for each ( var child:Oxel in _children ) 
				{
					child.changeGrainSize( changeSize, newBound );
				}
			}
			else
			{
				gc.bound = newBound;
				gc.grain = gc.grain + changeSize;
			}
			return;
		}
		
		public function print():void {
			trace( "Oxel - print: " + toString() );
			for each ( var child:Oxel in _children ) {
				child.print();
			}
		}
		
		public function toString():String {
			var p:String = _parent ? " has parent" : "  no parent";
			var c:String = childrenHas() ? (" has " + _children.length + " kids") : "  no children";
			var t:String = "";
			if ( null != root_get().gc )
			{
				var bg:uint = root_get().gc.grain;
				for ( var i:int = 0; i < bg - gc.grain; i++ ) {
					t += "\t";
				}
			var r:String;
			if ( Globals.INVALID == type )
				r = "\t\t oxel of type: " + Globals.Info[type].name;
			else
				var str:String = "";
				str = maskTempData().toString(16)
				var hex:String = ("0x00000000").substr(2,8 - str.length) + str;
				r = t + " oxel of type: " + Globals.Info[type].name + "\t location: " + gc.toString() + "  data: " + hex + " parent: " + p + " children: " + c;
			}
			else
				r = "Uninitialized Oxel" + p + c;
	
			return r;
		}
		
		public function toStringShort():String {
			return "oxel of type: " + Globals.Info[type].name + "\t location: " + gc.toString();
		}
		
		public function rebuildAll():void
		{
			if ( childrenHas() )
			{
				if ( Globals.AIR != type )
				{
					Log.out( "Oxel.rebuildAll - parent with TYPE: " + Globals.Info[type].name, Log.ERROR );
					type = Globals.AIR; 
				}
				for each ( var child:Oxel in _children )
				{
					child.rebuildAll();
				}
			}
			else
			{
				faces_mark_all_dirty();
				quadsDeleteAll();
			}
		}
		
		public function root_get():Oxel {
			if ( _parent )
				return _parent.root_get();
			else
				return this;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Neighbors function START
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function neighbor( $face:int ):Oxel { 
			if ( !_neighbors )
				_neighbors = NeighborPool.poolGet();
			
			// lazy evaluation
			var no:Oxel = _neighbors[ $face ];
			//if ( no && no != Globals.BAD_OXEL && no.gc.grain > gc.grain && no.childrenHas() )
			//	Log.out( "Oxel.neighbor - this should never happen this:" + toString() + "  no: " + no.toString() );
			if ( null == no )
			{
				// This uses the _s_scratchGrain
				if ( neighborsIsValid( $face ) ) {
					_neighbors[ $face ] = root_get().childFind( _s_scratchGrain );
				}
				else
					_neighbors[ $face ] = Globals.BAD_OXEL;
			}
			return _neighbors[ $face ];
		}
		
		protected function neighborsIsValid( dir:int ):Boolean {
			_s_scratchGrain.copyFrom( gc );
			var result:Boolean = false;
			if ( Globals.POSX == dir )
				result = _s_scratchGrain.move_posx();
			else if ( Globals.NEGX == dir )
				result = _s_scratchGrain.move_negx();
			else if ( Globals.POSY == dir )
				result = _s_scratchGrain.move_posy();
			else if ( Globals.NEGY == dir )
				result = _s_scratchGrain.move_negy();
			else if ( Globals.POSZ == dir )
				result = _s_scratchGrain.move_posz();
			else if ( Globals.NEGZ == dir )
				result = _s_scratchGrain.move_negz();
				
			return result;
		}
		
		// Mark all of the faces opposite this oxel as dirty
		public function neighborsMarkDirtyFaces( $guid:String ):void {
			var no:Oxel = null;
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				no = neighbor(face);
				if ( Globals.BAD_OXEL != no )
				{
					//trace( "Oxel.neighborsMarkDirtyFaces - our face: " + Globals.Plane[face].name + " their face: " + Globals.Plane[face_get_opposite( face )].name );
					no.face_mark_dirty( $guid, Oxel.face_get_opposite( face ) );
				}
			}
		}
		
		// I am breaking up, so get rid of any reference to me
		public function neighborsInvalidate():void {
			// regardless of whether or not I have neighbors, I need to create them so them I can tell them I have changed!
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				var no:Oxel = neighbor(face);
				if ( no && Globals.BAD_OXEL != no )
					no.neighborInvalidate( Oxel.face_get_opposite( face ) );
			}
		}

		// set old neighbor to null
		protected function neighborInvalidate( face:int ):void {
			if ( _neighbors )
			{
				_neighbors[face] = null;
			}
			
			if ( childrenHas() )
			{
				//const dchildren:Vector.<Oxel> = childrenForDirection( Oxel.face_get_opposite( face ) );
				const dchildren:Vector.<Oxel> = childrenForDirection( face );
				for each ( var dchild:Oxel in dchildren ) 
				{
					dchild.neighborInvalidate( face );
				}
			}
			
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Neighbors function END
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// face function
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override protected function face_mark_dirty( $guid:String, $face:uint ):void {
			// RSF should this go here too? do I ever pass this to a parent?
			//super.face_mark_dirty( $face );
			if ( childrenHas() )
			{
				const children:Vector.<Oxel> = childrenForDirection( $face );
				for each ( var child:Oxel in children ) 
				{
					child.face_mark_dirty( $guid, $face );
				}
			}
			else
			{
				// TODO This needs to be refactored to remove this from this function, so more likely go in the write function of the voxelModel.
				if ( Globals.Info[type].flowable && Globals.autoFlow && EditCursor.EDIT_CURSOR != $guid )
					Flow.addTask( $guid, gc, type, flowInfo, 1 );

				super.face_mark_dirty( $guid, $face );
			}
		}

		override protected function faces_mark_all_dirty():void { 
			super.faces_mark_all_dirty();
			faces_clear_all();
		}
		
		public function faces_rebuild( $guid:String ):void {
			quadsDeleteAll();
			
			// anytime oxel changes, neighbors need to know
			neighborsMarkDirtyFaces( $guid );
			faces_mark_all_dirty();
		}
		
		public var timeBuilding:int;
		public function faces_build():Boolean {
//			if ( MAX_BUILD_TIME < getTimer() - timeBuilding )
//				return false;
				
			var continueProcessing:Boolean = true;
			if ( dirty )
			{
				if ( childrenHas() )
				{
					// parents dont have faces!
					faces_clear_all();
					dirty = false;
					
					for each ( var child:Oxel in _children ) {
						if ( child.dirty )
						{
							continueProcessing = child.faces_build();
							// We have timed out in one of the children, get out.
							if ( !continueProcessing )
								return false;
						}
					}
				}
				else
				{
					faces_build_terminal();
				}
			}
			
			return continueProcessing;
		}

		protected function faces_build_terminal():void {
			//trace( "Oxel.faces_build_terminal");
			if ( Globals.AIR == type )
			{
				faces_mark_all_clean();
				return;
			}
			
//			if ( 4 == gc.grain && 10 == gc.grainX && 8 == gc.grainY && 8 == gc.grainZ  )
// 				var temp:int = 1; // place holder for b reak point
				
			// check to see if any faces are marked as dirty
			if ( faces_has_dirty() )
			{
				var no:Oxel = null ;
				for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
				{
					// only check the faces marked as dirty
  					if ( face_is_dirty( face ) )
					{
						no = neighbor( face );
						if ( Globals.BAD_OXEL == no ) 
						{
							// this is an external face. that is on the edge of the grain space
							// If this face_set is removed, then faces on invalid sides will not draw
							face_set( face );
						}
						else if ( no.type == type )
						{
							// nieghbor oxel is the same, we are done? nope, the neighbor might have different scaling.. for flowable type.
							// do we both have flow info?
							if ( no.flowInfo && flowInfo )
							{
								// verify both have scaling
								if ( no.flowInfo.flowScaling && flowInfo.flowScaling )
								{
									// so now I need the equivelent spots on each face to compare.
									var p1:Point = flowInfo.flowScaling.faceGet( face );
									var p2:Point = no.flowInfo.flowScaling.faceGet( face_get_opposite( face ) );
									if ( p1.equals( p2 ) )
										face_clear( face );
									else
										face_set( face );
								}
							}
							else
								face_clear( face );
						}
						else if ( no.childrenHas() ) 
						{
							var rface:int = Oxel.face_get_opposite( face )
							if ( no.faceHasAlpha( rface ) )
								face_set( face );
						}
						// no children, so just check against type
						else
						{
							if ( Globals.hasAlpha( no.type ) )
								face_set( face );
							else if ( flowInfo )
							{ 
								if ( flowInfo.flowScaling.scalingHas() ) 	// for scaled lava or other non alpha flowing types
									face_set( face );
								else
									face_clear( face );
							}
							else if ( no.flowInfo )	// for scaled lava or other non alpha flowing types
							{
								if ( no.flowInfo.flowScaling.scalingHas() )
									face_set( face );
								else
									face_clear( face );
							}
							else
								face_clear( face );
						}
					}
				}
			}
			faces_mark_all_clean();
		}
		
		static public function face_get_opposite( dir:int ):int	{
			if      ( Globals.POSX == dir )
				return Globals.NEGX;
			else if ( Globals.NEGX == dir )
				return Globals.POSX;
			else if ( Globals.POSY == dir )
				return Globals.NEGY;
			else if ( Globals.NEGY == dir )
				return Globals.POSY;
			else if ( Globals.POSZ == dir )
				return Globals.NEGZ;
			else if ( Globals.NEGZ == dir )
				return Globals.POSZ;

			trace( "Oxel - face_get_opposite - ERROR - Invalid face", Log.ERROR );
			return 1;
		}

		public function faceHasAlpha( dir:int ):Boolean	{
			//	If no children, then is this an opaque type
			if ( !childrenHas() )
			{
  				return Globals.hasAlpha( type );
			}
			else // I have children, so check each child on that face
			{
				const dchildren:Vector.<Oxel> = childrenForDirection( dir );
				for each ( var dchild:Oxel in dchildren ) 
				{
					// Need to gather the alpha info from each child
					if ( true == dchild.faceHasAlpha( dir ) )
						return true;
				}
			}
				
			// all children for that direction are opaque, so this face is opaque
			return false;	
		}
		
		public function faceHasWater( dir:int ):Boolean	{
			//	If no children, then is this an opaque type
			if ( !childrenHas() )
			{
				return ( Globals.WATER == type );
			}
			else // I have children, so check each child on that face
			{
				const dchildren:Vector.<Oxel> = childrenForDirection( dir );
				for each ( var dchild:Oxel in dchildren ) 
				{
					// Need to gather the alpha info from each child
					if ( true == dchild.faceHasWater( dir ) )
						return true;
				}
			}
				
			// all children for that direction are opaque, so this face is opaque
			return false;	
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// face function END
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// lighting START
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public static var _s_oxelsTested:int = 0;
		public static var _s_oxelsEvaluated:int = 0;
		public static var _s_lightsFound:int = 0;
		
		public function lightingFromSun( $guid:String, $face:int ):void {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in _children )
					child.lightingFromSun( $guid, $face );
			}
			else
			{
				_s_oxelsTested++;
				// Does this oxel have the a face in the $face direction, if not move on
				if ( faceHas( $face ) )
				{
					_s_oxelsEvaluated++;
					//LightSunCheck.addTask( $guid, gc, 1, $face );
				}

			}
		}
		
		// This would only be run once when model loads
		// set the activeVoxelModelGuid before calling
		public function lightsStaticCount( $guid:String ):void {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in _children )
					child.lightsStaticCount( $guid );
			}
			else
			{
				if ( Globals.Info[type].light ) // had & quads, but that doesnt matter with this style
					_s_lightsFound++;
			}
		}
		
		// This would only be run once when model loads
		// set the activeVoxelModelGuid before calling
		public function lightsStaticSetDefault( $attn:uint ):void {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in _children )
					child.lightsStaticSetDefault( $attn );
			}
			else
			{
				if ( _brightness && _brightness.lightHas( Brightness.DEFAULT_LIGHT_ID ) ) {
					var li:LightInfo = _brightness.lightGet( Brightness.DEFAULT_LIGHT_ID );
					li.setAll( $attn );
					quadsRebuildAll();

				}
			}
		}

		
		public function faceCenterGet( face:int ):Vector3D
		{
			const size:int = gc.size() / 2;
			var faceCenter:Vector3D = new Vector3D( gc.getModelX() + size, gc.getModelY() + size, gc.getModelZ() + size );
			if ( Globals.POSX == face )
				faceCenter.x += size;
			else if ( Globals.NEGX == face ) 	
				faceCenter.x -= size;
			else if ( Globals.POSY == face ) 	
				faceCenter.y += size;
			else if ( Globals.NEGY == face ) 	
				faceCenter.y -= size;
			else if ( Globals.POSZ == face ) 	
				faceCenter.z += size;
			else if ( Globals.NEGZ == face ) 	
				faceCenter.z -= size;
			
			return faceCenter;
		}
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// lighting END
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Begin Quad functions
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function quadsBuild( $plane_facing:int = 1 ):void {
			if ( dirty )
			{
				if ( childrenHas() )
				{
					// parents dont have quads!
					if ( dirty  && _quads )
					{
						vertManRemoveOxel();
					}
					faces_clean_all_face_bits();
					dirty = false;

					for each ( var child:Oxel in _children ) {
						if ( child.dirty )
							child.quadsBuild( $plane_facing );
					}
				}
				else
					quadsBuildTerminal( $plane_facing );
			}
		}
		
		protected function quadsBuildTerminal( $plane_facing:int = 1 ):void {
			var quadCount:int = 0;

			// Does this oxel have faces
			if ( facesHas() )
			{
				if ( null == _quads )
				{
					_quads = QuadsPool.poolGet();
					if ( !_brightness )
						_brightness = BrightnessPool.poolGet();
						if ( _brightness.lightHas( Brightness.DEFAULT_LIGHT_ID ) ) {
							var li:LightInfo = _brightness.lightGet( Brightness.DEFAULT_LIGHT_ID );
							var rootOxel:Oxel = root_get();
							if ( null == rootOxel._brightness ) {
								rootOxel._brightness = BrightnessPool.poolGet();
							}
							li.setAll( rootOxel._brightness.lightGet( Brightness.DEFAULT_LIGHT_ID ).avg );
						}
						_brightness.fallOffPerMeter = Globals.Info[type].attn;
				}
				
				if ( Globals.Info[type].fullBright )
					_brightness.lightFullBright();
					
				var scale:uint = 1 << gc.grain;
				for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
					quadCount += quadAddOrRemoveFace( face, $plane_facing, scale );
			}
			else 
			{
				// if no faces release all quads
				quadsDeleteAll();
			}
			
			// did any of the quads change?
			if ( quadCount )
			{
				// if those this oxel has not been added to vertex manager do it now.
				if ( !added_to_vertex ) 
					vertManAddOxel();
				else
					vertManMarkDirty( Globals.INVALID );
			}
			// I was added to vertex, but I lost all my face, so remove oxel
			else if ( added_to_vertex )
				vertManRemoveOxel();

			dirty = false;
		}
		
		protected function quadAddOrRemoveFace( $face:int, $plane_facing:int, $scale:uint ):int {
			var validFace:Boolean = faceHas($face);
			var quad:Quad = _quads[$face];
			
			// has face and quad
			if ( validFace && quad )
				return 1;
			// face but no quad
			else if ( validFace && !quad ) 
			{
				quad = QuadPool.poolGet();
				if ( flowInfo && isFlowable )
					quad.buildScaled( type, gc.getModelX(), gc.getModelY(), gc.getModelZ(), $face, $plane_facing, $scale, _brightness, flowInfo );
				else
					quad.build( type, gc.getModelX(), gc.getModelY(), gc.getModelZ(), $face, $plane_facing, $scale, _brightness );
				_quads[$face] = quad;
				return 1;
			}
			// no face but has a quad
			else if ( !validFace && quad )
			{
				quadDelete( quad, $face, Globals.INVALID );
				return 0;
			}
			// last case is no face and no quad		
			return 0;	
		}
		
		public function quadDeleteFace( $face:int ):void {
			if  ( !_quads )
				return;
			dirty = true;
			var quad:Quad = _quads[$face];
			if ( quad )
				quadDelete( quad, $face, type );
		}

		public function quadRebuild( $face:int ):void {
			if  ( !_quads )
				return;
			dirty = true;
			var quad:Quad = _quads[$face];
			if ( quad )
			{
				var plane_facing:int = 1;
				var scale:uint = 1 << gc.grain;
				quad.rebuild( type, gc.getModelX(), gc.getModelY(), gc.getModelZ(), $face, plane_facing, scale, _brightness );
			}
		}

		public function quadsRebuildAll():void {
			if  ( !_quads )
				return;
				
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
				quadRebuild( face );
		}
		
		////////////////////////////////////////
		public function quadsDeleteAll():void {
			if  ( _quads )
			{
				//Log.out( "Oxel.quadsDeleteAll" );
				dirty = true;
				for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
				{
					var quad:Quad = _quads[face];
					if ( quad )
						quadDelete( quad, face, type );
				}
			}
		}

		// TODO, I see some risk here when I am changing oxel type from things like sand to glass
		// Its going to assume that it was solid, which works for sand to glass
		// how about water to sand? the oxel would lose all its faces, but never go away.
		protected function quadDelete( quad:Quad, face:int, type:int ):void {
			vertManMarkDirty( type );
			QuadPool.poolDispose( quad );
			_quads[face] = null;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// End Quad functions
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Vertex Manager functions START
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function vertManRemoveOxel():void {
			if ( _quads )
			{
				quadsDeleteAll();
				QuadsPool.poolDispose( _quads );
				_quads = null;
			}
			// Air can have brightness but not quads
			//if ( _brightness )
			//{
				//BrightnessPool.poolReturn( _brightness );
				//_brightness = null;
			//}
			
			if ( added_to_vertex )
			{
				// Todo - this should just mark the oxels, and clean up should happen later
				vm_get().oxelRemove( this, type );
				added_to_vertex = false;
			}
		}
		
		private function vertManAddOxel():void {
			added_to_vertex = true;
			vm_get().oxelAdd( this );
		}
		
		protected function vertManMarkDirty( oldType:int ):void {
			vm_get().VIBGet( type, oldType ).dirty = true;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Vertex Manager END
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/*//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		 * FLOW FUNCTIONS
		 * three different kinds of flow
		 * 1) pressurized flow, $gc unlimited oxels are produced (rate limited?), this could fill a cavity then go over the top
		 * 2) continuous gravity flow, a spring for example, this flow always goes downhill, but doesnt run out
		 * 3) limited flow, like a bucket of water being poured out, this has a set number of oxels.
		 *
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
		private const MIN_FLOW_GRAIN:int = 2;
		public function flowFindCandidates( $guid:String, $countDown:int = 8, $countOut:int = 8):void {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in children )
					if ( MIN_FLOW_GRAIN <= child.gc.grain )
						child.flowFindCandidates( $guid, $countDown, $countOut);
			}
			else
			{
				if ( Globals.Info[type].flowable )
				{
					Log.out( "Oxel.flowFindCandidates - gc: " + gc.toString() );
					//flowTerminal();
					Flow.addTask( $guid, gc, type, flowInfo, 1 );
				}
			}
		}

		//public function flowTerminal():void { }
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// END FLOW FUNCTIONS
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Saving and Restoring from File
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function writeData( ba:ByteArray ):void 
		{
			//trace( Oxel.data_mask_temp( _data ) );
			if ( childrenHas() && Globals.AIR != type )
			{
				Log.out( "Oxel.writeData - parent with TYPE: " + Globals.Info[type].name, Log.ERROR );
				type = Globals.AIR; 
			}
			
			if ( flowInfo || ( _brightness && _brightness.valuesHas() ) )
			{
				// I only have 1 bit for additional data...
				additionalDataMark();
				ba.writeInt( maskTempData() );
				
				if ( !flowInfo )
					flowInfo = new FlowInfo(); 
				flowInfo.toByteArray( ba );
				
				if ( !brightness )
					brightness = BrightnessPool.poolGet();
				ba = brightness.toByteArray( ba );
			}
			else
				ba.writeInt( maskTempData() );
			
			if ( childrenHas() ) 
			{
				for each ( var child:Oxel in _children ) 
					child.writeData( ba );
			}
		}
		
		public function readVersionedData( $version:String, $parent:Oxel, $gc:GrainCursor, $ba:ByteArray, $stats:ModelStatisics ):ByteArray 
		{
			var oxelData:uint = $ba.readInt();
			initializeVersionedData( $version, $parent, $gc, oxelData, $stats );
			
			// Bad data check
			if ( OxelData.data_is_parent( oxelData ) && Globals.AIR != type )
			{
				Log.out( "Oxel.readData001 - parent with TYPE: " + Globals.Info[type].name, Log.ERROR );
				type = Globals.AIR;
			}
			// Check for flow and brightnessInfo
			if ( OxelData.dataHasAdditional( oxelData ) )
			{
				if ( !flowInfo )
					flowInfo = new FlowInfo();
				$ba = flowInfo.fromByteArray( $version, $ba );
				
				brightness = BrightnessPool.poolGet();
				$ba = brightness.fromByteArray( $version, $ba );
				brightness.fallOffPerMeter = Globals.Info[type].attn;
			}
			
			if ( OxelData.data_is_parent( oxelData ) )
			{
				_children = ChildOxelPool.poolGet();
				var gct:GrainCursor = GrainCursorPool.poolGet( $stats.largest );
				for ( var i:int = 0; i < OXEL_CHILD_COUNT; i++ )
				{
					_children[i]  = OxelPool.poolGet();
					gct.copyFrom( $gc );
					gct.become_child(i);   
					_children[i].readVersionedData( $version, this, gct, $ba, $stats );
				}
				GrainCursorPool.poolDispose( gct );
			}

			return $ba;
		}

		public function readData( $parent:Oxel, $gc:GrainCursor, $ba:ByteArray, $stats:ModelStatisics ):ByteArray 
		{
			var oxelData:uint = $ba.readInt();
			//trace( intToHexString() + "  " + oxelData );
			initialize( $parent, $gc, oxelData, $stats );
			if ( OxelData.data_is_parent( oxelData ) && Globals.AIR != type )
			{
				Log.out( "Oxel.readData - parent with TYPE: " + Globals.Info[type].name, Log.ERROR );
				type = Globals.AIR;
			}
			if ( OxelData.data_is_parent( oxelData ) )
			{
				_children = ChildOxelPool.poolGet();
				var gct:GrainCursor = GrainCursorPool.poolGet( $stats.rootSize );
				for ( var i:int = 0; i < OXEL_CHILD_COUNT; i++ )
				{
					_children[i]  = OxelPool.poolGet();
					gct.copyFrom( $gc );
					gct.become_child(i);   
					_children[i].readData( this, gct, $ba, $stats );
				}
				GrainCursorPool.poolDispose( gct );
			}
			
			return $ba;
		}
		
		private function intToHexString( $val:int ):String
		{
			var str:String = $val.toString(16)
			var hex:String = ("0x00000000").substr(2,8 - str.length) + str;
			return hex;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// End Saving and Restoring from File
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Intersection functions START
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function lineIntersect( $msStartPoint:Vector3D, $msEndPoint:Vector3D, $msIntersections:Vector.<GrainCursorIntersection> ):void {
			if ( Globals.AIR == type && !childrenHas() )
				return;
			gc.lineIntersect( $msStartPoint, $msEndPoint, $msIntersections );
		}

		public function lineIntersectWithChildren( $msStartPoint:Vector3D, $msEndPoint:Vector3D, $msIntersections:Vector.<GrainCursorIntersection>, $minSize:int = 2 ):void	{
			if ( !childrenHas() )
			{
				if ( Globals.AIR != type )
					gc.lineIntersect( $msStartPoint, $msEndPoint, $msIntersections );
			}
			else if ( gc.grain <=  $minSize	)			
				gc.lineIntersect( $msStartPoint, $msEndPoint, $msIntersections );

			// find the oxel that is closest to the start point, and is solid?
			// first do a quick check to see if ray hits any children.
			// then for any children it hits, do a hit test with its children
			else if ( childrenHas() )
			{
				// have to seperate childIntersections from totalIntersections
				var childIntersections:Vector.<GrainCursorIntersection> = new Vector.<GrainCursorIntersection>();
				var totalIntersections:Vector.<GrainCursorIntersection> = new Vector.<GrainCursorIntersection>();
				for each ( var child:Oxel in _children ) 
				{
					child.lineIntersect( $msStartPoint, $msEndPoint, childIntersections );
					for each ( var gcIntersection:GrainCursorIntersection in childIntersections )
					{
						gcIntersection.oxel = child;
						totalIntersections.push( gcIntersection );
					}
					childIntersections.splice( 0, childIntersections.length );
				}
				// if nothing to work with leave early
				if ( 0 == totalIntersections.length )
					return;
				
				// scratchVector is used by sort function
				_s_scratchVector = $msStartPoint;
				// sort getting closest ones first
				totalIntersections.sort( intersectionsSort );
				
				// this empties the vector
				_s_oxelIntersections.splice( 0, _s_oxelIntersections.length );
				for each ( var gci:GrainCursorIntersection in totalIntersections )
				{
					// only check each oxel once, checking the closest first.
					//if ( !isOxelInSet( gci ) )
					{
						// closest child might be empty, if no intersection with this child, try the next one.
						gci.oxel.lineIntersectWithChildren( $msStartPoint, $msEndPoint, $msIntersections, $minSize );
						// does this bail after the first found interesection?
						if ( 0 != $msIntersections.length )
						{
							return;
						}
					}
				}
			}
		}
		
		// This function makes sure we dont test the same oxel multiple times
		// HUGE time savings, not doing this almost doubles speed
		static private function isOxelInSet( gci:GrainCursorIntersection ):Boolean	{
			// test to see if we have already used this oxel for testing.
			for each ( var oxel:Oxel in _s_oxelIntersections )
			{
				if ( gci.oxel == oxel )
					return true;
			}
			// if we dont find it, add it to set.
			_s_oxelIntersections.push( gci.oxel );
			return false;
		}
		
		private function intersectionsSort( pointModel1:GrainCursorIntersection, pointModel2:GrainCursorIntersection ):Number {
			var point1Rel:Number = _s_scratchVector.subtract( pointModel1.point ).length;
			var point2Rel:Number = _s_scratchVector.subtract( pointModel2.point ).length;
			if ( point1Rel < point2Rel )
				return -1;
			else if ( point1Rel > point2Rel ) 
				return 1;
			else 
				return 0;			
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Intersection functions END
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/*
		 * This function will build a list of all Oxels that have any part inside
		 * the sphere described by the parameters:  cx,cy,cz, radius  (g0 units) 
		 * The typical context for this function is a culling method $gc the sphere
		 * is g0 point of the camera and the caller only wants to render Oxels inside
		 * some maximum distance from the camera
		 */
		public function select_all_inside_sphere( cx:int, cy:int, cz:int,  radius:int,  the_list:Vector.<Oxel> ):void {
			var child:Oxel;
			
			// our first test is the simplest case where this grain is
			// entirely inside the parameter sphere
			if ( true == GrainCursorUtils.is_inside_sphere( gc, cx, cy, cz, radius ))
			{
				// this grain and 100% of children (if any) are inside the radius
				// so if the grain has children or it has an opaque type it will be selected
				if(false
					|| true == childrenHas()
					|| true == hasAlpha
				)
				the_list.push(this);
				return;
			}
			
			// ok so this grain is not enclosed by the sphere which leaves only 3 cases
			// intersection,  disjoint,  encloses
			
			// the next thing we need to know is the sphere is completely inside this grain
			if ( true == GrainCursorUtils.contains_sphere(gc, cx, cy, cz, radius))
			{
				// the sphere is entirely enclosed by the grain
				if ( false == childrenHas() )
				{
					// leaf grain with no children
					// add it to the list if it is an opaque material type
					if ( hasAlpha)
						the_list.push(this);
					return;
				}
				
				// the sphere is entirely enclosed by the grain that has children
				// so we must visit each child
				for each ( child in _children )
					child.select_all_inside_sphere( cx, cy, cz, radius, the_list );
				
				// all done
				return;
			}
			
			// ok so the sphere is NOT entirely inside this grain which means
			// it is completely dis-joint or it intersects the grain in some way
			
			
			// ok so the sphere and grain do not enclose one another
			// the only 2 remaining cases are intersection and disjointed
		
			// check this grain to see if it completely outside the sphere
			if ( true == GrainCursorUtils.is_outside_sphere(gc,cx,cy,cz,radius))
			{
				// the sphere and this grain and children (if any) do not intersect
				// so we want to completely cull this grain space from the list
				return;
			}

				
			// ok so this grain intersects the sphere partially 
			// so if we have no children then we're done
			if ( false == childrenHas() )
			{
				// leaf grain with no children
				// add it to the list if it is an opaque material type
				if ( hasAlpha )
					the_list.push(this);
				return;
			}

			// this grain intersects the sphere 
			// and the grain has children
			// so we vist each child
			for each ( child in _children )
				child.select_all_inside_sphere( cx, cy, cz, radius, the_list );
				
			// all done

		}
		
		public function select_all_above_plane( p:Plane,  the_list:Vector.<Oxel> ):void	{
			var c:int = GrainCursorUtils.classify_from_plane( gc, p );
			
			if ( c == -1 )
			{
				// the grain is entirely below the plane so reject it
				return;
			}
			
			if ( c == +1 )
			{
				// the grain is entirely above the plane so accept it
				the_list.push(this);
				return;
			}
			
			// c == 0
			// the grain straddles the plain
			
			if (false == childrenHas())
			{
				// leaf grain with no children so accept it
				the_list.push(this);
				return;
			}
			
			// the grain straddles the plane
			// the grain has children
			// so visit each child
			for each ( var child:Oxel in _children )
				child.select_all_above_plane( p, the_list );

			// all done
		}
		
		static public function static_select_all_above_plane( p:Plane,  src_list:Vector.<Oxel> ):Vector.<Oxel> {
			var dst_list:Vector.<Oxel> = new Vector.<Oxel>;
			for each ( var child:Oxel in src_list )
				child.select_all_above_plane( p, dst_list );
			return dst_list;
		}
		
		static public function static_select_all_inside_frustrum( f:Vector.<Plane>,  src_list:Vector.<Oxel> ):Vector.<Oxel>	{
			var temp:Vector.<Oxel> = src_list;
			
			for each ( var p:Plane in f )
			{
				// use the current list as the source for the next test
				// doing so means the list will be getting smaller and smaller
				// due to the culling process of rejecting grains outside the planes
				temp = static_select_all_above_plane( p, temp );
			}
			
			// the final list should be grains that are either entirely inside
			// or partially inside the defined frustrum
			return temp;
		}
		
		public function write_sphere( $guid:String, cx:int, cy:int, cz:int, radius:int, $newType:int, gmin:uint=0 ):void {
			if ( true == GrainCursorUtils.is_inside_sphere( gc, cx, cy, cz, radius ))
			{
				write( $guid, gc, $newType );
				return;
			}
			
			if ( true == GrainCursorUtils.is_outside_sphere( gc, cx, cy, cz, radius ))
			{
				//trace("************ WRITE SPHERE REJECTING GRAIN: " + gc.toString() + " ");
				return;
			}
			
			if ( gc.grain <= gmin )
			{
				//write( gc, Globals.get_debug_type( gmin ) );
				return;	
			}

			if ( false == childrenHas() )
			{
				// become octa-mom
				childrenCreate();
			}
			
			if ( false == childrenHas() )
			{
				throw new Error("Oxel.write_sphere - ERROR - children expected");
				return;
			}

			for each ( var child:Oxel in _children )
			{
				// make sure child has not already been released.
				if ( child.gc )
					child.write_sphere( $guid, cx, cy, cz, radius, $newType, gmin );
			}
			
		}
		
		public function writeCylinder( $guid:String, cx:int, cy:int, cz:int, radius:int, $newType:int, axis:int, gmin:uint, startTime:int, runTime:int, startingSize:int ):Boolean {
			var result:Boolean = true;
			var timer:int = getTimer();
			if ( startTime + runTime < timer )
				return false;
				
			if ( true == GrainCursorUtils.isInsideCircle( gc, cx, cy, cz, radius, axis ))
			{
				write( $guid, gc, $newType );
				return result;
			}
			else if ( gc.grain < startingSize && true == GrainCursorUtils.isOutsideCircle( gc, cx, cy, cz, radius, axis ))
			{
 				return result;
			}
			else if ( gc.grain <= gmin )
				return result;	

			childrenCreate();
			
			if (!_children)
				throw new Error( "No kids");
			for each ( var child:Oxel in _children )
			{
				if ( child )
				{
					result = child.writeCylinder( $guid, cx, cy, cz, radius, $newType, axis, gmin, startTime, runTime, startingSize );
					if ( !result )
						return result;
				}
			}
			
			return result
		}
		
		public function empty_square( $guid:String, cx:int, cy:int, cz:int, radius:int, gmin:uint=0 ):void {
			if ( true == GrainCursorUtils.is_inside_square( gc, cx, cy, cz, radius ))
			{
				write( $guid, gc, Globals.AIR );
				return;
			} 
			if ( true == GrainCursorUtils.is_outside_square( gc, cx, cy, cz, radius ))
			{
				return;
			}
			
			if ( gc.grain <= gmin )
			{
				write( $guid, gc, Globals.AIR );
				return;	
			}

			childrenCreate();
			
			for each ( var child:Oxel in _children )
			{
				child.empty_square( $guid, cx, cy, cz, radius, gmin );
			}
		}

		public function effect_sphere( $guid:String, cx:int, cy:int, cz:int, ie:ImpactEvent ):void {
			var radius:int = ie.radius
			var writeType:int = 0;
			var ip:InteractionParams = null;
			// I never see this get called - RSF
			if ( true == GrainCursorUtils.is_inside_sphere( gc, cx, cy, cz, radius ))
			{
				ip = Globals.Info[type].interactions.IOGet( ie.type );
				writeType = Globals.getTypeId( ip.type );
				if ( type == writeType )
					return;
				write( $guid, gc, writeType, false );
				return;
			} 
			
			if ( true == GrainCursorUtils.is_outside_sphere( gc, cx, cy, cz, radius ))
			{
				return;
			}
			
			if ( gc.grain <= ie.detail )
			{
				ip = Globals.Info[type].interactions.IOGet( ie.type );
				writeType = Globals.getTypeId( ip.type );
				if ( type == writeType )
					return;
//				if ( "melt" == ip.script )
//					flowInfo.type = FlowInfo.FLOW_TYPE_MELT;
				write( $guid, gc, writeType, false );
				//else if ( "" != ip.script )
					//Log.out( "Oxel.effect_sphere - " + ip.script + " source type: " + type +  " writeType: " + writeType );
				return;	
			}

			if ( false == childrenHas() )
			{
				if ( type == Globals.AIR )
					return;
				childrenCreate();
			}
			
			for each ( var child:Oxel in _children )
			{
				if ( child && child.gc )
					child.effect_sphere( $guid, cx, cy, cz, ie );
			}
		}
		
		public function empty_sphere( $guid:String, cx:int, cy:int, cz:int, radius:Number, gmin:uint=0 ):void {
			if ( true == GrainCursorUtils.is_inside_sphere( gc, cx, cy, cz, radius ))
			{
				write( $guid, gc, Globals.AIR );
				return;
			} 
			if ( true == GrainCursorUtils.is_outside_sphere( gc, cx, cy, cz, radius ))
			{
				return;
			}
			
			if ( gc.grain <= gmin )
			{
				write( $guid, gc, Globals.AIR );
				return;	
			}

			if ( false == childrenHas() )
			{
				if ( type == Globals.AIR )
					return;
				childrenCreate();
			}
			
			if ( !_children )
				return;
				
			for each ( var child:Oxel in _children )
			{
				if ( child && child.gc )
					child.empty_sphere( $guid, cx, cy, cz, radius, gmin );
			}
		}
		
		// pass in 8 levels of height maps.
		public function write_height_map( $guid:String 
		                                , $type:int
		                                , minHeightMapArray:Vector.<Array>
										, maxHeightMapArray:Vector.<Array>
										, gmin:uint
										, heightMapOffset:int
										, ignoreSolid:Boolean ):void {
			if ( Globals.Info[type].solid && !ignoreSolid )
				return;

			// this fills in the grains that are not too high, and not too short.
			if ( gc.grain < gmin )
			{
				// This adds extra voxels, whats up there? RSF
				//var oxel:Oxel = childFind( gc, true );
				//oxel.set_type( Globals.get_debug_type( gc.grain ) );
				return;	
			}

			var grainSize:uint = GrainCursor.get_the_g0_size_for_grain(gc.grain);
			var bottom:uint = gc.grainY * grainSize;
			var top:uint = bottom + grainSize;

			if ( top <= minHeightMapArray[heightMapOffset][gc.grainX][gc.grainZ] )
			{
				if ( childrenHas() && gc.grain > gmin )
				{
					for each ( var child1:Oxel in _children )
					{
						child1.write_height_map( $guid, $type, minHeightMapArray, maxHeightMapArray, gmin, heightMapOffset - 1, ignoreSolid );
					}
				}
				else
				{
					if ( ignoreSolid )
						//write( $guid, gc, $type, true );
						writeFromHeightMap( gc, $type );
					else
						writeFromHeightMap( gc, $type );
						//write_empty( $guid, gc, $type );
				}
				return;
			}
			else if ( bottom >= maxHeightMapArray[heightMapOffset][gc.grainX][gc.grainZ] )
			{
				//trace("************ WRITE HEIGHTMAP OVER THE TOP: " + gc.toString() + " ");
				return;
			}
			
			if ( 0 < gc.grain && gc.grain > gmin  )
			{
				childrenCreate( false );
			
				for each ( var child:Oxel in _children )
				{
					child.write_height_map( $guid, $type, minHeightMapArray, maxHeightMapArray, gmin, heightMapOffset - 1, ignoreSolid );
				}
			}
		}
	
		public function rotateCCW():void
		{
			var range:uint = gc.bound - gc.grain;
			range = (1 << range) - 1;
			// 6 - 6 => 0
			// ( 2 ^ 0 ) - 1 => 0
			// 6 - 5 => 1
			// ( 2 ^ 1 ) - 1 => 1
			// 6 - 4 => 2
			// ( 2 ^ 2 ) - 1 => 3
			var x:uint = range - gc.grainZ;
			var z:uint = gc.grainX;
			gc.grainX = x;
			gc.grainZ = z;
			
			faces_mark_all_dirty();
			quadsDeleteAll();
			
			if ( _children )
			{
				// ClockWise
				//var toxel:Oxel = null;
				//var toxel2:Oxel = null;
				//toxel = _children[0];
				//_children[0] = _children[1];
				//toxel2 = _children[4];
				//_children[4] = toxel;
				//toxel = _children[5];
				//_children[5] = toxel2;
				//_children[1] = toxel;
//
				//toxel = _children[2];
				//_children[2] = _children[3];
				//toxel2 = _children[6];
				//_children[6] = toxel;
				//toxel = _children[7];
				//_children[7] = toxel2;
				//_children[3] = toxel;

				// Counter ClockWise
				var toxel:Oxel = null;
				var toxel2:Oxel = null;
				toxel = _children[0];
				_children[0] = _children[4];
				toxel2 = _children[1];
				_children[1] = toxel;
				toxel = _children[5];
				_children[5] = toxel2;
				_children[4] = toxel;

				toxel = _children[2];
				_children[2] = _children[6];
				toxel2 = _children[3];
				_children[3] = toxel;
				toxel = _children[7];
				_children[7] = toxel2;
				_children[6] = toxel;

				for each ( var child:Oxel in _children )
				{
					child.rotateCCW();
				}
			}
		}
		
		
		static private var _x_max:int = 512;
		static private var _x_min:int = 512;
		static private var _y_max:int = 512;
		static private var _y_min:int = 512;
		static private var _z_max:int = 512;
		static private var _z_min:int = 512;
		static private var _o_max:int = 0;
		static private var _o_min:int = 31;
		public function centerOxel():void
		{
			_x_max = 0;
			_x_min = gc.size();
			_y_max = 0;
			_y_min = gc.size();
			_z_max = 0;
			_z_min = gc.size();
			_o_max = 0;
			_o_min = gc.size();
			// first determine extends
			for each ( var child:Oxel in _children )
			{
				child.extents();
			}
			trace( "Oxel.centerOxel" );
			trace( _x_max );
			trace( _x_min );
			trace( "x range: " + (_x_max - _x_min) );
			trace( "oxel center is: " + gc.size()/2 + "  model center is: " + (_x_max + _x_min)/2 );
			trace( _y_min );
			trace( _y_max );
			trace( "y range: " + (_y_max - _y_min) );
			trace( "oxel center is: " + gc.size()/2 + "  model center is: " + (_y_max + _y_min)/2 );
			trace( _z_max );
			trace( _z_min );
			trace( "z range: " + (_z_max - _z_min) );
			trace( "oxel center is: " + gc.size() / 2 + "  model center is: " + (_z_max + _z_min) / 2 );
			trace( "smallest oxel is " + _o_min + "  largest is " + _o_max );
			
			breakdown(2);
		}
		
		public function fullBright( $attn:uint ):void {
			var timer:int = getTimer();
			lightsStaticSetDefault( $attn );
			Log.out("Oxel.fullBright - rebuildAll took: " + (getTimer() - timer));
		}
		
		public function breakdown( smallest: int ):void {
			if ( smallest < gc.grain && !childrenHas() )
			{
				childrenCreate();
				for each ( var child:Oxel in _children )
				{
					child.breakdown( smallest );
				}
			}
			else
			{
				if ( childrenHas() )
				{
					for each ( var child1:Oxel in _children )
					{
						child1.breakdown( smallest );
					}
				}
				
			}
		}
		
		private function extents():void {
			if ( childrenHas() )
			{
				// first determine extends
				for each ( var child:Oxel in _children )
				{
					child.extents();
				}
			}
			else if ( !childrenHas() )
			{
				if ( _o_min > gc.grain )
					_o_min = gc.grain;
				if ( _o_max < gc.grain )
					_o_max = gc.grain;
				if ( _x_min > gc.GetWorldCoordinate( 0 ) )
					_x_min = gc.GetWorldCoordinate( 0 );
				if ( _x_max < gc.GetWorldCoordinate( 0 ) + gc.size() )
					_x_max = gc.GetWorldCoordinate( 0 ) + gc.size();
					
				if ( _y_min > gc.GetWorldCoordinate( 1 ) )
					_y_min = gc.GetWorldCoordinate( 1 );
				if ( _y_max < gc.GetWorldCoordinate( 1 ) + gc.size() )
					_y_max = gc.GetWorldCoordinate( 1 ) + gc.size();
					
				if ( _z_min > gc.GetWorldCoordinate( 2 ) )
					_z_min = gc.GetWorldCoordinate( 2 );
				if ( _z_max < gc.GetWorldCoordinate( 2 ) + gc.size() )
					_z_max = gc.GetWorldCoordinate( 2 ) + gc.size();
			}
			// otherwise its air and doest not count
		}
		
		public function changeAllButAirToType( $toType:int, changeAir:Boolean = false ):void {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in _children )
				{
					child.changeAllButAirToType( $toType );
				}
			}
			else
			{
				// dont change the air to solid!
				if ( Globals.AIR == type ) 
				{
					if ( changeAir )
					{
						type = $toType; 
						// if AIR no quads to delete
						faces_mark_all_dirty();
					}
				}
				else
				{ 
					type = $toType; 
				}
			}
		}

		public function changeTypeFromTo( fromType:int, toType:int ):void {
			if ( type == fromType )
				type = toType;
				
			for each ( var child:Oxel in _children )
			{
				child.changeTypeFromTo( fromType, toType );
			}
		}
		
		private function reboundAll( newBound:int ):void {
			gc.bound = newBound;
			for each ( var child:Oxel in _children )
			{
				child.reboundAll( newBound );
			}
		}
		
		// { oxel:Globals.BAD_OXEL, gci:gci, positive:posMove, negative:negMove };
		// RSF - This only works correctly on the + sides, fails for some reason on neg side.
		public function grow( result:Object ):Oxel {
			if ( null != _parent )
				throw new Error( "Oxel.grow - Trying to grow a child");
				
			var newOxel:Oxel = OxelPool.poolGet();
			// change the bound on all children to the larger size
			reboundAll( gc.bound + 1 );
			var newGC:GrainCursor = GrainCursorPool.poolGet( gc.bound );
			newGC.copyFrom( gc );
			newGC.become_parent();
			newOxel._gc = newGC;
			newOxel.parentMarkAs();
			newOxel.type = Globals.AIR;
			// TODO - RSF 
			// This is potential problem - might need to change level _vertexManagers are created at. 
			// Otherwise all new oxels will be created off this one vertexManager
			newOxel._vertMan = this._vertMan;
			newOxel.childrenCreate();
			
			this._parent = newOxel;
			this._vertMan = null;

			// depending on what axis, and what movement it was, we choose which child to replace.
			switch ( result.gci.axis )
			{
				case 0: // x
					if ( 0 == result.gci.gc.grainX ) // going off neg side
					{
						this.gc.copyFrom( newOxel._children[1].gc );
						newOxel._children[1].release();
						newOxel._children[1] = this;
					}
					else
					{
						newOxel._children[0].release(); // This works
						newOxel._children[0] = this;
					}
					break;
				case 1: // y
					if ( 0 == result.gci.gc.grainY ) // going off neg side
					{
						this.gc.copyFrom( newOxel._children[2].gc );
						newOxel._children[2].release();
						newOxel._children[2] = this;
					}
					else
					{
						newOxel._children[0].release(); // This works
						newOxel._children[0] = this;
					}
					break;
				case 2: // z
					if ( 0 == result.gci.gc.grainZ ) // going off neg side
					{
						this.gc.copyFrom( newOxel._children[4].gc );
						newOxel._children[4].release();
						newOxel._children[4] = this;
					}
					else
					{
						newOxel._children[0].release(); // This works
						newOxel._children[0] = this;
					}
					break;
			}
			
			return newOxel;
		}
		
		public function growTreesOn( $guid:String, $type:int, $chance:int = 2000 ):void {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in children )
					child.growTreesOn( $guid, $type, $chance );
			}
			else if ( $type == type )
			{
				var upperNeighbor:Oxel = neighbor( Globals.POSY );
				if ( Globals.BAD_OXEL != upperNeighbor && Globals.AIR == upperNeighbor.type ) // false == upperNeighbor.hasAlpha
				{
					TreeGenerator.generateTree( $guid, this, $chance );
				}
			}
		}
		
		public function growTreesOnAnything( $guid:String, $chance:int = 2000 ):void {
			if ( childrenHas() )
			{
				for each ( var child:Oxel in children )
					child.growTreesOnAnything( $guid, $chance );
			}
			else
			{
				var upperNeighbor:Oxel = neighbor( Globals.POSY );
				if ( Globals.BAD_OXEL != upperNeighbor && Globals.AIR == upperNeighbor.type )
				{
					TreeGenerator.generateTree( $guid, this, $chance );
				}
			}
		}
		
		private function dirtAndGrassToSand( $dir:int ):void {
			var no:Oxel = neighbor( $dir );
			if ( Globals.BAD_OXEL == no )
				return;
				
			var noType:int = no.type;
			if ( Globals.WATER == noType )
				type = Globals.SAND;
			else if ( no.childrenHas() )
			{
				if ( no.faceHasWater( Oxel.face_get_opposite( $dir ) ) )
					type = Globals.SAND;
			}
		}
		
		public function dirtToGrassAndSand():void {

			if ( childrenHas() )
			{
				for each ( var child:Oxel in children )
					child.dirtToGrassAndSand();
			}
			else if ( Globals.DIRT == type || Globals.GRASS == type )
			{
				// See if we have water around us, if so change to sand
				for each ( var dir:int in Globals.allButDownDirections )
				{
					dirtAndGrassToSand( dir );	
				}
				
				// if this is still dirt meaning no water, see if we have air above us, change to grass
				if ( Globals.DIRT == type )
				{
					var no:Oxel = neighbor( Globals.POSY );
					if ( Globals.BAD_OXEL == no )
						return;
						
					if ( Globals.AIR == no.type )
					{
						if ( null == no._children )
							type = Globals.GRASS;
						else
						{
							var kids:Vector.<Oxel> = no.childrenForDirection( Globals.NEGY );
							for each ( var kid:Oxel in kids )
							{
								if ( Globals.AIR == kid.type )
								{
									type = Globals.GRASS;
									break;
								}
							}
						}
					}
				}
			}
		}
		
		public function vines( $guid:String ):void {

			if ( childrenHas() )
			{
				for each ( var child:Oxel in children )
					child.vines( $guid );
			}
			else if ( 152 == type  )
			{
				var nou:Oxel = neighbor( Globals.POSY )
				if ( Globals.BAD_OXEL == nou && Globals.AIR == nou.type && !nou.childrenHas() && nou.gc.grain <= 4 )
					nou.write( $guid, gc, 152 );
				var nod:Oxel = neighbor( Globals.NEGY )
				if ( Globals.BAD_OXEL != nod && Globals.AIR == nod.type && !nod.childrenHas() && nod.gc.grain <= 4 )
					nou.write( $guid, gc, 152 );
			}
		}
		
		public function harvestTrees( $guid:String ):void {

			if ( childrenHas() )
			{
				for each ( var child:Oxel in children )
				{
					child.harvestTrees( $guid );
					// harvesting trees can cause air oxels to merge. So we need to make sure we still have a valid parent.
					if ( !children )
						return;
				}
			}
			else if ( Globals.LEAF == type || Globals.BARK == type )
			{
				write( $guid, gc, Globals.AIR );
			}
		}
		
		public function lightingReset():void {

			if ( childrenHas() )
			{
				for each ( var child:Oxel in children )
				{
					child.lightingReset();
				}
			}
			else if ( _brightness )
			{
				_brightness.reset();
			}
		}
		
		public function lightingSunGatherList( ol:Vector.<Oxel> ):void {

			if ( childrenHas() )
			{
				for each ( var child:Oxel in children )
					child.lightingSunGatherList( ol );
			}
			else if ( Globals.AIR != type )
			{
				var no:Oxel = neighbor( Globals.POSY );
				if ( Globals.BAD_OXEL == no ) {
					ol.push( this );
					//trace( "light it - Globals.BAD_OXEL" + "  gc: " + gc.toString() );
				}
				else if ( no.childrenHas() )
				{
					// check opposite face to see if it has alpha
					if ( no.faceHasAlpha( Globals.NEGY ) ) {
						ol.push( this );
						//trace( "light it has hole - notype: " + no.type + "  gc: " + gc.toString() + "  no.gc: " + no.gc.toString() );
					}
				}
				else if ( !no.isSolid )	{
					ol.push( this );
					//trace( "light it - notype: " + no.type + "  gc: " + gc.toString() + "  no.gc: " + no.gc.toString() );
				}
				//else if ( !no.isSolid )	
				//	trace( "ignore - : " + type + "  gc: " + gc.toString() );

			}
		}
		
		public static var TEMP_COUNT:int = 0;
		public function layDownWater( $waterHeight:int ):void
		{
			// If this is below water height it should be full of water.
			var bottom_height:int = gc.getModelY();
			var top_height:int = gc.getModelY() + gc.size();
			var child:Oxel;
			// bottom of oxel is at water height or greater
			if ( childrenHas() )
			{
				for each ( child in children )
					child.layDownWater( $waterHeight );
			}
			else if ( bottom_height >= $waterHeight )
			{
				// This is oxel above water height, nothing to see here
				return;
			}
			else if ( top_height <= $waterHeight )
			{
				// This is oxel is below the water height, it better be full
				// if it has children keep on digging down
				if ( childrenHas() )
				{
					for each ( child in children )
						child.layDownWater( $waterHeight );
				}
				else if ( Globals.AIR == type )
				{
					type = Globals.WATER;
					//writeFromHeightMap( gc, Globals.AIR );
				}
//				else if ( Globals.DIRT != type )
//					Log.out( "what did I hit? type: " + Globals.Info[type].name );
			}
			else if ( top_height >= $waterHeight && bottom_height < $waterHeight )
			{
				// Still something wrong here...
				
				// This is on the boarder, it needs to be broken up
				if ( !childrenHas() )
				{
					TEMP_COUNT += 8;
					//Log.out( "Oxel.layDownWater - CREATED CHILDREN: " + TEMP_COUNT );
					childrenCreate();
				}

				for each ( child in children)
					child.layDownWater( $waterHeight );
			}
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Explosion Event Helpers START
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Not sure what this does - RSF
		public function breakFromParent():void
		{
			gc.bound = _parent.gc.bound - 1;
			gc.grainX = 0;
			gc.grainY = 0;
			gc.grainZ = 0;
			if ( childrenHas() )
				calculateGC();
			Log.out( "Oxel.breakFromParent - This should NEVER happen " );
			_vertMan = new VertexManager();
			_parent = null;
		}
		
		public function calculateGC():void
		{
			var gct:GrainCursor = GrainCursorPool.poolGet(root_get().gc.bound );
			for ( var i:int = 0; i < OXEL_CHILD_COUNT; i++ )
			{
				gct.copyFrom( gc );
				gct.become_child( i );   
				children[i].gc.copyFrom( gct );
				if ( true == children[i].childrenHas() )
					children[i].calculateGC();
			}
			GrainCursorPool.poolDispose( gct );
			
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Explosion Event Helpers END
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function generateID( $guid:String ):String {
			return $guid + _gc.toID();
		}
		
		static public function childIdOpposite( $face:uint, $childID:uint ):uint {
			if ( 0 == $childID ) {
				if ( Globals.NEGX == $face ) return 1;
				if ( Globals.NEGY == $face ) return 2;
				if ( Globals.NEGZ == $face ) return 4;
				trace( "GrainCursor.childIdOpposite - unknown face for childId: " + $childID + "  face: " + $face );
			}
			else if ( 1 == $childID ) {
				if ( Globals.POSX == $face ) return 0;
				if ( Globals.NEGY == $face ) return 3;
				if ( Globals.NEGZ == $face ) return 5;
				trace( "GrainCursor.childIdOpposite - unknown face for childId: " + $childID + "  face: " + $face );
			}
			else if ( 2 == $childID ) {
				if ( Globals.NEGX == $face ) return 3;
				if ( Globals.POSY == $face ) return 0;
				if ( Globals.NEGZ == $face ) return 6;
				trace( "GrainCursor.childIdOpposite - unknown face for childId: " + $childID + "  face: " + $face );
			}
			else if ( 3 == $childID ) {
				if ( Globals.POSX == $face ) return 2;
				if ( Globals.POSY == $face ) return 1;
				if ( Globals.NEGZ == $face ) return 7;
				trace( "GrainCursor.childIdOpposite - unknown face for childId: " + $childID + "  face: " + $face );
			}
			else if ( 4 == $childID ) {
				if ( Globals.NEGX == $face ) return 5;
				if ( Globals.NEGY == $face ) return 6;
				if ( Globals.POSZ == $face ) return 0;
				trace( "GrainCursor.childIdOpposite - unknown face for childId: " + $childID + "  face: " + $face );
			}
			else if ( 5 == $childID ) {
				if ( Globals.POSX == $face ) return 4;
				if ( Globals.NEGY == $face ) return 7;
				if ( Globals.POSZ == $face ) return 1;
				trace( "GrainCursor.childIdOpposite - unknown face for childId: " + $childID + "  face: " + $face );
			}
			else if ( 6 == $childID ) {
				if ( Globals.NEGX == $face ) return 7;
				if ( Globals.POSY == $face ) return 4;
				if ( Globals.POSZ == $face ) return 2;
				trace( "GrainCursor.childIdOpposite - unknown face for childId: " + $childID + "  face: " + $face );
			}
			else if ( 7 == $childID ) {
				if ( Globals.POSX == $face ) return 6;
				if ( Globals.POSY == $face ) return 5;
				if ( Globals.POSZ == $face ) return 3;
				trace( "GrainCursor.childIdOpposite - unknown face for childId: " + $childID + "  face: " + $face );
			}
			else
				trace( "GrainCursor.childIdOpposite - unknown $childID for childId: " + $childID + "  face: " + $face );
			
			return 0;	
		}
		
		
	} // end of class Oxel
	
} // end of package

/*
		public function toxLoad( parent:Oxel, $gc:GrainCursor, ba:ByteArray, rootGrainSize:int ):ByteArray 
		{
			var data:int = ba.readByte();
			if ( 0 == data )
				data = Globals.AIR;
			initializeTox( parent, $gc, data );
			var isParent:int = ba.readByte();
			if ( 0 < isParent )
			{
				this.markAsParent();
				_children = ChildOxelPool.child_vector_get();
				var gct:GrainCursor = GrainCursorPool.poolGet( rootGrainSize );
				for ( var i:int = 0; i < OXEL_CHILD_COUNT; i++ )
				{
					_children[i]  = OxelPool.oxel_get();
					gct.copyFrom($gc);
					gct.become_child(i);   
					_children[i].toxLoad( this, gct, ba, rootGrainSize );
				}
				GrainCursorPool.poolDispose( gct );
			}
			
			return ba;
		}
		// What should only be used when loading from byte array data.
		public function initializeTox( $parent:Oxel, $gc:GrainCursor, $type:int = 0 ):void
		{
			_parent = $parent;
			_data = $type;
			_gc = GrainCursorPool.poolGet($gc.bound);
			gc.copyFrom( $gc );
			dirty = true;
			faces_mark_all_dirty();

			if ( null == _parent || (_vertMan && _vertMan.minGrain == gc.grain)  )
			{
				_vertMan = new VertexManager();	
			}
			//trace( "Oxel.initialize: " + toString() );
		}
*/
		
