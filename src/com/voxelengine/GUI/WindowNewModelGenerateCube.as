
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

	
	
public class WindowNewModelGenerateCube extends ModalPopup
	{
		private var _cbSize:ComboBox;
		private var _cbType:ComboBox;
		private var _ii:InstanceInfo;

		public function WindowNewModelGenerateCube( ii:InstanceInfo )
		{ 
			super( "WindowNewModelGenerateCube", 100, 100 );
			_ii = ii;
			_modalObj = new ModalObject( this );
			
			layout.orientation = LayoutOrientation.VERTICAL;
            autoSize = true;
			shadow = true;
			
			var panel:Panel = new Panel( 200, 80);
            panel.autoSize = true;
			panel.layout.orientation = LayoutOrientation.VERTICAL;
			
			var size:Label = new Label( "Size in meters" )
			size.fontSize = 14;
			panel.addElement( size );
			_cbSize = new ComboBox( "Size in meters" );
			
			for ( var i:int = 4; i < 12; i++ )
			{
				_cbSize.addItem( String(1<<(i-4)), i );
			}
			_cbSize.selectedIndex = 0;
			panel.addElement( _cbSize );
			
			var madeOfType:Label = new Label( "Made of Type" )
			madeOfType.fontSize = 14;
			panel.addElement( madeOfType );
			_cbType = new ComboBox( "Made Of" );
			for each (var nitem:TypeInfo in Globals.Info )
			{
				_cbType.addItem( nitem.name, nitem.type );
			}
			_cbType.selectedIndex = 0;
			panel.addElement( _cbType );
			
			addElement( panel );
			
			var button:Button = new Button( "Create" );
			button.addEventListener(MouseEvent.CLICK, create );
			addElement( button );
			
			_modalObj.display( 200, 150 );
		} 
		
		private function create(event:UIMouseEvent):void 
		{
			if ( -1 == _cbSize.selectedIndex )
				return;
			var li:ListItem = _cbSize.getItemAt(_cbSize.selectedIndex );
			var size:int = li.data;			
			var liType:ListItem = _cbType.getItemAt( _cbType.selectedIndex );
			var type:int = liType.data;			
			_ii.grainSize = size;
			_ii.type = type;
			var viewDistance:Vector3D = new Vector3D(0, 0, -75);
			_ii.positionSet = Globals.controlledModel.instanceInfo.worldSpaceMatrix.transformVector( viewDistance );
			Globals.g_modelManager.create( _ii );
			_modalObj.remove();
		}
	}
}