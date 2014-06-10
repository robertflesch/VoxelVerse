package com.voxelengine.worldmodel.scripts 
{
	/**
	 * ...
	 * @author Bob
	 */
	import com.voxelengine.events.LoadingEvent;
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	public class AutoControlObjectScript extends Script 
	{
		public function AutoControlObjectScript() 
		{
			Globals.g_app.addEventListener( ModelEvent.PARENT_MODEL_ADDED, onModelEvent, false, 0, true );
		}
		
		public function onModelEvent( $event:ModelEvent ):void 
		{
			if ( $event.type == ModelEvent.PARENT_MODEL_ADDED )
			{
				if ( $event.instanceGuid == instanceGuid )
				{
					var vm:VoxelModel = Globals.g_modelManager.getModelInstance( instanceGuid );
					if ( Globals.player ) {
						vm.takeControl( Globals.player );
						Log.out( "AutoControlObjectScript.AutoControlObjectScript player controlling this object: " + vm.instanceInfo.name );
					}
					else {
						Globals.g_app.addEventListener( LoadingEvent.LOAD_COMPLETE, onLoadingPlayerComplete );
					}
				}
			}
		}
		
		private function onLoadingPlayerComplete( le:LoadingEvent ):void {
			Globals.g_app.removeEventListener( LoadingEvent.LOAD_COMPLETE, onLoadingPlayerComplete );
			
			var player:VoxelModel = Globals.player;
			if ( !player ) 
				player = Globals.g_modelManager.getModelInstance( le.name );
				
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( instanceGuid );
			if ( player && vm ) {
				vm.takeControl( player );
			}
		}
	}
}