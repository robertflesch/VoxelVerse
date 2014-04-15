/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.GUI
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;

	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.Box;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.dnd.DnDOperation;
	import org.flashapi.swing.layout.AbsoluteLayout;
	
	import com.voxelengine.worldmodel.TypeInfo;
	import com.voxelengine.Globals;
	
	public class QuickInventory extends VVCanvas
	{
		private static var s_currentItemSelection:int = -1;
		public static function get currentItemSelection():int { return s_currentItemSelection }
		public static function set currentItemSelection(val:int):void { s_currentItemSelection = val; }
		
		private const IMAGE_SIZE:int = 64;
		private var _dragOp:DnDOperation = new DnDOperation();
		private var _selector:Sprite = new Canvas(IMAGE_SIZE, IMAGE_SIZE);
		
		
		public function QuickInventory() {
			super( 256, IMAGE_SIZE );
			layout = new AbsoluteLayout();
		}

		
		public function addTypeAt( ti:TypeInfo, slot:int ):void {
			var box:Box = getBoxFromIndex( slot );
			box.backgroundTexture = ti.image;
			box.data = ti;
		}
		
		public function getBoxFromIndex( index:int ):Box {
			var selectedItem:int = index * 2;
			//var el:Element  = getElementAt( selectedItem );
			//var box:Box = el.getElement() as Box;
			var box:Box = getObjectAt( selectedItem ) as Box;
			return box;
		}
		
		public function getIndexFromBox( box:Box ):int {
			var index:int = box.x / IMAGE_SIZE;
			return index;
		}
		
		public function addSelector():void {
			_selector = new Sprite();
			_selector.filters = [new GlowFilter(0xff0000, .5)];
			with (_selector.graphics) {
				lineStyle(2, 0xff0000, .5);
				drawRect(2, 2, 61, 61);
				endFill();
			}
			addElement(_selector);
		}
		
		public function moveSelector( x:int ):void {
			_selector.x = x;
			QuickInventory.currentItemSelection = x/IMAGE_SIZE;
			//Log.out( "QuickInventory index of selected: " + QuickInventory.currentItemSelection );
		}
		
		public function buildActionItem( actionItem:Object, count:int ):Object {
			var box:Box = new Box(IMAGE_SIZE, IMAGE_SIZE);
			var hk:Label = new Label("", 20);
			box.x = IMAGE_SIZE * count;
			box.y = 0;
			box.name = String( count );
			if ( actionItem && actionItem.image )
			{
				box.data = actionItem;
				box.backgroundTexture = "assets/textures/" + actionItem.image;
			}
			else
			{
				box.data = null;
				box.backgroundTexture = "assets/textures/blank.png";
				box.dropEnabled = true;
			}
			addElement( box );
			
			hk.x = IMAGE_SIZE * count;
			hk.fontColor = 0xffffff;
			if ( count == 10 )
				hk.text = "0";
			else	
				hk.text = String( count + 1 );
			addElement(hk);

			return { box: box, hotkey:hk };
		}
		
		
		public function buildGrain( item:TypeInfo, count:int, shortCutImage:String):Object {
			var box:Box = new Box(IMAGE_SIZE, IMAGE_SIZE);
			var hk:Label = new Label("", 20);
			box.x = IMAGE_SIZE * (count - 1);
			box.y = 0;
			box.name = String( count );
			box.data = item;
			box.backgroundTexture = "assets/textures/" + item.image;
			addElement( box );
			
			hk.data = item;
			hk.x = IMAGE_SIZE * (count - 1);
			hk.fontColor = 0xffffff;
			hk.text = "F" + String( count );
			addElement(hk);
			
			return { box: box, hotkey:hk };
		}
		
		public function buildItem( item:TypeInfo, count:int, shortCutImage:String ):Object {
			var box:Box = new Box(IMAGE_SIZE, IMAGE_SIZE);
			var hk:Label = new Label("", 20);
			box.x = IMAGE_SIZE * count;
			box.y = 0;
			box.name = String( count );
			if ( item )
			{
				box.data = item;
				hk.data = item;
				box.backgroundTexture = "assets/textures/" + item.image;
			}
			else
			{
				box.backgroundTexture = "assets/textures/blank.png";
				box.dropEnabled = true;
			}
			addElement( box );
			
			hk.x = IMAGE_SIZE * count;
			hk.fontColor = 0xffffff;
			if ( count == 10 )
				hk.text = "0";
			else	
				hk.text = String( count + 1 );
			addElement(hk);

			return { box: box, hotkey:hk };
		}
	}
}