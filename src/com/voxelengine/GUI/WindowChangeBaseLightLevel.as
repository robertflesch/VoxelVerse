
package com.voxelengine.GUI
{
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.TypeInfo;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.events.MouseEvent;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	
	
public class WindowChangeBaseLightLevel extends VVPopup
	{
		private var _ll:LabelInput;
		private var _vm:VoxelModel;

		public function WindowChangeBaseLightLevel( vm:VoxelModel ):void 
		{ 
			//throw new Error("Nothing here"); 
			_vm = vm;
			
			super("Base Light Level");
			layout.orientation = LayoutOrientation.VERTICAL;
//            autoSize = true;
			shadow = true;
			
			var panel:Panel = new Panel( 200, 80);
            panel.autoSize = true;
			panel.layout.orientation = LayoutOrientation.VERTICAL;
			
			_ll = new LabelInput( "light level", "128" );
			
			panel.addElement( _ll );
			addElement( panel );
			
			var button:Button = new Button( "Change" );
			button.addEventListener(MouseEvent.CLICK, change );
			addElement( button );
			
			display( 200, 150 );
		} 
		
		private function change(event:UIMouseEvent):void 
		{
			if ( _vm )
			{
				var ll:String = _ll.label;
				_vm.oxel.lightsStaticSetDefault( parseInt( ll ) );
			}
		}

	}
}