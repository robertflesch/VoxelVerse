
package com.voxelengine.GUI
{
import org.flashapi.swing.Popup;
import org.flashapi.swing.event.UIOEvent;

import com.voxelengine.Globals;

public class VVPopup extends Popup
{
	
	public function VVPopup( title:String )
	{
		super( title );
		VoxelVerseGUI.openWindowCount = VoxelVerseGUI.openWindowCount + 1;
		eventCollector.addEvent(this, UIOEvent.REMOVED, onRemoved );
	}
	
	private function onRemoved( event:UIOEvent ):void
	{
		eventCollector.removeEvent(this, UIOEvent.REMOVED, onRemoved );
		VoxelVerseGUI.openWindowCount = VoxelVerseGUI.openWindowCount - 1;
	}
	
}
}