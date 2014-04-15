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

package org.flashapi.tween {
	
	// -----------------------------------------------------------
	// BTween.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 27/05/2011 20:30
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.tween.core.BTweenManager;
	import org.flashapi.tween.core.TweenBase;
	
	/**
	 * 	The <code>BTween</code> class defines a tween, a property animation performed
	 * 	on a target object over a period of time.
	 * 
	 * 	<p>The <code>BTween</code> class is optimized for being used with Flash Player
	 * 	10 and latest. To use the BeeTween API with Flash Player 9, use the <code>Tween</code> 
	 * 	class instead.</p>
	 * 
	 * 	@see org.flashapi.tween.Tween
	 * 	@see org.flashapi.tween.core.Easing
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 10
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BTween extends TweenBase {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>BTween</code> instance with the 
		 * 					specified parameters.
		 * 
		 * 	@param	target	The object that is notified at each interval of the
		 * 					animation. 
		 * 	@param	start	The initial value(s) of the animation. Either a number or
		 * 					an array of numbers. If a number is passed, the animation
		 * 					interpolates between this number and the number passed in
		 * 					the <code>end</code> parameter. If an array of numbers is
		 * 					passed, each number in the array is interpolated.
		 * 	@param	end		The final value(s) of the animation. The type of the
		 * 					<code>end</code> parameter must match the type of the
		 * 					<code>start</code> parameter.
		 * 	@param	duration	The duration of the animation, in milliseconds.
		 */
		public function BTween(target:Object = null, start:* = null, end:* = null, duration:uint = 500) {
			super(BTweenManager, target, start, end, duration);
		}
	}
}