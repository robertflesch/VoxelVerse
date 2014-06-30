
package com.voxelengine.GUI 
{
import com.voxelengine.events.LoginEvent;
import com.voxelengine.events.RegionEvent;
import com.voxelengine.worldmodel.Region;
import flash.display.DisplayObjectContainer;
import org.flashapi.swing.*;
import org.flashapi.swing.core.UIDescriptor;
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
import org.flashapi.swing.button.RadioButtonGroup;
import org.flashapi.swing.databinding.DataProvider;

import com.voxelengine.Globals;
import com.voxelengine.Log;

public class WindowRegionNew extends VVPopup
{
	private static const WIDTH:int = 300;
	private static const BORDER_WIDTH:int = 4;
	private static const BORDER_WIDTH_2:int = BORDER_WIDTH * 2;
	private static const BORDER_WIDTH_3:int = BORDER_WIDTH * 3;
	private static const BORDER_WIDTH_4:int = BORDER_WIDTH * 4;
	
	private var _region:Region = null;
	private var _rbGroup:RadioButtonGroup = null;
	
		//DONE private var _name:String = "Some Friendly Name";
		//DONE private var _desc:String = "Tell me about it";
		//HM...private var _worldId:String = "VoxelVerse";
		//DONE private var _regionId:String = DEFAULT_REGION_ID;
		//Hm...private var _template:String = DEFAULT_REGION_ID;
		//Hm...private var _owner:String;
		//Hm...private var _editors:Vector.<String> = new Vector.<String>() //{ user Id1:role, user id2:role... }
		//Hm...private var _admin:Vector.<String> = new Vector.<String>() // : { user Id1:role, user id2:role... }
		//DONE private var _created:Date;
		//DONE private var _modified:Date;
		//private var _data:String;
		//private var _regionObject:Object;
		//private var _databaseObject:DatabaseObject  = null;							// INSTANCE NOT EXPORTED
		//private var _changed:Boolean = false;
		//private var _currentRegion:Boolean = true;
        //private var _changeTimer:Timer;
	
	
	public function WindowRegionNew( $region:Region )
	{
		super( "New Region" );
		autoSize = true;
		layout.orientation = LayoutOrientation.VERTICAL;
		//closeButtonEnabled = false;
		closeButtonActive = false;
		//_modalObj = new ModalObject( this );
		
		_region = $region

		addElement( new Label( "ID: " + _region.regionId ) );
		addElement( new Label( "Gravity" ) );
		
		addLabel( this, "Name:", changeNameHandler, _region.name );
		addElement( new Label( "Description" ) );
		addTextArea( this, "Desc:", changeDescHandler, _region.desc );
		
		_rbGroup = new RadioButtonGroup( this );
		var radioButtons:DataProvider = new DataProvider();
		radioButtons.addAll( { label:"Use Gravity" }, { label:"NO Gravity. " } );
		eventCollector.addEvent( _rbGroup, ButtonsGroupEvent.GROUP_CHANGED
		                       , function (event:ButtonsGroupEvent):void 
							   {  _region.gravity = (0 == event.target.index ?  true : false) } );
//							   {   Globals.GUIControl = true; _region.gravity = (0 == event.target.index ?  true : false) } );
		_rbGroup.dataProvider = radioButtons;
		_rbGroup.index = 0;
		
		var buttonPanel:Container = new Container( WIDTH, 40 );
		
		 var createRegionButton:Button = new Button( "Create" );
		eventCollector.addEvent( createRegionButton , UIMouseEvent.CLICK
							   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CREATE_SUCCESS, _region.regionId ) ); remove(); } );
		buttonPanel.addElement( createRegionButton );

		 var cancelRegionButton:Button = new Button( "Cancel" );
		eventCollector.addEvent( cancelRegionButton , UIMouseEvent.CLICK
							   , function( e:UIMouseEvent ):void { Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_CREATE_CANCEL, _region.regionId ) ); _region = null; remove(); } );
		buttonPanel.addElement( cancelRegionButton );
	
		addElement( buttonPanel );
		
		
		Globals.g_app.stage.addEventListener(Event.RESIZE, onResize);
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
		// Globals.GUIControl = true;
	}
	private function windowClick(e:UIMouseEvent):void
	{
		//Log.out( "WindowInventory.windowClick" );
		// Globals.GUIControl = true;
	}
	protected function onResize(event:Event):void
	{
		// Globals.GUIControl = true;
		move( Globals.g_renderer.width / 2 - (width + 10) / 2, Globals.g_renderer.height / 2 - (height + 10) / 2 );
	}
	private function onRemoved( event:UIOEvent ):void
	{
         Globals.g_app.stage.removeEventListener(Event.RESIZE, onResize);
//			removeEventListener(UIOEvent.REMOVED, onRemoved );
		eventCollector.removeAllEvents();
	}
	
	private function changeNameHandler(event:TextEvent):void
	{
		// Globals.GUIControl = true;
		_region.name = event.target.text;
	}
	
	private function changeDescHandler(event:TextEvent):void
	{
		// Globals.GUIControl = true;
		_region.desc = event.target.text;
	}
	
	private function addLabel( parentPanel:UIContainer, label:String, changeHandler:Function, initialValue:String, inputEnabled:Boolean = false ):LabelInput
	{
		var li:LabelInput = new LabelInput( label, initialValue );
		li.labelControl.width = 120;
		if ( null != changeHandler )
			li.editableText.addEventListener( TextEvent.EDITED, changeHandler );
		else
		{
			li.editableText.editable = false;
			li.editableText.fontColor = 0x888888;
		}

		var myWidth:int = li.width + BORDER_WIDTH_4 + BORDER_WIDTH_2;
		var myHeight:int = li.height + BORDER_WIDTH_4;
		var panel:Panel = new Panel( myWidth, myHeight );
		panel.addElement( li );
		panel.borderWidth = BORDER_WIDTH;
		parentPanel.addElement( panel );
		//_calculatedWidth = Math.max( myWidth, _calculatedWidth );
		
		return li;
	}

	import org.flashapi.swing.containers.UIContainer;
	private function addTextArea( parentPanel:UIContainer, label:String, changeHandler:Function, initialValue:String, inputEnabled:Boolean = false ):TextArea
	{
		var li:TextArea = new TextArea();
//		li.labelControl.width = 120;
		li.appendText( initialValue );
		li.width = 250;
		if ( null != changeHandler )
			li.addEventListener( TextEvent.EDITED, changeHandler );
			
//			eventCollector.addEvent( descInput, TextEvent.EDITED
//								   , function(e:TextEvent):void { _mi.desc = e.target.text; // Globals.GUIControl = true; } );
			
		//else
		//{
			//li.editableText.editable = false;
			//li.editableText.fontColor = 0x888888;
		//}

		var myWidth:int = li.width + BORDER_WIDTH_4 + BORDER_WIDTH_2;
		var myHeight:int = li.height + BORDER_WIDTH_4;
		var panel:Panel = new Panel( myWidth, myHeight );
		panel.addElement( li );
		panel.borderWidth = BORDER_WIDTH;
		parentPanel.addElement( panel );
		//_calculatedWidth = Math.max( myWidth, _calculatedWidth );
		
		return li;
	}	
}
}