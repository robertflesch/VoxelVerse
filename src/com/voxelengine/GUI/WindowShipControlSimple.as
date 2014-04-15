
package com.voxelengine.GUI
{
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.Ship;
	import flash.events.Event;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	
	public class WindowShipControlSimple extends VVContainer
	{
		static private var _s_currentInstance:WindowShipControlSimple = null;
		static public function get currentInstance():WindowShipControlSimple { return _s_currentInstance; }
		static private var _lastRotation:Number = 0;
		
		private var _ship:Ship;
		private var fudgeFactor:int = 20;


		public function WindowShipControlSimple( vm:Ship ):void 
		{ 
			super();
			_s_currentInstance = this;
			//Globals.GUIControl = true;
			_ship = vm;
			autoSize = true;
			padding = 10;
			layout.orientation = LayoutOrientation.VERTICAL;
			layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			
			var pc:Container = new Container();
			//onCloseFunction = closeFunction;
			//defaultCloseOperation = ClosableProperties.CALL_CLOSE_FUNCTION;
			pc.layout.orientation = LayoutOrientation.HORIZONTAL;

			display( Globals.g_renderer.width/2 - (width + fudgeFactor)/2, Globals.g_renderer.height - height - 128 );
            Globals.g_app.stage.addEventListener(Event.RESIZE, onResize);
			addEventListener(UIOEvent.REMOVED, onRemoved );
			
			_ship.takeControl( Globals.player );
		} 
		
		private function loseControl(event:UIMouseEvent):void 
		{
			if ( WindowShipControl.currentInstance )
			{
				WindowShipControl.currentInstance.remove();
			}
			if ( WindowGunControl.currentInstance )
			{
				WindowGunControl.currentInstance.remove();
			}
			if ( WindowHeading.currentInstance )
			{
				WindowHeading.currentInstance.remove();
			}
			if ( WindowBombControl.currentInstance )
			{
				WindowBombControl.currentInstance.remove();
			}

			remove();
			
			Globals.player.instanceInfo.controllingModel = null;
			
			_ship.loseControl();
		}
		
		private function onFileLoadError(event:Event):void
		{
			Log.out("WindowShipControl.onFileLoadError - File load error: " + event, Log.ERROR );
		}		

		
		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
            Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize);
			removeEventListener(UIOEvent.REMOVED, onRemoved );
			
			_s_currentInstance = null;
			Globals.player.instanceInfo.controllingModel = null;
			if ( _ship )
				_ship.loseControl();
		}
		
        protected function onResize(event:Event):void
        {
			move( Globals.g_renderer.width / 2 - (width + fudgeFactor) / 2, Globals.g_renderer.height - height - 128 );
		}
	}
}