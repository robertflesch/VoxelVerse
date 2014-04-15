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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// CornerUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 26/05/2009 22:14
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.IUIObject;
	
	/*[Deprecated(
		replacement = "org.flashapi.swing.plaf.core.LafDTOCornerUtil instead",
		since = "SPAS 3.0 alpha"
	)]*/
	/**
	 * 	The <code>CornerUtil</code> class creates convenient objects that deals
	 * 	with corner radiuses computations within a SPAS 3.0 object.
	 * 	
	 * 	@see org.flashapi.swing.plaf.core.LafDTOCornerUtil
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CornerUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>CornerUtil</code> object with the
		 * 					specified parameters.
		 * 
		 * 	@param	uio
		 * 	@param	defaultRadius
		 * 	@param	width
		 * 	@param	height
		 */
		public function CornerUtil(uio:IUIObject, defaultRadius:Number = 0, width:Number = NaN, height:Number = NaN) {
			super();
			initObj(uio, defaultRadius, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The calculated bottom-left-hand corner radius.
		 * 
		 * 	@default null
		 */
		public var bottomLeft:Number;
		
		/**
		 * 	The calculated bottom-right-hand corner radius.
		 * 
		 * 	@default null
		 */
		public var bottomRight:Number;
		
		/**
		 * 	The calculated top-left-hand corner radius.
		 * 
		 * 	@default null
		 */
		public var topLeft:Number;
		
		/**
		 * 	The calculated top-right-hand corner radius.
		 * 
		 * 	@default null
		 */
		public var topRight:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _defaultRadius:Number;
		/**
		 * 	Returns the default value for all computed radiuses.
		 * 
		 * 	@default 0
		 */
		public function get defaultRadius():Number {
			return _defaultRadius;
		}
		/*public function set defaultRadius(value:Number):void {
			_defaultRadius = value;
		}*/
		
		//--------------------------------------------------------------------------
		//
		//  private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(uio:IUIObject, defaultRadius:Number, width:Number, height:Number):void {
			_defaultRadius = defaultRadius;
			var w:Number = isNaN(width) ? uio.width : width;
			var h:Number = isNaN(height) ? uio.height : height;
			this.bottomLeft = getValue(uio.bottomLeftCorner, w, h);
			this.bottomRight = getValue(uio.bottomRightCorner, w, h);
			this.topLeft = getValue(uio.topLeftCorner, w, h);
			this.topRight = getValue(uio.topRightCorner, w, h);
		}
		
		private function getValue(value:Number, width:Number, height:Number):Number {
			var radius:Number =  isNaN(value) ? _defaultRadius : value;
			if (radius > width || radius > height) radius = 0;
			return radius;
		}
	}
}