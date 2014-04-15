package com.voxelengine.worldmodel.scripts 
{
	/**
	 * ...
	 * @author Bob
	 */
	import com.voxelengine.Globals;
	import com.voxelengine.GUI.WindowBeastControlQuery;
	import com.voxelengine.worldmodel.scripts.Script;
	import com.voxelengine.events.OxelEvent;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.VoxelModel;
	
	public class ControlBeastScript extends Script 
	{
		private var _wt:WindowBeastControlQuery = null;
				
		public function ControlBeastScript() 
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
				if ( !WindowBeastControlQuery.currentInstance )
				{
					var trigger:VoxelModel = Globals.g_modelManager.getModelInstance( instanceGuid );
					if ( trigger )
					{
						var controllingModel:VoxelModel = trigger.instanceInfo.controllingModel;
						if ( Globals.player && controllingModel && null == Globals.player.instanceInfo.controllingModel )
							_wt = new WindowBeastControlQuery( controllingModel.instanceInfo.instanceGuid );
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