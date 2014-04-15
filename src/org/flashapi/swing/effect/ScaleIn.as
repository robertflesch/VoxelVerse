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
	// ScaleIn.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 16:21
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.effect.core.ScaleEffects;
	import org.flashapi.tween.event.MotionEvent;
	
	/**
	 * 	The <code>ScaleIn</code> class creates a scale effect from 0 to 100% where
	 * 	the motion is defined by linear progression.
	 * 
	 * 	@see org.flashapi.swing.effect.ScaleOut
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ScaleIn extends ScaleEffects implements Effect {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates e new <code>ScaleIn</code> effect with 
		 * 	the specified parameters.
		 * 
		 * 	@param	target		The target container for this effect.
		 * 	@param	duration	The effect duration, in milliseconds.
		 */
		public function ScaleIn(target:Object, duration:uint = 300) {
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
			$container.scaleX = $container.scaleY = 0;
			$start = 0;
			$end = 1;
		}
		
		/**
		 * 	@private
		 */
		override protected	function motionFinish(e:MotionEvent):void {
			$container.scaleX = $container.scaleY = 1;
			super.motionFinish(e);
		}
	}
}