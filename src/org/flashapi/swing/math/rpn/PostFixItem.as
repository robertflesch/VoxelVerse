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

package org.flashapi.swing.math.rpn {
	
	/**
	 * 	Post fixed items are stored into the stack of <code>RpnExp</code> instances
	 * 	to write mathematical expressions using the Reverse Polish Notation syntax.
	 * 
	 * 	@see org.flashapi.swing.math.RpnExp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PostFixItem {
		
		// -----------------------------------------------------------
		// PostFixItem.as
		// -----------------------------------------------------------
		
		/**
		* @author	Pascal ECHEMANN
		* @version	1.0.0, 19/05/2008 16:40
		* @see		http://www.flashapi.org/
		*/
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Creates a new post fixed item.
		 * 
		 * 	@param	value		The value of the post fix item.
		 * 	@param	operator	The operator of the post fix item.
		 * 	@param	type		The type of the post fix item.
		 */
		public function PostFixItem(value:Number = 0, operator:String = "", type:String = "value") {
			super();
			initObj(value, operator, type);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The value of the post fix item.
		 * 
		 * 	@default 0
		 */
		public var value:Number;
		
		/**
		 * 	The operator of the post fix item.
		 * 
		 * 	@default ""
		 */
		public var operator:String;
		
		/**
		 * 	The type of the post fix item.
		 * 
		 * 	<p>Possible values are defined by <code>RpnOperator</code> class constants:
		 * 		<ul>
		 * 			<li><code>RpnOperator.VALUE</code>,</li>
		 * 			<li><code>RpnOperator.OPERATOR</code>,</li>
		 * 			<li><code>RpnOperator.FUNCTION</code>,</li>
		 * 			<li><code>RpnOperator.VARIABLE</code>,</li>
		 * 			<li><code>RpnOperator.LEFT_BRACKET</code>,</li>
		 * 			<li><code>RpnOperator.RIGHT_BRACKET</code>.</li>
		 * 		</ul>
		 * 	</p>
		 * 
		 * 	@default "value"
		 */
		public var type:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(value:Number, operator:String, type:String):void {
			this.value = value;
			this.type = type;
			this.operator = operator;
		}
	}
}