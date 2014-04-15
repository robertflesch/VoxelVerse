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
	// BorderStyle.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 27/12/2008 02:44
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>BorderStyle</code> class is an enumeration of constant values that
	 * 	specify the style to use in drawing border lines. The constants are provided
	 * 	for use to set values of the <code>borderWidth</code> property, defined by 
	 * 	the <code>Border</code> interface. For more information about using border
	 * 	styles, see <a href='../../../../appendixes/box_class.html' title='The Box
	 * 	class'>The Box class</a> in the 'Appendixes' section.
	 * 
	 * 	@see org.flashapi.swing.border.Border#lineStyle()
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BorderStyle {
		
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
		 * 				A DeniedConstructorAccess if you try to create a new BorderStyle
		 * 				instance.
		 */
		public function BorderStyle() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	No border. Color and width are ignored. 
		 */
		public static const NONE:String = "none";
		
		/**
		 * 	A series of dashes.
		 */
		public static const DASHED:String = "dashed";
		
		/**
		 * 	A series of dots. (Not yet available.) 
		 */
		public static const DOTTED:String = "dotted";
		
		/**
		 * 	Two parallel solid lines with some space between them. (The thickness of
		 * 	the lines is not specified, but the sum of the lines and the space must
		 * 	equal the <code>borderWidth</code> property value.) 
		 */
		public static const DOUBLE:String = "double";
		
		/**
		 * 	A single line segment.
		 */
		public static const SOLID:String = "solid";
		
		/**
		 * 	Looks as if the content on the inside of the border is coming out
		 * 	of the canvas.
		 */
		public static const OUTSET:String = "outset";
		
		/**
		 * 	Looks as if the content on inside of the border is sunken into
		 * 	the canvas.
		 */
		public static const INSET:String = "inset";
		
		/**
		 * 	Looks as if it were coming out of the canvas.
		 */
		public static const RIDGE:String = "ridge";
		
		/**
		 * 	Looks as if it were carved in the canvas.
		 */
		public static const GROOVE:String = "groove";
		
		/**
		 * 	A double line border that reproduces a stylized frame.
		 */
		public static const FRAME:String = "frame";
	}
}