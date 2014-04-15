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

package org.flashapi.vsound.util {
	
	// -----------------------------------------------------------
	// Geom.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/11/2010 13:54
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	
	/**
	 * 	The <code>Geom</code> is a utility class that provides methods and properties
	 * 	for working with geometric objects within the VSound project.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class Geom {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	Constructor.
		 */
		public function Geom() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A <code>Point</code> object used to set the <code>(0, 0)</code> destination
		 * 	point when applying a <code>BitmapFilter</code> to the <code>VSound</code>
		 * 	bitmapdata. This constants is typically used within the <code>update()</code>
		 * 	method of a <code>SpectrumRenderer</code> instance.
		 * 
		 * 	@see org.flashapi.vsound.VSound
		 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
		 */
		public static const ORIGIN:Point = new Point(0, 0);
	}
}