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
	// Spring.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/07/2008 00:50
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.effect.core.AEM;
	import org.flashapi.tween.event.MotionEvent;
	
	/**
	 * 	The <code>Spring</code> class creates a springing effect.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Spring extends AEM implements Effect {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates e new <code>Spring</code> effect with 
		 * 	the specified parameters.
		 * 
		 * 	@param	target		The target container for this effect.
		 * 	@param	duration	The effect duration, in milliseconds.
		 */
		public function Spring(target:Object, duration:uint = 250) {
			super(target, duration);
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function initialize():void {
			$container.scaleX = $container.scaleY = 1;
			$start = 0; $end = 1;
		}
		
		/**
		 * 	@private
		 */
		override protected	function motionFinish(e:MotionEvent):void {
			$container.scaleX = $container.scaleY = 2;
			$container.alpha = 0;
			super.motionFinish(e);
		}
		
		/**
		 * 	@private
		 */
		override protected function motionChanged(e:MotionEvent):void {
			var v:Number = Number(e.value);
			$container.scaleX = $container.scaleY = 1 + v;
			$container.x = $target.x + ($bounds.width - $container.width)/2;
			$container.y = $target.y + ($bounds.height - $container.height) / 2;
			$container.alpha = 1 - v;
		}
	}
}