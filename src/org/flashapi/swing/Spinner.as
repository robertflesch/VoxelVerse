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
	// Spinner.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 17/03/2010 22:12
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.core.AbstractSpinner;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.plaf.libs.SpinnerUIRef;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	[IconFile("Spinner.png")]
	
	/**
	 * 	<img src="Spinner.png" alt="Spinner" width="18" height="18"/>
	 * 
	 *  The <code>Spinner</code> class allows you to step through the possible
	 * 	values of a list by means of an up and down arrow key.
	 * 
	 * 	<p>The sequence of a <code>Spinner</code> instance is defined by its
	 * 	collection of values. The collection can be specified as a constructor
	 * 	function parameter and changed with the <code>collection</code> property.</p>
	 * 
	 * 	<p><code>Spinner</code> instances only step between strings. If you want 
	 * 	step between numeric values, use the <code>NumericStepper</code> class
	 * 	instead.</p>
	 * 
	 * 	@see org.flashapi.swing.NumericStepper
	 * 
	 *  @includeExample SpinnerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Spinner extends AbstractSpinner implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Spinner</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	collection	A collection of <code>String</code> objects to be
		 * 						displayed within this <code>Spinner</code> instance.
		 * 						If <code>null</code>, nothing will be displayed within
		 * 						this <code>Spinner</code> instance.
		 * 						Default value is <code>null</code>.
		 * 	@param	width	The width of the <code>Spinner</code> instance, in pixels.
		 */
		public function Spinner(collection:Array = null, width:Number = 100) {
			super(width, SpinnerUIRef);
			initObj(collection);
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
		
		/**
		 * 	Sets or gets the collection of <code>String</code> objects to be displayed 
		 * 	within this <code>Spinner</code> instance.
		 * 
		 * 	@default An empty <code>Array</code>.
		 */
		public function get collection():Array {
			return _collection;
		}
		public function set collection(value:Array):void {
			createCollection(value);
			setRefresh();
		}
		
		/**
		 * 	Returns the value in the sequence that comes after the current value.
		 * 
		 * 	@see #previousValue
		 */
		public function get nextValue():String {
			if (_position < _collection.length - 1) $currentValue = getValue(_position + 1);
			return $currentValue;
		}
		
		/**
		 * 	Returns the value in the sequence that comes before the current value.
		 * 
		 * 	@see #nextValue
		 */
		public function get previousValue():String  {
			if (_position > 0) $currentValue = getValue(_position - 1);
			return $currentValue;
		}
		
		/**
		 * 	Sets or gets the current value displayed in the text area of the
		 * 	<code>Spinner</code> instance. The value specified by this
		 * 	property is added to the collection of this <code>Spinner</code>
		 * 	instance.
		 * 
		 * 	@see #collection
		 */
		public function get value():String {
			return $currentValue;
		}
		public function set value(value:String):void { 
			$currentValue = value;
			_collection.splice(_position, 0, value);
			setRefresh();
		}
		
		/**
		 * 	Returns the position of the cursor that defines the current
		 * 	<code>value</code> in the sequence for this <code>Spinner</code>
		 * 	instance.
		 * 
		 * 	@see #value
		 */
		public function get cursor():int {
			return _position;
		}
		
		/**
		 *  @private
		 */
		override public function get data():* {
			return _isObjCollection ? _collection[_position].data : $data;
		}
		override public function set data(value:*):void { 
			if (_isObjCollection) _collection[_position].data = value;
			else $data = value;
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
			var l:int = _collection.length;
			if (l == 0) return "";
			if (_position + 1 <= l-1) _position++;
			return getValue(_position);
		}
		
		/**
		 *  @private
		 */
		override protected function getDecreasedValue():* {
			if (_collection.length == 0) return "";
			if (_position - 1 >= 0) _position--;
			return getValue(_position);
		}
		
		/**
		 *  @private
		 */
		override protected function getEditedValue():* {
			var v:String = $textInput.text;
			_collection.splice(_position, 0, v);
			return v;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _collection:Array
		private var _position:int = -1;
		private var _isObjCollection:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(collection:Array):void {
			_collection = [];
			if (collection != null) createCollection(collection);
			else $currentValue = "";
			spas_internal::isInitialized(1);
		}
		
		private function getValue(cursor:int):String {
			return _isObjCollection ? _collection[cursor].text : _collection[cursor];
		}
		
		private function createCollection(value:Array):void {
			_collection = value;
			_position = 0;
			if (typeof(_collection[0]) == PrimitiveType.STRING) {
				$currentValue = _collection[_position];
				_isObjCollection = false;
			} else {
				var obj:Object = _collection[0];
				$currentValue = obj.text;
				$data = obj.data;
				_isObjCollection = true;
			}
		}
	}
}