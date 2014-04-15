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
	// Segment.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/11/2010 17:24
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	
	/**
	 * 	A convenient class to define and work with segments within the SPAS 3.0 API.
	 * 	A line segment is a part of a line that is bounded by two end points, A and B,
	 * 	and contains every point on the line between its end points:
	 * 
	 * 	<p><img src = "../../../../doc-images/segment.gif" alt="Segment object definition." /></p>
	 * 
	 * 	<p>The length of the segment is the distance between these two points.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public final class Segment {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Defines a new <code>Segment</code> object from the specified
		 * 	parameters.
		 * 
		 * 	@param	ax	The <code>x</code> coordinate value of the A point, in pixels.
		 * 	@param	ay	The <code>y</code> coordinate value of the A point, in pixels.
		 * 	@param	bx	The <code>x</code> coordinate value of the B point, in pixels.
		 * 	@param	by	The <code>y</code> coordinate value of the B point, in pixels.
		 */
		public function Segment(ax:Number = 0, ay:Number = 0, bx:Number = 0, by:Number = 0) {
			super();
			initObj(ax, ay, bx, by);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _a:Point;
		/**
		 * 	sets or gets the start <code>Point</code> (A point) of the segment.
		 * 
		 * 	@see #b
		 */
		public function get a():Point {
			return _a;
		}
		public function set a(value:Point):void {
			_a = value;
		}
		
		private var _b:Point;
		/**
		 * 	sets or gets the end <code>Point</code> (B point) of the segment.
		 * 
		 * 	@see #b
		 */
		public function get b():Point {
			return _b;
		}
		public function set b(value:Point):void {
			_b = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Changes the coordinates of this <code>Segment</code> object.
		 * 
		 * 	@param	ax	The <code>x</code> coordinate value of the A point, in pixels.
		 * 	@param	ay	The <code>y</code> coordinate value of the A point, in pixels.
		 * 	@param	bx	The <code>x</code> coordinate value of the B point, in pixels.
		 * 	@param	by	The <code>y</code> coordinate value of the B point, in pixels.
		 */
		public function define(ax:Number = 0, ay:Number = 0, bx:Number = 0, by:Number = 0):void {
			_a.x = ax;
			_a.y = ay;
			_b.x = bx;
			_b.y = by;
		}
		
		/**
		 * 	Returns the length of the <code>Segment</code> object, in pixels.
		 * 
		 * 	@return	The length of the segment.
		 */
		public function getLength():Number {
			return Point.distance(_a, _b);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(ax:Number, ay:Number, bx:Number, by:Number):void {
			_a = new Point();
			_b = new Point;
			this.define(ax, ay, bx, by);
		}
	}
}