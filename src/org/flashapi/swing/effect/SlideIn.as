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

package org.flashapi.swing.effect {
	
	// -----------------------------------------------------------
	// SlideIn.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 16:21
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.Direction;
	import org.flashapi.swing.effect.core.SlideEffects;
	import org.flashapi.tween.event.MotionEvent;
	
	/**
	 * 	The <code>SlideIn</code> class creates a sliding effect that progressively
	 * 	moves an object to display it.
	 * 
	 * 	@see org.flashapi.swing.effect.SlideOut
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SlideIn extends SlideEffects implements Effect {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates e new <code>SlideIn</code> effect with 
		 * 	the specified parameters.
		 * 
		 * 	@param	target		The target container for this effect.
		 * 	@param	direction	The direction of the effect
		 * 	@param	duration	The effect duration, in milliseconds.
		 */
		public function SlideIn(target:Object, direction:String = Direction.DOWN, duration:uint = 250) {
			super(target, direction, duration);
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function motionFinish(e:MotionEvent):void {
			resetSlide();
			super.motionFinish(e);
		}
		
		/**
		 * 	@private
		 */
		override protected function initMove():void {
			switch($direction) {
				case Direction.UP :
					$initValues = [$origin.y + $bounds.height, $origin.y];
					break;
				case Direction.DOWN :
					$initValues = [$origin.y - $bounds.height, $origin.y];
					break;
			}
		}
	}
}