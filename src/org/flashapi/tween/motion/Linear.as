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

package org.flashapi.tween.motion {

	// -----------------------------------------------------------
	// Linear.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 09/03/2010 12:11
	* @see http://www.flashapi.org/
	* credit: Based upon Robert Penner's Easing Equations v1.3 - Oct. 29, 2002
	* (c) 2002 Robert Penner.
	* @see http://www.robertpenner.com/profmx
	*/
	
	import org.flashapi.tween.core.AbstractEasing;
	import org.flashapi.tween.core.Easing;
	
	/**
	 * 	The <code>Linear</code> class defines easing functions to implement 
	 * 	non-accelerated motion with SPAS 3.0 BeeTween animations. Its methods all
	 * 	produce the same effect, a constant motion.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Linear extends AbstractEasing implements Easing {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>Linear</code> object with the 
		 * 					specified parameters.
		 * 
		 * 	@param	type	The type of "ease" process that defines this
		 * 					<code>Easing</code> object. Possible values are:
		 * 					<code>EaseType.IN</code>, <code>EaseType.OUT</code> and
		 * 					<code>EaseType.BOTH</code>.
		 * 					Default value is <code>EaseType.IN</code>.
		 */
		public function Linear(type:String = "in") {
			super(this, type);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Defines a constant motion with no acceleration.
		 * 
		 * 	@param	t	Specifies the current time, between <code>0</code> and duration
		 * 				inclusive.
		 * 	@param	b	Specifies the initial value of the animation property.
		 * 	@param	c	Specifies the total change in the animation property.
		 * 	@param	d	Specifies the duration of the motion.
		 * 
		 * 	@return	The value of the interpolated property at the specified time.
		 * 
		 *  @see http://www.robertpenner.com/profmx
		 */
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c * t / d + b;
		}
		
		/**
		 * 	@private
		 */
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c * t / d + b;
		}
		
		/**
		 * 	@private
		 */
		public static function easeBoth(t:Number, b:Number, c:Number, d:Number):Number {
			return c * t / d + b;
		}
	}
}