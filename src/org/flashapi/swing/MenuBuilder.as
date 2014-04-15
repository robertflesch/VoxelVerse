////////////////////////////////////////////////////////////////////////////////
//    
//    Swing Package for Actionscript 3.0 (SPAS 3.0)
//    Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//    
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//    
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.
//    
//    You should have received a copy of the GNU General Public License
//    along with this program. If not, see <http://www.gnu.org/licenses/>.
//    
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// MenuBuilder.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.1.3, 09/05/2010 17:53
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.button.SelectableItem;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.constants.MenuItemType;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.list.ThreeList;
	import org.flashapi.swing.plaf.libs.MenuUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("MenuBuilder.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when an item is clicked within the <code>MenuBuilder</code>
	 * 	instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_CLICKED
	 */
	[Event(name = "itemClicked", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>MenuBuilder</code> instance value changes due 
	 * 	to mouse or keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name = "listChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the <code>MenuBuilder</code> instance has been populated 
	 * 	by an <code>XMLQuery</code> object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 * 	<img src="MenuBuilder.png" alt="MenuBuilder" width="18" height="18"/>
	 * 
	 * 	The <code>MenuBuilder</code> class creates a menu of individually selectable
	 * 	choices, similar to <code>Menu</code> class Instances. But <code>Menu</code>
	 * 	built with the <code>MenuBuilder</code> class can have as many levels of
	 * 	submenus as needed. After a <code>Menu</code> instance has been opened,
	 * 	it remains visible until it is closed by any of the following actions:
	 * 	<ul>
	 * 		<li>A call to the <code>Menu.remove()</code> method,</li>
	 * 		<li>when a user selects an active menu item,</li>
	 * 		<li>when a user clicks outside of the <code>Menu</code> object.</li>
	 * 	</ul>
	 * 
	 * 	<p>To populate a <code>MenuBuilder</code> instance, you use a
	 * 	<code>XMLQuery</code> object.</p>
	 * 
	 * 	<p>The <code>MenuBuilder</code> class has the same look and feel structure
	 * 	as the <code>Menu</code>  class. That means that you cab use a Look and Feel
	 * 	class that implements the <code>MenuUI</code> interface, as parameter of the
	 * 	<code>MenuBuilder.setLaf()</code> and <code>MenuBuilder.lockLaf()</code>
	 * 	methods.</p>
	 * 
	 *  @includeExample MenuBuilderExample.as
	 * 
	 * 	@see org.flashapi.swing.databinding.XMLQuery
	 * 	@see org.flashapi.swing.plaf.MenuUI
	 *  @see org.flashapi.swing.list.ListItem
	 * 	@see org.flashapi.swing.Menu
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MenuBuilder extends ThreeList implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>MenuBuilder</code> instance.
		 */
		public function MenuBuilder() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _lastSelectedMenu:Menu = null;
		/**
		 * 	Returns a reference to the last <code>Menu</code> instance that has been
		 * 	clicked on  by the user within this <code>MenuBuilder</code> instance.
		 * 	This property changes each time the <code>ListEvent.ITEM_CLICKED </code>
		 * 	event is dispatched.
		 * 
		 * 	@default null
		 */
		public function get lastSelectedMenu():Menu {
			return _lastSelectedMenu;
		}
		
		/**
		 * 	Returns a reference to the <code>XML</code>  object used to
		 * 	populate the <code>MenuBuilder</code> instance.
		 */
		public function get xml():XML {
			return $xmlQuery.xml;
		}
		
		/**
		 * 	@private
		 */
		override public function get height():Number {
			return _mainMenu != null ? _mainMenu.height : 0;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>iconPath</code> property.
		 * 
		 * 	@see #iconPath
		 */
		protected var $iconPath:String = "";
		/**
		 * 	Sets or gets a global URI path used as shortcut for all icons
		 * 	displayed within this <code>MenuBuilder</code> instance.
		 * 
		 * 	@default An empty string.
		 */
		public function get iconPath():String {
			return $iconPath;
		}
		public function set iconPath(value:String):void {
			$iconPath = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				createUIObject(x, y);
				doStartEffect(setToTopLevel);
			}
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			var m:Menu;
			for each (m in _menuStack) {
				m.finalize();
				m = null;
			}
			super.finalize();
		}
		
		/**
		 * 	Returns the item element with the ID specified by the <code>value</code>
		 * 	parameter.
		 * 
		 * 	@param	value 	A string representing the unique ID of the element being
		 * 					sought. 
		 * 
		 *  @return The element with the specified ID.
		 */
		public function getElementByID(value:String):* {
			return UIDescriptor.getUIManager().document.getElementByID(value);
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			if ($displayed) {
				if (_mainMenu != null) {
					var menu:Menu;
					for each(menu in _menuStack) removeMenu(menu);
					_mainMenu.autoRemove = true;
					_mainMenu.remove();
					_menuPath = [];
					_currentMenu = null;
				}
				unload();
			}
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			var l:int = _menuStack.length - 1;
			var lafRef:Class = $uiRef.laf;
			for (; l >= 0; l--) _menuStack[l].lockLaf(lafRef, true);
		}
		
		/**
		 * 	[Note implemented yet.]
		 */
		public function setToggleModeAt(index:uint, value:Boolean):void {
			var menu:Menu = _menuStack[index].toggleMode = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			if (_mainMenu != null) {
				if (!_mainMenu.displayed) _mainMenu.display();
			}
			refresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _menuStack:Array;
		private var _interactiveItemStack:Dictionary;
		private var _mainMenu:Menu = null;
		private var _menuPath:Array;
		private var _currentMenu:Menu = null;
		private var _menuId:int;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_menuStack = [];
			initLaf(MenuUIRef);
			_interactiveItemStack = new Dictionary(true);
			_menuPath = [];
			$parent = $stage;
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
			$evtColl.addEvent($parent, MouseEvent.MOUSE_DOWN, detectMenuStageMouseDown);
			spas_internal::isInitialized(1);
		}
		
		private function xmlQueryChangedHandler(e:ListEvent):void {
			var data:XML = $xmlQuery.xml;
			checkStrictMode("MenuBuilder");
			if (data.@urlPath != undefined) $urlPath = data.@urlPath.toString();
			if (data.@iconPath != undefined) $iconPath = data.@iconPath.toString();
			if ($dataBindingMode == DataBindingMode.INCREMENT) {
				createNewMenu(data.children());
				if (_mainMenu == null) _mainMenu = _menuStack[0];
				var l:int = _menuStack.length - 1;
				for (; l >= 0; l--) _menuStack[l].spas_internal::unlockMenu();
			} else {
				_menuId = -1;
				updateMenu(data.children());
			}
			if($displayed) _mainMenu.display();
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
		}
		
		//--> TODO: this function must be finished and checked:
		private function updateMenu(data:XMLList):void {
			_menuId++;
			var obj:Object;
			var i:int = 0;
			var l:int = data.length();
			var menu:Menu = _menuStack[_menuId];
			//var act:Boolean;
			//var tog:Boolean;
			var tpe:String;
			//var grpName:String;
			var lab:String;
			var dt:String;
			//var subLength:int;
			var xmlData:XML;
			for (; i < l; ++i) {
				xmlData = data[i];
				tpe = xmlData.@type != null ? xmlData.@type.toString() : MenuItemType.DEFAULT;
				if (tpe != MenuItemType.SEPARATOR) {
					lab = xmlData.@label != null ? xmlData.@label.toString() : null;
					dt = xmlData.@data != null ? xmlData.@data.toString() : null;
					obj = { };
					if (lab != null) obj.label = lab;
					menu.updateItemAt(i, obj, dt);
				}
			}
		}
		
		private function createNewMenu(data:XMLList, item:SelectableItem = null, depth:uint = 0, parentMenu:Menu = null):void {
			var obj:Object;
			var i:int = 0;
			var l:int = data.length();
			var menu:Menu = new Menu();
			menu.lockLaf($uiRef.laf, true);
			menu.spas_internal::lockMenu();
			menu.spas_internal::parentMenu = parentMenu;
			$evtColl.addEvent(menu, ListEvent.ITEM_CLICKED, updateMenuData);
			$evtColl.addEvent(menu, ListEvent.ITEM_PRESSED, dispatchItemPressedEvent);
			menu.target = spas_internal::uioSprite;
			menu.spas_internal::depth = depth;
			_menuStack.push(menu);
			if (item != null) {
				_interactiveItemStack[item] = menu;
				var ic:Icon = new Icon();
				ic.name = "iconRight";
				ic.target = item.container;
				var b:StateBrush = ic.setBrush(menu.lookAndFeel.getRightArrowBrush(), null, ic.spas_internal::lafDTO) as StateBrush;
				b.colors = item.iconColors;
				item.spas_internal::iconsStack.push(ic);
				ic.paint();
				var X:Number = item.width - ic.width;
				var Y:Number = (item.height - ic.height) /2;
				ic.display(X, Y);
				ic.spas_internal::setDepth(item.container.numChildren - 2);
			}
			var tpe:String;
			var dt:String;
			var subLength:int;
			var si:*;
			var xmlData:XML;
			for (; i < l; ++i) {
				xmlData = data[i];
				tpe = xmlData.@type != null ? xmlData.@type.toString() : MenuItemType.DEFAULT;
				obj = { type:tpe };
				if (xmlData.@className != null) obj.className = xmlData.@className.toString();
				if (xmlData.@id != undefined) obj.id = xmlData.@id.toString();
				if (tpe == MenuItemType.SEPARATOR) menu.addItem(obj);
				else {
					obj.groupName = xmlData.@groupName != null ? xmlData.@groupName.toString() : null;
					obj.label = xmlData.@label != null ? xmlData.@label.toString() : "";
					dt = (xmlData.@data != null && xmlData.@data != undefined) ? xmlData.@data.toString() : null;
					obj.icon = (xmlData.@icon != undefined) ? $iconPath + xmlData.@icon.toString() : null;
					subLength = xmlData.children().length();
					if (xmlData.@active != undefined) {
						if (xmlData.@active.toString() == "false") obj.active = false;
					}
					if (xmlData.@toggled != undefined) {
						if (xmlData.@toggled.toString() == "true") obj.toggled = true;
					}
					si = menu.addItem(obj, dt).item;
					$evtColl.addEvent(si, UIMouseEvent.ROLL_OVER, itemRollOver);
					if (subLength > 0) createNewMenu(xmlData.children(), si, depth + 1, menu);
				}
			}
		}
		
		private function dispatchItemPressedEvent(e:ListEvent):void {
			var le:ListEvent = new ListEvent(ListEvent.ITEM_PRESSED);
			le.spas_internal::pressedItemRef = e.spas_internal::pressedItemRef;
			dispatchEvent(le);
		}
		
		private function updateMenuData(e:ListEvent):void {
			_lastSelectedMenu = e.target as Menu;
			if (_lastSelectedMenu.autoRemove == true) {
				$listItem = _lastSelectedMenu.listItem;
				$data = _lastSelectedMenu.data;
				$value = _lastSelectedMenu.value;
				this.remove();
				dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
			}
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICKED));
		}
		
		private function itemRollOver(e:UIMouseEvent):void {
			var si:SelectableItem = e.target as SelectableItem;
			var m:Menu = (_interactiveItemStack[si] != null) ?
				_interactiveItemStack[si] : null;
			if (m == null) removeUnusedMenus(si.target.data);
			else {
				if (m.spas_internal::parentMenu == null) removeUnusedMenus(m);
				else {
					if (_menuPath.indexOf(m.spas_internal::parentMenu) == -1) {
						var menu:Menu;
						for each (menu in _menuPath) removeMenu(menu);
						_menuPath = [];
					} else removeUnusedMenus(m);
				}
			}
			if (m != null) {
				if (m.spas_internal::parentMenu != null)
					m.spas_internal::parentMenu.autoRemove = false;
				m.autoRemove = (m != null);
				_currentMenu = m;
				if (_menuPath.indexOf(m) == -1) _menuPath.push(m);
				if (m.displayed) return;
				var tgt:Sprite = si.target.target;
				m.display(tgt.x + tgt.width, si.y + tgt.y);
			}
		}
		
		private function removeUnusedMenus(m:Menu):void {
			var menu:Menu;
			for each (menu in _menuPath) {
				if (menu.spas_internal::depth >= m.spas_internal::depth && menu != m) {
					removeMenu(menu);
					_menuPath.splice(_menuPath.indexOf(menu), 1);
				}
			}
		}
		
		private function removeMenu(m:Menu):void {
			if (m == _mainMenu) return;
			m.autoRemove = true;
			m.remove();
		}
		
		/*private function initMenuBuilderLaf(value:Object):void {
			var lafObj:Class = value.getDefaultUI();
			validateLaf(lafObj);
			setConstructorLaf(lafObj);
		}*/
		
		private function detectMenuStageMouseDown(e:MouseEvent):void {
			//if (_displayEffectIsRendering) { this.remove(); return; }
			if (!spas_internal::uioSprite.hitTestPoint($stage.mouseX, $stage.mouseY, true))
				this.remove();
		}
	}
}