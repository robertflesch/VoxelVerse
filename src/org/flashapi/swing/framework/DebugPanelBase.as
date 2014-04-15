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
	// DebugPanelBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/03/2009 00:12
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.flashapi.swing.core.UIDescriptor;
	
	/**
	 * 	The <code>DebugPanelBase</code> class is the base class for all <code>DebugObject</code>
	 * 	that are displayed within a light-weight draggable frame.
	 * 
	 * 	@see org.flashapi.swing.framework.FPSMonitor
	 * 	@see org.flashapi.swing.framework.DebugPanel
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DebugPanelBase extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DebugPanelBase</code> object.
		 * 
		 * 	@param	title The title text of the debug panel object.
		 * 	@param	width	The width of the debug panel object, in pixels.
		 * 	@param	height	The height of the debug panel object, in pixels.
		 */
		public function DebugPanelBase(title:String, width:Number = 400, height:Number = 400) {
			super();
			createPanel(title, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The <code>TextField</code> object that is used to display the title text
		 * 	of the debug panel object.
		 */
		protected var $title:TextField;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function createPanel(title:String, width:Number, height:Number):void {
			$title = new TextField();
			with (this.graphics) {
				clear();
				lineStyle(1, 0xFFFFFF, .8);
				beginFill(0xFFFFFF, .5);
				drawRoundRect(0, 0, width, height, 10, 10);
				endFill();
			}
			$title.height = 20;
			$title.selectable = false;
			$title.appendText(title);
			$title.width = width;
			this.addChild($title);
			$title.addEventListener(MouseEvent.MOUSE_DOWN, startDragHandler);
			$title.addEventListener(MouseEvent.MOUSE_UP, stopDragHandler);
		}
		
		/**
		 * 	@private
		 */
		protected function display():void {
			UIDescriptor.getUIManager().stage.addChild(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function startDragHandler(e:MouseEvent):void {
			this.startDrag();
		}
		
		private function stopDragHandler(e:MouseEvent):void {
			this.stopDrag();
		}
	}
}