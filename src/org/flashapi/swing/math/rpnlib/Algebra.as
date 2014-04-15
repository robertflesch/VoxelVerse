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
	// Algebra.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/05/2008 21:05
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.math.rpn.PostFixItem;
	import org.flashapi.swing.math.rpn.rpn_internal;
	import org.flashapi.swing.math.rpn.RpnOperator;
	
	use namespace rpn_internal;
	
	/**
	 * 	The <code>Algebra</code> class library provides an extended set of functions
	 * 	to work with basic mathematical arithmetic operations within <code>RpnExp</code>
	 * 	instances.
	 * 
	 * 	<p>The following table lists the functions and operators that are defined by the
	 * 	<code>Algebra</code> class:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Name</th>
	 * 			<th>Math notation</th>
	 * 			<th>Syntax</th>
	 * 			<th>Description</th>
	 * 			
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Unary Negation Operator: -</td>
	 * 			<td>-x</td>
	 * 			<td><code>neg(x)</code></td>
	 * 			<td>The unary negation operator produces the negative of its operand
	 * 			(<code>x</code>).</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Pi constant value</td>
	 * 			<td>&#928;</td>
	 * 			<td><code>pi</code></td>
	 * 			<td>A mathematical constant for the ratio of the circumference of a 
	 * 			circle to its diameter, expressed as <code>pi</code>, with a value of
	 * 			<code>3.141592653589793</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Pi constant value</td>
	 * 			<td>&#928;</td>
	 * 			<td><code>&#928;</code></td>
	 * 			<td>A mathematical constant for the ratio of the circumference of a 
	 * 			circle to its diameter, expressed as <code>pi</code>, with a value of
	 * 			<code>3.141592653589793</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Addition</td>
	 * 			<td>a + b</td>
	 * 			<td><code>a + b</code></td>
	 * 			<td>Adds numeric expressions.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Subtraction</td>
	 * 			<td>a - b</td>
	 * 			<td><code>a - b</code></td>
	 * 			<td>Used for subtracting.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Multiplication</td>
	 * 			<td>a x b</td>
	 * 			<td><code>a</code> &#42; <code>b</code></td>
	 * 			<td>Multiplies two numerical expressions.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Division</td>
	 * 			<td>a &#47; b</td>
	 * 			<td><code>a</code> &#47; <code>b</code></td>
	 * 			<td>Divides "<code>a</code>" by "<code>b</code>".<br />
	 * 			Throws a <code>RpnException</code> error if <code>b</code> is equal
	 * 			to zero.
	 * 			</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Modulo</td>
	 * 			<td>a &#37; b</td>
	 * 			<td><code>a</code> &#37; <code>b</code></td>
	 * 			<td>Calculates the remainder of "<code>a</code>" divided by 
	 * 			"<code>b</code>".<br />
	 * 			Throws a <code>RpnException</code> error if <code>b</code> is equal
	 * 			to zero.
	 * 			</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Power</td>
	 * 			<td>a<sup>b</sup></td>
	 * 			<td><code>a</code> &#94; <code>b</code></td>
	 * 			<td>Computes and returns "<code>a</code>" to the power of
	 * 			"<code>b</code>".</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Square</td>
	 * 			<td>a<sup>2</sup></td>
	 * 			<td><code>sqr(a)</code></td>
	 * 			<td>Computes and returns  the product of <code>a</code> number
	 * 			by itself</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Square root</td>
	 * 			<td>&#8730;a</td>
	 * 			<td><code>sqrt(a)</code></td>
	 * 			<td>Computes and returns the square root of the specified number
	 * 			<code>a</code>.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	<p><strong>Note:</strong> The <code>Algebra</code> is the base library class
	 * 	for the <code>RpnExp</code> class.</p>
	 * 
	 * 	@see org.flashapi.swing.math.RpnExp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Algebra extends RpnLibraryBase implements RpnLibrary {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Algebra</code> instance.
		 */
		public function Algebra() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _functions:Array = [
			["null", 0, 0, "", 	null],
			["unary negation operator", 4, 1, "neg",
				function(arg:Array):Number {
					return -1 * arg[0];
				}
			],
			["pi", 0, 0, "pi",
				function(arg:Array):Number {
					return Math.PI;
				}
			],
			["pi", 0, 0, "π",
				function(arg:Array):Number {
					return Math.PI;
				}
			],
			["addition", 1, 2, "+",
				function(arg:Array):Number {
					return arg[1] + arg[0];
				}
			],
			["subtraction", 1, 2, "-",
				function(arg:Array):Number {
					return arg[1] - arg[0];
				}
			],
			["multiplication", 2, 2, "*",
				function(arg:Array):Number {
					return arg[1] * arg[0];
				}
			],
			["division", 2, 2, "/",
				function(arg:Array):Number {
					if (arg[0] == 0) $rpnInstance.rpn_internal::setError(2);
					return arg[1] / arg[0];	
				}
			],
			["modulo", 2, 2, "%",
				function(arg:Array):Number {
					if (arg[0] < 0) $rpnInstance.rpn_internal::setError(2);
					return arg[1] % arg[0];	
				}
			],
			["power", 3, 2, "^",
				function(arg:Array):Number {
					if (arg[1] < 0) $rpnInstance.rpn_internal::setError(3);
					if (arg[0] == 0 && arg[1] == 0) return 1;
					var r:Number = Math.exp(arg[0] * Math.log(arg[1]))
					return (arg[0] is int && arg[1] is int) ? Math.round(r) : r;
				}
			],
			["square", 0, 1, "sqr",
				function(arg:Array):Number {
					return  Math.pow(arg[0], 2);
				}
			],
			/*["square", 0, 1, "²", function(arg:Array):Number { return  Math.pow(arg[0], 2); } ],*/
			["square root", 0, 1, "sqrt",
				function(arg:Array):Number { 
					if (arg[0] < 0) $rpnInstance.rpn_internal::setError(3);
					return Math.sqrt(arg[0]);
				}
			],
			["square root", 3, 1, "√",
				function(arg:Array):Number { 
					if (arg[0] < 0) $rpnInstance.rpn_internal::setError(3);
					return Math.sqrt(arg[0]);
				}
			],
		];
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			var i:int = _functions.length - 1;
			for (; i >= 0; i--) {
				var obj:RpnOperator = new RpnOperator(_functions[i][0], _functions[i][3], _functions[i][1], _functions[i][2], _functions[i][4]);
				if (_functions[i][5]) obj.type = _functions[i][5];
				switch(_functions[i][3]) {
					case "√" : 	//--> Start "Delegate Function Example".
						/*	
						 * 	The RPN engine of the RpnExp Class uses parentheses to define the priority
						 * 	of predefined functions. To preserve the benefits of this approach, and of
						 * 	the separation of tests and calculations processes, the following routine
						 * 	recreates a function based on parentheses. So the expression written 
						 * 	"√64 + 3" bill be written "√(64) + 3" after the routine.
						 */
						obj.parsingFunction = function(exp:String):* {
							var i:uint = this.tokenId+1;
							var continueParsing:Boolean = true;
							var operators:String = '([+-;/*^%';
							var _exp:String = "";
							do {
								if(exp.charAt(i) == " " ||  i == exp.length) i++;
								else if (operators.indexOf(exp.charAt(i)) > -1) {
									if (_exp != "") {
										$rpnInstance.rpn_internal::parsedExp =
											exp.split(_exp).join("(" + _exp + ")");
									}
									continueParsing = false;
								} else {
									_exp += exp.charAt(i);
									i++;
								}
							} while (continueParsing);
							var token:PostFixItem =
								new PostFixItem(0, this.notation, RpnOperator.FUNCTION);
							$rpnInstance.rpn_internal::stack.push(token);
						}
						//--> End "Delegate Function Example".
						break;
					case "²" :
					break;
				}
				$opList.push(obj);
			}
			$specialSymbolList.push("π");
			$specialSymbolList.push("√");
			//_specialSymbolList.push("²");
		}
		
		private function addToStack(val:Number, op:String, tpe:String):void {
			var token:PostFixItem = new PostFixItem(val, op, tpe);
			$rpnInstance.rpn_internal::stack.push(token);
		}
	}
}