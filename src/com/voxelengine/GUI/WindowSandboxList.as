
package com.voxelengine.GUI
{
import com.voxelengine.events.LoginEvent;
import com.voxelengine.events.RegionEvent;
import com.voxelengine.server.VVServer;
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


public class WindowSandboxList extends VVPopup
{
	static private const WIDTH:int = 200;
	
	static private var _s_currentInstance:WindowSandboxList = null;
	static public function get isActive():Boolean { return null != _s_currentInstance; }
	static public function create():WindowSandboxList 
	{  
		if ( null == _s_currentInstance )
			new WindowSandboxList();
		return _s_currentInstance; 
	}
	
	
	private var _listbox1:ListBox = new ListBox( WIDTH, 15 );
	private var _createFileButton:Button		
	
	public function WindowSandboxList()
	{
		super("Sandbox List");
		var openType:String = Globals.mode;
		autoSize = true;
		layout.orientation = LayoutOrientation.VERTICAL;
		closeButtonActive = false;

		// Buttons in TabBar
		if ( Globals.MODE_LOCAL != openType  )
		{
			var bar:TabBar = new TabBar();
			bar.setButtonsWidth( WIDTH/2 );
			bar.addItem( Globals.MODE_PUBLIC );
			bar.addItem( Globals.MODE_PRIVATE );
			addGraphicElements( bar );
			eventCollector.addEvent( bar, ListEvent.ITEM_CLICKED, selectCategory );
			eventCollector.addEvent( bar, ListEvent.ITEM_PRESSED, pressCategory );
		}

		// Label
		addElement(new Label( "Click Sandbox to load" ));
		
		// Listbox
		addElement( _listbox1 );
		
		if ( Globals.MODE_LOCAL != openType )
		{
			var buttonPanel:Container = new Container( WIDTH, 20);
			_createFileButton = new Button( "Create" );
			buttonPanel.addElement( _createFileButton );
			addElement( buttonPanel );
			eventCollector.addEvent( _createFileButton , UIMouseEvent.CLICK
								   , createRegion )
		}
	
		
		// Event handlers
		eventCollector.addEvent( _listbox1, UIMouseEvent.CLICK, loadthisRegion );
		//eventCollector.addEventListener( _listbox1, ListEvent.LIST_CHANGED, selectSandbox);
		// These events are needed to keep mouse clicks from leaking thru window
		// This needs to be handled by stage
		Globals.g_app.stage.addEventListener(Event.RESIZE, onResize);
		eventCollector.addEvent( this, UIMouseEvent.CLICK, windowClick );
		eventCollector.addEvent( this, UIOEvent.REMOVED, onRemoved );
		eventCollector.addEvent( this, UIMouseEvent.PRESS, pressWindow );
		
		Globals.g_app.addEventListener( RegionEvent.REGION_CACHE_COMPLETE, regionCacheComplete );
		
		if ( bar )
		{
			bar.selectedIndex = 0;
		}
		displaySelectedRegionList( openType );
		
		display( Globals.g_renderer.width / 2 - (((width + 10) / 2) + x ), Globals.g_renderer.height / 2 - (((height + 10) / 2) + y) );
	}
	
	private function createRegion(e:UIMouseEvent):void
	{
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_PERSISTANCE_CREATE, "" ) ); 
		remove();
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
	private function pressCategory(e:UIMouseEvent):void
	{
		//Log.out( "WindowInventory.pressCategory" );
		//Globals.GUIControl = true;
	}
	
	private function selectCategory(e:ListEvent):void 
	{			
		//Log.out( "WindowInventory.selectCategory" );
		//Globals.GUIControl = true;
		//while ( 1 < numElements )
		//{
			//removeElementAt( 1 );
		//}
		displaySelectedRegionList( e.target.value );	
	}
	protected function onResize(event:Event):void
	{
		move( Globals.g_renderer.width / 2 - (width + 10) / 2, Globals.g_renderer.height / 2 - (height + 10) / 2 );
	}
	
	// Window events
	private function onRemoved( event:UIOEvent ):void
	{
		//Globals.GUIControl = false;
		
		Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize);
		Globals.g_app.removeEventListener( RegionEvent.REGION_CACHE_COMPLETE, regionCacheComplete );

		removeEventListener(UIOEvent.REMOVED, onRemoved );
		eventCollector.removeAllEvents();
		_s_currentInstance = null;
	}
	
	private function onClickSandBox(event:UIMouseEvent):void 
	{
		//Globals.GUIControl = true;
		loadthisRegion( null );
	}
	
	private function loadthisRegion(event:UIMouseEvent):void 
	{
		if ( -1 == _listbox1.selectedIndex )
			return;
			
		var li:ListItem = _listbox1.getItemAt( _listbox1.selectedIndex );
		if ( li && li.data )
		{
			if ( Globals.MODE_LOCAL != Globals.mode )
				VVServer.joinRoom( li.data );
			else	
				new WindowRegionDetail( li.data );	
		}
		remove();
	}
	
	private function displaySelectedRegionList( type:String ):void
	{
		_listbox1.removeAll();
		if ( Globals.MODE_LOCAL == type )
		{
			populateSandboxListFromLocal();
		}
		else if ( Globals.MODE_PRIVATE == type )
		{
			populateSandboxListFromPrivate();
		}
		else if ( Globals.MODE_PUBLIC == type )
		{
			populateSandboxListFromPublic();
		}
	}

	private function populateSandboxListFromPrivate():void
	{
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_PRIVATE, "" ) );
	}
	
	private function populateSandboxListFromPublic():void
	{
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_PUBLIC, "" ) );
	}
	
	private function populateSandboxListFromLocal():void
	{
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_LOCAL, "startingRegion" ) );
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_LOCAL, "kickstarter" ) );
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_LOCAL, "collisionTest" ) );
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_LOCAL, "multiplayerTestRegion" ) );
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_LOCAL, "startingRegionTwoPlatforms" ) );
		Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CACHE_REQUEST_LOCAL, "zeppelin" ) );
	}
	
	private function regionCacheComplete( e: RegionEvent ):void
	{
		Log.out( "WindowSandboxList.regionCacheComplete - adding regionId: " + e.regionId );
		var region:Region = Globals.g_regionManager.getRegion( e.regionId );
		_listbox1.addItem( region.name, region.regionId );
	}
}
}