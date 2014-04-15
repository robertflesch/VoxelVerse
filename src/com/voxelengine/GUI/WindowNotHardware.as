
package com.voxelengine.GUI
{
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import flash.events.Event;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
	
	
	public class WindowNotHardware extends VVPopup
	{
		static private var _s_currentInstance:WindowNotHardware = null;
		static public function get currentInstance():WindowNotHardware { return _s_currentInstance; }

        private var _textArea:TextArea = new TextArea();
        private var _image:Image = null;
		
		public function WindowNotHardware( title:String, data:String ):void 
		{ 
			super( "No hardware accelleration Detected" );
            //autoSize = true;
			width = 300;
			height = 300;
			var _textArea:TextArea = new TextArea();
			_textArea.text = data;
			_textArea.fontSize = 24;
			_textArea.autoSize = true;
			_textArea.editable = false;
			_textArea.width = 300;
			_textArea.height = 300;
			
            addElement(_textArea);
			
			display( Globals.g_renderer.width / 2 - (((width + 10) / 2) + x ), Globals.g_renderer.height / 2 - (((height + 10) / 2) + y) );

			Globals.g_app.stage.addEventListener(Event.RESIZE, onResize);
			addEventListener(UIOEvent.REMOVED, onRemoved );
		}

			
		// Window events
		private function onRemoved( event:UIOEvent ):void
 		{
            Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize);
			removeEventListener(UIOEvent.REMOVED, onRemoved );
		}
		
        protected function onResize(event:Event):void
        {
			move( Globals.g_renderer.width / 2 - (width + 10) / 2, Globals.g_renderer.height / 2 - (height + 10) / 2 );
		}

	}
}