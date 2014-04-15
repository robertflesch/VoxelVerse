
package com.voxelengine.GUI
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.GUIEvent;
	import com.voxelengine.worldmodel.models.Ship;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import com.voxelengine.events.RegionEvent;
	
	
public class WindowBeastControlQuery extends VVContainer
	{
		static private var _s_currentInstance:WindowBeastControlQuery = null;
		static public function get currentInstance():WindowBeastControlQuery { return _s_currentInstance; }
		
		private var _beastInstanceGuid:String = "";
		private const TOOL_BAR_HEIGHT:int = 140;
		private var window_offset:int = TOOL_BAR_HEIGHT;
		
		public function WindowBeastControlQuery( $beastInstanceGuid:String ):void 
		{ 
			super();
			if ( null != WindowBeastControlQuery.currentInstance )
				Log.out( "WindowBeastControl.constructor - trying to create window when one already exists" );
				
			_beastInstanceGuid = $beastInstanceGuid;
			_s_currentInstance = this;
			autoSize = true;
			
			var button:Button = new Button( "Click me to control beast ( or 'F' key )" );
			button.width = 300;
			button.height = 80;
			button.addEventListener(MouseEvent.CLICK, takeControlMouse );
			Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_DOWN, takeControlKey );
			addElement( button );
			
            Globals.g_app.stage.addEventListener(Event.RESIZE, onResize );
			Globals.g_app.addEventListener( RegionEvent.REGION_UNLOAD, onRegionUnload );
			Globals.g_app.addEventListener( GUIEvent.TOOLBAR_HIDE, guiEventHandler );
			Globals.g_app.addEventListener( GUIEvent.TOOLBAR_SHOW, guiEventHandler );
			addEventListener(UIOEvent.REMOVED, onRemoved );
			
			if ( VoxelVerseGUI.currentInstance.toolBar && VoxelVerseGUI.currentInstance.toolBar.visible )
				window_offset = TOOL_BAR_HEIGHT;
			else	
				window_offset = 0;
				
			display();
			onResize( null );
		} 
		
        protected function onResize( event:Event ):void
        {
			move( Globals.g_renderer.width / 2 - width / 2, Globals.g_renderer.height - height - window_offset );
		}
		
		private function onRegionUnload ( le:RegionEvent ):void 
		{ 
			remove();
		}
		

		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
			removeEventListener(UIOEvent.REMOVED, onRemoved );
            Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize );
			Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, takeControlKey );
			Globals.g_app.removeEventListener( RegionEvent.REGION_UNLOAD, onRegionUnload );
			Globals.g_app.removeEventListener( GUIEvent.TOOLBAR_HIDE, guiEventHandler );
			Globals.g_app.removeEventListener( GUIEvent.TOOLBAR_SHOW, guiEventHandler );
			_s_currentInstance = null;
		}

		private function takeControl():void 
		{
			var vm:VoxelModel = Globals.g_modelManager.getModelInstance( _beastInstanceGuid );
			if ( vm )
			{
				new WindowBeastControl( _beastInstanceGuid );
				remove();
				vm.takeControl( Globals.player );
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
		
		private function guiEventHandler( e:GUIEvent ):void
		{
			if ( GUIEvent.TOOLBAR_HIDE == e.type )
				window_offset = 0;
			else if ( GUIEvent.TOOLBAR_SHOW == e.type )
				window_offset = TOOL_BAR_HEIGHT;
				
			onResize( null );
		}
	}
}