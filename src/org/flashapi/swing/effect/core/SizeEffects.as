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
	// SizeEffects.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 03/11/2010 14:42
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.tween.event.MotionEvent;
	
	/**
	 * 	The <code>FadeEffects</code> class is the base class for all resizing effects
	 * 	that change only one property (<code>width</code> or <code>height</code>) at
	 * 	time.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SizeEffects extends AEM {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>SizeEffects</code> instance with the
		 * 	specified properties.
		 * 
		 * 	@param	target	The target container for this <code>SizeEffects</code>
		 * 					object.
		 * 	@param	duration	The effect duration, in milliseconds.
		 */
		public function SizeEffects(target:Object, duration:uint) {
			super(target, duration);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected var $property:String;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function initialize():void {
			_delay = $bounds[$property] - $target[$property];
		}
		
		/**
		 * 	@private
		 */
		override protected function motionChanged(e:MotionEvent):void {
			var v:Number = Number(e.value);
			$target[$property] = v;
			$bounds[$property] = v + _delay;
			$bitmap.dispose();
			$needsBitmapRefresh = true;
			initBitmap();
			move();
			refresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _delay:Number = 0;
	}
}