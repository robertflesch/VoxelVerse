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
	// Observer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/07/2007 17:30
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.util.Observable;
	
	/**
	 * 	A class can implement the <code>Observer</code> interface when it
	 * 	wants to be informed of changes in <code>Observable</code> objects.
	 * 
	 * 	@see     org.flashapi.swing.util.Observable
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */ 
	public interface Observer {
		
		/**
		 * 	This method is called whenever the observed object is changed.
		 * 	An application calls the <code>notifyObservers()</code> method
		 * 	of an <code>Observable</code> object to have all the registered
		 * 	observers notified of the change.
		 * 
		 * 	@param	o	The <code>Observable</code> object to be notified of
		 * 				changes.
		 * 	@param	arg A custom argument passed to the <code>notifyObservers()</code>
		 * 				method.
		 */
		function update(o:Observable, arg:*):void;
	}
}