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
	// Vector.as renamed Vector2D.as for FP10 compatibility
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/06/2008 14:56
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 	The <code>Vector2D</code> class creates objects that represent 2D geometric
	 * 	vertors defined within an Euclidean Space. A vector is what is needed to
	 * 	"carry" the point A to the point B, as follow:
	 * 
	 * 	<p><img src = "../../../../doc-images/vector-2d.gif" alt="Vector2D object
	 * 	definition." /></p>
	 * 
	 * 	<p>The magnitude (norm) of the vector is the distance between the two 
	 * 	points and the direction refers to the direction of displacement from A to B.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Vector2D {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Defines a new <code>Vector2D</code> object from the specified
		 * 	parameters.
		 * 
		 * 	@param	ax	The <code>x</code> coordinate value of the A point, in pixels.
		 * 	@param	ay	The <code>y</code> coordinate value of the A point, in pixels.
		 * 	@param	bx	The <code>x</code> coordinate value of the B point, in pixels.
		 * 	@param	by	The <code>y</code> coordinate value of the B point, in pixels.
		 */
		public function Vector2D(ax:Number = 0, ay:Number = 0, bx:Number = 0, by:Number = 0) {
			super();
			initObj(ax, ay, bx, by);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>x</code> coordinate value of the A point, in pixels.
		 */
		public var ax:Number;
		
		/**
		 * 	The <code>y</code> coordinate value of the A point, in pixels.
		 */
		public var ay:Number;
		
		/**
		 * 	The <code>x</code> coordinate value of the B point, in pixels.
		 */
		public var bx:Number;
		
		/**
		 * 	The <code>y</code> coordinate value of the B point, in pixels.
		 */
		public var by:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a rectangle that represents the area defined by the <code>Vector2D</code>
		 * 	instance, within the Flash Player regular two-dimensional plane.
		 * 
		* 	<p><img src = "../../../../doc-images/vector-2d.gif" alt="Vector2D object
		* 	definition." /></p>
		 * 
		 * 	@return The area defined by this <code>Vector2D</code> object.
		 */
		public function getRect():Rectangle {
			var r:Rectangle = new Rectangle(ax, ay, bx, by);
			return r;
		}
		
		/**
		 * 	Returns the norm of this <code>Vector2D</code> object.
		 * 
		 * 	@return The norm of the vector.
		 */
		public function getNorm():Number {
			return Point.distance(new Point(ax, ay), new Point(bx, by));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(ax:Number, ay:Number, bx:Number, by:Number):void {
			this.ax = ax;
			this.ay = ay;
			this.bx = bx;
			this.by = by;
		}
	}
}