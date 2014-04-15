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

package org.flashapi.tween.core {
	
	// -----------------------------------------------------------
	// AbstractEasing.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 20/09/2007 15:18
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.tween.constant.EaseType;
	
	/**
	 * 	The <code>AbstractEasing</code> class defines an abstract set of methods 
	 * 	and properties for creating <code>Easing</code> equation classes.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractEasing implements Easing {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>AbstractEasing</code> instance with
		 * 					the specified parameters.
		 * 
		 * 	@param	obj		A reference to the class that currently extends the
		 * 					<code>AbstractEasing</code> class.
		 * 	@param	type	The type of "ease" process that defines this
		 * 					<code>Easing</code> object. Possible values are:
		 * 					<code>EaseType.IN</code>, <code>EaseType.OUT</code> and
		 * 					<code>EaseType.BOTH</code>.
		 */
		public function AbstractEasing(obj:*, type:String) {
			super();
			initObj(obj, type);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var _equation:Function;
		/**
		 * 	@inheritDoc
		 */
		public function get equation():Function {
			return _equation;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private function initObj(obj:*, type:String):void {
			var c:Object = (obj as Object).constructor;
			switch(type){
				case EaseType.IN :
					_equation = c.easeIn;
					break;
				case EaseType.OUT :
					_equation = c.easeOut;
					break;
				case EaseType.BOTH :
					_equation = c.easeBoth;
					break;
			}
		}
	}
}