/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.GUI
{
    import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import org.flashapi.swing.Image;
    import org.flashapi.swing.event.UIMouseEvent;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;

    public class ColorPicker extends VVCanvas {

        public function ColorPicker( x:int = 200, y:int = 200 ) {
			VoxelVerseGUI.openWindowCount = VoxelVerseGUI.openWindowCount + 1;
			var image:Image = new Image( Globals.appPath + "assets/textures/colors.png");
			addElement( image );
			display( x, y );
			eventCollector.addEvent( image, UIMouseEvent.PRESS, clickListener );
        }

    	private function clickListener(event:UIMouseEvent):void {
			
			// I cant find a good way to get the bitmapData from the parent, so I am resorting to this.
			// bounds and size of parent in its own coordinate space
			var rect:Rectangle = event.target.parent.getBounds(event.target.parent);
			var bmp:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			bmp.draw(event.target.parent);			
    		var pixelValue:uint = bmp.getPixel(event.localX, event.localY)
			
			Log.out("ColorPicker.clickListener - picked color: " + pixelValue.toString(16) );
			
			remove();
    	}
    }
}
