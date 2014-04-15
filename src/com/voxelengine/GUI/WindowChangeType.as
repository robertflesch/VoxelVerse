
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
	
	
public class WindowChangeType extends VVPopup
	{
		private var _cb:ComboBox;
		private var _cbTo:ComboBox;
		private var _vm:VoxelModel;

		public function WindowChangeType( vm:VoxelModel ):void 
		{ 
			//throw new Error("Nothing here"); 
			_vm = vm;
			
			super("Change Type");
			layout.orientation = LayoutOrientation.VERTICAL;
            autoSize = true;
			shadow = true;
			
			var panel:Panel = new Panel( 200, 80);
            panel.autoSize = true;
			panel.layout.orientation = LayoutOrientation.VERTICAL;
			
			_cb = new ComboBox( "Original Type" );
			
			for each (var item:TypeInfo in Globals.Info )
			{
				_cb.addItem( item.name, item.type );
			}
			panel.addElement( _cb );
			
			_cbTo = new ComboBox( "New Type" );
			for each (var nitem:TypeInfo in Globals.Info )
			{
				_cbTo.addItem( nitem.name, nitem.type );
			}
			panel.addElement( _cbTo );
			
			addElement( panel );
			
			var button:Button = new Button( "Change all Types" );
			button.addEventListener(MouseEvent.CLICK, change );

			addElement( button );
			
			display( 200, 150 );
			
			//var pg:PictureGallery = new PictureGallery( 200, 200, BorderStyle.SOLID );
			//for each (var item:TypeInfo in Globals.Info )
			//{
				//trace( Globals.appPath + item.thumbnail );
				//
				//var o:Object = { image: (Globals.appPath + item.thumbnail), caption: item.name, data: item };
				//pg.addItem( o, item );
			//}
			//pg.display()			
		} 
		
		private function change(event:UIMouseEvent):void 
		{
			if ( _vm )
			{
				if ( -1 == _cb.selectedIndex )
					return;
				var li:ListItem = _cb.getItemAt(_cb.selectedIndex );
				var fromType:int = li.data;
				if ( -1 == _cbTo.selectedIndex )
					return;
				li = _cbTo.getItemAt(_cbTo.selectedIndex );
				var toType:int = li.data;
				_vm.oxel.changeTypeFromTo( fromType, toType );
			}
		}

	}
}