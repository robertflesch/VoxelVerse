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

package org.flashapi.swing.util {

	// -----------------------------------------------------------
	// GlobalObject.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/03/2008 16:37
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.exceptions.SingletonException;
	
	/**
	 * 	The <code>GlobalObject</code> is used to simulate the ActionScript 2 
	 * 	<code>_global</code> property.
	 * 
	 * 	<p><strong>Note: </strong> You cannot create more than one <code>GlobalObject</code>
	 * 	within a SPAS 3.0 application.</p>
	 * 	
	 * 	<listing version="3.0" >
	 * 		import org.flashapi.swing.util.GlobalObject;
	 * 		var go:GlobalObject = new GlobalObject();
	 * 		this.global.test = "test";
	 * 		var mc:MovieClip = new MovieClip();
	 * 		trace(mc.global.test);// test
	 * 	</listing>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class GlobalObject extends Object {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>GlobalObject</code> object.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException
		 * 			A <code>SingletonException</code> if you try create maore than
		 * 			one <code>GlobalObject</code> instance.
		 */
		public function GlobalObject() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public functions
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private static var _isInstantiated:Boolean = false;
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the <code>GlobalObject</code>
		 * 	class has already been instantiated (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@return	<code>true</code> if a <code>GlobalObject</code> already exists;
		 * 			<code>false</code> otherwise.
		 */
		public static function isInstantiated():Boolean {
			return _isInstantiated;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const GLOBAL:Object = new Object();
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if (_isInstantiated) throw new SingletonException();
			else {
				_isInstantiated = true;
				Object.prototype.global = GLOBAL;
			}
		}
	}
}