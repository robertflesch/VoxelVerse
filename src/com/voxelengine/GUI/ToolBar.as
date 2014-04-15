/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.GUI
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import org.flashapi.swing.Box;
	import org.flashapi.swing.Image;
	import org.flashapi.swing.Label;
    import org.flashapi.swing.event.UIMouseEvent;
    import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.core.UIObject;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.GUIEvent;
	 
	public class ToolBar extends VVCanvas	
	{
		private var TOOLBAROUTLINE_WIDTH:int = 800;
		private var TOOLBAROUTLINE_HEIGHT:int = 136;
		protected const IMAGE_SIZE:int = 64;
		
		protected var _itemInventory:QuickInventory = null;
		
		private const ITEM_COUNT:int = 10;
		
		public function ToolBar()
		{
			var outline:Image = new Image( Globals.appPath + "assets/textures/toolbar.png");
			addElement( outline );
			
			_itemInventory = new QuickInventory();
			addChild(_itemInventory);

			display( 0, Globals.g_renderer.height - TOOLBAROUTLINE_HEIGHT );

			// These have to be AFTER display for some odd reason or they wont work.
			buildActions();
			resizeToolBar( null );
			
			addListeners();
			//Globals.g_app.dispatchEvent( new GUIEvent( GUIEvent.TOOLBAR_SHOW ) );
		}
		
		private function onRemoved( event:UIOEvent ):void
 		{
			removeListeners();
			_itemInventory.remove();
			_itemInventory = null;
			eventCollector.removeAllEvents();
		}
		
		public function addListeners():void
		{
			Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_DOWN, hotKeyItem );
			Globals.g_app.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);	
			Globals.g_app.stage.addEventListener( Event.RESIZE, resizeToolBar );
			addEventListener(UIOEvent.REMOVED, onRemoved );
		}
		
		public function removeListeners():void
		{
			Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, hotKeyItem );
			Globals.g_app.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);	
			Globals.g_app.stage.removeEventListener( Event.RESIZE, resizeToolBar );
			removeEventListener(UIOEvent.REMOVED, onRemoved );
		}
		
		protected function mouseDown(e:MouseEvent):void {
			throw new Error( "ToolBar.mouseDown - Must be overriden" );
		}
		// Dont call this until after bar is displayed
		public function buildActions():void	{
			throw new Error( "ToolBar.buildActions - Must be overriden" );
		}
		public function processItemSelection( box:UIObject ):void 
		{
			throw new Error( "ToolBar.processItemSelection - Must be overriden" );
		}
		public function activateItemSelection( box:UIObject ):void 
		{
			throw new Error( "ToolBar.activateItemSelection - Must be overriden" );
		}
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Inventory and ToolSize
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function buildAction( actionItem:Object, count:int ):Box
		{
			var buildResult:Object = _itemInventory.buildActionItem( actionItem, count );
			eventCollector.addEvent( buildResult.box, UIMouseEvent.PRESS, pressItem );
			eventCollector.addEvent( buildResult.hotkey, UIMouseEvent.PRESS, pressItem );
			return buildResult.box;
		}
		
		public function show():void
		{
			this.visible = true;
			_itemInventory.visible = true;
			Globals.g_app.editing = true;
		}
		
		public function hide():void
		{
			Globals.g_app.editing = false;
			this.visible = false;
			_itemInventory.visible = false;
		}
		
		private function pressItem(e:UIMouseEvent):void {
			var box:UIObject = e.target as UIObject;
			processItemSelection( box );
			activateItemSelection( box );
		}			
		
		private function selectItemByIndex( index:int ):void
		{
			//Log.out( "ToolBar.selectItemByIndex: " + index );
			var box:Box = _itemInventory.getBoxFromIndex( index )
			_itemInventory.moveSelector( box.x );
			processItemSelection( box );
		}
		
		public function hotKeyItem(e:KeyboardEvent):void 
		{
			if  ( !Globals.active )
				return;
				
			//Log.out( "ToolBar.hotKeyItem: " + (e.keyCode - 49) );
			if ( 49 <= e.keyCode && e.keyCode <= 58 )
			{
				var selectedItem:int = e.keyCode - 49;
				var box:Box = _itemInventory.getBoxFromIndex( selectedItem );
				_itemInventory.moveSelector( box.x );
				processItemSelection( box );
				activateItemSelection( box );
			}
		}
		
		protected function onMouseWheel(event:MouseEvent):void
		{
			if  ( !Globals.active )
				return;
				
			var curSel:int = QuickInventory.currentItemSelection;
			if ( -1 != curSel )
			{
				if ( 0 < event.delta && curSel < (ITEM_COUNT - 1)  )
				{
					selectItemByIndex( curSel + 1 );
				}
				else if ( 0 < event.delta && ( ITEM_COUNT -1 ) == curSel )
				{
					selectItemByIndex( 0 );
				}
				else if ( 0 > event.delta && 0 == curSel )
				{
					selectItemByIndex( ITEM_COUNT - 1 );
				}
				else if ( 0 < curSel )
				{
					selectItemByIndex( curSel - 1 );
				}
			}
		}
		
		public function resizeToolBar(event:Event):void 
		{
			var halfRW:int = Globals.g_renderer.width / 2;
			var halfRH:int = Globals.g_renderer.height / 2;

			_itemInventory.y = Globals.g_renderer.height - (_itemInventory.height );
			_itemInventory.x = (halfRW  -  320);
			
			y = Globals.g_renderer.height - TOOLBAROUTLINE_HEIGHT;
			x = halfRW - (TOOLBAROUTLINE_WIDTH / 2);
		}
	}
}