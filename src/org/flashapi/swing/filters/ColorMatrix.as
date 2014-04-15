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

package org.flashapi.swing.filters {
	
	// -----------------------------------------------------------
	// ColorMatrix.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/02/2009 16:57
	* @see http://www.flashapi.org/
	*/
	
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import org.flashapi.swing.constants.Luminance;
	import org.flashapi.swing.core.isNull;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.util.ArrayUtil;
	import org.flashapi.swing.util.RangeChecker;
	
	/**
	 * 	The <code>ColorMatrix</code> class is a tool that helps developers to perform
	 * 	color operations on digital images.
	 * 
	 * 	<p>
	 * 		You must use the <code>filters</code> property of a <code>DisplayObject</code>
	 * 		to apply a new color manipulation on it:
	 *  	<listing version="3.0">
	 * 			var cm:ColorMatrix = new ColorMatrix();
	 * 			cm.invert();
	 * 			myDisplayObject.filters = [cm.filter];
	 * 		</listing>
	 * 	</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ColorMatrix {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ColorMatrix</code> object.
		 * 
		 * 	@param	elements	An array collection of color settings fo creating a
		 * 						specific <code>ColorMatrix</code> object. The number
		 * 						of elements for a color matrix is 20 ([4x5]);
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.IllegalArgumentException
		 * 				An <code>IllegalArgumentException</code> if the lengts of the
		 * 				elements collection is different from <code>20</code>.
		 */
		public function ColorMatrix(elements:Array = null) {
			super();
			initObj(elements);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a <code>ColorMatrixFilter</code> instance initialized with the 
		 * 	filter parameters specified by this <code>ColorMatrix</code> object.
		 */
		public function get filter():BitmapFilter  {
			return new ColorMatrixFilter(_elements);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a copy of this <code>ColorMatrix</code> object.
		 * 
		 * 	@return	A new <code>ColorMatrix</code> instance with all of the same 
		 * 			properties as the original one.  
		 */
		public function clone():ColorMatrix {
			return new ColorMatrix(_elements);
		}
		
		/**
		 *  Creates a gray scale matrix for this <code>ColorMatrix</code> object.
		 */
		public function desaturate():void {
			_elements = [Luminance.RED_CGL, Luminance.GREEN_CGL, Luminance.BLUE_CGL, 0, 0,
						Luminance.RED_CGL, Luminance.GREEN_CGL, Luminance.BLUE_CGL, 0, 0,
						Luminance.RED_CGL, Luminance.GREEN_CGL, Luminance.BLUE_CGL, 0, 0, 0, 0, 0 , 1, 0];
		}
		
		/**
		 *  Defines a digital negative matrix for this <code>ColorMatrix</code> object.
		 */
		public function invert():void {
			_elements = ArrayUtil.clone(_DIGITAL_NEGATIVE);
		}
		
		/**
		 * 	Defines a matrix to change the brightness of this <code>ColorMatrix</code>
		 * 	object.
		 * 
		 * 	@param	value 	The value used to adjust the brightness.
		 */
		public function setBrightness(value:Number):void {
			multiply([1, 0, 0, 0, value, 0, 1, 0, 0, value, 0, 0, 1, 0, value, 0, 0, 0, 1, 0]);
		}
		
		/**
		 * 	Defines a matrix to adjust the contrast of this <code>ColorMatrix</code>
		 * 	object.
		 * 
		 * 	@param	value 	The value used to adjust the contrast. The effective range
		 * 					for the contrast value is from <code>0</code> to <code>1</code>.
		 */
		public function setContrast(value:Number):void {
			RangeChecker.checkNum(value, 1, 0, "value");
			var a:Number = value + 11;
			var b:Number = 63.5 - (value * 698.5);
			multiply([a, 0, 0, 0, b, 0, a, 0, 0, b, 0, 0, a, 0, b, 0, 0, 0, 1, 0]);
		}
		
		/**
		 * 	Defines a matrix to change the saturation of this <code>ColorMatrix</code>
		 * 	object.
		 * 
		 * 	@param	value 	The value used to adjust the saturation.
		 */
		public function setSaturation(value:Number):void {
			var v:Number = 1 - value;
			var r:Number = Luminance.RED_CGL;
			var g:Number = Luminance.GREEN_CGL;
			var b:Number = Luminance.BLUE_CGL;
			multiply([	v * r + value, v * g, v * b, 0, 0, v * r, v * g + value,
				v * b, 0, 0, v * r, v * g, v * b + value, 0, 0, 0, 0, 0, 1, 0]);
		}
		
		/**
		 * 	Reinitializes this <code>ColorMatrix</code> object.
		 */
		public function reset():void {
			/**
			 *  Notice that this elements array do not defines an identity matrix.
			 * 	For a non-square matrix [A] you might be able to find a matrix [I]
			 * 	such that [A][I]=[A]; however, if you reverse the order, you will be
			 * 	left with an illegal multiplication.
			 */
			_elements = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
		}
		
		/**
		 * 	Returns a string representation of this <code>ColorMatrix</code> object.
		 * 
		 * 	@return	A string representation of this <code>ColorMatrix</code> object.
		 */
		public function toString():String {
			return "ColorMatrix [" + _elements.join(", ") + "]";
		}
		
		/**
		 * 	Returns an array that represents the current element array of this <code>ColorMatrix</code> object.
		 * 
		 * 	@return	a 5x4 array that represents the current element array of this <code>ColorMatrix</code> object.
		 */
		public function toArray():Array {
			return ArrayUtil.clone(_elements);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Defines the constant number of elements for a color matrix: [4x5] = 20;
		 * 
		 * 	@private
		 */
		private const ELEMENTS_LENGTH:int = 20;
		
		/**
		 * 	@private
		 */
		private const _DIGITAL_NEGATIVE:Array =
			[ -1, 0, 0, 0, 255, 0, -1, 0, 0, 255, 0, 0, -1, 0, 255, 0, 0, 0, 1, 0];
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An array for internal storage of all the matrix elements.
		 * 
		 * 	@private
		 */
		private var _elements:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(elements:Array):void {
			if (!isNull(elements)) {
				if (elements.length != ELEMENTS_LENGTH) throw new IllegalArgumentException();
				else _elements = ArrayUtil.clone(elements);
			} else reset();
		}
		
		/**
		 * 	An algorithm that multiplies two linear array elements that represent
		 * 	two NxM matrix.
		 * 	This algorithm is a translation by Mario Klingemann in his ColorMatrix
		 * 	Class v1.2 of the following matrix multiplication algorithm:
		 * 	
		 * 	var buffer = new Array(20);
		 * 	for (var i:uint = 0; i < 4; i++) {
		 * 		for (var j:uint = 0; j < 5; j++) {
		 * 			for (var k:uint = 0; k < 5; k++) {
		 * 				buffer[i][j] = _element[i][k] * elm[k][j];
		 * 			}
		 * 		}
		 * 	}
		 * 
		 * 	@private
		 */
		private function multiply(elm:Array):void {
			var buffer:Array = [];
			var i:uint = 0;
			//var j:uint = 0
			var x:uint;
			var z:Number;
			var y:uint = 0;
			for (; y < 4; y++) {
				for (x = 0; x < 5; x++)	{
					z = x == 4 ? elm[i + 4] : 0;
					buffer[i + x] = elm[i] * elm[x] + elm[i+1] * elm[x + 5] + elm[i+2] * elm[x + 10] + elm[i+3] * elm[x + 15] + z;
				}
				i += 5;
			}
			_elements = buffer;
		}
	}
}