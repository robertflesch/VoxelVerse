
package com.voxelengine.GUI
{
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.*;
    import org.flashapi.swing.managers.*;
	
	import com.voxelengine.Globals;
	
	public class WindowHelp extends Popup
	{
        private var _textArea:TextArea = new TextArea();
		
		public function WindowHelp()
		{
            //_image = new Image("my_picture.jpg", 300, 326);
			
			super("Help");
            //autoSize = true;
			width = 600;
			height = 600;
			shadow = true;
			_textArea.width = 600;
			_textArea.height = 600;
			_textArea.editable = false;
			_textArea.loadText( Globals.appPath + "assets/help.txt" );
            addElement(_textArea);
            display(30, 30);
        }
		
	}
}