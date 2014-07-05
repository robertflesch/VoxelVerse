package com.voxelengine.GUI
{
	import flash.display.BlendMode;
	import flash.events.MouseEvent;

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
	import com.voxelengine.worldmodel.TypeInfo;
	
	public class WindowInventory extends VVPopup
	{
		private var _dragOp:DnDOperation = new DnDOperation();
		
		public function WindowInventory()
		{
			super("Inventory");
			autoSize = true;
			layout.orientation = LayoutOrientation.VERTICAL;
			
            var bar:TabBar = new TabBar();
			// TODO I should really iterate thru that types and collect the categories - RSF
            bar.addItem("Earth");
			bar.addItem("Liquid");
            bar.addItem("Plant");
            bar.addItem("Metal");
            bar.addItem("Air");
            bar.addItem("Dragon");
            bar.addItem("Util");
            bar.addItem("Gem");
            bar.addItem("Avatar");
            bar.addItem("Light");
            var li:ListItem = bar.addItem("All");
			bar.setButtonsWidth( 64 );
			bar.selectedIndex = li.index;
            
            addGraphicElements( bar );
            
            eventCollector.addEvent( bar, ListEvent.ITEM_CLICKED, selectCategory );
            eventCollector.addEvent( bar, ListEvent.ITEM_PRESSED, pressCategory );
            eventCollector.addEvent( this, UIMouseEvent.CLICK, windowClick );
            eventCollector.addEvent( this, UIOEvent.REMOVED, onRemoved );
            eventCollector.addEvent( this, UIMouseEvent.PRESS, pressWindow );
			eventCollector.addEvent(_dragOp, DnDEvent.DND_DROP_ACCEPTED, dropMaterial );
			
			display();
			
			displaySelectedCategory( "all" );
			
			move( Globals.g_renderer.width / 2 - width / 2, Globals.g_renderer.height / 2 - height / 2 );
		}

		private function onRemoved( event:UIOEvent ):void 
		{
			//Log.out( "WindowInventory.onRemoved" );
//			Globals.GUIControl = false;
			eventCollector.removeAllEvents();
		}
			
		private function dropMaterial(e:DnDEvent):void 
		{
			//Log.out( "WindowInventory.dropMaterial" );
			if ( e.dragOperation.initiator.data is TypeInfo )
			{
				e.dropTarget.backgroundTexture = e.dragOperation.initiator.backgroundTexture;
				e.dropTarget.data = e.dragOperation.initiator.data;
			}
//			Globals.GUIControl = false;
		}
			
		private function doDrag(e:UIMouseEvent):void 
		{
			//Log.out( "WindowInventory.doDrag" );
			//Globals.GUIControl = true;
			_dragOp.initiator = e.target as UIObject;
			UIManager.dragManager.startDragDrop(_dragOp);
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
			while ( 1 < numElements )
			{
				removeElementAt( 1 );
			}
			displaySelectedCategory( e.target.value );	
		}
		
		private function displaySelectedCategory( category:String ):void
		{	
			var count:int = 0;
			var pc:Container = new Container( width, 64 );
			//pc.autoSize = false;
			var countMax:int = width/64
			for each (var item:TypeInfo in Globals.Info )
			{
				if ( item.placeable && (item.category.toLowerCase() == String(category).toLowerCase() || "all" == String(category).toLowerCase() ) )
				{
					if ( countMax == count )
					{
						addElement( pc );
						pc = new Container( width, 64 );
						count = 0;		
					}
					var box:Box = new Box(64, 64, BorderStyle.INSET);
					box.autoSize = false;
					box.dragEnabled = true;
					box.data = item;
					box.title = item.name;
					box.titlePosition = BorderPosition.BELOW_TOP;
					box.titleAlignment = HorizontalAlignment.CENTER;
					box.titleLabel.color = 0x00FF00;
					//box.titleLabel.textField.blendMode = BlendMode.INVERT;
					box.titleLabel.textField.blendMode = BlendMode.ADD;
					box.backgroundTexture = "assets/textures/" + item.image;
					
					pc.addElement( box );
					eventCollector.addEvent( box, UIMouseEvent.PRESS, doDrag);
					count++
				}
			}
			addElement( pc );
		}
	}
}