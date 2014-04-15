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
	// Effect.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 30/04/2009 03:20
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.tween.core.Easing;
	import org.flashapi.tween.Tween;
	
	/**
	 * 	The <code>Effect</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 effects used by <code>UIObject</code>
	 * 	instances when displayed or removed.
	 * 
	 * 	@see org.flashapi.swing.core.UIObject#displayEffect
	 * 	@see org.flashapi.swing.core.UIObject#removeEffect
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Effect extends Finalizable {
		
		/**
		 *  Forces the effect to be rendered.
		 */
		function render():void;
		
		/**
		 * 	Plays the effect.
		 * 
		 * 	@see #stop()
		 */
		function play():void;
		
		/**
		 * 	Pauses the effect.
		 * 
		 * 	@see #resume()
		 */
		function pause():void;
		
		/**
		 * 	Resumes the effect whether the <code>pause()</code> method has been
		 * 	called.
		 * 
		 * 	@see #pause()
		 */
		function resume():void;
		
		/**
		 * 	Stops the effect.
		 * 
		 * 	@see #play()
		 */
		function stop():void;
		
		/**
		 * 	Resets the effect.
		 */
		function reset():void;
		
		/**
		 *  Sets or gets the effect duration while it is rendering, in milliseconds.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.EffectException
		 * 				An <code>EffectException</code> if you try to change the
		 * 				duration of the effect while it is rendering.
		 * 
		 * 	@see #tween
		 */
		function get duration():uint;
		function set duration(value:uint):void;
		
		/**
		 * 	Sets or gets the <code>Easing</code> used by the <code>Tween</code>
		 * 	instance used to render the effect.
		 * 
		 * 	@see org.flashapi.swing.motion.effects.Easing
		 */
		function get easingFunction():Easing;
		function set easingFunction(value:Easing):void;
		
		/**
		 *  Returns the <code>Tween</code> instance used to render the effect.
		 * 
		 * 	@see org.flashapi.swing.motion.Tween;
		 */
		function get tween():Tween;
	}
}