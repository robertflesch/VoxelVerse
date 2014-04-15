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

package org.flashapi.swing.net.remoting {
	
	// -----------------------------------------------------------
	// AMFCredentialsHeader.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/03/2009 17:00
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.net.AMFHeader;
	
	/**
	 * 	<code>AMFCredentialsHeader</code> allows to encapsulate a credentials context 
	 * 	header for the AMF packet structure. 
	 * 	
	 * 	<p><strong>Note:</strong> The Header blocks will automatically be annotated
	 * 	with the <code>mustUnderstand</code> attribute set to <code>false</code>.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AMFCredentialsHeader extends AMFHeader {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>AMFCredentialsHeader</code> object with the
		 * 	specified parameters.
		 * 
		 * @param	param	Any ActionScript object.
		 */
		public function AMFCredentialsHeader(param:Object) {
			super("Credentials", false, param);
		}
	}
}