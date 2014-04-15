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

package org.flashapi.swing.plaf.core {
	
	// -----------------------------------------------------------
	// LafDTOCornerUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 11/11/2010 19:12
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>LafDTOCornerUtil</code> class creates convenient objects that deals
	 * 	with corner radiuses computations within a Look And Feel class.
	 * 
	 * 	@see org.flashapi.swing.plaf.core.LafDTO
	 * 	@see org.flashapi.swing.core.UIObject#cornerRadius
	 * 	@see org.flashapi.swing.core.UIObject#bottomLeft
	 * 	@see org.flashapi.swing.core.UIObject#bottomRight
	 * 	@see org.flashapi.swing.core.UIObject#topRight
	 * 	@see org.flashapi.swing.core.UIObject#topLeft
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LafDTOCornerUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>LafDTOCornerUtil</code> instance.
		 * 
		 * 	@param	dto	The <code>LafDTO</code> object for which to calculate radiuses.
		 * 	@param	defaultRadius	The default value for all computed radiuses.
		 */
		public function LafDTOCornerUtil(dto:LafDTO, defaultRadius:Number = 0) {
			super();
			_defaultRadius = isNaN(dto.cornerRadius) ? defaultRadius : dto.cornerRadius;
			this.bottomLeft = getValue(dto.bottomLeftCorner);
			this.bottomRight = getValue(dto.bottomRightCorner);
			this.topLeft = getValue(dto.topLeftCorner);
			this.topRight = getValue(dto.topRightCorner);
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
		
		private function getValue(value:Number):Number {
			var radius:Number =  isNaN(value) ? _defaultRadius : value;
			return radius;
		}
	}
}