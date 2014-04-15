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

package org.flashapi.swing.button.core {
	
	// -----------------------------------------------------------
	// CheckGroupBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 08/03/2010 17:38
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>CheckGroupBase</code> class is the base class for <code>ButtonsGroup</code>
	 * 	objects especially associated with <code>CheckButtonBase</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CheckGroupBase extends ButtonsGroup {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. creates a new <code>CheckGroupBase</code> instance.
		 * 	
		 * 	@param	target 	The <code>UIContainer</code> where to display the buttons
		 * 					of the group.
		 */
		public function CheckGroupBase(target:UIContainer = null) {
			super(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>enableMultipleSelections</code>
		 * 	property.
		 * 
		 * 	@see #enableMultipleSelections
		 */
		protected var $multipleSelections:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether this <code>CheckGroupBase</code>
		 * 	allows several button objects to be selected at the same time (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get enableMultipleSelections():Boolean {
			return $multipleSelections;
		}
		public function set enableMultipleSelections(value:Boolean):void {
			$multipleSelections = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>selectedItems</code> property.
		 * 
		 * 	@see #selectedItems
		 */
		protected var $selectedItems:Array = [];
		/**
		 * 	Returns a reference to the array that contains all selected items when
		 * 	the <code>enableMultipleSelections</code> property is true.
		 * 
		 * 	@see #enableMultipleSelections
		 * 	@see #values
		 * 	@see #allData
		 */
		public function get selectedItems():Array {
			return $selectedItems;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>values</code> property.
		 * 
		 * 	@see #values
		 */
		protected var $values:Array = [];
		/**
		 * 	Returns a reference to the array that contains all the values of the 
		 * 	group when the <code>enableMultipleSelections</code> property is true.
		 * 
		 * 	@see #enableMultipleSelections
		 * 	@see #selectedItems
		 * 	@see #allData
		 */
		public function get values():Array {
			return $values;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>allData</code> property.
		 * 
		 * 	@see #allData
		 */
		protected var $allData:Array = [];
		/**
		 * 	Returns a reference to the array that contains all the data of the 
		 * 	group when the <code>enableMultipleSelections</code> property is true.
		 * 
		 * 	@see #enableMultipleSelections
		 * 	@see #selectedItems
		 * 	@see #values
		 */
		public function get allData():Array {
			return $allData;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal function resetAllData():void {
			$values = [];
			$allData = [];
		}
	}
}