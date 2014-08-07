/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.events.GUIEvent;
	import com.voxelengine.GUI.QuickInventory;
	import com.voxelengine.pools.LightingPool;
	import com.voxelengine.worldmodel.oxel.GrainCursorIntersection;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import flash.display3D.Context3D;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.oxel.*;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.models.ModelInfo;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.worldmodel.tasks.flowtasks.CylinderOperation;
	import com.voxelengine.worldmodel.tasks.flowtasks.SphereOperation;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * 
	 */
	public class EditCursor extends VoxelModel
	{
		static public const EDIT_CURSOR:String 		= "EditCursor";
		
		static public	const CURSOR_TYPE_GRAIN:int 		= 0;
		static public	const CURSOR_TYPE_SPHERE:int 		= 1;		
		static public	const CURSOR_TYPE_SQUARE:int 		= 2;		
		static public	const CURSOR_TYPE_CYLINDER:int 		= 3;		
		
		static public	const CURSOR_OP_NONE:int 			= 0;
		static public	const CURSOR_OP_INSERT:int 			= 1;
		static public 	const CURSOR_OP_DELETE:int 			= 2;

		static 	private	const SCALE_FACTOR:Number 			= 0.01;
		
		static 	private var   _s_editCursorSize:int			 = 0;			// this allows me to go from model to model with the same size cursor.
		static  private var   _s_cursorColor:int			 = 1000; 		// Globals.EDITCURSOR_SQUARE;
		static 	private var   _s_cursorType:int = CURSOR_TYPE_GRAIN;		// round, square, cylinder
		static 	private var   _s_cursorOperation:int = CURSOR_OP_NONE;		// none, insert, delete
		
        static private 	var	  _repeatTime:int = 100;
		static private 	var   _repeatTimer:Timer;
		static private  var   _count:int = 0;
		
		static public function get cursorColor():int { return _s_cursorColor; }
		static public function set cursorColor(val:int):void { _s_cursorColor = val; }
		static public function get cursorType():int { return _s_cursorType; }
		static public function set cursorType(val:int):void { _s_cursorType = val; }
		static public function get cursorOperation():int { return _s_cursorOperation; }
		static public function set cursorOperation(val:int):void { _s_cursorOperation = val; }
		static public function get editCursorSize():int { return _s_editCursorSize; }
		static public function set editCursorSize(val:int):void { _s_editCursorSize = val; }
		
		private 		var   _gciData:GrainCursorIntersection = null;
		public function get gciData():GrainCursorIntersection { return _gciData; }
		public function set gciData(value:GrainCursorIntersection):void { _gciData = value; }
		
		static public function create():EditCursor 
		{
			var instanceInfo:InstanceInfo = new InstanceInfo();
			instanceInfo.instanceGuid = EDIT_CURSOR;
			instanceInfo.templateName = EDIT_CURSOR

			var modelInfo:ModelInfo = new ModelInfo();
			modelInfo.fileName = EDIT_CURSOR;
			modelInfo.modelClass = EDIT_CURSOR;

			
			return new EditCursor( instanceInfo, modelInfo );
		}
		
		override public function get visible():Boolean
		{
			Globals.g_app.addEventListener( GUIEvent.APP_DEACTIVATE, onDeactivate );
			return super.visible;
		}
		
		override public function set visible( $val:Boolean ):void
		{
			Globals.g_app.removeEventListener( GUIEvent.APP_DEACTIVATE, onDeactivate );
			super.visible = $val;
		}
		
		
		protected function onDeactivate( e:GUIEvent ):void 
		{
			//Log.out( "EditCursor.onDeactivate - disabling repeat" );
			// We dont want the repeat on if app loses focus
			EditCursor.mouseUp( null );
		}
		
		public function EditCursor( instanceInfo:InstanceInfo, mi:ModelInfo ):void 
		{
			super( instanceInfo, mi );
			oxel.gc.bound = 4;
			visible = false;
		}

		public function clearGCIData():void 
		{
			gciData = null;
		}
		
		public function setGCIData( $gciData:GrainCursorIntersection ):void 
		{
			gciData = $gciData;
			visible = true;

			var gct:GrainCursor = GrainCursorPool.poolGet( $gciData.model.oxel.gc.bound );
			GrainCursor.getFromPoint( $gciData.point.x, $gciData.point.y, $gciData.point.z, gct );
			// we have to make the grain scale up to the size of the edit cursor
			gct.become_ancestor( oxel.gc.grain );
			instanceInfo.positionSetComp( gct.getModelX(), gct.getModelY(), gct.getModelZ() );
			_gciData.gc.copyFrom( gct );
			GrainCursorPool.poolDispose( gct );
			var selectedCursor:int = cursorColor;
			oxel.quadsDeleteAll();
			oxel.faces_clear_all();
			oxel.faces_mark_all_clean();
			var gcCursor:GrainCursor = GrainCursorPool.poolGet( oxel.gc.bound );
			if ( CURSOR_OP_INSERT == cursorOperation ) {
				
				var pl:PlacementLocation = getPlacementLocation( gciData.model );
				if ( PlacementLocation.INVALID == pl.state )
					selectedCursor = 1004; // EDITCURSOR_INVALID;

				// We have to manually delete all of the quads so that they can be rebuilt
				// This method shows only the two faces aligned with axis
				switch ( gciData.axis )
				{
					case 0:
						oxel.face_set( Globals.POSX );
						oxel.face_set( Globals.NEGX );
						break;
					case 1:
						oxel.face_set( Globals.POSY );
						oxel.face_set( Globals.NEGY );
						break;
					case 2:
						oxel.face_set( Globals.POSZ );
						oxel.face_set( Globals.NEGZ );
						break;
				}
				if ( !oxel.brightness )
					oxel.brightness = LightingPool.poolGet();
				oxel.brightness.setAll( Lighting.DEFAULT_LIGHT_ID, Lighting.MAX_LIGHT_LEVEL );
				gcCursor.set_values( 0, 0, 0, oxel.gc.grain )
				oxel.write( EditCursor.EDIT_CURSOR, gcCursor, selectedCursor, true );
			}
			else
			{
				oxel.faces_set_all();
				gcCursor.set_values( 0, 0, 0, oxel.gc.grain )
				oxel.write( EditCursor.EDIT_CURSOR, gcCursor, selectedCursor, true );
				if ( !oxel.brightness )
					oxel.brightness = LightingPool.poolGet();
				var li:LightInfo = oxel.brightness.lightGet( Lighting.DEFAULT_LIGHT_ID );
				li.color = cursorColorRainbow();
			}
			
			oxel.quadsBuild();
			GrainCursorPool.poolDispose( gcCursor );
		}
		
		private var _phase:Number = 0;
		private function cursorColorRainbow():uint {
			var frequency:Number = 2.4;
			var red:uint = Math.max( 0, Math.sin( frequency + 2 + _phase ) ) * 255;
			var green:uint = Math.max( 0, Math.sin( frequency + 0 + _phase ) ) * 255;
			var blue:uint = Math.max( 0, Math.sin( frequency + 4 + _phase ) ) * 255;
			var color:uint;
			color |= red << 16;
			color |= green << 8;
			color |= blue << 0;
			_phase += 0.03;
			return color;
		}
		
		
		override public function draw(mvp:Matrix3D, $context:Context3D, $isChild:Boolean ):void	{

			var t:Number = oxel.gc.size() * SCALE_FACTOR/2;
			
			var viewMatrix:Matrix3D = instanceInfo.worldSpaceMatrix.clone();
			viewMatrix.prependScale( 1 + SCALE_FACTOR, 1 + SCALE_FACTOR, 1 + SCALE_FACTOR ); 
			var positionscaled:Vector3D = viewMatrix.position;
			viewMatrix.prependTranslation( -t, -t, -t)
			viewMatrix.append(mvp);
			
			oxel.drawNew( viewMatrix, this, $context, _shaders, selected, $isChild );
		}
		
		override public function drawAlpha( mvp:Matrix3D,$context:Context3D, $isChild:Boolean ):void 
		{
			var t:Number = oxel.gc.size() * SCALE_FACTOR/2;
			
			var viewMatrix:Matrix3D = instanceInfo.worldSpaceMatrix.clone();
			viewMatrix.prependScale( 1 + SCALE_FACTOR, 1 + SCALE_FACTOR, 1 + SCALE_FACTOR ); 
			var positionscaled:Vector3D = viewMatrix.position;
			viewMatrix.prependTranslation( -t, -t, -t)
			viewMatrix.append(mvp);
			
			oxel.drawNewAlpha( viewMatrix, this, $context, _shaders, selected, $isChild );
		}
		
		override public function update($context:Context3D, elapsedTimeMS:int ):void
		{
			// the grain should never be larger then the bound
			if ( oxel.gc.bound < editCursorSize )
			{
				oxel.gc.grain = oxel.gc.bound;
				editCursorSize = oxel.gc.bound;
			}
			else
			{
				oxel.gc.grain =  editCursorSize;
			}
			
			internal_update($context, elapsedTimeMS );
		}
		
		override public function initialize($context:Context3D ):void 
		{
			internal_initialize($context );
			visible = false;
			Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			Globals.g_app.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			Globals.g_app.stage.addEventListener(MouseEvent.CLICK, mouseClick);
			Globals.g_app.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);

			if ( oxel.gc.grain == editCursorSize )
				return;
			else if ( oxel.gc.grain < editCursorSize )
				growCursor();
			else if ( oxel.gc.grain > editCursorSize )
				shrinkCursor();
		}

		override public function release():void 
		{
			if ( oxel )
				oxel.release();
				
			Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			Globals.g_app.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			Globals.g_app.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		static private function isAvatarInsideThisOxel( vm:VoxelModel, oxel:Oxel ):Boolean
		{
			var mp:Vector3D = vm.worldToModel( Globals.g_modelManager.worldSpaceStartPoint );
			// check head
			var result:Boolean = oxel.gc.is_point_inside( mp );
			// and foot
			mp.y -= Globals.AVATAR_HEIGHT;
			result = result || oxel.gc.is_point_inside( mp );
			return result;
		}
		
		static public function getHighlightedOxel(recurse:Boolean = false):Oxel {
			
			var foundModel:VoxelModel = Globals.selectedModel;
			// placementResult - { oxel:Globals.BAD_OXEL, gci:gci, positive:posMove, negative:negMove };
			var placementResult:PlacementLocation = getPlacementLocation( foundModel );
			if ( PlacementLocation.INVALID == placementResult.state )
			{
				Log.out( "EditCursor.getHighlightedOxel NO PLACEMENT FOUND" );
				return Globals.BAD_OXEL;
			}
			var oxelToBeModified:Oxel = foundModel.oxel.childGetOrCreate( placementResult.gc );
			if ( Globals.BAD_OXEL == oxelToBeModified )
			{
				Log.out( "EditCursor.getHighlightedOxel BAD OXEL OLD" );
				if ( recurse )
					return Globals.BAD_OXEL;
					
				if ( placementResult && null == placementResult.gci )
					return Globals.BAD_OXEL;
					
				if ( foundModel.editCursor.gciData )
				{
					Log.out( "EditCursor.getHighlightedOxel BAD OXEL NEW gciData.point" + foundModel.editCursor.gciData.point + "  gciData.gc: " + foundModel.editCursor.gciData.gc );
					// What does this do?
					insertOxel( true );
					return Globals.BAD_OXEL;
				}
//					foundModel.grow( placementResult );
			}
			
			return oxelToBeModified;
		}
		
		static private function insertOxel(recurse:Boolean = false):void
		{
			if ( CURSOR_OP_INSERT != _s_cursorOperation )
				return;

			var foundModel:VoxelModel = Globals.selectedModel;
			if ( foundModel )
			{
				var oxelToBeModified:Oxel = getHighlightedOxel( recurse );
				if ( Globals.BAD_OXEL == oxelToBeModified )
				{
					Log.out( "EditCursor.insertOxel - Invalid location" );
					return;
				}
				
				if ( isAvatarInsideThisOxel( foundModel, oxelToBeModified ) )
				{
					Log.out( "EditCursor.insertOxel - Trying to place an oxel on top of ourself" );
					return;
				}
				
				if ( CURSOR_TYPE_GRAIN == cursorType )
				{
					foundModel.write( oxelToBeModified.gc, cursorColor );
				}
				else if ( CURSOR_TYPE_SPHERE == cursorType )
				{
					sphereOperation();				 
				}
				else if ( CURSOR_TYPE_SQUARE == cursorType )
				{
					Log.out( "EditCursor.InsertOxel - CURSOR_TYPE_SQUARE not supported yet" );
				}
				else if ( CURSOR_TYPE_CYLINDER == cursorType )
				{
					cylinderOperation();				 
				}
			}
		}
		
		static private function getPlacementLocation( foundModel:VoxelModel ):PlacementLocation
		{
			var gci:GrainCursorIntersection = foundModel.editCursor.gciData;
			var pl:PlacementLocation = new PlacementLocation();
			if ( gci )
			{
				// to determine whether a block can be placed
				// first get the camera position, and change the coordinates from world to model
				// then use the axis of the active face, to step a block forward and backward along that axis
				// watch the results of the step, to see if a blocks has been sent out of bounds.
				// now for valid steps (not oob), choose the one which is the lesser distance from the camera.
				//var startPoint:Vector3D = gci.model.worldToModel( Globals.controlledModel.instanceInfo.positionGet );
				// This seems to fix problem with distance calculation not working correct when using avatar origin ONCE in a while
				var startPoint:Vector3D = gci.model.worldToModel( Globals.g_modelManager.worldSpaceStartPoint );
				var placedGC:GrainCursor = GrainCursorPool.poolGet( foundModel.oxel.gc.bound );
				var negPlacedGC:GrainCursor = GrainCursorPool.poolGet( foundModel.oxel.gc.bound );
				var posMove:Boolean = false;
				var negMove:Boolean = false;
				var posxDist:Number = 0.0;
				var negxDist:Number = 0.0;
				switch ( gci.axis )
				{
					case 0:
						placedGC.copyFrom( gci.gc );
						posMove = placedGC.move_posx();
						posxDist = placedGC.GetDistance( startPoint );
						
						negPlacedGC.copyFrom( gci.gc );
						negMove = negPlacedGC.move_negx();
						negxDist = negPlacedGC.GetDistance( startPoint );
						break;
					case 1:
						placedGC.copyFrom( gci.gc );
						posMove = placedGC.move_posy();
						posxDist = placedGC.GetDistance( startPoint );
						
						negPlacedGC.copyFrom( gci.gc );
						negMove = negPlacedGC.move_negy();
						negxDist = negPlacedGC.GetDistance( startPoint );
						break;
					case 2:
						placedGC.copyFrom( gci.gc );
						posMove = placedGC.move_posz();
						posxDist = placedGC.GetDistance( startPoint );
						
						negPlacedGC.copyFrom( gci.gc );
						negMove = negPlacedGC.move_negz();
						negxDist = negPlacedGC.GetDistance( startPoint );
						break;
				}
				
				placedGC.copyFrom( gci.gc );
				if ( posxDist > negxDist ) 
				{
					if ( negMove )
					{
						switch ( gci.axis )
						{
							case 0: placedGC.move_negx(); break;
							case 1: placedGC.move_negy(); break;
							case 2: placedGC.move_negz(); break;
						}
						pl.state = PlacementLocation.VALID
					}
					else
						pl.state = PlacementLocation.INVALID
				}
				else
				{
					if ( posMove )
					{
						switch ( gci.axis )
						{
							case 0: placedGC.move_posx(); break;
							case 1: placedGC.move_posy(); break;
							case 2: placedGC.move_posz(); break;
						}
						pl.state = PlacementLocation.VALID
					}
					else
						pl.state = PlacementLocation.INVALID
				}
				if ( PlacementLocation.VALID == pl.state ) {
					pl.gci = gci;
					pl.negative = negMove;
					pl.positive = posMove;
					pl.gc.copyFrom( placedGC );
				}
				GrainCursorPool.poolDispose( placedGC );
				GrainCursorPool.poolDispose( negPlacedGC );
			}
			
			return pl;
		}
		
		static private function getOxelFromPoint( vm:VoxelModel, gci:GrainCursorIntersection ):Oxel
		{
			var gcDelete:GrainCursor = GrainCursorPool.poolGet( vm.oxel.gc.bound );
			// This is where it intersects with a grain 0
			gcDelete.grainX = int( vm.editCursor.instanceInfo.positionGet.x + 0.05 );
			gcDelete.grainY = int( vm.editCursor.instanceInfo.positionGet.y + 0.05 );
			gcDelete.grainZ = int( vm.editCursor.instanceInfo.positionGet.z + 0.05 );
			// we have to make the grain scale up to the size of the edit cursor
			gcDelete.become_ancestor( vm.editCursor.oxel.gc.grain );
			var oxelToBeDeleted:Oxel = vm.oxel.childFind( gcDelete );
			GrainCursorPool.poolDispose( gcDelete );
			return oxelToBeDeleted;
		}
		
		static private function deleteOxel():void
		{
			if ( CURSOR_OP_DELETE != _s_cursorOperation )
				return;

			var foundModel:VoxelModel;
			if ( Globals.selectedModel )
			{
				if ( Globals.g_app.toolOrBlockEnabled )
				{
					Globals.player.stateSet( "Pick", 1 );
					Globals.player.stateLock( true, 300 );

				}
				
				
				foundModel = Globals.selectedModel;
				var fmRoot:Oxel = foundModel.oxel;
				if ( CURSOR_TYPE_GRAIN == cursorType )
				{
					var gcDelete:GrainCursor = GrainCursorPool.poolGet(foundModel.oxel.gc.bound);
					// This is where it intersects with a grain 0
					gcDelete.grainX = int( foundModel.editCursor.instanceInfo.positionGet.x + 0.05 );
					gcDelete.grainY = int( foundModel.editCursor.instanceInfo.positionGet.y + 0.05 );
					gcDelete.grainZ = int( foundModel.editCursor.instanceInfo.positionGet.z + 0.05 );
					// we have to make the grain scale up to the size of the edit cursor
					gcDelete.become_ancestor( foundModel.editCursor.oxel.gc.grain );
					var oxelToBeDeleted:Oxel = foundModel.oxel.childGetOrCreate( gcDelete );
					if ( Globals.BAD_OXEL != oxelToBeDeleted )
						foundModel.write( gcDelete, Globals.AIR );
					GrainCursorPool.poolDispose( gcDelete );
				}
				else if ( CURSOR_TYPE_SPHERE == cursorType )
				{
					var gci:GrainCursorIntersection = foundModel.editCursor.gciData;
					var cuttingPoint:Vector3D = new Vector3D();
					if ( 0 == gci.axis ) // x
					{
						cuttingPoint.x = gci.point.x;
						cuttingPoint.y = gci.gc.getModelY() + gci.gc.size() / 2;
						cuttingPoint.z = gci.gc.getModelZ() + gci.gc.size() / 2;
					}
					else if ( 1 == gci.axis )  // y
					{
						cuttingPoint.x = gci.gc.getModelX() + gci.gc.size() / 2;
						cuttingPoint.y = gci.point.y;
						cuttingPoint.z = gci.gc.getModelZ() + gci.gc.size() / 2;
					}
					else 
					{
						cuttingPoint.x = gci.gc.getModelX() + gci.gc.size() / 2;
						cuttingPoint.y = gci.gc.getModelY() + gci.gc.size() / 2;
						cuttingPoint.z = gci.point.z;
					}
					foundModel.empty_sphere(  cuttingPoint.x
											, cuttingPoint.y
											, cuttingPoint.z
											, gci.gc.size() / 2
											, 0 );
				}
				else if ( CURSOR_TYPE_SQUARE == cursorType )
				{
					foundModel.empty_square( int(foundModel.editCursor.gciData.point.x)
												, int(foundModel.editCursor.gciData.point.y)
												, int(foundModel.editCursor.gciData.point.z)
												, foundModel.editCursor.gciData.gc.size() / 2
												, 0 );
				}
				else if ( CURSOR_TYPE_CYLINDER == cursorType )
				{
					cylinderOperation();				 
				}
				else
				{
					throw new Error( "EditCursor.keyDown - Cursor type not found" );
				}
			}
		}

		static private function sphereOperation():void
		{
			var foundModel:VoxelModel = Globals.selectedModel;
			if ( foundModel )
			{
				var gciCyl:GrainCursorIntersection = foundModel.editCursor.gciData;
				var where:GrainCursor = null;
				
				var radius:int = gciCyl.gc.size()/2;
				
				var what:int = cursorColor;
				if ( CURSOR_OP_INSERT == _s_cursorOperation )
				{
					var placementResult:PlacementLocation = getPlacementLocation( foundModel );
					if ( PlacementLocation.INVALID == placementResult.state )
						return;
					
					//where = placementResult.gci.gc;
					where = placementResult.gc;
				}
				else
				{
					where = gciCyl.gc;
					radius -= radius / 8
					what = Globals.AIR;
				}
				
				var cuttingPointCyl:Vector3D = new Vector3D();
				cuttingPointCyl.x = where.getModelX() + radius;
				cuttingPointCyl.y = where.getModelY() + radius
				cuttingPointCyl.z = where.getModelZ() + radius
				
				var minGrain:int = Math.max( foundModel.editCursor.oxel.gc.grain - 4, 0 );
				var startingGrain:int = foundModel.editCursor.oxel.gc.grain - 1;
				//SphereOperation( gc:GrainCursor, what:int, guid:String,	cx:int, cy:int, cz:int, radius:int, currentGrain:int, gmin:uint = 0  ):void 				
				new SphereOperation( where
									 , what
									 , foundModel.instanceInfo.instanceGuid
									 , cuttingPointCyl.x
									 , cuttingPointCyl.y
									 , cuttingPointCyl.z
									 , radius
									 , startingGrain
									 , minGrain );
			}
		}
		
		static private function cylinderOperation():void
		{
			var foundModel:VoxelModel = Globals.selectedModel;
			if ( foundModel && foundModel.editCursor.gciData )
			{
				var gciCyl:GrainCursorIntersection = foundModel.editCursor.gciData;
				var where:GrainCursor = null;
				
				var offset:int = 0;
				var radius:int = gciCyl.gc.size()/2;
				var cuttingPointCyl:Vector3D = new Vector3D();
				if ( 0 == gciCyl.axis ) // x
				{
					cuttingPointCyl.x = gciCyl.point.x + offset;
					cuttingPointCyl.y = gciCyl.gc.getModelY() + radius;
					cuttingPointCyl.z = gciCyl.gc.getModelZ() + radius;
				}
				else if ( 1 == gciCyl.axis )  // y
				{
					cuttingPointCyl.x = gciCyl.gc.getModelX() + radius;
					cuttingPointCyl.y = gciCyl.gc.getModelY();
					//cuttingPointCyl.y = gciCyl.point.y + offset;
					cuttingPointCyl.z = gciCyl.gc.getModelZ() + radius;
				}
				else 
				{
					cuttingPointCyl.x = gciCyl.gc.getModelX() + radius;
					cuttingPointCyl.y = gciCyl.gc.getModelY() + radius;
					cuttingPointCyl.z = gciCyl.point.z + offset;
				}
				
				var what:int = cursorColor;
				if ( CURSOR_OP_INSERT == _s_cursorOperation )
				{
					offset = gciCyl.gc.size();
					var pl:PlacementLocation = getPlacementLocation( foundModel );
					if ( PlacementLocation.INVALID == pl.state )
						return;
					
					//where = temp.gci.gc;						
					where = pl.gc;
				}
				else // CURSOR_OP_DELETE
				{
					where = gciCyl.gc;
					radius -= radius / 8
					//radius += radius / 16
					what = Globals.AIR;
				}
					
				var minGrain:int = Math.max( foundModel.editCursor.oxel.gc.grain - 5, 0 );
				var startingGrain:int = foundModel.editCursor.oxel.gc.grain - 1;
				if ( where )
				{
					new CylinderOperation( where
										 , what
										 , foundModel.instanceInfo.instanceGuid
										 , cuttingPointCyl.x
										 , cuttingPointCyl.y
										 , cuttingPointCyl.z
										 , gciCyl.axis
										 , radius
										 , startingGrain
										 , minGrain );
				}
			}
		}
		
		static private function keyDown(e:KeyboardEvent):void 
		{
			if ( Globals.GUIControl || !Globals.clicked )
				return;
				
			var foundModel:VoxelModel;
			switch (e.keyCode) 
			{
				case Keyboard.F:
					if ( true == Globals.g_app.editing && true == Globals.g_app.toolOrBlockEnabled )
					{
						if ( 0 == QuickInventory.currentItemSelection )
							deleteOxel();
						else if ( 1 < QuickInventory.currentItemSelection )
							insertOxel();
					}
					break;
				case 107: case Keyboard.NUMPAD_ADD:
				case 45: case Keyboard.INSERT:
						insertOxel();
					break;
				case 189: case Keyboard.MINUS: 
				case 46: case Keyboard.DELETE: 
				case 109: case Keyboard.NUMPAD_SUBTRACT: 
						deleteOxel();
					break;
				case 33: case Keyboard.PAGE_UP:
						EditCursor.editCursorSize = EditCursor.editCursorSize + 1;
						growCursor()
					break;
					
				case 34: case Keyboard.PAGE_DOWN:
						EditCursor.editCursorSize = EditCursor.editCursorSize - 1;
						shrinkCursor();
					break;
			}
		}
		
		static public function growCursor():void
		{
			if ( Globals.selectedModel )
			{
				Globals.selectedModel.editCursor.oxel.gc.bound = Globals.selectedModel.oxel.gc.bound;
				var gcGrow:GrainCursor = Globals.selectedModel.editCursor.oxel.gc;
				
				// If edit cursor wants to be larger the the size of the selected object
				// then set it to the size of the selected object
				if ( Globals.selectedModel.oxel.gc.grain < EditCursor.editCursorSize )
					EditCursor.editCursorSize = Globals.selectedModel.oxel.gc.grain;
					
				if ( gcGrow.grain < Globals.selectedModel.oxel.gc.grain )
				{
					for ( var i:int = gcGrow.grain; i < EditCursor.editCursorSize; i++ )
						gcGrow.grain = ++gcGrow.grain;
						
					editCursorSize = gcGrow.grain;
					Globals.selectedModel.editCursor.oxel.faces_rebuild( EDIT_CURSOR );
				}
			}
		}
		
		static public function shrinkCursor():void
		{
			if ( Globals.selectedModel )
			{
				var gcShrink:GrainCursor = Globals.selectedModel.editCursor.oxel.gc;
				if ( 0 < gcShrink.grain )
				{
					var currentSize:int = gcShrink.grain;
					for ( var i:int = EditCursor.editCursorSize; i < currentSize; i++ )
						gcShrink.grain = --gcShrink.grain;
					editCursorSize = gcShrink.grain;
					Globals.selectedModel.editCursor.oxel.faces_rebuild( EDIT_CURSOR );
				}
			}	
		}
		
		static protected function onRepeat(event:TimerEvent):void
		{
			if ( Globals.GUIControl )
				return;
				
			if ( 1 < _count )
			{
				if ( CURSOR_OP_DELETE == _s_cursorOperation )
					deleteOxel();
				else if ( CURSOR_OP_INSERT == _s_cursorOperation )
					insertOxel();
			}
			_count++;
		}

		static private function mouseUp(e:MouseEvent):void 
		{
			if ( _repeatTimer )
				_repeatTimer.removeEventListener( TimerEvent.TIMER, onRepeat );
			_count = 0;	
		}
		
		static private function mouseDown(e:MouseEvent):void 
		{
			//Log.out( "EditCursor.mouseDown GUIControl: " + Globals.GUIControl + "  Globals.clicked: " + Globals.clicked );
			if ( Globals.GUIControl || !Globals.clicked )
				return;
				
			_repeatTimer = new Timer( 200 );
			_repeatTimer.addEventListener(TimerEvent.TIMER, onRepeat);
			_repeatTimer.start();
			
			var foundModel:VoxelModel;
			switch (e.type) 
			{
				case "mouseDown": case Keyboard.NUMPAD_ADD:
					if ( CURSOR_OP_DELETE == _s_cursorOperation )
						deleteOxel();
					else if ( CURSOR_OP_INSERT == _s_cursorOperation )
						insertOxel();
					break;
			}
		}
		
		static private function mouseClick(e:MouseEvent):void 
		{
			//Log.out( "EditCursor.initialize - mouseClick mouseClick mouseClick" );
		}
		
		static public function setPickColorFromType( type:int ):void
		{
			switch ( type )
			{
				case EditCursor.CURSOR_TYPE_CYLINDER:
					EditCursor.cursorColor = Globals.EDITCURSOR_CYLINDER;
					break;
				case EditCursor.CURSOR_TYPE_SPHERE:
					EditCursor.cursorColor = Globals.EDITCURSOR_ROUND;
					break;
				case EditCursor.CURSOR_TYPE_GRAIN:
					EditCursor.cursorColor = Globals.EDITCURSOR_SQUARE;
					break;
			} 
		}
		
		
	}
}

import com.voxelengine.worldmodel.oxel.GrainCursorIntersection;
import com.voxelengine.worldmodel.oxel.GrainCursor;
import com.voxelengine.worldmodel.oxel.Oxel;
import com.voxelengine.Globals;

internal class PlacementLocation
{
	static public const INVALID:int = 0;
	static public const VALID:int = 1;
//	public var oxel:Oxel = Globals.BAD_OXEL
	public var gc:GrainCursor = new GrainCursor();
	public var gci:GrainCursorIntersection
	public var positive:Boolean;
	public var negative:Boolean;
	public var state:int = INVALID;
}