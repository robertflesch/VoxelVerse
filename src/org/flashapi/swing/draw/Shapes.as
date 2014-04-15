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

package org.flashapi.swing.draw {
	
	// -----------------------------------------------------------
	// Shapes.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/12/2008 16:38
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.exceptions.IndexOutOfBoundsException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.geom.Geometry;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>Shapes</code> class extends the drawing capabilities of the
	 * 	<code>Figure</code> class by adding new methods for drawing more shapes,
	 * 	shuch as stars, etc..
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Shapes extends Figure {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Shapes</code> instance for the specified
		 * 	target.
		 * 
		 * 	@param	target	A <code>Sprite</code> or a <code>Shape</code> where the
		 * 					<code>Figure</code> object is drawn.
		 */
		public function Shapes(target:*) {
			super(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Draws a star shape with the specified parameters.
		 * 
		 * 	@param	points	The number of vertices on the star.
		 * 	@param	radius	The radius the star where vertices are anchored, in pixels.
		 * 	@param	innerRadius	The radius of the inside vertices of the star.
		 * 	@param	angle	The offet angle that the start is rotated, in degrees.
		 * 	@param	cx	The distance by which to translate the center of the star along
		 * 				the x axis.
		 * 	@param	cy	The distance by which to translate the center of the star along
		 * 				the y axis.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.IndexOutOfBoundsException
		 * 				An <code>IndexOutOfBoundsException</code> if the <code>points</code>
		 * 				parameter is lower than <code>3</code>.
		 */
		public function drawStar(points:uint, radius:Number, innerRadius:Number, angle:Number = 0, cx:Number = 0, cy:Number = 0):void {
			if (points < 3) {
				throw new IndexOutOfBoundsException(
					Locale.spas_internal::ERRORS["GET_OUT_OF_RANGE_ERROR"]("points", points)
					)
			} else {
				var n:Number;
				var dx:Number;
				var dy:Number;
				var step:Number = (Math.PI * 2) / points;
				var halfStep:Number = step / 2;
				var start:Number = Geometry.radianToDegree(angle); //(angle / 180) * Math.PI; 
				var ir:Number = innerRadius;
				$gfx.moveTo(cx + radius + (Math.cos(start) * radius), cy + radius - (Math.sin(start) * radius));
				for (n = 1; n <= points; n++) { 
					dx = cx + radius + Math.cos(start + (step * n) - halfStep) * ir;
					dy = cy + radius - Math.sin(start + (step * n) - halfStep) * ir;
					$gfx.lineTo(dx, dy);
					dx = cx + radius + Math.cos(start + (step * n)) * radius;
					dy = cy + radius - Math.sin(start + (step * n)) * radius;
					$gfx.lineTo(dx, dy);
				}
			}
		}
	}
}