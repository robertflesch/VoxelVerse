package com.voxelengine.worldmodel.scripts 
{
	/**
	 * ...
	 * @author Bob
	 */
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.events.ModelEvent;
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	public class AutoControlObjectScript extends Script 
	{
		public function AutoControlObjectScript() 
		{
			Globals.g_app.addEventListener( ModelEvent.CREATE, onModelEvent, false, 0, true );
		}
		
		public function onModelEvent( $event:ModelEvent ):void 
		{
			if ( $event.type == ModelEvent.CREATE )
			{
				if ( $event.instanceGuid == instanceGuid )
				{
					var vm:VoxelModel = Globals.g_modelManager.getModelInstance( instanceGuid );
					vm.takeControl( Globals.player );
					Log.out( "AutoControlObjectScript.AutoControlObjectScript player controlling this object: " + vm.instanceInfo.name );
				}
			}
		}
	}
}