/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
	import com.voxelengine.events.LightEvent;
	import com.voxelengine.worldmodel.TypeInfo;
	import flash.geom.Vector3D;
	import com.developmentarc.core.tasks.events.TaskEvent;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.lighting.LightTask;
	import com.voxelengine.worldmodel.oxel.Brightness;
	import com.voxelengine.pools.BrightnessPool;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.pools.OxelPool;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class Light extends LightTask 
	{		
		/**
		 *  
		 * @param $instanceGuid - guid of parent model
		 * @param $gc of oxel that HAS light attributes
		 * @param $lightID a light id
		 * @param $color a light color
		 * 
		 */
		static public function handleLightEvents( $le:LightEvent ):void {
			if ( LightEvent.ADD == $le.type )
			{
				var vm:VoxelModel = Globals.g_modelManager.getModelInstance( $le.instanceGuid );
				main:if ( vm ) {
					var lo:Oxel = vm.oxel.childGetOrCreate( $le.gc );
					if ( valid( lo ) )
					{
						var ti:TypeInfo = Globals.Info[lo.type];
						lo.brightness.colorAdd( ti.color, $le.lightID, true );
						lo.brightness.lastLightID = $le.lightID;
						if ( lo.parent ) {
							if ( null == lo.parent.brightness )
								lo.parent.brightness = BrightnessPool.poolGet();
							lo.parent.brightness.deriveFromChildOxel( lo );
						}
					}
					
					addTask( $le.instanceGuid, $le.gc, $le.lightID );
				}
			}
		}
		 
		static public function addTask( $instanceGuid:String, $gc:GrainCursor, $lightID:uint ):void {
			//Log.out( "Light.addTask: for gc: " + $gc.toString() + "  taskId: " + $gc.toID() );
			var lt:Light = new Light( $instanceGuid, $gc, $lightID, $gc.toID(), $gc.grain );
			lt.selfOverride = true;
			Globals.g_lightTaskController.addTask( lt );
		}
		
		// NEVER use this, use the static function
		public function Light( $instanceGuid:String, $gc:GrainCursor, $lightID:uint, $taskType:String, $taskPriority:int ):void {
//			super( $instanceGuid, $gc, $gc.toID(), $gc.grain );
			super( $instanceGuid, $gc, $lightID, $taskType, $taskPriority );
		}
		
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			main:if ( vm ) {
				
				var lo:Oxel = vm.oxel.childGetOrCreate( _gc );
				if ( lo.gc.eval( 5, 1, 2 , 7 ) )
					Log.out ( "light spreading WRONG to this one" );
				if ( valid( lo ) ) {
					
					spreadToNeighbors( lo );
				}
				else
					Log.out( "Light.start - lightValid failed", Log.ERROR );

			}
			else
				Log.out( "Light.start - VoxelModel not found: " + _guid, Log.ERROR );
				
			super.complete();
		}
		
		static private function valid( o:Oxel ):Boolean {
			
			if ( Globals.BAD_OXEL == o ) // This is possible, if oxel is on edge of model
			{
				//Log.out( "Light.valid - o == Globals.BAD_OXEL - continue" );
				return false;
			}
			else if ( Globals.Info[o.type].light ) // dont try to light a light? what if light source is stronger?
			{
				Log.out( "Light.valid - Dont light a light! - continue" );
				return false;
			}

			if ( !o.brightness ) // does this oxel already have a brightness?
				o.brightness = BrightnessPool.poolGet();

			if ( 0 == o.brightness.lastLightID )
			{
				Log.out( "Light.valid - 0 == LIGHT ID - continue" );
				return false;
			}
				
			return true;
		}
		
		private function spreadToNeighbors( $lo:Oxel ):void {
				
			Log.out( "Light.spreadToNeighbors - $lo: " + $lo.toStringShort() + "b: " + $lo.brightness.toString() );
			//$lo.brightness.color = color;
			
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				var no:Oxel = $lo.neighbor(face);
				
				if ( Globals.BAD_OXEL != no && no.gc.eval( 5, 1, 2 , 7 ) )
					Log.out ( "light spreading WRONG to this one" );
					
				if ( !valid( no ) )
					continue;
				
				if ( no.gc.grain > $lo.gc.grain )  // implies it has no children.
				{
					projectOnLargerGrain( $lo, no, face );
				}
				else if ( no.gc.grain == $lo.gc.grain ) // equal grain can have children
				{ 
					projectOnEqualGrain( $lo, no, face );
				}
				else {
					Log.out( "Light.spreadToNeighbors - NEIGHBOR GRAIN IS SMALLER: ", Log.ERROR );
				}					
			}
		}
		
		// returns true if continue
		private function projectOnEqualGrain( $lo:Oxel, $no:Oxel, $face:int ):Boolean {
			
			if ( false == $no.hasAlpha ) // this is a SOLID object which does not transmit light (leaves, water are exceptions)
			{
				//Log.out( "Light.projectOnEqualGrain - solid - addInfluence and rebuildFace" );
				if ( $no.brightness.addInfluence( $lo.brightness, $face, true, $no.gc.size(), $lo.brightness._b000.colorGet( $lo.brightness.lastLightID ) ) )
					rebuildFace( $face, $no );
			}					
			else if ( $no.childrenHas() ) 
			{
				//Log.out( "Light.projectOnEqualGrain - projectOnNeighborChildren" );
				projectOnNeighborChildren( $no, $lo, $face );
			}					
			else if ( $no.brightness.lastLightID == $lo.brightness.lastLightID ) // dont reevaluate an oxel that already has the influence from this light
			{
				// Should I allow this to happen multiple times, but not add new tasks for it?
//				if ( $no.brightness.addInfluence( $lo.brightness, $face, false, no.gc.size() ) )
//					rebuildFace( $face, $no );
				//Log.out( "Light.projectOnEqualGrain - ALREADY LIT BY SAME LIGHT  - continue face: " + Globals.Plane[$face].name );
				return true;
			}
			else 
			{
				//if ( Globals.AIR == $no.type ) { // this oxel does not have faces OR children, and transmits light
				if ( true == $no.hasAlpha )	 { // this oxel does not have faces OR children, and transmits light
					//Log.out( "Light.projectOnEqualGrain - no.brightness.addInfluence - face: " + Globals.Plane[$face].name );
					if ( $no.brightness.addInfluence( $lo.brightness, $face, false, $no.gc.size(), $lo.brightness._b000.colorGet( $lo.brightness.lastLightID ) ) )
						add( $no );
				}
				else { // this oxel has faces and transmits light (water and leaves)
					// this is a solid object which does not transmit light (leaves are exception)
					//Log.out( "Light.projectOnEqualGrain - no.brightness.addInfluence - face: " + Globals.Plane[$face].name );
					if ( $no.brightness.addInfluence( $lo.brightness, $face, false, $no.gc.size(), $lo.brightness._b000.colorGet( $lo.brightness.lastLightID ) ) )
					{
						rebuildFace( $face, $no );
						add( $no );
					}
				}
			}
			
			return false;
		}
		
		// returns true if continue
		private function projectOnLargerGrain( $lo:Oxel, $no:Oxel, $face:int ):Boolean {
			
			//Log.out( "Light.projectOnLargerGrain" );
			if ( $no.childrenHas() )
			{
				Log.out( "Light.projectOnLargerGrain - NEIGHBOR GRAIN HAS CHILDEN!: ", Log.ERROR );
				return true;
			} 
			
			// first thing I need to do is to generate the larger grain size for parent
			if ( null == $lo.parent )
				return true;
			else {
				// if the parent has not been set up
				if ( null == $lo.parent.brightness )
					$lo.parent.brightness = BrightnessPool.poolGet();
					
				if ( $lo.parent.brightness.lastLightID != $lo.brightness.lastLightID ) {
					var parent:Oxel = $lo.parent;
					var current:Oxel = $lo;
					while ( parent.gc.grain <= $no.gc.grain ) {
						// Make sure light color data is being passed correctly
						parent.brightness.deriveFromChildOxel( current );
						current = parent;
						parent = parent.parent;
					}
					projectOnEqualGrain( current, $no, $face );
				}
				else // ( $lo.parent.brightness.lastLightID == $lo.brightness.lastLightID )
				{
					// has the neighbor been lit by same light already?
					if ( $no.brightness.lastLightID != $lo.brightness.lastLightID )
						projectOnEqualGrain( $lo.parent, $no, $face );
				}
			}
			return false;
		}
		
		private function projectOnNeighborChildren( $no:Oxel, $lo:Oxel, $face:int ):void {
			
			//Log.out( "Light.projectOnNeighborChildren - no: " + $no.toStringShort() + "  " + $lo.brightness.toString() );
			
			var gct:GrainCursor = GrainCursorPool.poolGet( $no.gc.bound );
			var oxelt:Oxel = OxelPool.poolGet(); // forced to create a temp oxel to use for projection
			var bt:Brightness = BrightnessPool.poolGet();
			
			var of:int = Oxel.face_get_opposite( $face );
			var dchild:Vector.<Oxel> = $no.childrenForDirection( of );
			for ( var childIndex:int = 0; childIndex < 4; childIndex++ )
			{
				$lo.brightness.subfaceGet( $face, childIndex, bt );
				if ( bt.valuesHas() )
				{
					// create temp oxel as light source for lighting purposes
					gct.copyFrom( dchild[childIndex].gc );
					// move to location of fake light oxel
					gct.move( of );
					// dont care the type, since it is only temp, just has to be transparent
					oxelt.initialize( $no, gct, Globals.AIR, null );
					oxelt.brightness = bt;
					
					var  noChild:Oxel = dchild[childIndex];
					var  loChild:Oxel = oxelt;
					if ( !valid( noChild ) )
						continue;
					
					projectOnEqualGrain( loChild, noChild, $face );	
				}
			}
			GrainCursorPool.poolDispose( gct );
			OxelPool.poolDispose( oxelt );
			BrightnessPool.poolReturn( bt );
		}
		
		private function add( $no:Oxel ):void {
			
			if ( $no.isSolid )
			{
				Log.out( "Light.add - SOLID", Log.ERROR );
				return;
			}
			
			if ( $no.brightness.valuesHas() )
			{
				addTask( _guid, $no.gc, lightID );
				Log.out( "Light.add - gc:" + $no.gc.toString() + " br: " + $no.brightness.toString() );
			}
		}
		
		public function rebuildFace( $faceFrom:int, $no:Oxel ):void {
			
			if ( !$no.isSolid )
				Log.out( "Brightness.calculateEffect - being called on non solid object", Log.ERROR );
				
			if ( $no.brightness.sunlit )
				return
			
			if ( !$no.brightness.valuesHas() ) {
				//Log.out( "Brightness.calculateEffect - fails valuesHas " );
				return;
			}

			if ( $no.quads && 0 < $no.quads.length )
			{
					$no.quadRebuild( Oxel.face_get_opposite( $faceFrom ) );
	//			else
	//				$no.quadsRebuildAll( $no.type ); // All of the quads may have changed...
			}
		}
		
		
/*		
		private function projectOnChildren( $no:Oxel, $lo:Oxel, $face:int ):void {
			
			//Log.out( "Light.projectOnChildren - no: " + $no.toStringShort() + "  " + $lo.brightness.toString() );
			var of:int = Oxel.face_get_opposite( $face );
			var dchild:Vector.<Oxel> = $no.childrenForDirection( of );
			var gct:GrainCursor = GrainCursorPool.poolGet( $no.gc.bound );
			// forced to create a temp oxel to use for projection
			var oxelt:Oxel = OxelPool.poolGet();
			var bt:Brightness = BrightnessPool.poolGet();
			for ( var childIndex:int = 0; childIndex < 4; childIndex++ )
			{
				$lo.brightness.subfaceGet( $face, childIndex, bt );
				if ( bt.valuesHas() )
				{
					// create temp oxel as light source for lighting purposes
					gct.copyFrom( dchild[childIndex].gc );
					// move to location of fake light oxel
					gct.move( of );
					// dont care the type, since it is only temp, just has to be transparent
					oxelt.initialize( $no, gct, Globals.AIR, null );
					oxelt.brightness = bt;
					
					lightNeighbor( dchild[childIndex], oxelt, $face ); 
				}
				
			}
			GrainCursorPool.poolDispose( gct );
			OxelPool.poolDispose( oxelt );
			BrightnessPool.poolReturn( bt );
		}
*/
		
		
/*		
		private function addToParent( $lo:Oxel ):void {
			if ( !$lo.parent )
				return; 
				
			var po:Oxel = $lo.parent;
			var childId:int;
			// allocate a new brightness, and set any solid oxels to set = true.
			if ( !po.brightness )
			{
				po.brightness = BrightnessPool.poolGet();
				// this iterates thru the solid children, and sets all of them to complete.
				// TODO still possible issue if there are hidden AIR pockets, parent might never complete
				for each ( var child:Oxel in po.children )
				{
					if ( child.isSolid )
					{
						childId = child.gc.childId();
						if ( !child.brightness )
							child.brightness = BrightnessPool.poolGet();
						// child need a brightness if it is solid
						po.brightness.setFromChildOxel( child.brightness, childId );
					}	
				}
				add ( po );
			}
			// if already ready, this must be from a previous lighting
			// reset the ready and the lastLight lightID
			else if ( po.brightness.lastLight ) 
			{
				po.brightness.readyReset();
				po.brightness.lastLight = null;
				// adding po here means even if the all the children dont get ready, it still runs
				add ( po );
			}

			//if ( po.gc.eval( 5, 0, 4, 0 ) )
			//	trace( "B4 - 5, 0, 4, 0: " + po.brightness.toString() );
				
			childId = $lo.gc.childId();
			po.brightness.setFromChildOxel( $lo.brightness, childId );
			
			//if ( po.gc.eval( 5, 0, 4, 0 ) )
			//	trace( "8T - 5, 0, 4, 0: " + po.brightness.toString() );
			
			if ( po.brightness.ready )
			{
				//Log.out( "Light.addToParent - complete: " + po.toStringShort() + " " + po.brightness.toString() );
				po.brightness.lastLight = lightID;
			}
		}
*/	
		
	}
}