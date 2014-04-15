/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
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
		 * @param $id a light id
		 * 
		 */
		static public function addTask( $instanceGuid:String, $gc:GrainCursor, $id:String, $taskPriority:int = 1 ):void {
			//Log.out( "Light.addTask: for gc: " + $gc.toString() + "  taskId: " + $gc.toID() );
			var tt:String = $gc.toID();
			var lt:Light = new Light( $instanceGuid, $gc, $id, tt, $gc.grain )
			lt.selfOverride = true;
			Globals.g_lightTaskController.addTask( lt );
		}
		
		// NEVER use this, use the static function
		public function Light( $instanceGuid:String, $gc:GrainCursor, $id:String, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			super( $instanceGuid, $gc, $id, $taskType, $taskPriority );
		}
		
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			main:if ( vm )
			{
				var lo:Oxel = vm.oxel.childGetOrCreate( _gc );
				if ( null == lo.gc )
					break main; 
				if ( null == lo.brightness )
					break main; 
					
//				Log.out( "=================================================================================================================" );
//				Log.out( "Light.start - taskType: " + taskType + " oxel: " + lo.toStringShort() + " brightness: " + lo.brightness.toString() );
				
//				if ( lo.gc.eval( 5, 0, 4, 0 ) )
//					trace( " measure" );
//				if ( lo.gc.grain == 5 )
//					trace( " check parent" );
				//trace( "Light lo: " + lo.brightness.toString() );
				lightOxel( lo );
			}
			else
			{
				Log.out( "Light.start - VoxelModel not found: " + _guid, Log.ERROR );
			}	
			super.complete();
		}
		
		private function lightOxel( $lo:Oxel ):void {
				
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				var no:Oxel = $lo.neighbor(face);
				if ( Globals.BAD_OXEL == no ) // This is expected, if oxel is on edge of model
					continue;
				else if ( Globals.Info[no.type].light ) // dont try to light a light? what if light source is stronger?
					continue;
						
				
				if ( no.brightness ) { // does this oxel already have a brightness?
					if ( no.gc.grain == $lo.gc.grain )
						no.brightness.addInfluence( $lo.brightness, face, no.hasAlpha, no.gc.size() );
					if ( no.brightness.lastLight == id ) // dont reevaluate an oxel that already has the influence from this light
						continue;
				}
				
				// wait for parent to handle it
				if ( no.gc.grain > $lo.gc.grain )
					continue;
					
				lightNeighbor( no, $lo, face );
			}
			// do this after the oxel has been lit
			addToParent( $lo );
		}
		
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
			// reset the ready and the lastLight id
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
				po.brightness.lastLight = id;
			}
		}
		
		private function lightNeighbor( $no:Oxel, $lo:Oxel, $face:int ):void {
			
			if ( $no.gc.grain != $lo.gc.grain )
				throw new Error( "Light.lightNeighbor - neighbor is larger then light" );

			if ( Globals.hasAlpha( $no.type ) && !$no.childrenHas() )
			{
				if ( !$no.brightness )
					$no.brightness = BrightnessPool.poolGet();
					
				if ( $no.brightness.calculateEffect( $face, $lo.brightness, $no, id ) )
				{
					lightOxel( $no )
					add( $no );
				}
			}
			// neighbor might be the parent of smaller oxel, so project onto them
			else if ( Globals.AIR == $no.type && $no.childrenHas() )
			{
				projectOnChildren( $no, $lo, $face );
			}
			// I see a face, light it!
			else if ( $no.facesHas() )
			{
				$no.brightness.calculateEffect( $face, $lo.brightness, $no, id ); 
			}
			// Should never hit these.
			else if ( !$no.facesHas() && !$no.childrenHas() && Globals.AIR != $no.type )
			{
				// Ran into a solid oxel with no faces, stop here.
				//Log.out( "Light.lightNeighbor ---------------- solid oxel with no faces, no children, and is NOT AIR, stop here." + $no.toStringShort() );
			}
			else
			{
				throw new Error( "Light.lightNeighbor - invalid condition" );
			}
		}
		
		private function add( $no:Oxel ):void {
			//if ( $no.brightness.valuesHas() )
			{
				if ( $no.brightness.valuesHas() )
				{
					Light.addTask( _guid, $no.gc, id, $no.gc.grain );
					//Log.out( "Light.addTask - brightness: " + $no.brightness.toString() );
				}
				//else
				//	Log.out( "Light.addTask - No values" );
			}
			//else
			//	Log.out( "Light.add - Not adding task with default values" );
		}
		
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

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
		
	}
}