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

package org.flashapi.swing.framework {
	
	// -----------------------------------------------------------
	// FDTrace.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/07/2010 10:34
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.framework.flashdevelop.FlashConnect;
	
	/**
	 * 	The <code>FDTrace</code> class is the <code>Debugger</code> class that is 
	 * 	used  to debug SPAS 3.0 applications directly from the FlashDevelop environement.
	 * 
	 * 	<p>To to debug SPAS 3.0 applications directly from the Flash IDE, use the
	 * 	<code>DebugObject</code> class instead.</p>
	 * 
	 * 	@see org.flashapi.swing.framework.DebugObject
	 * 	@see org.flashapi.swing.UIManager#debugger
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FDTrace implements Debugger {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>FDTrace</code> instance.
		 */
		public function FDTrace() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function print(... arguments):void {
			FlashConnect.trace(arguments);
		}
	}
}