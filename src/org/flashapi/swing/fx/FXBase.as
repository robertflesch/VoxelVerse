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

package org.flashapi.swing.fx {
	
	// -----------------------------------------------------------
	// FXBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/07/2007 17:35
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.flashapi.swing.core.UIObject;
	
	/**
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 */
	public class FXBase extends EventDispatcher implements IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.
		 * 	@param	src
		 */
		public function FXBase(src:*) {
			super();
			this.src = src;
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _duration:uint;
		/**
		 * 	Sets or gets the duration of the effect, in milliseconds.
		 */
		public function get duration():uint { return _duration; }
		public function set duration(value:uint):void { _duration = value; }
		
		/**
		 * @private
		 */
		protected var _height:Number;
		/**
		 * 	
		 */
		public function get height():Number { return _height; }
		
		/**
		 * @private
		 */
		protected var src:*;
		/**
		 * 
		 */
		public function get source():* { return src; }
		
		/**
		 * @private
		 */
		protected var _target:*;
		/**
		 * 
		 */
		public function get target():* { return _target; }
		
		/**
		 * @private
		 */
		protected var _uio:UIObject;
		/**
		 * 
		 */
		public function get uio():UIObject { return _uio; }
		
		/**
		 * @private
		 */
		protected var _width:Number;
		/**
		 * 
		 */
		public function get width():Number { return _width; }
		
		/**
		 * 
		 */
		public function get x():Number { return uioSprite.x; }
		public function set x(value:Number):void { uioSprite.x = value; }
		
		/**
		 * 
		 */
		public function get y():Number { return uioSprite.y; }
		public function set y(value:Number):void { uioSprite.y = value; }
		
		//--------------------------------------------------------------------------
		//
		//  Protected constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var uioSprite:Sprite = new Sprite();
	}
}