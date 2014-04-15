
package com.voxelengine.GUI
{
import com.voxelengine.events.LoadingEvent;
import com.voxelengine.events.LoginEvent;
import com.voxelengine.events.RegionEvent;
import com.voxelengine.server.Network;
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


public class WindowObjects extends VVPopup
{
	static private const WIDTH:int = 200;
	
	static private var _s_currentInstance:WindowObjects = null;
	static public function get isActive():Boolean { return null != _s_currentInstance; }
	static public function create():WindowObjects 
	{  
		if ( null == _s_currentInstance )
			new WindowObjects();
		return _s_currentInstance; 
	}
	
	
	private var _listbox1:ListBox = new ListBox( WIDTH, 15 );
	private var _createFileButton:Button		
	
	public function WindowObjects()
	{
		super("Object List");
		var openType:String = Globals.mode;
		autoSize = true;
		layout.orientation = LayoutOrientation.VERTICAL;
//		closeButtonActive = false;

		// Buttons in TabBar
		if ( Globals.MODE_LOCAL != openType  )
		{
			var bar:TabBar = new TabBar();
			bar.setButtonsWidth( WIDTH/2 );
			bar.addItem( Globals.MODE_PUBLIC );
			bar.addItem( Globals.MODE_PRIVATE );
			addGraphicElements( bar );
			eventCollector.addEvent( bar, ListEvent.ITEM_CLICKED, selectCategory );
			//eventCollector.addEvent( bar, ListEvent.ITEM_PRESSED, pressCategory );
		}

		// Label
		addElement(new Label( "Click Object to load" ));
		
		// Listbox
		addElement( _listbox1 );
	/*	
		if ( Globals.MODE_LOCAL != openType )
		{
			var buttonPanel:Container = new Container( WIDTH, 20);
			_createFileButton = new Button( "Create" );
			buttonPanel.addElement( _createFileButton );
			addElement( buttonPanel );
			eventCollector.addEvent( _createFileButton , UIMouseEvent.CLICK
								   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_PERSISTANCE_CREATE, "" ) ); remove(); } );
		}
	*/
		
		// Event handlers
		eventCollector.addEvent( _listbox1, UIMouseEvent.CLICK, loadthisObject );
		//eventCollector.addEventListener( _listbox1, ListEvent.LIST_CHANGED, selectSandbox);
		// These events are needed to keep mouse clicks from leaking thru window
		// This needs to be handled by stage
		Globals.g_app.stage.addEventListener(Event.RESIZE, onResize);
		//eventCollector.addEvent( this, UIMouseEvent.CLICK, windowClick );
		eventCollector.addEvent( this, UIOEvent.REMOVED, onRemoved );
		//eventCollector.addEvent( this, UIMouseEvent.PRESS, pressWindow );
		
		//Globals.g_app.addEventListener( RegionEvent.REGION_CACHE_COMPLETE, regionCacheComplete );
		
		if ( bar )
		{
			bar.selectedIndex = 0;
		}
		displaySelectedObjectList( openType );
		
		display( Globals.g_renderer.width / 2 - (((width + 10) / 2) + x ), Globals.g_renderer.height / 2 - (((height + 10) / 2) + y) );
	}
	
	private function selectCategory(e:ListEvent):void 
	{			
		displaySelectedObjectList( e.target.value );	
	}
	
	protected function onResize(event:Event):void
	{
		move( Globals.g_renderer.width / 2 - (width + 10) / 2, Globals.g_renderer.height / 2 - (height + 10) / 2 );
	}
	
	// Window events
	private function onRemoved( event:UIOEvent ):void
	{
		Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize);
		//Globals.g_app.removeEventListener( RegionEvent.REGION_CACHE_COMPLETE, regionCacheComplete );

		removeEventListener(UIOEvent.REMOVED, onRemoved );
		eventCollector.removeAllEvents();
		_s_currentInstance = null;
	}
	
////////////////////////////////////////////////////////////////////////////////////////

	private function onClickSandBox(event:UIMouseEvent):void 
	{
		//loadthisRegion( null );
	}
	
	private function displaySelectedObjectList( type:String ):void
	{
		_listbox1.removeAll();
		if ( Globals.MODE_LOCAL == type )
		{
			populateObjectListFromLocal();
		}
		else if ( Globals.MODE_PRIVATE == type )
		{
			populateObjectListFromPrivate();
		}
		else if ( Globals.MODE_PUBLIC == type )
		{
			populateObjectListFromPublic();
		}
	}

	private function populateObjectListFromPrivate():void
	{
		Globals.g_modelManager.loadUserObjects( Network.userId, loadObjects );
	}
	
	private function populateObjectListFromPublic():void
	{
		Globals.g_modelManager.loadPublicObjects( Network.userId, loadObjects );
	}
	
	private function populateObjectListFromLocal():void
	{
		//Globals.g_modelManager.loadUserObjects( Network.userId, loadObjects );
	}
	
	import playerio.DatabaseObject;
	private function loadObjects( dba:Array ):void
	{
		for each ( var dbo:DatabaseObject in dba )
		{
			//trace( dbo.description );
			//trace( dbo.name );
			//trace( dbo.template );
			trace( "WindowObject - Adding to list name: "  + dbo.name + "  key: " + dbo.key );
			_listbox1.addItem( dbo.name + " - " + dbo.description, dbo.key );
		}
	}
	
	private function  loadthisObject( e:UIMouseEvent ):void
	{
		
	}
}
}