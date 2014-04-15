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

package org.flashapi.tween.constant {
	
	// -----------------------------------------------------------
	// TweenSquencerAction.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 03/02/2011 13:18
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>TweenSquencerAction</code> class is an enumeration of constant
	 * 	values that are internally used by <code>TweenSequencer</code> objects to
	 * 	determine the kind of action that must be performed during the sequence.
	 * 
	 * 	@see org.flashapi.tween.TweenSequencer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class TweenSquencerAction {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 */
		public function TweenSquencerAction() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Used to specify the <code>play</code> action. The <code>play</code>
		 * 	action indicates that the <code>TweenSquencer</code> instance must call
		 * 	the <code>org.flashapi.tween.core.SequentialTween.play()</code> for all
		 * 	registred tweens.
		 * 
		 * 	@see org.flashapi.tween.core.SequentialTween#play()
		 */
		public static const PLAY:String = "play";
		
		/**
		 * 	Used to specify the <code>pause</code> action. The <code>pause</code>
		 * 	action indicates that the <code>TweenSquencer</code> instance must call
		 * 	the <code>org.flashapi.tween.core.SequentialTween.pause()</code> for all
		 * 	registred tweens.
		 * 
		 * 	@see org.flashapi.tween.core.SequentialTween#pause()
		 */
		public static const PAUSE:String = "pause";
		
		/**
		 * 	Used to specify the <code>reverse</code> action. The <code>reverse</code>
		 * 	action indicates that the <code>TweenSquencer</code> instance must call
		 * 	the <code>org.flashapi.tween.core.SequentialTween.reverse()</code> for all
		 * 	registred tweens.
		 * 
		 * 	@see org.flashapi.tween.core.SequentialTween#reverse()
		 */
		public static const REVERSE:String = "reverse";
		
		/**
		 * 	Used to specify the <code>stop</code> action. The <code>stop</code>
		 * 	action indicates that the <code>TweenSquencer</code> instance must call
		 * 	the <code>org.flashapi.tween.core.SequentialTween.stop()</code> for all
		 * 	registred tweens.
		 * 
		 * 	@see org.flashapi.tween.core.SequentialTween#stop()
		 */
		public static const STOP:String = "stop";
		
		/**
		 * 	Used to specify the <code>reset</code> action. The <code>reset</code>
		 * 	action indicates that the <code>TweenSquencer</code> instance must call
		 * 	the <code>org.flashapi.tween.core.SequentialTween.reset()</code> for all
		 * 	registred tweens.
		 * 
		 * 	@see org.flashapi.tween.core.SequentialTween#reset()
		 */
		public static const RESET:String = "reset";
	}
}