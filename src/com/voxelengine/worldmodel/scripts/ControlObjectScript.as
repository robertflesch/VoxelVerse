package com.voxelengine.worldmodel.scripts 
{
	/**
	 * ...
	 * @author Bob
	 */
	import com.voxelengine.Globals;
	import com.voxelengine.GUI.WindowShipControl;
	import com.voxelengine.GUI.WindowGunControl;
	import com.voxelengine.GUI.WindowShipControlQuery;
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.events.OxelEvent;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	public class ControlObjectScript extends Script 
	{
		private var _wt:WindowShipControlQuery = null;
				
		public function ControlObjectScript() 
		{
			Globals.g_app.stage.addEventListener(OxelEvent.INSIDE, onInsideEvent, true, 0, true);
			Globals.g_app.stage.addEventListener(OxelEvent.OUTSIDE, onOutsideEvent, true, 0, true);
		}
		
		public function onInsideEvent( $event:OxelEvent ):void 
		{
			if ( instanceGuid != $event.instanceGuid )
			{
				//Log.out( "OnOxelEvent: ignoring event for someone else" + $event );
				return;
			}
				
			//Log.out( "ControlObjectScript.onInsideEvent: " + $event );

			if ( $event.type == OxelEvent.INSIDE )
			{
				if ( !WindowShipControl.currentInstance && !WindowGunControl.currentInstance )
				{
					var vm:VoxelModel = Globals.g_modelManager.getModelInstance( instanceGuid );
					if ( vm )
					{
						var controllingModel:VoxelModel = vm.instanceInfo.controllingModel;	
						_wt = new WindowShipControlQuery( controllingModel.instanceInfo.instanceGuid );
					}
				}
			}
		}
		
		public function onOutsideEvent( $event:OxelEvent ):void 
		{
			if ( instanceGuid != $event.instanceGuid )
			{
				//Log.out( "ControlObjectScript.onOutsideEvent: ignoring event for someone else" + $event );
				return;
			}
				
			//Log.out( "ControlObjectScript.onOutsideEvent: " + $event );

			if ( _wt )
			{
				_wt.remove();
				_wt = null;
			}
		}
	}

}