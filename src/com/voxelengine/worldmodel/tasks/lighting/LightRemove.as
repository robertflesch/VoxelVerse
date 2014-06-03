/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.worldmodel.tasks.lighting
{
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.events.LightEvent;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.worldmodel.oxel.Brightness;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.oxel.Oxel;
	import com.voxelengine.worldmodel.tasks.lighting.LightTask

	/**
	 * ...
	 * @author Robert Flesch
	 */
	public class LightRemove extends LightTask 
	{		
		static public function handleLightEvents( $le:LightEvent ):void {
			if ( LightEvent.REMOVE == $le.type )
				addTask( $le.instanceGuid, $le.gc, $le.lightID );
		}
		
		static public function addTask( $instanceGuid:String, $gc:GrainCursor, $lightID:uint ):void {
			//Log.out( "Light.addTask: for gc: " + $gc.toString() + "  taskId: " + $gc.toID() );
			var lt:LightRemove = new LightRemove( $instanceGuid, $gc, $lightID, $gc.toID(), $gc.grain );
			lt.selfOverride = true;
			Globals.g_lightTaskController.addTask( lt );
		}
		
		// NEVER use this, use the static function
		public function LightRemove( $instanceGuid:String, $gc:GrainCursor, $lightID:uint, $taskType:String, $taskPriority:int ):void {
			super( $instanceGuid, $gc, $lightID, $taskType, $taskPriority );
		}
		

		/**
		 * @param $taskType The Task type.
		 * @param $taskPriority The priority of the task, 0 is the highest priority, int.MAX_VALUE is the lowest.
		 */
		private function remove( $o:Oxel ):void {
			LightRemove.addTask( _guid, $o.gc, lightID );
		}
		
		
		override public function start():void {
			super.start();
			
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _guid );
			main:if ( vm ) {
				
				var lo:Oxel = vm.oxel.childFind( _gc );
				if ( valid( lo ) ) {
					if ( !lo.gc.is_equal( _gc ) ) {
						// This is a distinct possibility for removal. If the light was last non air oxel
						// then removing it merged it into its parent.
						// Does it require different handling?
						Log.out ( "LightRemove.start - Didn't find child!" );
					}
					lo.brightness.lightRemove( lightID );

					removeFromNeighbors( lo );
				}
				else
					Log.out( "LightRemove.start - valid failed", Log.ERROR );

			}
			else
				Log.out( "LightRemove.start - VoxelModel not found: " + _guid, Log.ERROR );
				
			super.complete();
		}
		
		static private function valid( $o:Oxel ):Boolean {
			
			if ( Globals.BAD_OXEL == $o ) // This is expected, if oxel is on edge of model
				return false;
			
			if ( !$o.brightness ) // does this oxel already have a brightness?
				return false;

			return true;
		}
		 
		private function removeFromNeighbors( $lo:Oxel ):void {
				
			Log.out( "LightRemove.spreadToNeighbors - $lo: " + $lo.toStringShort() + "  brightness: " + $lo.brightness.toString() );

						if ( 5 == $lo.gc.grain )
							trace( "Watch here" );
			
			for ( var face:int = Globals.POSX; face <= Globals.NEGZ; face++ )
			{
				var no:Oxel = $lo.neighbor(face);
					
				if ( Globals.BAD_OXEL == no )
					continue;
				
				if ( no.childrenHas() )
					removeFromChildren( no, face );
				else if ( no.brightness && no.brightness.lightGet( lightID ) )
					terminalLightRemove( no, face );
				else
					Log.out( "LightRemove.spreadToNeighbors - Light doesnt exist: " + lightID );
			}
		}
		
		private function removeFromChildren( $no:Oxel, $face:int ):void {
			// I am getting the indexes for the imaginary children that are facing the real children
			// and a list of the real children
			var of:int = Oxel.face_get_opposite( $face );
			var dchild:Vector.<Oxel> = $no.childrenForDirection( of );

			for ( var childIndex:int = 0; childIndex < 4; childIndex++ )
			{
				var noChild:Oxel = dchild[childIndex];

				if ( noChild.childrenHas() )
					removeFromChildren( noChild, $face );
				else
					terminalLightRemove( noChild, $face );
			}
		}
		
		private function terminalLightRemove( $o:Oxel, $face:int ):void {
			
			if ( null == $o.brightness )
				return;
				
			$o.brightness.lightRemove( lightID );
				
			if ( true == $o.isSolid ) // this is a SOLID object which does not transmit light (leaves, water are exceptions)
					rebuildFace( $o, $face );
			else if ( Globals.AIR == $o.type ) // this oxel does not have faces OR children, and transmits light
					remove( $o );
			else { // this oxel has faces and transmits light (water and leaves)
					rebuildFace( $o, $face );
					remove( $o );
			}
		}
		
		static private function rebuildFace( $o:Oxel, $faceFrom:int ):void {
			
			if ( !$o.isSolid ) {
				Log.out( "LightTask.rebuildFace - being called on non solid object", Log.ERROR );
				return;
			}
				
			if ( $o.quads && 0 < $o.quads.length )
				$o.quadsRebuildAll();
		}
	}
}