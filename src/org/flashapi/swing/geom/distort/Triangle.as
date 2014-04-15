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
	
	import flash.geom.Matrix;
	
	/**
	 * 	The <code>Triangle</code> class generates triangle objects used to tesselate
	 * 	<code>BitmapData</code> within a <code>Distortion</code> instance.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.6
	 */
	public class Triangle {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>Triangle</code> object with the
		 * 					specified parameters.
		 * 
		 * 	@param	vertex0	Specifies the first vertex point of this <code>Triangle</code>
		 * 					object.
		 * 	@param	vertex1	Specifies the second vertex point of this <code>Triangle</code>
		 * 					object.
		 * 	@param	vertex2	Specifies the third vertex point of this <code>Triangle</code>
		 * 					object.
		 */
		public function Triangle(vertex0:VertexPoint, vertex1:VertexPoint, vertex2:VertexPoint) {
			super();
			initObj(vertex0, vertex1, vertex2);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A <code>Vertex</code> object; specifies the first vertex point of this
		 * 	<code>Triangle</code> object.
		 */
		public var vertex0:VertexPoint;
		
		/**
		 * 	A <code>Vertex</code> object; specifies the second vertex point of this
		 * 	<code>Triangle</code> object.
		 */
		public var vertex1:VertexPoint;
		
		/**
		 * 	A <code>Vertex</code> object; specifies the third vertex point of this
		 * 	<code>Triangle</code> object.
		 */
		public var vertex2:VertexPoint;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(vertex0:VertexPoint, vertex1:VertexPoint, vertex2:VertexPoint):void {
			this.vertex0 = vertex0;
			this.vertex1 = vertex1
			this.vertex2 = vertex2;
		}
	}
}