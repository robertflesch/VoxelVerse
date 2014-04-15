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
	// CalculatorButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/06/2008 17:06
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>CalculatorButton</code> class provides constant values to determine
	 * 	the name of each button displayed on the face of <code>Calculator</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.Calculator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CalculatorButton {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new CalculatorButton
		 * 				instance.
		 */
		public function CalculatorButton() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The name of the "decimal symbol" button:
		 * 	<img src = "../../../../doc-images/calculator/decimal_btn.jpg" alt="Decimal symbol button." />
		 */
		public static const DECIMAL:String = "decimal";
		
		//--> Actions names
		/**
		 * 	The name of the "backspace" button:
		 * 	<img src = "../../../../doc-images/calculator/backspace_btn.jpg" alt="Backspace button." />
		 */
		public static const BACKSPACE:String = "backspace";
		
		/**
		 * 	The name of the "clear" button:
		 * 	<img src = "../../../../doc-images/calculator/c_btn.jpg" alt="Clear button." />
		 */
		public static const C:String = "clear";
		
		/**
		 * 	The name of the "clear entry" button:
		 * 	<img src = "../../../../doc-images/calculator/ce_btn.jpg" alt="Clear entry button." />
		 */
		public static const CE:String = "clearEntry";
		
		//--> Mem names:
		/**
		 * 	The name of the "memory clear" button:
		 * 	<img src = "../../../../doc-images/calculator/mc_btn.jpg" alt="Memory clear button." />
		 */
		public static const MEMORY_CLEAR:String = "memoryClear";
		
		/**
		 * 	The name of the "memory plus" button:
		 * 	<img src = "../../../../doc-images/calculator/mplus_btn.jpg" alt="Memory plus button." />
		 */
		public static const MEMORY_PLUS:String = "memoryPlus";
		
		/**
		 * 	The name of the "memory recall" button:
		 * 	<img src = "../../../../doc-images/calculator/mr_btn.jpg" alt="Memory recall button." />
		 */
		public static const MEMORY_RECALL:String = "memoryRecall";
		
		/**
		 * 	The name of the "memory store" button:
		 * 	<img src = "../../../../doc-images/calculator/ms_btn.jpg" alt="Memory store button." />
		 */
		public static const MEMORY_STORE:String = "memoryStore";
		
		//--> Operators names:
		/**
		 * 	The name of the "substraction" button:
		 * 	<img src = "../../../../doc-images/calculator/minus_btn.jpg" alt="Substraction button." />
		 */
		public static const MINUS:String = "minus";
		
		/**
		 * 	The name of the "percent key" button:
		 * 	<img src = "../../../../doc-images/calculator/percent_btn.jpg" alt="Percent key button." />
		 */
		public static const PERCENT:String = "percent";
		
		/**
		 * 	The name of the "equal symbol" button:
		 * 	<img src = "../../../../doc-images/calculator/equal_btn.jpg" alt="Equal button." />
		 */
		public static const EQUAL:String = "equal";
		
		/**
		 * 	The name of the "addition" button:
		 * 	<img src = "../../../../doc-images/calculator/plus_btn.jpg" alt="Addition button." />
		 */
		public static const PLUS:String = "plus";
		
		/**
		 * 	The name of the "division" button:
		 * 	<img src = "../../../../doc-images/calculator/divide_btn.jpg" alt="Division button." />
		 */
		public static const DIVIDE:String = "divide";
		
		/**
		 * 	The name of the "multiplication" button:
		 * 	<img src = "../../../../doc-images/calculator/multiply_btn.jpg" alt="Multiplication button." />
		 */
		public static const MULTIPLY:String = "multiply";
		
		/**
		 * 	The name of the "square root" button:
		 * 	<img src = "../../../../doc-images/calculator/sqrt_btn.jpg" alt="Square root button." />
		 */
		public static const SQRT:String = "squareRoot";
		
		/**
		 * 	The name of the "inverse" button:
		 * 	<img src = "../../../../doc-images/calculator/inverse_btn.jpg" alt="Inverse button." />
		 */
		public static const INVERSE:String = "inverse";
		
		/**
		 * 	The name of the "plus/minus" button:
		 * 	<img src = "../../../../doc-images/calculator/plus_minus_btn.jpg" alt="Plus/minus button." />
		 */
		public static const PLUS_MINUS:String = "plusMinus";
		
		//--> Num names:
		/**
		 * 	The name of the "zero" button:
		 * 	<img src = "../../../../doc-images/calculator/zero_btn.jpg" alt="Zero button." />
		 */
		public static const ZERO:String = "zero";
		
		/**
		 * 	The name of the "one" button:
		 * 	<img src = "../../../../doc-images/calculator/one_btn.jpg" alt="One button." />
		 */
		public static const ONE:String = "one";
		
		/**
		 * 	The name of the "two" button:
		 * 	<img src = "../../../../doc-images/calculator/two_btn.jpg" alt="Two button." />
		 */
		public static const TWO:String = "two";
		
		/**
		 * 	The name of the "three" button:
		 * 	<img src = "../../../../doc-images/calculator/three_btn.jpg" alt="Three button." />
		 */
		public static const THREE:String = "three";
		
		/**
		 * 	The name of the "four" button:
		 * 	<img src = "../../../../doc-images/calculator/four_btn.jpg" alt="Four button." />
		 */
		public static const FOUR:String = "four";
		
		/**
		 * 	The name of the "five" button:
		 * 	<img src = "../../../../doc-images/calculator/five_btn.jpg" alt="Five button." />
		 */
		public static const FIVE:String = "five";
		
		/**
		 * 	The name of the "six" button:
		 * 	<img src = "../../../../doc-images/calculator/six_btn.jpg" alt="Six button." />
		 */
		public static const SIX:String = "six";
		
		/**
		 * 	The name of the "seven" button:
		 * 	<img src = "../../../../doc-images/calculator/seven_btn.jpg" alt="Seven button." />
		 */
		public static const SEVEN:String = "seven";
		
		/**
		 * 	The name of the "eight" button:
		 * 	<img src = "../../../../doc-images/calculator/eight_btn.jpg" alt="Eight button." />
		 */
		public static const EIGHT:String = "eight";
		
		/**
		 * 	The name of the "nine" button:
		 * 	<img src = "../../../../doc-images/calculator/nine_btn.jpg" alt="Nine button." />
		 */
		public static const NINE:String = "nine";
	}
}