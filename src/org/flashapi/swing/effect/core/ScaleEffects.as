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

package org.flashapi.swing.effect.core {
	
	// -----------------------------------------------------------
	// ScaleEffects.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/12/2008 02:41
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.tween.event.MotionEvent;
	
	/**
	 * 	The <code>ScaleEffects</code> class is the base class for all scaling effects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ScaleEffects extends AEM {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ScaleEffects</code> instance with the
		 * 	specified properties.
		 * 
		 * 	@param	target	The target container for this <code>ScaleEffects</code>
		 * 					object.
		 * 	@param	duration	The effect duration, in milliseconds.
		 */
		public function ScaleEffects(target:Object, duration:uint) {
			super(target, duration);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function motionChanged(e:MotionEvent):void {
			move();
			$container.scaleX = $container.scaleY = e.value as Number;
			$container.x = $target.x + ($bounds.width - $container.width)/2;
			$container.y = $target.y + ($bounds.height - $container.height)/2;
		}
	}
}