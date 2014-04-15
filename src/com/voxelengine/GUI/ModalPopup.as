
package com.voxelengine.GUI
{
import org.flashapi.swing.*;
import org.flashapi.swing.event.*;
import org.flashapi.swing.constants.*;

import com.voxelengine.Globals;

public class ModalPopup extends Popup
{
	protected var _modalObj:ModalObject;
	
	public function ModalPopup( $title:String, $width:int = undefined, $height:int = undefined ):void
	{
		super( $title, $width, $height );
		eventCollector.addEvent( this, UIOEvent.REMOVED, onRemoved );
	// if the mouse is over a window, this causes the event to only be handled by the UI
		eventCollector.addEvent( this, UIMouseEvent.ROLL_OVER, function(e:UIMouseEvent):void { Globals.GUIControl = true; } );
		eventCollector.addEvent( this, UIMouseEvent.ROLL_OUT, function(e:UIMouseEvent):void { Globals.GUIControl = false; } );
	}
	
	private function onRemoved( event:UIOEvent ):void
	{
	}
}
}
