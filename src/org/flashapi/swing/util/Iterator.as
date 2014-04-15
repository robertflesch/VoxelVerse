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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// Iterator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 10/07/2007 22:20
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>Iterator</code> interface provides a way to access the elements
	 * 	of an aggregate object sequentially without exposing its underlying
	 * 	representation.
	 * 
	 * 	@see org.flashapi.swing.util.Collection#iterator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Iterator {
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the iteration
		 * 	has more elements (<code>true</code>), or not(<code>false</code>).
		 * 
		 * @return	<code>true</code> if the iterator has more elements;
		 * 			<code>false</code> otherwise.
		 */
		function hasNext():Boolean;
		
		/**
		 * 	Returns the next element in the iteration. Calling this method repeatedly,
		 * 	until the <code>hasNext()</code> method returns <code>false</code>, will
		 * 	return each element in the underlying collection exactly once.
		 * 
		 * 	@return	The next element in the iteration. 
		 */
		function next():Object;
		
		/**
		 * 	Resets the iteration. For example, calling the <code>next()</code> method
		 * 	after reseting the iterator, will return the first element in the underlying
		 * 	collection.
		 */
		function reset():void;
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all internal process
		 * 	of an object are killed before you delete it. Typically, the <code>finalize</code>
		 * 	action should remove all events associated with this object, and destroy
		 * 	somme objects such like <code>BitmapData</code> or <code>NetConnection</code>
		 * 	instances.
		 * 	<p><strong>After calling this function you must set the object to <code>null</code>
		 * 	to make it elligible for garbage collection.</strong></p>
		 */
		function finalize():void;
	}
}