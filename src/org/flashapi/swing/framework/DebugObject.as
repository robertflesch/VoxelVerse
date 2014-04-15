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
	// DebugObject.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/11/2008 00:09
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DebugObject</code> class is the default <code>Debugger</code>
	 * 	class that is used to debug SPAS 3.0 applications. <code>DebugObject</code>
	 * 	instance invoke a <code>trace()</code> statement to output expressions to
	 * 	log files, which is useful for debugging applcation from the Flas IDE.
	 * 	To debugge an applcation directly from FlashDevelop, use a <code>FDTrace</code>
	 * 	object instead.
	 * 
	 * 	@see org.flashapi.swing.framework.FDTrace
	 * 	@see org.flashapi.swing.UIManager#debugger
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DebugObject implements Debugger {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DebugObject</code> instance.
		 */
		public function DebugObject() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function print(... arguments):void {
			trace(arguments);
		}
	}
}