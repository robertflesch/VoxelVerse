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

package org.flashapi.swing.list {
	
	// -----------------------------------------------------------
	// ItemsList.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/02/2010 20:29
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.core.IUIObject;
	
	/**
	 * 	The <code>ItemsList</code> interface defines the basic set of APIs 
	 * 	that you must implement to create SPAS 3.0 <code>UIObjects</code> that
	 * 	can be used as drop-down list object within a <code>DropListBase</code>
	 * 	control.
	 * 
	 * 	@see org.flashapi.swing.list.DropListBase
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ItemsList extends Listable, Border, IUIObject {
		
		/**
		 * 	Sets or gets the number of items visible within this 
		 * 	<code>ItemsList</code> object.
		 * 	
		 * 	@default 5
		 */
		function get size():uint;
		function set size(value:uint):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A <code>Boolean</code> value that indicates whether the items
		 * 	contained within this <code>ItemsList</code> object can be updated
		 * 	and laid out (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		function get invalidateListUpdate():Boolean;
		function set invalidateListUpdate(value:Boolean):void;
		
		/**
		 *  Resets the <code>ItemsList</code> object. Sets <code>item</code> and
		 * 	<code>data</code> properties to <code>null</code> and the <code>value</code>
		 * 	property to <code>""</code> (empty string). 
		 */
		function reset():void;
	}
}