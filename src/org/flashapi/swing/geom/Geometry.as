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

package org.flashapi.swing.geom {
	
	// -----------------------------------------------------------
	// Geometry.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/01/2008 04:29
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>Geometry</code> class is an all-static class with methods for
	 * 	working with geometric transformations within SPAS 3.0.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Geometry {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new
		 * 				Geometry instance.
		 */
		public function Geometry() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant <code>Point</code> object that always define the coordinates of
		 * 	the origin point within a 2D plane (<code>0, 0</code>).
		 */
		public static const ORIGIN:Point = new Point(0, 0);
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A convenient function to transpose the coordinates from the coordinates
		 * 	space of a <code>DisplayObject</code> to the coordinates space of another
		 * 	one.
		 * 
		 * 	@param	x	The <code>x</code> value to trancpose from a coordinates space
		 * 				to the other, in pixels.
		 * 	@param	y	The <code>y</code> value to trancpose from a coordinates space
		 * 				to the other, in pixels.
		 * 	@param	from	The <code>DisplayObject</code> that define the orgin
		 * 					coordinates space.
		 * 	@param	to	The <code>DisplayObject</code> that define the destination
		 * 					coordinates space.
		 * 
		 * 	@return	A <code>Point</code> that contains the transposed coordinates.
		 */
		public static function transposeCoordinates(x:Number, y:Number, from:DisplayObject, to:DisplayObject):Point {
			var p:Point = new Point(x, y);
			var pt:Point = from.localToGlobal(p);
			return to.globalToLocal(pt);
		}
		
		/**
		 * 	Calculates the specified value of an angle from degrees to radians.
		 * 
		 * 	@param	value	The value of the angle to convert from degrees to radians.
		 * 
		 * 	@return	The value of an angle converted from degrees to radians.
		 * 
		 * 	@see #radianToDegree()
		 */
		public static function degreeToRadian(value:Number):Number {
			return value * Math.PI / 180;
		}
		
		/**
		 * 	Calculates the specified value of an angle from radians to degrees.
		 * 
		 * 	@param	value	The value of the angle to convert from radians to degrees.
		 * 
		 * 	@return	The value of an angle converted from radians to degrees.
		 * 
		 * 	@see #degreeToRadian()
		 */
		public static function radianToDegree(value:Number):Number {
			return value * 180 / Math.PI;
		}
		
		//--> Not implemented yet.
		/*private function angleDifference(angle0:Number, angle1:Number):Number {
			return Math.abs((angle0 + 180 -  angle1) % 360 - 180);
		}*/
	}
}