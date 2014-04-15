
package com.voxelengine.GUI
{
	import com.voxelengine.worldmodel.models.ModelInfo;
	import org.flashapi.swing.*;
    import org.flashapi.swing.event.*;
    import org.flashapi.swing.constants.*;
	import com.voxelengine.worldmodel.models.InstanceInfo;
	import com.voxelengine.worldmodel.biomes.LayerInfo;
	
	public class PanelProcedurallyGeneratedModel extends ScrollPane
	{
		private var _mi:ModelInfo = null;
		private var _width:int = 0;
		public function PanelProcedurallyGeneratedModel( $width:int, $height:int, $mi:ModelInfo ):void
		{
			super( $width + 20, $height, DataFormat.OBJECT );			
			_mi = $mi;
			_width = $width;
			//-------------------- Procedurally Generated Models -----------------------------------------
//			borderStyle = BorderStyle.INSET;
//            borderWidth = 2;			
			layout.orientation = LayoutOrientation.VERTICAL;
//			layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			
			this.addElement( new Label( "Procedurally Generated Model" ) );
			var cbAddWorker:CheckBox = new CheckBox( "Add Worker" );
			cbAddWorker.data = this;
			cbAddWorker.addEventListener( UIMouseEvent.CLICK, addWorker );
			this.addElement( cbAddWorker );
			for each ( var layer:LayerInfo in _mi.biomes )
			{
				trace ( "WindowModelTemplate.constructor - layer: " + layer );
			}
        }
		
		private function addWorker( me:UIMouseEvent ):void
		{
			var btn:CheckBox = me.target as CheckBox;
			var parentContainer:ScrollPane = btn.data as ScrollPane; 
			var index:int = parentContainer.getElementIndex( btn );
			if ( btn.selected )
			{
				//parentContainer.removeElementAt( index );
				parentContainer.addElement( new WorkerPanel( _width ) );
				//parentContainer.addElement( btn );
				btn.selected = false;
			}
		}
	}
}

import org.flashapi.collector.EventCollector;
import org.flashapi.swing.*;
import org.flashapi.swing.containers.*;
import org.flashapi.swing.event.*;
import org.flashapi.swing.constants.*;
import org.flashapi.swing.list.ListItem;

import com.voxelengine.worldmodel.tasks.landscapetasks.TaskLibrary;
import com.voxelengine.worldmodel.TypeInfo;
import com.voxelengine.Globals;

class WorkerPanel extends SimpleContainerBase
{
	private var _range:int = -1;
	private var _offset:int = -1;
	private var _optionalInt:int = -1;
	private var _type:String = "";
	private var _functionName:String = "";
	private var _totalHeight:int = -1;
	public var myEventCollector:EventCollector = new EventCollector();
	
	static private const COMPONENT_HEIGHT:int = 20;
	public function WorkerPanel($width:int = 200, $height:int = 100):void
	{
		super( $width, 10 );
		padding = 0;
		layout.orientation = LayoutOrientation.VERTICAL;
		layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
		addWorkerSelector();
	}
	
	private function addWorkerSelector( index:int = -1 ):void
	{
		var cbFunction:ComboBox = new ComboBox( "Job of Worker" );
		
		// This gets a list of all worker types
		var libTask:Object = TaskLibrary.getAssetNames();
		for(var name:String in libTask) 
            cbFunction.addItem( name );
		
		cbFunction.addEventListener(ListEvent.LIST_CHANGED, selectionChanged );
		addElement( cbFunction );
		_totalHeight += COMPONENT_HEIGHT;
		
		if ( -1 != index	)
			cbFunction.selectedIndex = index;

	}

	private function selectionChanged( me:ListEvent ):void
	{
		var selected:int = (me.target as ComboBox).selectedIndex;
		removeGenerateLayerControls( selected );
		
		var cb:ComboBox = me.target as ComboBox;
		if ( -1 != cb.selectedIndex )
		{
			var li:ListItem = cb.getItemAt(cb.selectedIndex );
			if ( "GenerateLayer" == li.value )
			{
				AddGenerateLayerControls();
			}
			else if ( "GenerateWater" == li.value )
			{
				AddGenerateWaterControls();
			}

			_totalHeight += COMPONENT_HEIGHT;	
			
			_functionName = li.value;
		}
		
		height = _totalHeight;
	}
	
	private function removeGenerateLayerControls( index:int = -1 ):void
	{
		
		//for ( var index:int = numElements - 1; 0 < index; index-- )
		//		removeElementAt( index );
		
		while ( 0 < numElements )
			removeElementAt( 0 );
			
		trace( "removeGenerateLayerControls numberof Elements: " + numElements );
			
		_totalHeight = 0;
		
		addWorkerSelector( index );
	}
	
	private function AddGenerateLayerControls():void
	{
		addElement( new LayerData( "Starting Height(%)", "50", offsetChanged, width ) ); // offset
		addElement( new LayerData( "Range(%)", "70", rangeChanged, width ) );
		addElement( new LayerData( "Smallest Block(3+)", "4", optionalIntChanged, width ) ); // optional int
		addElement( new LayerTypeData( "Block Type", "DIRT", typeChanged, width ) );
		_totalHeight += COMPONENT_HEIGHT * 4;
	}
	
	private function AddGenerateWaterControls():void
	{
		addElement( new LayerData( "Starting Height(%)", "50", offsetChanged, width ) ); // offset
		addElement( new LayerData( "Smallest Block(3+)", "4", optionalIntChanged, width ) ); // optional int
		_totalHeight += COMPONENT_HEIGHT * 2;
	}
	
	private function offsetChanged( te:TextEvent ):void
	{
		//Globals.GUIControl = true;
		_offset = int( te.target.text );
		
	}
	private function rangeChanged( te:TextEvent ):void
	{
		//Globals.GUIControl = true;
		_range = int( te.target.text );
		
	}
	private function optionalIntChanged( te:TextEvent ):void
	{
		//Globals.GUIControl = true;
		_optionalInt = int( te.target.text );
		
	}
	private function typeChanged( le:ListEvent ):void
	{
		//Globals.GUIControl = true;
		var cb:ComboBox = (le.target as ComboBox);
		var selected:int = cb.selectedIndex;
		if ( -1 == cb.selectedIndex )
			return;
		var li:ListItem = cb.getItemAt(cb.selectedIndex );
		_type = li.value;
		trace( "type changed - type: " + _type );
	}
} // worker

class LayerData extends SimpleContainerBase
{
	public function LayerData( $label:String, $value:String, callBack:Function, $width:int = 180, $height:int = 20 ):void
	{
		super( $width, $height );
		padding = 0;
		//var compWidth = $width - 60;
		addElement( new Label( $label, 140 ) );
		var ti:TextInput = new TextInput( $value, 60 );
		ti.data = $label;
		addElement( ti );
		//worker.myEventCollector.addEvent( Text
		ti.addEventListener( TextEvent.EDITED, callBack );
	}
}

class LayerTypeData extends SimpleContainerBase
{
	public function LayerTypeData( $label:String, $value:String, callBack:Function, $width:int = 180, $height:int = 20 ):void
	{
		super( $width, $height );
		padding = 0;
		autoSize = false;
		addElement( new Label( "Made of Type" ) );
		
		var cbType:ComboBox = new ComboBox( $value, 80, 10 );
		cbType.addEventListener( ListEvent.LIST_CHANGED, callBack );
		cbType.x = $width - 80;
		for each (var nitem:TypeInfo in Globals.Info )
		{
			//if ( "INVALID" != nitem.name && "AIR" != nitem.name && "BRAND" != nitem.name && -1 == nitem.name.indexOf( "EDIT" ) && -1 == nitem.name.indexOf( "UNNAMED" ) )
			if ( "INVALID" != nitem.name && "AIR" != nitem.name && "BRAND" != nitem.name && -1 == nitem.name.indexOf( "EDIT" ) )
			{
				cbType.addItem( nitem.name, nitem.type );
			}
		}
		cbType.selectedIndex = 0;
		addElement( cbType );
	}
}

