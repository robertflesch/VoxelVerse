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

package org.flashapi.swing.wtk {
	
	// -----------------------------------------------------------
	// WTKControlContainer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1 10/02/2011 17:28
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.containers.IUIContainer;
	
	/**
	 * 	The <code>WTKControlContainer</code> interface defines the basic
	 * 	set of APIs that you must implement to create <code>WindowControlContainer</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.wtk.WindowControlContainer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public interface WTKControlContainer extends IUIContainer {
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the parent window
		 * 	should be updates when elements are added to this <code>WTKControlContainer</code>
		 * 	object (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		function get invalidateParentUpdate():Boolean;
		function set invalidateParentUpdate(value:Boolean):void;
	}
}