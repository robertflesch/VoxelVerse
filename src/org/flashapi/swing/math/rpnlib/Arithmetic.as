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
	// Arithmetic.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @author Stephane CHARPENTIER
	* @version 1.0.0, 16/05/2008 19:08
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.math.rpn.RpnOperator;
	
	/**
	 * 	The <code>Arithmetic</code> class library provides an extended set of functions
	 * 	to work with basic mathematical arithmetic operations within <code>RpnExp</code>
	 * 	instances.
	 * 
	 * 	<p>The following table lists the functions that are defined by the <code>Arithmetic</code>
	 * 	class:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Name</th>
	 * 			<th>Math notation</th>
	 * 			<th>Syntax</th>
	 * 			<th>Description</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Greatest common divisor</td>
	 * 			<td>gcd(a,b)</td>
	 * 			<td><code>gcd(a;b)</code></td>
	 * 			<td>Computes and returns the largest positive integer that divides both
	 * 			numbers, <code>a</code> and <code>b</code>, without remainder.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Least common multiple</td>
	 * 			<td>lcm(a,b)</td>
	 * 			<td><code>lcm(a;b)</code></td>
	 * 			<td>Computes and returns the smallest positive integer that is a multiple
	 * 			of both numbers, <code>a</code> and <code>b</code>.</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.math.RpnExp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Arithmetic extends RpnLibraryBase implements RpnLibrary {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Arithmetic</code> instance.
		 */
		public function Arithmetic() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		private var _func:Array = [
			["greatest common divisor", 0, 2, "gcd", gcd],
			["least common multiple", 0, 2, "lcm", lcm]
		];
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			var i:int = _func.length - 1;
			for (; i >= 0; i--) {
				var obj:RpnOperator =
					new RpnOperator(_func[i][0], _func[i][3],
					_func[i][1], _func[i][2], _func[i][4]);
				$opList.push(obj);
			}
		}
		
		private function gcd(arg:Array):Number {
			var min:Number = Math.min(Math.abs(arg[1]), Math.abs(arg[0]));
			var max:Number = Math.max(Math.abs(arg[1]), Math.abs(arg[0]));
			if (min == 0) return max;
			else if (max == 0) return min;
			else return Math.abs(this.gcd([min, max % min]));
		}
		
		private function lcm(arg:Array):Number {
			var a:Number = arg[1];
			var b:Number = arg[0];
			if (a == 0 || b == 0) return 0;
			else return Math.abs(a * b / gcd([a, b]));
		}
	}
}