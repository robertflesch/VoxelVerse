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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// Finalizable.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 30/04/2009 16:13
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	
	/**
	 * 	The <code>Finalizable</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 objects which are able to kill all their
	 * 	internal events and subprocess, to prevent memory leaks.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Finalizable extends IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all internal process
		 * 	of an object are killed before you delete it. Typically, the <code>finalize</code>
		 * 	action should remove all events associated with this objects, and destroy
		 * 	somme objects such like <code>BitmapData</code> or <code>NetConnection</code>
		 * 	instances.
		 * 	<p><strong>After calling this function you must set the object to <code>null</code>
		 * 	to definitely kill it.</strong></p>
		 */
		function finalize():void;
	}
}