
package com.voxelengine.GUI 
{
import com.voxelengine.events.LoginEvent;
import com.voxelengine.events.RegionEvent;
import com.voxelengine.worldmodel.Region;
import org.flashapi.swing.*;
import org.flashapi.swing.event.*;
import org.flashapi.swing.constants.*;
import org.flashapi.swing.list.ListItem;
import flash.events.Event;

import org.flashapi.collector.EventCollector;
import org.flashapi.swing.*
import org.flashapi.swing.core.UIObject;
import org.flashapi.swing.event.*;
import org.flashapi.swing.constants.*;
import org.flashapi.swing.list.ListItem;
import org.flashapi.swing.constants.BorderStyle;
import org.flashapi.swing.dnd.*;

import com.voxelengine.Globals;
import com.voxelengine.Log;

public class WindowRegionDetail extends VVPopup
{
	private var _loadFileButton:Button;
	private var _saveFileButton:Button;
	private var _deleteFileButton:Button;
	private var _bigDBButton:Button;
	
	private var _region:Region = null;
	
	public function WindowRegionDetail( $regionId:String )
	{
		super("Region Detail");
		autoSize = true;
		layout.orientation = LayoutOrientation.VERTICAL;
		//_modalObj = new ModalObject( this );
		
		_region = Globals.g_regionManager.getRegion( $regionId );

		addElement( new Label( "Name: " + _region.name ) );
		addElement( new Label( "Description: " + _region.desc ) );
		addElement( new Label( "ID: " + _region.regionId ) );
		addElement( new Label( "Gravity is " + ( _region.gravity ? "On" : "Off" )) );
		// Button pane
		var buttonPanel:Container = new Container( 300, 40 );
		
		if ( Globals.mode )
		{
			
			_loadFileButton = new Button( "Load" );
			//eventCollector.addEvent( _loadFileButton , UIMouseEvent.CLICK, loadLocal );
			eventCollector.addEvent( _loadFileButton , UIMouseEvent.CLICK
								   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_LOCAL_LOAD, _region.regionId ) ); remove(); } );
			buttonPanel.addElement( _loadFileButton );
								   
			_saveFileButton = new Button( "Save" );
			eventCollector.addEvent( _saveFileButton, UIMouseEvent.CLICK
								   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_LOCAL_UPDATE, _region.regionId ) ); remove(); } );
			buttonPanel.addElement( _saveFileButton );
			
			_bigDBButton = new Button( "Save To DB" );
			eventCollector.addEvent( _bigDBButton, UIMouseEvent.CLICK
								   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_PERSISTANCE_CREATE, _region.regionId ) ); remove(); } );
			buttonPanel.addElement( _bigDBButton );
		}
		else
		{
			_loadFileButton = new Button( "Load" );
			eventCollector.addEvent( _loadFileButton , UIMouseEvent.CLICK
								   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_PERSISTANCE_LOAD, _region.regionId ) ); remove(); } );
			buttonPanel.addElement( _loadFileButton );
								   
			_saveFileButton = new Button( "Save" );
			eventCollector.addEvent( _saveFileButton, UIMouseEvent.CLICK
								   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_PERSISTANCE_UPDATE, _region.regionId ) ); remove(); } );
			buttonPanel.addElement( _saveFileButton );
			
			_deleteFileButton = new Button( "Delete" );
			eventCollector.addEvent( _deleteFileButton, UIMouseEvent.CLICK
								   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_PERSISTANCE_DELETE, _region.regionId ) ); remove(); } );
			buttonPanel.addElement( _deleteFileButton );
		}
		
		addElement( buttonPanel );
		
		eventCollector.addEvent( this, Event.RESIZE, onResize );
		eventCollector.addEvent( this, UIMouseEvent.CLICK, windowClick );
		eventCollector.addEvent( this, UIOEvent.REMOVED, onRemoved );
		eventCollector.addEvent( this, UIMouseEvent.PRESS, pressWindow );
		
		// This auto centers
		//_modalObj.display();
		// this does not...
		display( Globals.g_renderer.width / 2 - (((width + 10) / 2) + x ), Globals.g_renderer.height / 2 - (((height + 10) / 2) + y) );
		//display();
	}
	
	private function pressWindow(e:UIMouseEvent):void
	{
		//Log.out( "WindowInventory.pressWindow" );
		//Globals.GUIControl = true;
	}
	private function windowClick(e:UIMouseEvent):void
	{
		//Log.out( "WindowInventory.windowClick" );
		//Globals.GUIControl = true;
	}
	protected function onResize(event:Event):void
	{
		//Globals.GUIControl = true;
		move( Globals.g_renderer.width / 2 - (width + 10) / 2, Globals.g_renderer.height / 2 - (height + 10) / 2 );
	}
	private function onRemoved( event:UIOEvent ):void
	{
//          Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize);
//			removeEventListener(UIOEvent.REMOVED, onRemoved );
		eventCollector.removeAllEvents();
		_region = null;
	}
}
}