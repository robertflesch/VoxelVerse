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

package org.flashapi.swing.net {
	
	// -----------------------------------------------------------
	// HTTPService.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 23/03/2009 18:04
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.net.rpc.WebServiceBase;
	
	/**
	 * 	The <code>HTTPService</code> class makes an HTTP request to the specified URL,
	 * 	and an HTTP response is returned. You can also pass parameters to the specified
	 * 	URL.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class HTTPService extends WebServiceBase {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>HTTPService</code> instance with the
		 * 	specified URI.
		 * 
		 * 	@param	rootUrl	A <code>String</code> that represents the root url where 
		 * 					to locate a Web service.
		 */
		public function HTTPService(rootUrl:String = null) {
			super(rootUrl);
		}
	}
}