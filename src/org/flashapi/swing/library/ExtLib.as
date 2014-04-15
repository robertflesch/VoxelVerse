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

package org.flashapi.swing.library {
	
	// -----------------------------------------------------------
	// ExtLib.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/01/2010 18:18
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ExtLib</code> interface allows developers to extend capabilities
	 * 	of SPAS 3.0 control objects by adding external libraries, such as filter 
	 * 	effects or new sets of properties and methods, etc..
	 * 
	 * 	<p>
	 * 	<strong>Important:</strong>
	 * 	<code>ExtLib</code> objects implementation is based on the prototype chain
	 * 	programming. Even if the prototype-based programming is a part of the core 
	 * 	ActionScript 3.0  API, it is not well supported by the Flex Compiler. Thus,
	 * 	to ensure that both, Flex and Flash compilers, will work the same when using
	 * 	an <code>ExtLib</code> object, you have to use the literal description of 
	 * 	instances actions or properties instead of a static description:
	 *  </p>
	 * 	<pre>
	 * 	var lab:Label = new Label("Lorem ipsum...");
	 * 	//For use with the Flex compiler, prefer
	 * 	//lab["addTextGlow"]() instead of lab.addTextGlow():
	 * 	lab["addTextGlow"]()
	 * 	</pre>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ExtLib {
		
		/**
		 * 	Initializes this external library.
		 * 
		 * 	@see org.flashapi.swing.managers.LibraryManager#addLib()
		 */
		function init():void;
		
		/**
		 * 	Deactivates this external library. This method is used for a better
		 * 	memory management within the Flash Player.
		 * 
		 * 	@see org.flashapi.swing.managers.LibraryManager#removeLib()
		 */
		function finalize():void;
	}
}