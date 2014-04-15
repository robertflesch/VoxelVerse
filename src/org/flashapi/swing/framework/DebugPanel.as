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

package org.flashapi.swing.framework {
	
	// -----------------------------------------------------------
	// DebugPanel.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 14/03/2009 00:14
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.ContextMenuEvent;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.framework.locale.Locale;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>DebugPanel</code> class is a convenient class that is used to debug
	 * 	SPAS 3.0 applications at runtime. It consists in a leight-weight text panel 
	 * 	that displays expressions, sent by the <code>print()</code> method, while
	 * 	debugging.
	 * 
	 * 	@see org.flashapi.swing.framework.FPSMonitor
	 * 	@see org.flashapi.swing.UIManager#debugger
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DebugPanel extends DebugPanelBase implements Debugger {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DebugPanel</code> object.
		 */
		public function DebugPanel() {
			super(Locale.spas_internal::LABELS.DEBUG_PANEL_TITLE);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function print(... arguments):void {
			var s:String = "Debug #" + String(_count++) + ": ";
			s += arguments.join(" ");
			s += "\n";
			_textField.appendText(s);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textField:TextField;
		private var _count:uint = 0;
		private var _txtMenu:ContextMenu;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createTracer();
			initTextMenu();
			display();
		}
		
		private function createTracer():void {
			_textField = new TextField();
			_txtMenu = new ContextMenu();
			var yPos:Number = $title.height;
			_textField.width = 400;
			_textField.height = 400 - yPos;
			_textField.y = yPos;
			this.addChild(_textField);
		}
		
		private function initTextMenu():void {
			var clearItem:ContextMenuItem =
				new ContextMenuItem(Locale.spas_internal::LABELS.CLEAR_DEBUG_PANEL);
			clearItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, clearItemSelect);
			_txtMenu.customItems.push(clearItem);
			_textField.contextMenu = _txtMenu;
		}
		
		private function clearItemSelect(e:ContextMenuEvent):void {
			_textField.text = "";
		}
	}
}