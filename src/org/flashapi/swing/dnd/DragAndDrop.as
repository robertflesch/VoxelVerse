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

package org.flashapi.swing.dnd {
	
	// -----------------------------------------------------------
	// DragAndDrop.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 31/07/2009 12:15
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	Indicates if an object implements Drag And Drop functionalities.
	 * 	This interface is implemented by the <core>UIObject</core> class.
	 * 
	 * 	@see org.flashapi.swing.core.UIObject
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DragAndDrop {
		
		/**
		 * 	Sets or gets the data value used for a Drag and Drop operation.
		 * 
		 * 	@default null
		 */
		function get dndData():*;
		function set dndData(value:*):void;
		
		/**
		 * 	Returns an <code>Array</code> that contains all <code>DnDFormat</code> objects
		 * 	for this Drag and Drop operation.
		 * 
		 * 	@see org.flashapi.swing.dnd.DnDFormat
		 */
		function get dropFormat():Array;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the object is elligible
		 * 	for drag operations (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #dropEnabled
		 */
		function get dragEnabled():Boolean;
		function set dragEnabled(value:Boolean):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the object is elligible
		 * 	for drop operations (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #dragEnabled
		 */
		function get dropEnabled():Boolean;
		function set dropEnabled(value:Boolean):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the object prevent
		 * 	drop operations for its paren container (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #parentDragEnabled
		 */
		function get parentDropEnabled():Boolean;
		function set parentDropEnabled(value:Boolean):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the object prevent
		 * 	drag operations for its paren container (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #parentDropEnabled
		 */
		function get parentDragEnabled():Boolean;
		function set parentDragEnabled(value:Boolean):void;
		
		/**
		 * 	Add a new drop format to this object.
		 * 
		 * 	@param	format The drop format to add to this object.
		 * 
		 * 	@see org.flashapi.swing.dnd.DnDFormat
		 */
		function addDropFormat(format:DnDFormat):void;
		
		/**
		 * 	Checks whether this object has registered the <code>DnDFormat</code> object
		 * 	specified by the <code>format</code> parameter.
		 * 
		 * 	@param	format	The drop format to check.
		 * 
		 * 	@return	A value of <code>true</code> if the drop format is registered;
		 * 			<code>false</code> otherwise.

		 * 
		 * 	@see org.flashapi.swing.dnd.DnDFormat
		 */
		function hasDropFormat(format:DnDFormat):Boolean;
		
		/**
		 * 	Removes the specified drop format from this object.
		 * 
		 * 	@param	format The drop format to remove from this object.
		 * 
		 * 	@see org.flashapi.swing.dnd.DnDFormat
		 */
		function removeDropFormat(format:DnDFormat):void;
	}
}