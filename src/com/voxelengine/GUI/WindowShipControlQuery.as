
package com.voxelengine.GUI
{
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.worldmodel.models.Ship;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
public class WindowShipControlQuery extends VVContainer
	{
		private var _instanceGuid:String = "";
		private var _windowShipControl:WindowShipControl = null;
		private var _windowGunControl:WindowGunControl = null;
		private var _windowHeading:WindowHeading = null;
		
		static private var _s_currentInstance:WindowShipControlQuery = null;
		
		public function WindowShipControlQuery( $instanceGuid:String ):void 
		{ 
			super();
			_instanceGuid = $instanceGuid;
			
			_s_currentInstance = this;
			
			//onCloseFunction = closeFunction;
			//defaultCloseOperation = ClosableProperties.CALL_CLOSE_FUNCTION;
			
			var button:Button = new Button( "Click me to become captain ( or 'F' key )" );
			button.width = 300;
			button.height = 80;
			button.addEventListener(MouseEvent.CLICK, takeControlMouse );
			Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_DOWN, takeControlKey );

			addElement( button );
			
			layout.orientation = LayoutOrientation.VERTICAL;
            autoSize = true;
			shadow = true;
			
			display( Globals.g_renderer.width / 2 - (width + 10) / 2, Globals.g_renderer.height / 2 - (height + 10) / 2 );
			
            Globals.g_app.stage.addEventListener(Event.RESIZE, onResizeHeading );
			addEventListener(UIOEvent.REMOVED, onRemoved );
		} 
		
        protected function onResizeHeading( event:Event ):void
        {
			move( Globals.g_renderer.width / 2 - (width + 10) / 2, Globals.g_renderer.height / 2 - (height + 10) / 2 );
		}

		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
            Globals.g_app.stage.removeEventListener(Event.RESIZE, onResizeHeading );
			removeEventListener(UIOEvent.REMOVED, onRemoved );
			Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, takeControlKey );
			_s_currentInstance = null;
		}

		private function takeControl():void 
		{
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _instanceGuid );
			if ( vm )
			{
				addControlWindows( vm );
				remove();
				
				Globals.player.instanceInfo.controllingModel = vm;
			}
		}
		
		private function takeControlKey(e:KeyboardEvent):void 
		{
			if ( Keyboard.F == e.keyCode )
				takeControl();
		}
		
		private function takeControlMouse(event:UIMouseEvent):void 
		{
			event.target.removeEventListener(MouseEvent.CLICK, takeControl );
			takeControl();
		}
		
		public function addControlWindows( vm:VoxelModel ):void
		{
			if ( _windowShipControl )
			{
				_windowShipControl.remove();
				_windowShipControl = null;
			}
			if ( _windowGunControl )
			{
				_windowGunControl.remove();
				_windowGunControl = null;
			}
			//if ( _windowBombControl )
			//{
			//	_windowBombControl.remove();
			//	_windowBombControl = null;
			//}
			if ( _windowHeading )
			{
				_windowHeading.remove();
				_windowHeading = null;
			}

			//_windowShipControl = new WindowShipControl( _modelToBeControlled.instanceInfo.controllingModel );
			_windowShipControl = new WindowShipControl( _instanceGuid );
			
			_windowGunControl = new WindowGunControl( _instanceGuid );
			//_windowBombControl = new WindowBombControl( _instanceGuid );
			_windowHeading = new WindowHeading( _instanceGuid );
			
			//new WindowQuest( "Second Quest", "assets/quests/secondQuest.txt", 0, 150 );
			
		}
		
		private function closeFunction():void
		{
			//Globals.GUIControl = false;
			_s_currentInstance = null;
		}
		
	}
}