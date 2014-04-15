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

package org.flashapi.swing.databinding {
	
	// -----------------------------------------------------------
	//  AbstractDataProvider.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 02/03/2011 02:58
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.events.EventDispatcher;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.ArrayList;
	import org.flashapi.swing.util.Iterator;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>AbstractDataProvider</code> class defines abstract methods to 
	 * 	help developers for creating custom <code>DataProviderObject</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.7
	 */
	public class AbstractDataProvider extends EventDispatcher implements DataProviderObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AbstractDataProvider</code> instance.
		 */
		public function AbstractDataProvider() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get iterator():Iterator {
			return $stack.iterator;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get length():int {
			return $stack.size;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		public function add(value:Object):void {
			$stack.add(value);
		}
		
		/**
		 * 	@private
		 */
		public function addAll(... rest):void{}
		
		/**
		 * 	@private
		 */
		public function addCommonProperty(property:String, value:*):void {}
		
		/**
		 * 	@private
		 */
		public function applyCommonProperties(obj:*):void {}
		
		/**
		 * 	@inheritDoc
		 */
		public function toArray():Array {
			return $stack.toArray();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function remove(value:Object):void {
			$stack.remove(value);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function removeAll(... rest):void { }
		
		/**
		 * 	@private
		 */
		public function reset():void {}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			$stack.finalize();
			$stack = null;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function cloneArrayList():ArrayList {
			return new ArrayList($stack);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The internal <code>ArrayList</code> instance used to store data into this
		 * 	<code>DataProviderObject</code> object.
		 * 
		 * 	@see #createStack()
		 */
		protected var $stack:ArrayList;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Creates the <code>ArrayList</code> instance used to store data into this
		 * 	<code>DataProviderObject</code> object and defines its data from the 
		 * 	specified <code>collection</code> parameter. If the <code>collection</code>
		 * 	parameter is <code>null</code>, no data are defined.
		 * 
		 * 	@param	collection	A collection of data used to define this custom
		 * 						<code>DataProviderObject</code> object.
		 * 
		 * 	@see #$stack
		 */
		protected function createStack(collection:Array = null):void {
			$stack = new ArrayList();
			if(collection) $stack.spas_internal::setStack(collection);
		}
	}
}