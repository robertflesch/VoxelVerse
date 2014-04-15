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

package org.flashapi.swing.constants {
	
	// -----------------------------------------------------------
	// SVGShape
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/02/2009 16:52
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>SVGShape</code> class is an enumeration of constant values that
	 * 	you can use to define the basic shapes of SVG objects.
	 * 
	 * 	@see http://www.w3.org/TR/SVG/shapes.htm
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class SVGShape {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new SVGShape
		 * 				instance.
		 */
		public function SVGShape() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Defines a rectangle corresponding to the SVG "rect" element.
		 */
		public static const RECT:String = "rect";
		
		/**
		 * 	Defines a polygon corresponding to the SVG "polygon" element.
		 */
		public static const POLYGON:String = "polygon";
		
		/**
		 * 	Defines a circle corresponding to the SVG "circle" element.
		 */
		public static const CIRCLE:String = "circle";
		
		/**
		 * 	Defines a line corresponding to the SVG "line" element.
		 */
		public static const LINE:String = "line";
		
		/**
		 * 	Defines an ellipse corresponding to the SVG "ellipse" element.
		 */
		public static const ELLIPSE:String = "ellipse";
	}
}