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
	import flash.geom.Vector3D;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.lighting.LightTask
	import com.voxelengine.worldmodel.oxel.Brightness;
	import com.voxelengine.pools.BrightnessPool;
	import com.voxelengine.pools.GrainCursorPool;
	import com.voxelengine.pools.OxelPool;

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class LightRemove extends LightTask 
	{		
		
		static public function addTask( $instanceGuid:String, $gc:GrainCursor, $id:String, $color:uint, $taskPriority:int = 1 ):void 
		{
			Log.out( "LightRemove.addTask: for gc: " + $gc.toString() );
			var lt:LightRemove = new LightRemove( $instanceGuid, $gc, $id, $color, $gc.toID(), LightTask.TASK_PRIORITY + $taskPriority )
			lt.selfOverride = true;
			Globals.g_lightTaskController.addTask( lt );
		}
		
		/**
		 * @param $taskType The Task type.
		 * @param $taskPriority The priority of the task, 0 is the highest priority, int.MAX_VALUE is the lowest.
		 */
		public function LightRemove( $instanceGuid:String, $gc:GrainCursor, $id:String, $color:uint, $taskType:String = TASK_TYPE, $taskPriority:int = TASK_PRIORITY ):void {
			super( $instanceGuid, $gc, $id, $color, TASK_TYPE, $taskPriority );
		}
		
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			main:if ( vm )
			{
				// we are going to be getting the light oxel position, the light is gone.
				// In that case how do I get its id, and colors??
				var lo:Oxel = vm.oxel.childGetOrCreate( _gc );
				if ( null == lo.gc )
					break main; 
				if ( null == lo.brightness )
					break main; 
					
				Log.out( "=================================================================================================================" );
				Log.out( "LightRemove.start - priority: " + priority + " oxel: " + lo.toStringShort() + " brightness: " + lo.brightness.toString() );
				
				// face is ignored here, but better to put in a valid value.
				lo.brightness.restoreDefault( "", lo, Globals.POSX );
				
				var result:Boolean = false;
				for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
				{
					var no:Oxel = lo.neighbor(face);
					if ( Globals.BAD_OXEL == no ) // This is expected, if oxel is on edge of model
						continue;
					else if ( Globals.Info[no.type].light ) // dont try to light a light? what if light source is stronger?
						continue;
					else if ( null == no ) // this should never happen
						continue;
					else if ( null == no.gc ) // this happens if we run into a released oxel, should never happen
						continue;
	
					lightRemoveNeighbor( no, lo, face );
				}
			}
			else
			{
				Log.out( "LightRemove.start - VoxelModel not found: " + _guid, Log.ERROR );
			}	
			super.complete();
		}

		private function remove( $gc:GrainCursor, $id:String, $color:uint, $priority:int ):void {
			LightRemove.addTask( _guid, $gc, $id, $color, $priority );
		}
		
		private function lightRemoveNeighbor( $no:Oxel, $lo:Oxel, $face:int ):void {
			
			if ( $no.brightness ) {
				if ( $no.brightness.lastLight == id ) // dont relight something that already has the influence from this light
					return;
				else if ( $no.brightness.lastLight == Brightness.FIXED ) // dont relight something that already has the influence from this light
					return;
			}
			var propogate:Boolean = false;
			// Larger - AIR no children - Pass thru
			// Larger - ALPHA - Pass thru
			// Same - AIR no children - Pass thru
			// Same - ALPHA - Pass thru
			if ( Globals.hasAlpha( $no.type ) && !$no.childrenHas() )
			{
				if ( !$no.brightness )
					return;
					
				if ( $no.gc.grain == $lo.gc.grain )
				{
					if ( $no.brightness.restoreDefault( id, $no, $face ) )
						remove( $no.gc, id, color, priority + $lo.parent.gc.grain );
				}
					
				else // no is larger (never smaller by definition)	
				{
					// pass info into parent.
					if ( $lo.parent )
					{
						if ( !$lo.parent.brightness )
							$lo.parent.brightness = BrightnessPool.poolGet();
						$lo.parent.brightness.restoreDefaultFromChildOxel( id, $lo.parent, $face );
						remove( $lo.parent.gc, id, color, priority + $lo.parent.gc.grain );
					}
					//propogate = $no.brightness.setToDefaultFromChildOxel( id, $no, $face );
				}
					
			}
			else if ( Globals.AIR == $no.type && $no.childrenHas() )
			{
				// propogation will be handled on recursive calls
				projectOnChildren( $no, $lo, $face );
			}

			// Larger - facesHas not alpha - propograte and Stop
			// Same - 	facesHas not alpha  - propograte and Stop
			else if ( $no.faceHas( Oxel.face_get_opposite( $face ) ) )
			{
				// Change this oxel, but dont propogate
				// TODO add transparent torch?
				if ( $no.gc.grain == $lo.gc.grain )
					$no.brightness.restoreDefault( id, $no, $face );
				else // no is larger (never smaller by definition)	
				{
					// pass info into parent.
					if ( $lo.parent )
					{
						if ( !$lo.parent.brightness )
							$lo.parent.brightness = BrightnessPool.poolGet();
						$lo.parent.brightness.restoreDefaultFromChildOxel( id, $lo.parent, $face );
						remove( $lo.parent.gc, id, color, priority + $lo.parent.gc.grain );
					}
					//propogate = $no.brightness.setToDefaultFromChildOxel( id, $no, $face );
				}
			}
			// has brightness, but no faces, so reset to default.
			else if ( $no.brightness )
			{
				$no.brightness.setByFace( Oxel.face_get_opposite( $face ), $no.brightness.DEFAULT, id, $no.gc.size() );
				//$no.brightness.calculateEffect( $face, $lo.brightness, $no, id );
			}
			// Should never hit these.
			else if ( !$no.facesHas() && !$no.childrenHas() && Globals.AIR != $no.type )
			{
				// Ran into a solid oxel with no faces, stop here.
				Log.out( "LightRemove.start - solid oxel with no faces, stop here." );
			}
			else
			{
				Log.out( "LightRemove.start - solid oxel with no face" );
			}
		}
		
		private function projectOnChildren( $no:Oxel, $lo:Oxel, $face:int ):void {
			
			var of:int = Oxel.face_get_opposite( $face );
			var dchild:Vector.<Oxel> = $no.childrenForDirection( of );
			var gct:GrainCursor = GrainCursorPool.poolGet( $no.gc.bound );
			var oxelt:Oxel = OxelPool.poolGet();
			for ( var childIndex:int = 0; childIndex < 4; childIndex++ )
			{
				// create temp oxel as light source for lighting purposes
				gct.copyFrom( dchild[childIndex].gc );
				// move to location of fake light oxel
				gct.move( of );
				// dont care the type, since it is only temp, just has to be transparent
				oxelt.initialize( $no, gct, Globals.AIR, null );
				oxelt.brightness = Brightness.scratch();
				oxelt.brightness.restoreDefault( id, $no, $face );
				
				lightRemoveNeighbor( dchild[childIndex], oxelt, $face ); 
				
			}
			GrainCursorPool.poolDispose( gct );
			OxelPool.poolDispose( oxelt );
			
		}

		override public function cancel():void {
			// TODO stop this somehow?
			super.cancel();
		}
		
	}
}