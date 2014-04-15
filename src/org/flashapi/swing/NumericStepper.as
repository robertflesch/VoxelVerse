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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// NumericStepper.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 17/03/2010 20:55
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.AbstractSpinner;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.plaf.libs.NumericStepperUIRef;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.util.RangeChecker;
	
	use namespace spas_internal;
	
	[IconFile("NumericStepper.png")]
	
	/**
	 * 	<img src="NumericStepper.png" alt="NumericStepper" width="18" height="18"/>
	 * 
	 * 	The <code>NumericStepper</code> class lets the user select a number from an
	 * 	ordered set. It consists of a single-line input text field and 	a pair of
	 * 	arrow buttons for stepping through the possible values.
	 * 	The Up Arrow and Down Arrow keys also cycle through the values.
	 * 
	 * 	<p><code>NumericStepper</code> instances only step between numeric values.
	 * 	If you want step between strings, use the <code>Spinner</code> class
	 * 	instead.</p>
	 * 
	 * 	@see org.flashapi.swing.Spinner
	 * 
	 * 	@includeExample NumericStepperExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class NumericStepper extends AbstractSpinner implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>NumericStepper</code> instance with
		 * 					the specified parameters
		 * 
		 * 	@param	minimum		Minimum value of the <code>NumericStepper</code> instance.
		 * 						The minimum can be any number, including a fractional value. 
		 * 	@param	maximum		Maximum value of the <code>NumericStepper</code> instance.
		 * 						The maximum can be any number, including a fractional value.
		 * 	@param	stepSize	Non-zero unit of change between values.
		 * 	@param	width		The width of the <code>NumericStepper</code> instance,
		 * 						in pixels.
		 */
		public function NumericStepper(minimum:Number = 0, maximum:Number = 100, stepSize:Number = 1, width:Number = 50) {
			super(width, NumericStepperUIRef);
			initObj(minimum, maximum, stepSize);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _maximum:Number;
		/**
		 * 	Maximum value of the <code>NumericStepper</code> instance. The maximum
		 * 	can be any number, including a fractional value.
		 * 
		 * 	@default 10
		 * 
		 * 	@see #minimum
		 */
		public function get maximum():Number {
			return _maximum;
		}
		public function set maximum(value:Number):void {
			_maximum = value;
		}
		
		private var _minimum:Number;
		/**
		 * 	Minimum value of the <code>NumericStepper</code> instance. The minimum
		 * 	can be any number, including a fractional value.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #maximum
		 */
		public function get minimum():Number {
			return _minimum;
		}
		public function set minimum(value:Number):void {
			_minimum = value;
		}
		
		/**
		 * 	Returns the value that is one step larger than the current <code>value</code>
		 * 	property and not greater than the <code>maximum</code> property value.
		 * 
		 * 	@see #previousValue
		 * 	@see #value
		 * 	@see #maximum
		 */
		public function get nextValue():Number {
			return _maximum >= $currentValue+_stepSize ? $currentValue+_stepSize : $currentValue;
		}
		
		/**
		 * 	Returns the value that is one step smaller than the current <code>value</code>
		 * 	property and not smaller than the <code>minimum</code> property value.
		 * 
		 * 	@see #nextValue
		 * 	@see #value
		 * 	@see #minimum
		 */
		public function get previousValue():Number  {
			return _minimum <= $currentValue-_stepSize ? $currentValue-_stepSize : $currentValue;
		}
		
		private var _stepSize:Number;
		/**
		 * 	Non-zero unit of change between values. The <code>value</code> property must
		 * 	be a multiple of this number.
		 *
		 * 	@default 1
		 * 
		 * 	@see #value
		 */
		public function get stepSize():Number {
			return _stepSize;
		}
		public function set stepSize(value:Number):void {
			_stepSize = value;
		}
		
		/**
		 * 	[Partially implemented.]
		 * 
		 * 	The current value displayed within the text control of this
		 * 	<code>NumericStepper</code> instance.
		 * 
		 * 	@default 0
		 * 
		 *  @throws org.flashapi.swing.exceptions.IndexOutOfBoundsException
		 * 	An <code>IndexOutOfBoundsException</code> if the value is not a
		 * 	multiple of the <code>stepSize</code> property or is not in the
		 * 	range between the <code>maximum</code> and <code>minimum</code>
		 * 	properties values.
		 * 
		 * 	@see #stepSize
		 */
		public function get value():Number {
			return $currentValue;
		}
		public function set value(value:Number):void {
			RangeChecker.check(value, _maximum, _minimum);
			$currentValue = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function getIncreasedValue():* {
			var fixedValue:Number = bug_135045_fix(1);
			return (_maximum >= fixedValue) ? fixedValue : $currentValue;
		}
		
		/**
		 *  @private
		 */
		override protected function getDecreasedValue():* {
			var fixedValue:Number = bug_135045_fix(-1);
			return (_minimum <= fixedValue) ? fixedValue : $currentValue;
		}
		
		/**
		 *  @private
		 */
		override protected function getEditedValue():* { 
			var v:Number = Number($textInput.text);
			return (v<=_maximum || v>=_minimum) ? v : $currentValue;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(minimum:Number, maximum:Number, stepSize:Number):void {
			_minimum = $currentValue = minimum;
			_maximum = maximum;
			_stepSize = stepSize;
			$textInput.restrict = "0-9\\-\\.\\,";
			spas_internal::isInitialized(1);
		}
		
		private function bug_135045_fix(delta:int):Number {
			var dn:Array = (new String(1 + _stepSize)).split("."); //--> decimal num
			var fv:Number; //--> fixed value
			var ds:Number = 1; //--> decimal scale
			if(dn.length == 2) {
				ds = Math.pow(10, dn.length);
				fv = Math.round($currentValue * ds) + delta * dn[1];
			} else fv = $currentValue + delta * _stepSize;
			return fv / ds;
		}
	}
}