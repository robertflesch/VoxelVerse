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

package org.flashapi.swing.constants {
	
	// -----------------------------------------------------------
	// RemotingServiceType.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/02/2011 16:17
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>RemotingServiceType</code> class is an enumeration of constant  
	 * 	values taht you can use to set the <code>gateway</code> property of the
	 * 	<code>AbstractRemotingService</code> class.
	 * 
	 * 	@see org.flashapi.swing.net.remoting.AbstractRemotingService#gateway
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class RemotingServiceType {
		
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
		 * 				RemotingServiceType instance.
		 */
		public function RemotingServiceType() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>"/amfphp/gateway.php"</code> path reference is a logical mapping
		 * 	for the Flash Remoting service in AMFPHP. 
		 */
		public static const AMF_PHP_DEFAULT_PATH:String = "/amfphp/gateway.php";
		
		/**
		 * 	The <code>"flashservices/gateway"</code> path reference is a logical mapping
		 * 	for the Flash Remoting service in ColdFusion MX. 
		 */
		public static const CFC_DEFAULT_PATH:String = "/flashservices/gateway";
	}
}