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

package org.flashapi.swing.media {
	
	// -----------------------------------------------------------
	// MediaObserver.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 10/01/2009 15:55
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>MediaRessourceUser</code> interface is the markup interface for 
	 * 	controls that interact with <code>Media</code> objects and/or share 
	 * 	ressources through the <code>MediaRessourceManager</code> class.
	 * 
	 * 	@see org.flashapi.swing.managers.MediaRessourceManager
	 * 	@see org.flashapi.swing.media.Media
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface MediaRessourceUser {
		
		/**
		 * 	The <code>updateAfterEvent()</code> allows to update a <code>MediaRessourceUser</code>
		 * 	instance at the interval specified by the <code>precision</code> property
		 * 	of the <code>MediaRessourceManager</code> class.
		 * 
		 * 	@see org.flashapi.swing.managers.MediaRessourceManager#precision
		 */
		function updateAfterEvent():void;
	}
}