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

package org.flashapi.swing.html {
	
	// -----------------------------------------------------------
	// EmptyElement.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 07/03/2011 16:39
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.flashapi.swing.Icon;
	import org.flashapi.swing.icons.ImageIcon;
	
	/**
	 * 	<code>EmptyElement</code> class creates a visual representation of an
	 * 	<code>InlineGraphicElement</code> which has occured an error while loading
	 * 	an image file.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class EmptyElement extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>EmptyElement</code> instance.
		 */
		public function EmptyElement() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _width:Number = 100;
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			_width = value;
			drawElement();
		}
		override public function get width():Number {
			return _width;
		}
		
		private var _height:Number = 22;
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {
			_height = value;
			drawElement();
		}
		override public function get height():Number {
			return _height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private var _icon:Icon;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_icon = new Icon();
			_icon.setBrush(ImageIcon, new Rectangle(0, 0, 16, 16));
			_icon.target = this;
			_icon.shadow = true;
			_icon.paint();
			_icon.display();
			drawElement();
		}
		
		private function drawElement():void {
			with (this.graphics) {
				clear();
				beginFill(0x999999, .15);
				lineStyle(1, 0x999999);
				drawRect(0, 0, _width, _height);
				moveTo(0, 0);
				lineTo(_width, _height);
				moveTo(_width, 0);
				lineTo(0, _height);
				endFill();
			}
			_icon.move((_width - 16) / 2, (_height - 16) / 2);
		}
	}
}