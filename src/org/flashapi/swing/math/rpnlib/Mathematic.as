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
	// Mathematic.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/05/2008 18:44
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.math.rpn.rpn_internal;
	import org.flashapi.swing.math.rpn.RpnOperator;
	
	use namespace rpn_internal;
	
	/**
	 * 	The <code>Mathematic</code> class library provides an extended set of functions
	 * 	to work with mathematical expressions within <code>RpnExp</code> instances.
	 * 
	 * 	<p>The following table lists the functions that are defined by the Mathematic class:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Name</th>
	 * 			<th>Math notation</th>
	 * 			<th>Syntax</th>
	 * 			<th>Description</th>
	 * 			
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Absolute value</td>
	 * 			<td>|x|</td>
	 * 			<td><code>abs(x)</code></td>
	 * 			<td>Computes and returns an absolute value for the number <code>x</code>.</td>
	 * 		</tr>
	 *		<tr>
	 * 			<td>Ceiling function</td>
	 * 			<td><img src = "../../../../../doc-images/ceil.gif" alt="Ceiling function" /></td>
	 * 			<td><code>ceil(x)</code></td>
	 * 			<td>Returns the ceiling of the specified number or expression.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Floor function</td>
	 * 			<td><img src = "../../../../../doc-images/floor.gif" alt="Floor function" /></td>
	 * 			<td><code>floor(x)</code></td>
	 * 			<td>Returns the floor of the number <code>x</code>.</td>
	 * 		</tr>
	 * 
	 * 		<tr>
	 * 			<td>Nearest integer function</td>
	 * 			<td>nint(x) or [x]</td>
	 * 			<td><code>round(x)</code></td>
	 * 			<td>Rounds the value of the number <code>x</code> up or down to the nearest
	 * 			integer and returns the value.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Integer part</td>
	 * 			<td>int(x)</td>
	 * 			<td><code>int(x)</code></td>
	 * 			<td>Gives the integer part of the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Fractional value</td>
	 * 			<td>frac(x)</td>
	 * 			<td><code>frac(x)</code></td>
	 * 			<td>Gives the fractional (noninteger) part of a the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Minimum</td>
	 * 			<td>minA</td>
	 * 			<td><code>min(a;b)</code></td>
	 * 			<td>Evaluates <code>a</code> and <code>b</code> (or more values) and returns
	 * 			the smallest value.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Maximum</td>
	 * 			<td>maxA</td>
	 * 			<td><code>max(a;b)</code></td>
	 * 			<td>Evaluates <code>a</code> and <code>b</code> (or more values) and returns
	 * 			the largest value.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Natural logarithm</td>
	 * 			<td>Ln</td>
	 * 			<td><code>Ln</code> or <code>ln</code></td>
	 * 			<td>Returns the value of the logarithm to base <code>e</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Common logarithm</td>
	 * 			<td>logx</td>
	 * 			<td><code>log</code></td>
	 * 			<td>Computes and returns value of the logarithm to base <code>10</code>
	 * 			for the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Logarithm</td>
	 * 			<td>log<sub>b</sub>x</td>
	 * 			<td><code>log_b(b;x)</code></td>
	 * 			<td>Computes and returns value of the logarithm to base <code>b</code>
	 * 			for the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Factorial</td>
	 * 			<td>n!</td>
	 * 			<td><code>n!(x)</code></td>
	 * 			<td>Computes and returns the factorial for the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Natural logarithm of 1+x</td>
	 * 			<td>Ln(x+1)</td>
	 * 			<td><code>lnxp1(x)</code></td>
	 * 			<td>Computes and returns the natural logarithm of <code>1+x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Napier's constant</td>
	 * 			<td>e</td>
	 * 			<td><code>e</code></td>
	 * 			<td>A mathematical constant for the base of natural logarithms, expressed
	 * 			as <code>e</code>. The approximate value of <code>e</code> is
	 * 			<code>2.71828182845905</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Exponential Function</td>
	 * 			<td>exp(x)</td>
	 * 			<td><code>exp(x)</code></td>
	 * 			<td>Returns the value of the base of the natural logarithm (e),
	 * 			to the power of the exponent specified in the number <code>x</code>.</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.math.RpnExp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Mathematic extends RpnLibraryBase implements RpnLibrary {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Mathematic</code> instance.
		 */
		public function Mathematic() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _functions:Array = [
			["absolute value", 0, 1, "abs",
				function(arg:Array):Number {
					return Math.abs(arg[0]);
				}
			],
			["ceiling function", 0, 1, "ceil",
				function(arg:Array):Number {
					return Math.ceil(arg[0]);
				}
			],
			["floor function", 0, 1, "floor",
				function(arg:Array):Number {
					return Math.floor(arg[0]);
				}
			],
			["nearest integer function", 0, 1, "round",
				function(arg:Array):Number {
					return Math.round(arg[0]);
				}
			],
			["integer part", 0, 1, "int",
				function(arg:Array):Number {
					return int(arg[0]);
				}
			],
			["fractional value", 0, 1, "frac",
				function(arg:Array):Number {
					return arg[0] - Math.floor(arg[0]);
				}
			],
			["minimum", 0, 2, "min",
				function(arg:Array):Number {
					return Math.min(arg[1], arg[0]);
				}
			],
			["maximum", 0, 2, "max",
				function(arg:Array):Number {
					return Math.max(arg[1], arg[0]);
				}
			],
			["natural logarithm", 0, 1, "ln",
				function(arg:Array):Number {
					return Math.log(arg[0]);
				}
			],
			["natural logarithm", 0, 1, "Ln",
				function(arg:Array):Number {
					return Math.log(arg[0]);
				}
			],
			["common logarithm", 0, 1, "log",
				function(arg:Array):Number {
					return Math.log(arg[0]) / Math.log(10);
				}
			],
			["logarithm", 0, 2, "log_b",
				function(arg:Array):Number {
					if (arg[0] <= 0 || arg[1] <= 0) $rpnInstance.rpn_internal::setError(3);
					return Math.log(arg[1]) / Math.log(arg[0]);
				}
			],
			["factorial", 0, 1, "n!",
				function(arg:Array):Number {
					if (arg[0] < 0) $rpnInstance.rpn_internal::setError(3);
					else {
						var v:Number = 1;
						var i:uint = 1;
						for (; i <= arg[0] ; i++) v *= i;
					}
					return v;
				}
			],
			["lnxp1", 0, 1, "lnxp1",
				function(arg:Array):Number {
					return Math.log(arg[0] + 1);
				}
			],
			["napier's constant", 0, 0, "e",
				function(arg:Array):Number {
					return Math.E;
				}
			],
			//["E", 0, 1, "E", function(arg:Array):Number { return int(arg[0]); }],
			["exponential function", 0, 1, "exp",
				function(arg:Array):Number {
					return Math.exp(arg[0]);
				}
			]
		];
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			var i:int = _functions.length-1;
			for (; i >= 0; i--) {
				var obj:RpnOperator =
					new RpnOperator(_functions[i][0], _functions[i][3],
					_functions[i][1], _functions[i][2], _functions[i][4]);
				$opList.push(obj);
			}
		}
	}
}