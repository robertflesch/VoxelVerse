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

package org.flashapi.swing.fx.basicfx.firelib {
	
	// -----------------------------------------------------------
	// FireFxDTO.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/07/2008 14:22
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The FireFxDTO class lets you create a data transfert object to set the parameters
	 * 	of FireFx instances filters. The FireFx class uses a <code>ColorMatrixFilter</code>
	 * 	object and a <code>ColorTransform</code> object to draw the fire effect.
	 * 
	 * 	<p>By setting the <code>redOffset</code>, <code>greenOffset</code> and <code>blueOffset</code>
	 * 	properties of the FireFxDTO object, you will change the corresponding properties of the
	 * 	<code>ColorTransform</code> object used by the associated FireFx instance.</p>
	 * 
	 * 	<p>To change the values of the <code>ColorMatrixFilter</code> object used by the
	 * 	associated FireFx instance, you can set the FireFxDTO object's parameters. The following
	 * 	figure illustrates how these parameters will affect the <code>ColorMatrixFilter</code>.
	 * 	Each line represents a line of the 4 x 5 matrix, from the first to the last. As the "alpha
	 * 	result" line can not be changed, it is represented by the letter N:</p>
	 * 	<pre>
	 * 		| redR - redFadeMult &#42; fadeRate | redG | redB | redA | redO |
	 * 		| greenR | greenG - greenFadeMult &#42; fadeRate | greenB | greenA | greenO |
	 * 		| blueR | blueG | blueB - blueFadeMult &#42; fadeRate | blueA | blueO |
	 * 		| N | N | N | N | N |
	 * 	</pre>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 */
	public class FireFxDTO extends Object {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new FireFx data transfert object to set FireFx's
		 * 	filters parameters.
		 */
		public function FireFxDTO() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The offset value for the red color channel of the FireFx's ColorTransform object,
		 * 	in the range from -255 to 255.
		 * 
		 * 	@default 255
		 */
		public var redOffset:Number = 255;
		
		/**
		 * 	The offset value for the green color channel of the FireFx's ColorTransform object,
		 *	in the range from -255 to 255. 
		 * 
		 * 	@default 255
		 */
		public var greenOffset:Number = 255;
		
		/**
		 * 	The offset value for the blue color channel of the FireFx's ColorTransform object,
		 * 	in the range from -255 to 255.
		 * 
		 * 	@default 210
		 */
		public var blueOffset:Number = 210;
		
		/**
		 * 	
		 * 	@default 0.35
		 */
		public var redFadeMult:Number = 0.35;
		
		public var greenFadeMult:Number = 0.45;
		
		public var blueFadeMult:Number = 0.55;
		
		public var redR:Number = 0.96;
		
		public var redG:Number = 0.1;
		
		public var redB:Number = 0;
		
		public var redA:Number = 0;
		
		public var redO:Number = -1;
		
		public var greenR:Number = 0;
		
		public var greenG:Number = 0.9;
		
		public var greenB:Number = 0;
		
		public var greenA:Number = 0;
		
		public var greenO:Number = 0;
		
		public var blueR:Number = 0;
		
		public var blueG:Number = 0;
		
		public var blueB:Number = 0.8;
		
		public var blueA:Number = 0;
		
		public var blueO:Number = 0;
	}
}