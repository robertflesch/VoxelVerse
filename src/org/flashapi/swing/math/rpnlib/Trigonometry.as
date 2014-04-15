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
	// Trigonometry.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 19/05/2008 12:30
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.math.rpn.rpn_internal;
	import org.flashapi.swing.math.rpn.RpnOperator;
	
	use namespace rpn_internal;
	
	/**
	 * 	The <code>Trigonometry</code> class library provides an extended set of functions
	 * 	to work with trigonometric expressions within <code>RpnExp</code> instances.
	 * 
	 * 	<p>All of these functions can deal with values in degrees, grads or radians.
	 * 	The default unit to get the value of an angle is radian. To set the 
	 * 	unit for angles, use the <code>unit</code> property.</p>
	 * 
	 *	<p>The following table lists the functions that are defined by the <code>Trigonometry</code>
	 * 	class:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Name</th>
	 * 			<th>Math notation</th>
	 * 			<th>Syntax</th>
	 * 			<th>Description</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Sine</td>
	 * 			<td>sin(A)</td>
	 * 			<td><code>sin(x)</code></td>
	 * 			<td>Returns the sine of the angle defined by the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Cosine</td>
	 * 			<td>cos(A)</td>
	 * 			<td><code>cos(x)</code></td>
	 * 			<td>Returns the cosine of the angle defined by the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Tangent</td>
	 * 			<td>tan(A)</td>
	 * 			<td><code>tan(x)</code></td>
	 * 			<td>Returns the tangent of the angle defined by the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Involute</td>
	 * 			<td><img src = "../../../../../doc-images/involute.gif" alt="Involute" /></td>
	 * 			<td><code>inv(x)</code></td>
	 * 			<td>Returns the computed value specified by the "involute function" for
	 * 			the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Sine cardinal</td>
	 * 			<td>sinc(x)</td>
	 * 			<td><code>sinc(x)</code></td>
	 * 			<td>Returns the computed value specified by the "sampling function" for
	 * 			the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Hyperbolic sine</td>
	 * 			<td>sinh<sub>z</sub></td>
	 * 			<td><code>sinh(x)</code></td>
	 * 			<td>Returns the computed value specified by the "hyperbolic sine function"
	 * 			for the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Hyperbolic cosine</td>
	 * 			<td>cosh<sub>z</sub></td>
	 * 			<td><code>cosh(x)</code></td>
	 * 			<td>Returns the computed value specified by the "hyperbolic cosine function"
	 * 			for the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Hyperbolic tangent</td>
	 * 			<td>tanh<sub>z</sub></td>
	 * 			<td><code>tanh(x)</code></td>
	 * 			<td>Returns the computed value specified by the "hyperbolic tangent function"
	 * 			for the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Inverse sine</td>
	 * 			<td>sin<sup>-1</sup><sub>z</sub></td>
	 * 			<td><code>asin(x)</code> or <code>arcsin(x)</code></td>
	 * 			<td>Computes and returns the arc sine for the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Inverse cosine</td>
	 * 			<td>cos<sup>-1</sup><sub>z</sub></td>
	 * 			<td><code>acos(x)</code> or <code>arccos(x)</code></td>
	 * 			<td>Computes and returns the arc cosine for the number <code>x</code>.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Inverse tangent</td>
	 * 			<td>tan<sup>-1</sup><sub>z</sub></td>
	 * 			<td><code>atan(x)</code> or <code>arctan(x)</code></td>
	 * 			<td>Computes and returns the arc tangent for the number <code>x</code>.</td>
	 * 		</tr> 
	 * 	</table>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Trigonometry extends RpnLibraryBase implements RpnLibrary {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Trigonometry</code> instance.
		 */
		public function Trigonometry() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant used to set the <code>unit</code> property of the <code>Trigonometry</code>
		 * 	class, to specify that angles unit is in degrees.
		 * 
		 * 	@see #unit
		 */
		public static const DEGREE:String = "degree";
		
		/**
		 * 	A constant used to set the <code>unit</code> property of the <code>Trigonometry</code>
		 * 	class, to specify that angles unit is in grads.
		 * 
		 * 	@see #unit
		 */
		public static const GRAD:String = "grad";
		
		/**
		 * 	A constant used to set the <code>unit</code> property of the <code>Trigonometry</code>
		 * 	class, to specify that angles unit is in radians.
		 * 
		 * 	@see #unit 
		 */
		public static const RADIAN:String = "radian";
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _unit:String = RADIAN;
		/**
		 * 	Sets or gets the unit of angles used by the RPN trigonometric library.
		 * 
		 * 	<p>Possible values are defined by <code>Trigonometry</code> class constants:
		 * 		<ul>
		 * 			<li><code>Trigonometry.DEGREE</code>,</li>
		 * 			<li><code>Trigonometry.GRAD</code>,</li>
		 * 			<li><code>Trigonometry.RADIAN</code>.</li>
		 * 		</ul>
		 * 	</p>
		 * 
		 * 	@default Trigonometry.RADIAN
		 */
		public function get unit():String {
			return _unit; 
		}
		public function set unit(value:String):void {
			_unit = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _functions:Array = [
			["cosine", 0, 1, "cos",
				function(arg:Array):Number {
					return Math.cos(getValue(arg[0]));
				}
			],
			["sinine", 0, 1, "sin",
				function(arg:Array):Number {
					return Math.sin(getValue(arg[0]));
				}
			],
			["tangent", 0, 1, "tan",
				function(arg:Array):Number {
					return Math.tan(getValue(arg[0]));
				}
			],
			["involute", 0, 1, "inv",
				function(arg:Array):Number {
					return Math.tan(getValue(arg[0])) - getValue(arg[0]);
				}
			],
			["sine cardinal", 0, 1, "sinc",
				function(arg:Array):Number {
					if(arg[0] == 0) $rpnInstance.rpn_internal::setError(2);
						return Math.sin(getValue(arg[0])) / getValue(arg[0]);
					}
			],
			["hyperbolic sine", 0, 1, "sinh",
				function(arg:Array):Number {
					return (Math.exp(getValue(arg[0])) -  Math.exp( -1 * getValue(arg[0]))) / 2;
				}
			],
			["hyperbolic cosine", 0, 1, "cosh",
				function(arg:Array):Number {
					return (Math.exp(getValue(arg[0])) +  Math.exp( -1 * getValue(arg[0]))) / 2;
				}
			],
			["hyperbolic tangent", 0, 1, "tanh",
				function(arg:Array):Number {
					return (Math.exp(2 * getValue(arg[0])) - 1) / (Math.exp(2 * getValue(arg[0])) + 1);
				}
			],
			["inverse sine", 0, 1, "asin",
				function(arg:Array):Number {
					return Math.acos(getValue(arg[0])); 
				}
			],
			["inverse cosine", 0, 1, "acos",
				function(arg:Array):Number {
					return Math.asin(getValue(arg[0]));
				}
			],
			["inverse tangent", 0, 1, "atan",
				function(arg:Array):Number {
					return Math.atan(getValue(arg[0]));
				}
			],
			["inverse sine", 0, 1, "arcsin",
				function(arg:Array):Number {
					return Math.acos(getValue(arg[0]));
				}
			],
			["inverse cosine", 0, 1, "arccos",
				function(arg:Array):Number {
					return Math.asin(getValue(arg[0]));
				}
			],
			["inverse tangent", 0, 1, "arctan",
				function(arg:Array):Number {
					return Math.atan(getValue(arg[0]));
				}
			]
			];
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			var i:int = _functions.length - 1;
			for (; i >= 0; i--) {
				var obj:RpnOperator =
					new RpnOperator(_functions[i][0], _functions[i][3],
						_functions[i][1], _functions[i][2], _functions[i][4]);
				$opList.push(obj);
			}
		}
		
		private function getValue(value:Number):Number {
			switch(_unit) {
				case DEGREE :
					return Math.PI * value / 180;
					break;
				case GRAD :
					return Math.PI * value / 200;
					break;
			}
			return value;
		}
	}
}