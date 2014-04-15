
package com.voxelengine.GUI
{
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
	import flash.events.Event;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	
	public class WindowQuest extends VVPopup
	{
		//private var eventCollector:EventCollector = new EventCollector();
		
		public function WindowQuest( title:String, data:String, x:int = 0, y:int = 0 )
		{
            //autoSize = true;
			width = 300;
			height = 300;
			var _textArea:TextArea = new TextArea();
			_textArea.loadText( Globals.appPath + data );
			_textArea.fontSize = 16;
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