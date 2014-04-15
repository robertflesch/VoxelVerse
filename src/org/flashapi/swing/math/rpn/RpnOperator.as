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
	
	// -----------------------------------------------------------
	// RpnOperator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.1.0 12/05/2011 23:56
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>RpnOperator</code> class creates proxy objects used by the
	 * 	<code>RpnExp</code> class to manage operators, constants and functions during
	 * 	the evaluation of mathematical strings.
	 * 	
	 * 	@see org.flashapi.swing.math.RpnExp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public dynamic class RpnOperator {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>RpnOperator</code> instance with the
		 * 	following properties.
		 * 
		 * 	@param	name	The name of the <code>RpnOperator</code> instance.
		 * 	@param	notation	The notation of a mathematical expression associated
		 * 						with this <code>RpnOperator</code> instance.
		 * 	@param	priority	The priority of the <code>RpnOperator</code> instance.
		 * 	@param	operandNum	The number of operands associated with this 
		 * 						<code>RpnOperator</code> instance.
		 * 	@param	operation	The type of operation to perform, associated with this
		 * 						<code>RpnOperator</code> instance.
		 * 	@param	parsingFunction		The specific parsing method associated with 
		 * 								this <code>RpnOperator</code> instance.
		 */
		public function RpnOperator(name:String, notation:String, priority:int = 0, operandNum:uint = 0, operation:Function = null, parsingFunction:Function = null) {
			super();
			initObj(name, notation, priority, operandNum, operation, parsingFunction);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The constant value which indicates that a <code>RpnOperator</code> object
		 * 	is a numeric value.
		 */
		public static const VALUE:String = "value";
		
		/**
		 * 	The constant value which indicates that a <code>RpnOperator</code> object
		 * 	is a mathematical operator.
		 */
		public static const OPERATOR:String = "operator";
		
		/**
		 * 	The constant value which indicates that a <code>RpnOperator</code> object
		 * 	is a mathematical function.
		 */
		public static const FUNCTION:String = "function";
		
		/**
		 * 	The constant value which indicates that a <code>RpnOperator</code> object
		 * 	is a variable.
		 */
		public static const VARIABLE:String = "variable";
		
		/**
		 * 	The constant value which indicates that a <code>RpnOperator</code> object
		 * 	is a string.
		 */
		public static const STRING:String = "string";
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The name of the <code>RpnOperator</code> instance.
		 */
		public var name:String;
		
		/**
		 * 	The notation of the mathematical expression associated with this
		 * 	<code>RpnOperator</code> instance.
		 */
		public var notation:String;
		
		/**
		 * 	The priority of the <code>RpnOperator</code> instance.
		 * 
		 * 	@default 0
		 */
		public var priority:int;
		
		/**
		 * 	The number of operands associated with this <code>RpnOperator</code>
		 * 	instance.
		 */
		public var operandNum:uint;
		
		/**
		 * 	The type of operation to perform, associated with this 
		 * 	<code>RpnOperator</code> instance.
		 * 
		 * 	@default null
		 */
		public var operation:Function = null;
		
		/**
		 * 	The specific parsing method associated with this <code>RpnOperator</code>
		 * 	instance.
		 * 
		 * 	@default false
		 */
		public var parsingFunction:Function = null;
		
		/**
		 * 	An interal identifier used by the <code>RpnExp</code> class when parsing
		 * 	and evaluating a mathematical expression.
		 */
		public var tokenId:int;
		
		//The specific calculation method used by this <code>RpnOperator</code> instance.
		//public var delegateFunction:Function = null;
		
		/**
		 * 	The type of this <code>RpnOperator</code> instance.
		 * 	<p>Possible values are defined by <code>RpnOperator</code> class constants:
		 * 		<ul>
		 * 			<li><code>RpnOperator.VALUE</code></li>
		 * 			<li><code>RpnOperator.OPERATOR</code></li>
		 * 			<li><code>RpnOperator.FUNCTION</code></li>
		 * 			<li><code>RpnOperator.VARIABLE</code></li>
		 * 		</ul>
		 * 	</p>
		 * 
		 * 	@default ""
		 */
		public var type:String = "";
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(name:String, notation:String, priority:int, operandNum:uint, operation:Function, parsingFunction:Function):void {
			this.name = name;
			this.notation = notation;
			this.priority = priority;
			this.operandNum = operandNum;
			if (operation != null) this.operation = operation;
			this.parsingFunction = parsingFunction;
		}
	}
}