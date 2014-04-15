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
	//  DataProviderObject.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.1, 24/02/2009 16:13
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.util.ArrayList;
	import org.flashapi.swing.util.Iterator;
	
	/**
	 * 	The <code>DataProviderObject</code> interface defines the basic set of APIs 
	 * 	that you must implement to create data management objects for <code>Listable</code>.
	 * 	instances To create XML data management objects for <code>Listable</code> 
	 * 	 instances, use <code>XMLQueryObject</code> controls.
	 * 
	 * 	@see org.flashapi.swing.databinding.XMLQueryObject
	 * 	@see org.flashapi.swing.list.Listable
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DataProviderObject extends Finalizable {
		
		/**
		 * 	Adds an object to this <code>DataProvider</code> instance.
		 * 
		 * 	@param	value An object to add to this <code>DataProvider</code> instance.
		 */
		function add(value:Object):void;
		
		/**
		 * 	Adds all items specified by the <code>rest</code> paremeter to this
		 * 	<code>DataProvider</code> instance.
		 * 
		 * 	@param	... rest 	A list of items to add to this <code>DataProvider</code>
		 * 						instance.
		 */
		function addAll(... rest):void;
		
		/**
		 * 	Returns an <code>Array</code> that is a copy of this <code>DataProvider</code>
		 * 	object. This <code>Array</code> contains reference to all items added to the
		 * 	<code>DataProvider</code>.
		 * 
		 * 	@return	An <code>Array</code>; a copy of this <code>DataProvider</code>
		 * 	object.
		 */
		function toArray():Array;
		
		/**
		 * 	This method is used by <code>Listable</code> objects to qually applied all
		 * 	common registered properties the specified object object.
		 * 
		 * 	@param	obj	The object for wich to apply all common registered properties.
		 */
		function applyCommonProperties(obj:*):void;
		
		/**
		 * 	Adds pairs of property/value items that must by equally applied to all objects
		 * 	contained within this <code>DataProvider</code>.
		 * 
		 * 	@param	property	A string; the name of the common property.
		 * 	@param	value		The value that must be assigned to this property.
		 */
		function addCommonProperty(property:String, value:*):void;
		
		/**
		 * 	Removes an object from the <code>DataProvider</code> instance.
		 * 
		 * 	@param	value 	The object to remove from to this <code>DataProvider</code>
		 * 					instance.
		 */
		function remove(value:Object):void;
		
		/**
		 * 	[Not implemented yet] Removes all items contained within the <code>DataProvider</code>
		 * 	object but remains properties registered with the <code>addCommonProperty()</code>
		 * 	method.
		 * 
		 * 	<p>To remove both, all items an properties contained within the
		 * 	<code>DataProvider</code> object, use the <code>removeAll()</code> method.</p>
		 * 
		 * 	@see #reset()
		 * 	@see #addCommonProperty()
		 */
		function removeAll(... rest):void;
		
		/**
		 * 	Resets the <code>DataProvider</code> instance. Removes all items contained
		 * 	within the <code>DataProvider</code> object and all properties registered
		 * 	with the <code>addCommonProperty()</code> method.
		 * 
		 * 	<p>To only remove items contained within the <code>DataProvider</code> object,
		 * 	use the <code>removeAll()</code> method.</p>
		 * 
		 * 	@see #removeAll()
		 * 	@see #addCommonProperty()
		 */
		function reset():void;
		
		/**
		 * 	Makes and returns a copy of all the items contained within this
		 * 	<code>DataProvider</code> object as an <code>ArrayList</code> instance.
		 * 
		 * 	@return		A copy of this <code>DataProvider</code> object as an
		 * 				<code>ArrayList</code> instance.
		 */
		function cloneArrayList():ArrayList;
		
		/**
		 * 	Returns a reference of the <code>Iterator</code> object used within this 
		 * 	<code>DataProvider</code> instance. 
		 */
		function get iterator():Iterator;
		
		/**
		 * 	Returns the number of objects stored within this <code>DataProvider</code>
		 * 	instance. 
		 */
		function get length():int;
	}
}