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

package org.flashapi.swing.renderer {
	
	// -----------------------------------------------------------
	// ItemEditor.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 30/03/2010 14:03
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.IUIObject;
	
	/**
	 * 	The <code>ItemEditor</code> interface defines the basic set of APIs 
	 * 	that you must implement to create SPAS 3.0 item editor objects.
	 * 
	 * 	@see org.flashapi.swing.renderer.ItemRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ItemEditor extends IUIObject {
		
		/**
		 * 	sets or gets the <code>ItemRenderer</code> instance that can be edited
		 * 	by this by <code>ItemEditor</code> object.
		 */
		function get itemRenderer():ItemRenderer;
		function set itemRenderer(value:ItemRenderer):void;
		
		/**
		 * 	Sets or gets the plain text displayed by <code>ItemEditor</code> objects.
		 */
		function get text():String;
		function set text(value:String):void;
		
		/**
		 * 	Returns a reference to the input control which is accessible by users
		 * 	to edit the <code>ItemRenderer</code> instance sepecified by the 
		 * 	<code>itemRenderer</code> property. If no input control is defined for
		 * 	this <code>ItemEditor</code> object, returns <code>null</code>.
		 * 
		 * 	@default null
		 * 
		 * 	@see #itemRenderer
		 */
		function get inputControl():*;
		
		/**
		 * 	Sets the index for this <code>ItemEditor</code> object.
		 */
		function set index(value:int):void;
	}
}