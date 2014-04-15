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

package org.flashapi.swing.localization.init {
	
	// -----------------------------------------------------------
	// InitLocaleFr.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/01/2011 19:13
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>InitLocaleFr</code> class is an enumeration of constant values
	 * 	that contains French messages to be used with the <code>Initializator</code>
	 * 	class.
	 * 
	 * 	<p>The default class for messages to be used with the <code>Initializator</code>
	 * 	within the SPAS 3.0 API is the <code>InitLocaleUs</code> class.</p>
	 * 
	 * 	@see org.flashapi.swing.Initializator
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class InitLocaleFr {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new
		 * 				InitLocaleFr instance.
		 */
		public function InitLocaleFr() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The first message that appears on the face of the <code>Initializator</code>
		 * 	object.
		 */
		public static const INITIAL_MESSAGE:String = "Initialisation de l'application.";
		
		/**
		 * 	The last message that appears on the face of the <code>Initializator</code>
		 * 	object.
		 */
		public static const FINAL_MESSAGE:String = "L'application est initialisée.";
	}
}