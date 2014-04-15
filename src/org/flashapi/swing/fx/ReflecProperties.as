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
	// ReflecProperties.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 11/06/2009 09:54
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.IUIObject;
	
	/**
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ReflecProperties {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * 	@param	uio
		 * 	@param	gap
		 * 	@param	alpha
		 * 	@param	ratio
		 * 	@param	interval
		 */
		public function ReflecProperties(uio:IUIObject,  gap:Number = 0, alpha:Number = 1.0, ratio:Number = 255, interval:Number = -1) {
			super();
			_alpha = alpha;
			_ratio = ratio;
			_gap = gap;
			_interval = interval;
			_uio = uio as IUIObject;
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _alpha:Number;
		/**
		 * 
		 */
		public function get alpha():Number {
			return _alpha;
		}
		public function set alpha(value:Number):void {
			_alpha = value;
			redraw();
		}
		
		private var _ratio:Number;
		/**
		 * 
		 */
		public function get ratio():Number {
			return _ratio;
		}
		public function set ratio(value:Number):void {
			_ratio = value;
			redraw();
		}
		
		private var _gap:Number;
		/**
		 * 
		 */
		public function get gap():Number {
			return _gap;
		}
		public function set gap(value:Number):void {
			_gap = value;
			redraw();
		}
		
		private var _interval:Number;
		/**
		 * 
		 */
		public function get interval():Number {
			return _interval;
		}
		public function set interval(value:Number):void {
			_interval = value;
			redraw();
		}
		
		private var _hasChanged:Boolean = false;
		/**
		 * 
		 */
		public function get hasChanged():Boolean {
			return _hasChanged;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 */
		public function finalize():void {
			_uio = null;
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _uio:IUIObject;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function redraw():void {
			_hasChanged = true;
			if (_uio.displayed) {
				_uio.redraw();
			}
			_hasChanged = false;
		}
	}
}