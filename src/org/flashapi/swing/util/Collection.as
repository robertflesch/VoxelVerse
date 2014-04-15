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
	// Collection .as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/05/2009 19:03
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Finalizable;
	
	/**
	 * 	The root interface in the collection hierarchy. A collection represents a
	 * 	group of objects, known as its <i>elements</i>. Some collections allow
	 * 	duplicate elements and others do not. Some are ordered and others unordered.
	 * 	The SPAS 3.0 API does not provide any direct implementations of this interface:
	 * 	it provides implementations of more specific subinterfaces like <code>List</code>.
	 * 	This interface is typically used to pass collections around and manipulate
	 * 	them where maximum generality is desired.
	 * 
	 * 	<p>No assumptions are made about the order of the collection (if any),
	 * 	or whether it may contain duplicate elements.</p>
	 * 
	 * 	@see org.flashapi.swing.util.List
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Collection extends Finalizable{
		
		//function equals(obj:Collection):Boolean;
		//function hashCode():int;
		
		/**
		 * 	Adds the specified element to this collection.
		 * 
		 * 	@param	obj The element to add to this collection.
		 * 
		 * 	@return	The index position of the added element into this collection.
		 */
		function add(obj:Object):int;
		
		/**
		 * 	Adds a <code>Collection</code> of elements to this collection and 
		 * 	returns the new size of the new concatained collection.
		 * 
		 * 	@param	c	The <code>Collection</code> of elements to add to this
		 * 				collection.
		 * 
		 * 	@return	The new size of this collection after concatenation.
		 */
		function addAll(c:Collection):int;
		
		/**
		 * 	Removes all elements from this collection.
		 */
		function clear():void;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the
		 * 	element specified by the <code>obj</code> parameter is contained within
		 * 	this collection(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@param	obj	The element to determine the presence within the collection.
		 * 
		 * 	@return <code>true</code> if this collection contains the specified element;
		 * 			<code>false</code> otherwise.
		 */
		function contains(obj:Object):Boolean;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether this collection
		 * 	contains all of the elements in the collection specified by the <code>c</code>
		 * 	parameter (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@param	c	The collection to be checked for containment in this collection.
		 * 
		 * 	@return	<code>true</code> if this collection contains all the elements of 
		 * 	the specified collection; <code>false</code> otherwise.
		 */
		function containsAll(c:Collection):Boolean;
		
		/**
		 * 	Returns a <code>Boolean</code> that indicates whether this collection 
		 * 	contains elements <code>false</code>), or not (<code>true</code>). 
		 * 
		 * 	@return <code>true</code> if this collection do not contains elements;
		 * 			<code>false</code> otherwise. 
		 */
		function isEmpty():Boolean;
		
		/**
		 * 	Returns an iterator over the elements in this collection.
		 * 	There are no guarantees concerning the order in which the
		 * 	elements are returned (unless this collection is an instance
		 * 	of some class that provides a guarantee). 
		 */
		function get iterator():Iterator;
		
		/**
		 * 	Removes the specified element from this collection.
		 * 
		 * 	@param	obj	The element to be removed from this collection.
		 * 	@return	<code>true</code> if the element has been removed from this
		 * 			collection; <code>false</code> otherwise.
		 */
		function remove(obj:Object):Boolean;
		
		/**
		 * 	Removes all elements in the collection specified by the <code>c</code>
		 * 	that are also contained within this collection.
		 * 
		 * 	@param	c 	A collection of elements to be removed from this
		 * 				collection.
		 * 
		 * 	@return	<code>true</code> if all of the elements have been removed
		 * 			from this collection; <code>false</code> otherwise.
		 */
		function removeAll(c:Collection):Boolean;
		
		/**
		 * 	Retains only the elements in this collection that are contained
		 * 	in the specified collection (optional operation).
		 * 	In other words, removes from this collection all of its elements
		 * 	that are not contained in the specified collection. 
		 * 
		 * 	@param	c The collection of elements to be retained in this collection.
		 * 
		 * 	@return	<code>true</code> if all of the elements have been removed from
		 * 			this collection; <code>false</code> otherwise.
		 */
		function retainAll(c:Collection):Boolean;
		
		/**
		 * 	Returns the number of elements available within this collection.
		 */
		function get size():int;
		
		/**
		 * 	Returns an array containing all the elements contained within this
		 * 	collection. The returned array is "safe" in that no references to it
		 * 	are maintained by this collection.
		 * 
		 * 	@param	a
		 * 
		 * 	@return	An array containing all the elements of the collection.
		 */
		function toArray():Array;
	}
}