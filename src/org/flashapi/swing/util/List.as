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
	// List.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/07/2007 17:29
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	Defines an ordered collection of objects. The user of this interface
	 * 	has to precise control over where in the list each element is inserted.
	 * 	The user can access elements by their integer index (position in the list),
	 * 	and search for elements in the list.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface List extends Collection {
		
		//--> No interest in ActionScript:
		//function lastIndexOf(obj:Object):int;
		
		/**
		 * 	Adds the specified element to this <code>List</code> object at the specified
		 * 	position.
		 * 
		 * 	@param	obj		The element to add to this <code>List</code> object.
		 * 	@param	index	The position into the <code>List</code> object where to add
		 * 					the element.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An 
		 * 	<code>IndexOutOfBoundsException</code> error if the index position does
		 * 	not exist in the <code>List</code> object.
		 */
		function addAt(obj:Object, index:int):void;
		
		/**
		 * 	Returns the element at the specified position whithin this <code>List</code>
		 * 	object.
		 * 
		 * 	@param	index	The position of the element into the <code>List</code>
		 * 					object.
		 * 
		 * 	@return	A reference to the element into this <code>List</code> object 
		 * 			at the specified index.
		 */
		function get(index:uint):Object;
		
		/**
		 * 	Returns the current index, whithin this <code>List</code> object,
		 * 	of the specified element.
		 * 
		 * 	@param	obj	The element for which to retreive the current index
		 * 			whithin this <code>List</code> object.
		 * 
		 * 	@return	The current index of the specified element.
		 */
		function indexOf(obj:Object):int;
		
		/**
		 * 	Removes the specified element from the specified <code>index</code>
		 * 	position in this <code>List</code> object.
		 * 	
		 * 	@param	index	The index of the element to remove.
		 * 
		 * 	@return	The element <code>Object</code> that was removed.
		 */
		function removeAt(index:uint):Object;
		
		/**
		 * 	Replaces the element at the specified <code>index</code> position in this list
		 * 	by the specified <code>obj</code> element.
		 * 
		 * 	@param	obj	The element to add at the specified <code>index</code>
		 * 				position.
		 * 	@param	index	The index within the list where to replace the element.
		 * 
		 * 	@return	The element <code>Object</code> that has been replaced.
		 */
		function set(obj:Object, index:uint):Object;
		
		/**
		 * 	Returns a view of the portion of this list between the specified
		 * 	<code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive,
		 * 	values.
		 * 
		 * 	@param	fromIndex	The starting position of the portion to get,
		 * 						inclusive.
		 * 	@param	toIndex		The ending position of the portion to get,
		 * 						exclusive.
		 * 
		 * 	@return	A new <code>List</code> object which is a portion of this
		 * 			list between the specified values.
		 */
		function subList(fromIndex:int, toIndex:int):List;
		
		/**
		 * 	Swaps the order of the two elements at the indexes specified by 
		 * 	<code>index1</code> and <code>index2</code>. All other elements in the
		 * 	list remain in the same index positions.
		 * 
		 * 	@param	index1	The index of the first element.
		 * 	@param	index2	The index of the second element.
		 */
		function swap(index1:int, index2:int):void;
	}
}