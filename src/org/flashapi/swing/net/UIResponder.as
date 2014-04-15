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
	// UIResponder.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/03/2009 01:48
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.net.messaging.IResponder;
	
	/**
	 * 	The <code>UIResponder</code> class provides a Flash Responder object with
	 * 	a default implementation of the <code>IResponder</code> interface.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UIResponder implements IResponder {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>UIResponder</code> object with the specified
		 * 	closure functions.
		 * 
		 *  @param	result 	A <code>Function</code> called when the request has been 
		 * 					completed successfully.       
		 *  @param	status 	A <code>Function</code> called when the request has
		 * 					encountered errors.		
		 */
		public function UIResponder(result:Function, status:Function = null) {
			super();
			initObj(result, status);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function result(data:Object):void {
			_onResult(data);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function status(info:Object):void {
			_onStatus(info);
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		private var _onResult:Function;
		
		/**
		 *  @private
		 */
		private var _onStatus:Function;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(result:Function, status:Function):void {
			_onResult = result;
			_onStatus = status;
		}
	}
}