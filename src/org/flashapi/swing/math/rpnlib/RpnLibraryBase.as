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

package org.flashapi.swing.math.rpnlib {
	
	// -----------------------------------------------------------
	// RpnLibraryBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/05/2008 13:57
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.math.RpnExp;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>RpnLibraryBase</code> is a base class for library classes that can extend
	 * 	the <code>RpnExp</code> class capabilities. A <code>RpnLibrary</code> library consists
	 * 	in a set of additional functions defined to evaluate and solve specific mathematical
	 * 	literal expressions.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RpnLibraryBase implements RpnLibrary {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>RpnLibraryBase</code> instance.
		 */
		public function RpnLibraryBase() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>operatorList</code> property.
		 * 
		 * 	@see #operatorList
		 */
		protected var $opList:Array = [];
		/**
		 * 	@inheritDoc
		 */
		public function get operatorList():Array {
			return $opList;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>rpnInstance</code> property.
		 * 
		 * 	@see #rpnInstance
		 */
		protected var $rpnInstance:RpnExp;
		/**
		 * 	@inheritDoc
		 */
		public function get rpnInstance():RpnExp {
			return $rpnInstance;
		}
		public function set rpnInstance(value:RpnExp):void {
			$rpnInstance = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>specialSymbolList</code> property.
		 * 
		 * 	@see #specialSymbolList
		 */
		protected var $specialSymbolList:Array = [];
		/**
		 * 	@inheritDoc
		 */
		public function get specialSymbolList():Array {
			return $specialSymbolList;
		}
	}
}