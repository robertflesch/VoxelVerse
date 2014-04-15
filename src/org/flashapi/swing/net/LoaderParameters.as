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
	// LoaderParameters.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/07/2010 15:05
	* @see http://www.flashapi.org/
	*/
	
	import flash.net.URLVariables;
	import org.flashapi.swing.constants.HTTPMethod;
	
	/**
	 * 	<code>LoaderParameters</code> objects allows to transfer variables between a
	 * 	SPAS 3.0 application and a server, when calling the <code>load()</code> 
	 * 	method of the <code>UILoader</code> and <code>DataLoader</code> classes.
	 * 
	 * 	@see org.flashapi.swing.net.UILoader
	 * 	@see org.flashapi.swing.net.DataLoader
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LoaderParameters extends Object {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>LoaderParameters</code> instance.
		 */
		public function LoaderParameters() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		//public var fontName:String = null;
		
		/**
		 * 	A <code>URLVariables</code> object associated with this <code>LoaderParameters</code>
		 * 	instance.
		 */
		public var urlVariables:URLVariables = null;
		
		/**
		 * 	Controls whether the HTTP form submission method is a <code>GET</code> or
		 * 	<code>POST</code> operation. Valid values are <code>HTTPMethod.GET</code>
		 * 	or <code>HTTPMethod.POST</code>.
		 */
		public var method:String = HTTPMethod.POST;
	}
}