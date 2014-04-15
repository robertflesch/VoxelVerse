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

package org.flashapi.tween.core {
	
	// -----------------------------------------------------------
	// SequentialTween.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/05/2011 12:44
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>SequentialTween</code> interface defines the basic set of APIs  
	 * 	that you must implement to <code>ITween</code> objects that can be used 
	 * 	within a <code>TweenSequencer</code> instance.
	 * 
	 * 	@see org.flashapi.tween.TweenSequencer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface SequentialTween extends ITween {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or gets the unique identifier of the <code>SequentialTween</code>  
		 * 	object. Tween IDs are used by the <code>TweenSequencer</code> class to 
		 * 	control specific groups of <code>SequentialTween</code> objects.
		 * 
		 * 	@default ""
		 * 
		 * 	@see org.flashapi.tween.SequentialTween
		 * 
		 * 	@see #className
		 */
		function get id():String;
		function set id(value:String):void;
		
		/**
		 * 	Sets or gets the class name of the <code>SequentialTween</code> object.
		 * 	Tween class names are used by the <code>SequentialTween</code> class to
		 * 	control the animation of several <code>SequentialTween</code> objects 
		 * 	at the same time.
		 * 
		 * 	@default ""
		 * 
		 * 	@see org.flashapi.tween.SequentialTween#playTweensByClassName()
		 * 	@see org.flashapi.tween.SequentialTween#reverseTweensByClassName()
		 * 	@see org.flashapi.tween.SequentialTween#pauseTweensByClassName()
		 * 	@see org.flashapi.tween.SequentialTween#stopTweensByClassName()
		 * 	@see org.flashapi.tween.SequentialTween#resetTweensByClassName()
		 * 
		 * 	@see #id
		 */
		function get className():String;
		function set className(value:String):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Pauses the <code>SequentialTween</code> object until you call the
		 * 	<code>resume()</code> method.
		 * 
		 * 	@see #resume()
		 */
		function pause():void;
		
		/**
		 * 	Resets and force the <code>SequentialTween</code> object to play.
		 * 
		 * 	@see reverse()
		 * 	@see stop()
		 */
		function play():void;
		
		/**
		 *  Resets the <code>SequentialTween</code> object. 
		 */
		function reset():void;
		
		/**
		 *  Resumes the <code>SequentialTween</code> object after it has been
		 * 	paused by a call to the <code>pause()</code> method.
		 * 
		 * 	@see #pause()
		 */
		function resume():void;
		
		/**
		 * 	Forces the <code>SequentialTween</code> animation to play in reverse,
		 * 	starting from the current position of the playhead.
		 * 
		 * 	@see play()
		 * 	@see stop()
		 */
		function reverse():void;
		
		/**
		 * 	Interrupts the <code>SequentialTween</code> object.
		 * 
		 * 	@see play()
		 */
		function stop():void;
	}
}