
package com.voxelengine.GUI
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import org.flashapi.swing.Box;
	import org.flashapi.swing.Image;
    import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.Container;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.events.GUIEvent;
	import com.voxelengine.worldmodel.TypeInfo;
	import com.voxelengine.worldmodel.oxel.GrainCursor;
	import com.voxelengine.worldmodel.models.EditCursor;
	 
	public class Hub extends VVContainer
	{
		private var TOOLBAROUTLINE_WIDTH:int = 748;
		private var TOOLBAROUTLINE_HEIGHT:int = 172;
		
		private var _itemInventory:QuickInventory = null;
		private var _toolSize:QuickInventory = null;
		private var _shape:ShapeSelector = null;
		
		private static var _lastItemSelection:int = -1;
		private static var _lastGrainSelection:int = -1;
		private static var _itemMaterialSelection:int = -1;
		
		
		private var _evtColl:EventCollector = new EventCollector();;
		
		private const ITEM_COUNT:int = 10;
		
		public function get itemInventory():QuickInventory { return _itemInventory; }
		public function get toolSize():QuickInventory { return _toolSize; }
		
		public function Hub()
		{
			var outline:Image = new Image( Globals.appPath + "assets/textures/" + "hub_bob.png");
			addElement( outline );
			
			_itemInventory = new QuickInventory();
			addChild(_itemInventory);
			_toolSize = new QuickInventory();
			addChild(_toolSize);
			
			_shape = new ShapeSelector();
			addChild(_shape);
			
			display( 0, Globals.g_renderer.height - 186 );

			// These have to be AFTER display for some odd reason or they wont work.
			buildGrainSizeSelector();	
			buildInventorSelector();
			_shape.addShapeSelector();			
			
			resizeHub( null );
			
			show();
			
			Globals.g_app.dispatchEvent( new GUIEvent( GUIEvent.TOOLBAR_SHOW ) );
		}

		public function addListeners():void
		{
			Globals.g_app.stage.addEventListener(KeyboardEvent.KEY_DOWN, hotKeyInventory );
			Globals.g_app.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);	
			Globals.g_app.stage.addEventListener( Event.RESIZE, resizeHub );
		}
		
		public function removeListeners():void
		{
			Globals.g_app.stage.removeEventListener(KeyboardEvent.KEY_DOWN, hotKeyInventory );
			Globals.g_app.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);	
			Globals.g_app.stage.removeEventListener( Event.RESIZE, resizeHub );
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Inventory and ToolSize
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		private function buildItem( ti:TypeInfo, count:int ):Box
		{
			var buildResult:Object;
			buildResult = _itemInventory.buildItem( ti, count, String(count+1) + ".png" );
			_evtColl.addEvent( buildResult.box, UIMouseEvent.PRESS, pressItem );
			_evtColl.addEvent( buildResult.box, UIMouseEvent.RELEASE, releaseItem );
			_evtColl.addEvent( buildResult.hotkey, UIMouseEvent.PRESS, pressItem );
			_evtColl.addEvent( buildResult.hotkey, UIMouseEvent.RELEASE, releaseItem );
			return buildResult.box;
		}
		
		public function show():void
		{
			this.visible = true;
			_itemInventory.visible = true;
			_toolSize.visible = true;
			_shape.visible = true;
			Globals.g_app.editing = true;
			addListeners();
		}
		
		public function hide():void
		{
			Globals.g_app.editing = false;
			this.visible = false;
			_itemInventory.visible = false;
			_toolSize.visible = false;
			_shape.visible = false;
			removeListeners();
		}
		
		// Dont call this until 
		public function buildInventorSelector():void
		{
			_itemInventory.name = "ItemSelector";
			
			var count:int = 0;
			var pickItem:TypeInfo = new TypeInfo();
			pickItem.image = "pick.png";
			pickItem.name = "pick";
			buildItem( pickItem, count++ );
			
			var noneItem:TypeInfo = new TypeInfo();
			noneItem.image = "none.png";
			noneItem.name = "none";
			var noneBox:Box = buildItem( noneItem, count++ );
			
			// Should add what is in current inventory here.
			for  ( ; count < ITEM_COUNT;  )
			{
				buildItem( null, count++ );
			}
			
			_itemInventory.addSelector();			
			
			_itemInventory.width = ITEM_COUNT * 64;
			_itemInventory.display();
			
			processItemSelection( noneBox );
			
			resizeHub(null);
		}

		private function buildGrain( ti:TypeInfo, count:int ):Box
		{
			var buildResult:Object = _toolSize.buildGrain( ti, count, "F" + String(count) + ".png" );
			_evtColl.addEvent( buildResult.box, UIMouseEvent.PRESS, pressGrain );
			_evtColl.addEvent( buildResult.box, UIMouseEvent.RELEASE, releaseGrain );
			_evtColl.addEvent( buildResult.hotkey, UIMouseEvent.PRESS, pressGrain );
			_evtColl.addEvent( buildResult.hotkey, UIMouseEvent.RELEASE, releaseGrain );
			return buildResult.box;
		}
		
		public function buildGrainSizeSelector():void
		{
			_toolSize.name = "GrainSelector";

			var count:int = 1;
			var ti:TypeInfo = new TypeInfo();
			ti.image = "0.0625meter.png";
			ti.name = "0";
			buildGrain( ti, count++ );
			
			ti = new TypeInfo();
			ti.image = "0.125meter.png";
			ti.name = "1";
			buildGrain( ti, count++ );
			
			ti = new TypeInfo();
			ti.image = "0.25meter.png";
			ti.name = "2";
			buildGrain( ti, count++ );
			
			ti = new TypeInfo();
			ti.image = "0.5meter.png";
			ti.name = "3";
			buildGrain( ti, count++ );
			
			ti = new TypeInfo();
			ti.image = "1meter.png";
			ti.name = "4";
			var meterBox:Box = buildGrain( ti, count++ );
			
			ti = new TypeInfo();
			ti.image = "2meter.png";
			ti.name = "5";
			buildGrain( ti, count++ );
			
			ti = new TypeInfo();
			ti.image = "4meter.png";
			ti.name = "6";
			buildGrain( ti, count++ );
			
			_toolSize.width = 7 * 64;
			_toolSize.display();
			//grainAction( 4 );
			_toolSize.addSelector();			
			processGrainSelection( meterBox );
		}
	
		private function pressItem(e:UIMouseEvent):void 
		{
			var box:UIObject = e.target as UIObject;
			processItemSelection( box );
		}			
		
		private function releaseItem(e:UIMouseEvent):void 
		{
		}			
		
		private function pressGrain(e:UIMouseEvent):void 
		{
			var box:UIObject = e.target as UIObject;
			processGrainSelection( box );
		}			
			
		private function releaseGrain(e:UIMouseEvent):void 
		{
		}			
		
		private function selectItemByIndex( index:int ):void
		{
			processItemSelection( _itemInventory.getBoxFromIndex( index ) );
		}
		
		private function selectGrainByIndex( index:int ):void
		{
			processGrainSelection( _toolSize.getBoxFromIndex( index ) );
		}
		
		
		public function processGrainSelection( box:UIObject ):void 
		{
			var ti:TypeInfo = box.data as TypeInfo;
			EditCursor.editCursorSize = int ( ti.name.toLowerCase() );
			_toolSize.moveSelector( box.x );

			
			if ( Globals.controlledModel )
			{
				// don't want movement speed to be 0, so set it to 0.5
				if ( 0 == EditCursor.editCursorSize )
					Globals.controlledModel.instanceInfo.setSpeedMultipler( 0.5 ); 
				else
					Globals.controlledModel.instanceInfo.setSpeedMultipler( EditCursor.editCursorSize ); 
			}
			
			if ( null != Globals.selectedModel )
			{
				var current:GrainCursor = Globals.selectedModel.editCursor.oxel.gc;
				if ( current.grain > EditCursor.editCursorSize )
					EditCursor.shrinkCursor();
				else if ( current.grain < EditCursor.editCursorSize )
					EditCursor.growCursor();
			}
		}
		
		public function processItemSelection( box:UIObject ):void 
		{
			_itemInventory.moveSelector( box.x );
			
			var ti:TypeInfo = box.data as TypeInfo;
			var itemIndex:int = int( box.name );
			var name:String
			if ( ti )
				name = ti.name.toLowerCase();
			else 
				name = "none";
			
			Globals.g_app.editing = false;
			Globals.g_app.toolOrBlockEnabled = false;
			if ( "none" == name )
			{
				if ( _lastItemSelection != itemIndex )
				{   // We are selecting none when it was previously on another item
					EditCursor.cursorOperation = EditCursor.CURSOR_OP_NONE;
					Globals.g_app.editing = false;
					Globals.g_app.toolOrBlockEnabled = false;
				}
				else if ( - 1 != _itemMaterialSelection )// We are selecting the pick again when that is what we have already.
				{	// go back to previously used material
					EditCursor.cursorOperation = EditCursor.CURSOR_OP_INSERT;
					var lastBoxNone:Box = _itemInventory.getBoxFromIndex( _itemMaterialSelection );
					processItemSelection( lastBoxNone )
					return;
				}
			}
			else if ( "pick" == name )
			{
				Globals.g_app.editing = true;
				Globals.g_app.toolOrBlockEnabled = true;
				if ( _lastItemSelection != itemIndex )
				{   // We are selecting the pick when it was previously on another item
					EditCursor.cursorOperation = EditCursor.CURSOR_OP_DELETE;
					EditCursor.setPickColorFromType( EditCursor.cursorType )
				}
				else if ( - 1 != _itemMaterialSelection ) 
				{	// go back to previously used material
					EditCursor.cursorOperation = EditCursor.CURSOR_OP_INSERT;
					var lastBoxPick:Box = _itemInventory.getBoxFromIndex( _itemMaterialSelection );
					processItemSelection( lastBoxPick );
					return;
				}
			}
			else
			{
				EditCursor.cursorOperation = EditCursor.CURSOR_OP_INSERT;
				var index:int = 0;
				for each ( var o:TypeInfo in Globals.Info )
				{
					if ( name == o.name.toLowerCase() ) 
					{ 
						EditCursor.cursorColor = o.type; 
						_itemMaterialSelection = itemIndex;
						Globals.g_app.editing = true;
						Globals.g_app.toolOrBlockEnabled = true;
						break;
					}
					index++;
				}
			}
			_lastItemSelection = itemIndex;
		}
		
		public function hotKeyInventory(e:KeyboardEvent):void 
		{
//			if  ( Globals.GUIControl )
//				return;
			if  ( !Globals.active )
				return;
				
			if ( 49 <= e.keyCode && e.keyCode <= 58 )
			{
				var selectedItem:int = e.keyCode - 49;
				selectItemByIndex( selectedItem );
			}
			else if ( 112 <= e.keyCode && e.keyCode <= 118 )
			{
				var selectedGrain:int = e.keyCode - 112;
				selectGrainByIndex( selectedGrain );
			}
			else if ( 119 == e.keyCode )
			{
				_shape.pressShapeHotKey(e);
			}
		}
		
		protected function onMouseWheel(event:MouseEvent):void
		{
//			if  ( Globals.GUIControl )
//				return;
			if  ( !Globals.active )
				return;
				
			if ( !event.ctrlKey )
			{
				if ( -1 != _lastItemSelection )
				{
					if ( 0 < event.delta && _lastItemSelection < (ITEM_COUNT - 1)  )
					{
						selectItemByIndex( _lastItemSelection + 1 );
					}
					else if ( 0 < event.delta && ( ITEM_COUNT -1 ) == _lastItemSelection )
					{
						selectItemByIndex( 0 );
					}
					else if ( 0 > event.delta && 0 == _lastItemSelection )
					{
						selectItemByIndex( ITEM_COUNT - 1 );
					}
					else if ( 0 < _lastItemSelection )
					{
						selectItemByIndex( _lastItemSelection - 1 );
					}
				}
			}
			else
			{
				var curSelection:int = QuickInventory.currentItemSelection;
				if ( 0 > event.delta )
				{
					curSelection--;
					if ( curSelection < 0 )
						curSelection = 0;
				}
				else
				{
					curSelection++;
					if ( 6 < curSelection )
						curSelection = 6;
				}
				processGrainSelection( _toolSize.getBoxFromIndex( curSelection ) );
			}
				
		}
		
		public function resizeHub(event:Event):void 
		{
			var halfRW:int = Globals.g_renderer.width / 2;
			var halfRH:int = Globals.g_renderer.height / 2;
			_toolSize.y = Globals.g_renderer.height - (_toolSize.height * 2);
			_toolSize.x = halfRW - (_toolSize.width / 2) + 73;

			_itemInventory.y = Globals.g_renderer.height - (_itemInventory.height );
			_itemInventory.x = (halfRW  -  320);
			
			_shape.y = Globals.g_renderer.height - 128;
			_shape.x = halfRW - (_toolSize.width / 2) - 67;
			
			y = Globals.g_renderer.height - TOOLBAROUTLINE_HEIGHT;
			x = halfRW - (TOOLBAROUTLINE_WIDTH / 2);
		}
	}
}