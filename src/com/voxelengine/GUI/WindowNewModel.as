
package com.voxelengine.GUI
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.TypeInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.events.MouseEvent;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import flash.geom.Vector3D;

	
	
public class WindowNewModel extends VVPopup
	{
		public function WindowNewModel():void 
		{ 
			// I want a list of template, where does that come from?	
			var button:Button = new Button( "Create" );
//			button.addEventListener(MouseEvent.CLICK, create );
			addElement( button );
			
			display( 200, 150 );
		} 
		
	}
}