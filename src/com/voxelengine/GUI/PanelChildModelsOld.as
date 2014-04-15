
package com.voxelengine.GUI
{
	import com.voxelengine.worldmodel.models.ModelInfo;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import com.voxelengine.worldmodel.models.InstanceInfo;

	public class PanelChildModelsOld extends ScrollPane
	{
		private var _mi:ModelInfo = null;
		private var _width:int = 0;
		public function PanelChildModels( $width:int, $height:int, $mi:ModelInfo ):void
		{
			super( $width + 20, $height, DataFormat.OBJECT );			
			_mi = $mi;
			_width = $width;

			layout.orientation = LayoutOrientation.VERTICAL;
			layout.verticalAlignment = LayoutVerticalAlignment.TOP;
			layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			
			addElement( new Label( "Child Models" ) );
			var cbChildElement:CheckBox = new CheckBox( "Add Child" );
			cbChildElement.data = this;
			cbChildElement.addEventListener( UIMouseEvent.CLICK, addChildElement );
			addElement( cbChildElement );
			
			for each ( var childModel:InstanceInfo in _mi.children )
			{
				addElement( new ChildModelPanel( childModel, width ) );
			}
        }
		
		private function addChildElement( me:UIMouseEvent ):void
		{
			var btn:CheckBox = me.target as CheckBox;
			var parentContainer:ScrollPane = btn.data as ScrollPane; 
			var index:int = parentContainer.getElementIndex( btn );
			if ( btn.selected )
			{
				//parentContainer.removeElementAt( index );
				parentContainer.addElement( new ChildModelPanel( new InstanceInfo(), WindowModelTemplate.PANEL_WIDTH) );
				//parentContainer.addElement( btn );
				btn.selected = false;
			}
			
		}

	}
}

import com.voxelengine.GUI.WindowModelDetail;
import com.voxelengine.worldmodel.models.InstanceInfo;
import com.voxelengine.worldmodel.tasks.landscapetasks.TaskLibrary;
import com.voxelengine.worldmodel.TypeInfo;
import com.voxelengine.Globals;
import org.flashapi.collector.EventCollector;
import org.flashapi.swing.containers.UIContainer;
import org.flashapi.swing.*;
import org.flashapi.swing.containers.*;
import org.flashapi.swing.color.Color;
import org.flashapi.swing.event.*;
import org.flashapi.swing.constants.*;
import org.flashapi.swing.list.ListItem;
import com.voxelengine.GUI.layerDataComponents.LayerData;

class ChildModelPanel extends SimpleContainerBase
{
	static private const COMPONENT_HEIGHT:int = 20;
	private var _location:String = "";
	private var _totalHeight:int = -1;
	private var _ii:InstanceInfo = null
	
	public function ChildModelPanel( $ii:InstanceInfo, $width:int = 200, $height:int = 100):void
	{
		super( $width, 10 );
		_ii = $ii;
		padding = 0;
		layout.orientation = LayoutOrientation.VERTICAL;
		this.backgroundColor = Color.WINDOWS_WORKSPACE_COLOR;
//		layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
		this.addElement( new Label( "child" ) );
		this.addElement( new LayerData( "Name", _ii.name, nameChanged, width ) ); // offset
		this.addElement( new LayerData( "TemplateName", _ii.fileName, fileNameChanged, width ) ); // offset
		//this.addElement( new LayerData( "Location", _ii.name, locationChanged, width ) ); // offset
		eventCollector.addEvent( this, UIMouseEvent.CLICK, onClickHandler );
		_totalHeight += COMPONENT_HEIGHT * 5;	
		height = _totalHeight;
	}
	
	private function onClickHandler( e:UIMouseEvent ):void
	{
		new WindowModelDetail( _ii );
	}
	
	private function fileNameChanged( te:TextEvent ):void
	{
		//Globals.GUIControl = true;
		_ii.fileName =  te.target.text;
	}
	private function nameChanged( te:TextEvent ):void
	{
		//Globals.GUIControl = true;
		_ii.name =  te.target.text;
	}
	/*
	private function locationChanged( te:TextEvent ):void
	{
		//Globals.GUIControl = true;
		_location =  te.target.text;
	}
	*/
}
