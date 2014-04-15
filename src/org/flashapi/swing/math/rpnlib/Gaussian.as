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
	// Gaussian.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @author Romain AMALBERTI, Stephane CHARPENTIER
	* @version beta 0.9, 19/05/2008 12:29
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.math.rpn.rpn_internal;
	import org.flashapi.swing.math.rpn.RpnOperator;
	
	use namespace rpn_internal;
	
	/**
	 * 	The <code>Gaussian</code> class library provides an extended set of functions
	 * 	to work with Gaussian functions within <code>RpnExp</code> instances.
	 * 	
	 * 	<p>The following table lists the functions that are defined by the
	 * 	<code>Gaussian</code> class:</p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Name</th>
	 * 			<th>Math notation</th>
	 * 			<th>Syntax</th>
	 * 			<th>Description</th>
	 * 			
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Gaussian function</td>
	 * 			<td><img src = "../../../../../doc-images/gauss_1.gif" alt="Gaussian function" /></td>
	 * 			<td><code>gauss_1(x; a; b; c)</code></td>
	 * 			<td>
	 * 				The one dimension Gaussian function.<br />
	 * 				The parameter <code>a</code> is the height of the Gaussian peak,
	 * 				<code>b</code> is the position of the center of the peak, and
	 * 				<code>c</code> controls the width of the "bump".<br />
	 * 				Throws an <code>RpnException</code> error if <code>a</code> or <code>c</code>
	 * 				are lower than or equal to <code>0</code>.
	 * 			</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td>Gaussian two-dimensional function</td>
	 * 			<td><img src = "../../../../../doc-images/gauss_2.gif" alt="Gaussian function" /></td>
	 * 			<td><code>gauss_2(x; y; A; a; b; c; y0; y0)</code></td>
	 * 			<td>
	 * 				The two dimensions Gaussian function.<br />
	 * 				Where the matrix <code>[a,b;b,c]</code> is positive-definite.<br />
	 * 				Throws an <code>RpnException</code> error if the matrix <code>[a,b;b,c]</code>
	 * 				is not positive-definite.
	 * 			</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	<p>For more information, see the <a href="http://en.wikipedia.org/wiki/Gaussian_function">
	 * 	"Gaussian function"</a> article on Wikipedia.</p>
	 * 
	 * 	@see org.flashapi.swing.math.RpnExp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Gaussian extends RpnLibraryBase implements RpnLibrary {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Gaussian</code> instance.
		 */
		public function Gaussian() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			var gauss_1:Function = function(arg:Array):Number {
				var x:Number = arg[3];
				var a:Number = arg[2];
				var b:Number = arg[1];
				var c:Number = arg[0];
				if (a <= 0 || c <= 0) $rpnInstance.rpn_internal::setError(3);
				var v:Number = a * Math.exp(Math.pow((x - b), 2) / Math.pow((Math.sqrt(2) * c), 2));
				return v;
			}
			var obj:RpnOperator = new RpnOperator("Gaussian function", "gauss_1", 0, 4, gauss_1);
			$opList.push(obj);
			
			var gauss_2:Function = function(arg:Array):Number {
				var x:Number = arg[7];
				var y:Number = arg[6];
				var A:Number = arg[5];
				var a:Number = arg[4];
				var b:Number = arg[3];
				var c:Number = arg[2];
				var x0:Number = arg[1];
				var y0:Number = arg[0];
				var dSqrt:Number = Math.sqrt((Math.pow(a, 2) - 2 * a * c + 4 * Math.pow(b, 2) + Math.pow(c, 2)));
				if ((a + c - dSqrt) /2 <= 0 || (a + c + dSqrt) /2 <= 0) $rpnInstance.rpn_internal::setError("The matrix [a,b;b,c] is not positive-definite.");
				
				var v:Number = A * Math.exp( -( a * Math.pow((x - x0), 2) + b * (x - x0) * (y - y0) + c * Math.pow((y - y0), 2)));
				return v;
			}
			obj = new RpnOperator("Gaussian 2-D function", "gauss_2", 0, 8, gauss_2);
			$opList.push(obj);
		}
	}
}