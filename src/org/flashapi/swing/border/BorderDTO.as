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

package org.flashapi.swing.border {
	
	// -----------------------------------------------------------
	// BorderDTO.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/12/2008 22:59
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>BorderDTO</code> class represents a data transfert object used by 
	 * 	border decorators to set the parameters of <code>Border</code> objects.
	 * 
	 * 	@see org.flashapi.swing.decorator.BorderDecorator
	 * 	@see org.flashapi.swing.border.Border
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BorderDTO extends Object {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Constructor. Creates a new <code>Border</code> data transfert object.
		 */
		public function BorderDTO() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>BorderDTO</code> corner radius, in pixels.
		 */
		public var cornerRadius:Number;
		
		/**
		 * 	The <code>BorderDTO</code> width, in pixels.
		 */
		public var width:Number;
		
		/**
		 * 	The <code>BorderDTO</code> height, in pixels.
		 */
		public var height:Number;
		
		/**
		 * 	The <code>BorderDTO</code> border width, in pixels.
		 */
		public var borderWidth:Number;
		
		/**
		 * 	The <code>BorderDTO</code> border opacity
		 * 	valid values are from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public var borderAlpha:Number;
		
		/**
		 * 	The <code>BorderDTO</code> border style.
		 * 	Valid values are constants defined by the <code>BorderStyle</code> class.
		 */
		public var borderStyle:String;
		
		/**
		 * 	The <code>BorderDTO</code> border color.
		 */
		public var borderColor:Number;
		
		/**
		 * 	The <code>BorderDTO</code> shadow border color.
		 */
		public var shadowColor:Number;
		
		/**
		 * 	The <code>BorderDTO</code> highlight border color.
		 */
		public var highlightColor:Number;
		
		/**
		 * 	The <code>BorderDTO</code> top border color.
		 */
		public var btColor:Number;
		
		/**
		 * 	The <code>BorderDTO</code> right border color.
		 */
		public var brColor:Number;
		
		/**
		 * 	The <code>BorderDTO</code> bottom border color.
		 */
		public var bbColor:Number;
		
		/**
		 * 	The <code>BorderDTO</code> left border color.
		 */
		public var blColor:Number;
		
		/**
		 * 	The <code>BorderDTO</code> top border opacity
		 * 	valid values are from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public var btAlpha:Number;
		
		/**
		 * 	The <code>BorderDTO</code> right border opacity
		 * 	valid values are from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public var brAlpha:Number;
		
		/**
		 * 	The <code>BorderDTO</code> bottom border opacity
		 * 	valid values are from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public var bbAlpha:Number;
		
		/**
		 * 	The <code>BorderDTO</code> left border opacity
		 * 	valid values are from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public var blAlpha:Number;
		
		/**
		 * 	The <code>BorderDTO</code> shadow border opacity
		 * 	valid values are from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public var shadowAlpha:Number;
		
		/**
		 * 	The <code>BorderDTO</code> highlight border opacity
		 * 	valid values are from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public var highlightAlpha:Number;
		
		/**
		 * 	The <code>BorderDTO</code> top left corner radius, in pixels.
		 */
		public var tlcr:Number;
		
		/**
		 * 	The <code>BorderDTO</code> top right corner radius, in pixels.
		 */
		public var trcr:Number;
		
		/**
		 * 	The <code>BorderDTO</code> bottom right corner radius, in pixels.
		 */
		public var brcr:Number;
		
		/**
		 * 	The <code>BorderDTO</code> bottom left corner radius, in pixels.
		 */
		public var blcr:Number;
		
		/**
		 * 	The <code>BorderDTO</code> background color.
		 */
		public var bgColor:uint;
		
		/**
		 * 	The <code>BorderDTO</code> background opacity
		 * 	valid values are from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public var bgAlpha:Number;
		
		/**
		 * 	The <code>BorderDTO</code> background gradient mode.
		 */
		public var gradientMode:Boolean;
	}
}