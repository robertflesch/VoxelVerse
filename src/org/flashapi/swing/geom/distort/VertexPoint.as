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

package org.flashapi.swing.geom.distort {
	
	// -----------------------------------------------------------
	// VertexPoint.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/04/2011 23:05
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	A <code>VertexPoint</code> is the point of intersection of edges the of
	 * 	a polygon.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class VertexPoint {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>VertexPoint</code> instance with the 
		 * 	specified parameters.
		 * 
		 * 	@param	x	The <code>x</code> coordinate in the scene, in pixels.
		 * 	@param	y	The <code>y</code> coordinate in the scene, in pixels.
		 * 	@param	sx	The transformed <code>x</code> coordinate on the screen,
		 * 				in pixels.
		 * 	@param	sy	The transformed <code>y</code> coordinate on the screen,
		 * 				in pixels.
		 */
		public function VertexPoint(x:Number, y:Number, sx:Number, sy:Number) {
			super();
			initObj(x, y, sx, sy);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>x</code> coordinate in the scene, in pixels.
		 */
		public var x:Number;
		
		/**
		 * 	The <code>y</code> coordinate in the scene, in pixels.
		 */
		public var y:Number;
		
		/**
		 * 	The transformed <code>x</code> coordinate on the screen, in pixels.
		 */
		public var sx:Number;
		
		/**
		 * 	The transformed <code>y</code> coordinate on the screen, in pixels.
		 */
		public var sy:Number;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(x:Number, y:Number, sx:Number, sy:Number):void {
			this.x = x;
			this.y = y;
			this.sx = sx;
			this.sy = sy;
		}
	}
}