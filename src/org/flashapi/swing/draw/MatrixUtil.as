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

package org.flashapi.swing.draw {
	
	// -----------------------------------------------------------
	// MatrixUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/11/2010 09:46
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Matrix;
	
	/**
	 * 	Utility class that facilitates creation of custom <code>Matrix</code> objects
	 * 	with an assocaited gradient box.
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MatrixUtil {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 */
		public function MatrixUtil() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Creates and returns a <code>Matrix</code> object which defines a gradient
		 * 	box from the sepcified parameters.
		 * 
		 * 	@param	width	The width of the gradient box.
		 * 	@param	height	The height of the gradient box.
		 * 	@param	rotation The amount to rotate, in radians. Default value is
		 * 					<code>Math.PI/2</code> (<code>1.5707963267948966</code>).
		 * 	@param	tx	The distance, in pixels, to translate to the right along the x axis.
		 * 				This value is offset by half of the <code>width</code> parameter.
		 * 	@param	ty	The distance, in pixels, to translate down along the y axis.
		 * 				This value is offset by half of the <code>height</code> parameter.
		 * 	
		 * 	@return	A new custom <code>Matrix</code> object.
		 */
		public static function getMatrix(width:Number, height:Number, rotation:Number = 1.5707963267948966, tx:Number = 0, ty:Number = 0):Matrix {
			var m:Matrix = new Matrix();
			m.createGradientBox(width, height, rotation, tx, ty);
			return m;
		}
	}
}