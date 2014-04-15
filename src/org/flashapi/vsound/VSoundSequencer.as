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

package org.flashapi.vsound {
	
	// -----------------------------------------------------------
	// VSoundSequencer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 06/12/2010 20:04
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.flashapi.vsound.lib.FireBirdRenderer;
	import org.flashapi.vsound.lib.PondRenderer;
	import org.flashapi.vsound.lib.StarRenderer;
	import org.flashapi.vsound.lib.ThunderBoltRenderer;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when a <code>SpectrumRenderer</code> effect is replaced by
	 * 	another one from the internal library stack.
	 *
	 *  @eventType org.flashapi.vsound.SequencerEvent.LIBRARY_UPDATE
	 */
	[Event(name = "libraryUpdate", type = "org.flashapi.vsound.SequencerEvent")]
	
	/**
	 * 	The <code>VSoundSequencer</code> control allows to create and manage a
	 * 	set of several compute spectrum renderers. Compute spectrum effects can
	 * 	successively be displayed for a specified time, or can be programmatically
	 * 	controled.
	 * 
	 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
	 * 	@see org.flashapi.vsound.lib.StarRenderer
	 * 	@see org.flashapi.vsound.VSoundSequencer
	 * 
	 * 	@includeExample VSoundSequencerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class VSoundSequencer extends Sprite implements VSoundDisplayObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>VSoundSequencer</code> instance with the 
		 * 	specified parameters.
		 * 
		 * 	@param	width	The width of the <code>VSoundSequencer</code> instance,
		 * 					in pixels. The default value is <code>400</code> pixels.
		 * 	@param	height	The height of the <code>VSoundSequencer</code> instance,
		 * 					in pixels. The default value is <code>250</code> pixels.
		 * 
		 */
		public function VSoundSequencer(width:Number = 400, height:Number = 250) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Accessors
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies the amount of time, in miliseconds, during which the current
		 * 	compute spectrum effect is rendered by this sequencer.
		 * 
		 * 	@default 20000
		 */
		public function get duration():uint {
			return _duration;
		}
		public function set duration(value:uint):void {
			_duration = value;
			var isPlaying:Boolean = _isPlaying;
			this.stop();
			if (isPlaying) this.play();
		}
		
		/**
		 * 	@inheritDoc
		 */
		override public function get height():Number {
			return _height;
		}
		
		/**
		 * 	@inheritDoc
		 */
		override public function get width():Number {
			return _width;
		}
		
		/**
		 * 	Indicates the playing mode used by this <code>VSoundSequencer</code> object.
		 * 	Possible values are constants of the <code>SequencerMode</code> class:
		 * 	<ul>
		 * 		<li><code>SequencerMode.AUTOMATIC</code>,</li>
		 * 		<li><code>SequencerMode.MANUAL</code>.</li>
		 * 	</ul>
		 * 
		 * 	<p>The playing mode defines the way the sequence of effects is displayed.
		 * 	If <code>SequencerMode.AUTOMATIC</code>, effects are successively displayed
		 * 	for the time specified by the <code>duration</code> parameter.
		 * 	If <code>SequencerMode.MANUAL</code>, effects are displayed each time the
		 * 	<code>next()</code> or <code>previous()</code> functions are called.</p>
		 * 
		 * 	@default SequencerMode.AUTOMATIC
		 * 
		 * 	@see org.flashapi.vsound.SequencerMode
		 * 	@see #next()
		 * 	@see #previous()
		 * 	@see #duration
		 */
		public function get mode():String {
			return _mode;
		}
		public function set mode(value:String):void {
			_mode = value;
			if (_seqRef < 0 && _mode == SequencerMode.AUTOMATIC) {
				_seqRef = setInterval(updateLib, _duration);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a <code>SpectrumRenderer</code> library class to the effects sequence.
		 * 
		 * 	@see #removeAllLibs()
		 * 	@see #addLibCollection()
		 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
		 */
		public function addLib(rendererLib:Class):void {
			_libStack.push(rendererLib);
		}
		
		/**
		 * 	Removes all the <code>SpectrumRenderer</code> library classes from the
		 * 	effects sequence and stops the current effect rendering.
		 * 
		 * 	<p><strong>If the effects sequence list is empty when you call the 
		 * 	<code>play()</code> method, nothing will happen. In that case, 
		 * 	<code>isPlaying()</code>method will always return <code>false</code>.
		 * 	</strong></p>
		 * 	
		 * 	@see #addLib()
		 * 	@see #addLibCollection()
		 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
		 */
		public function removeAllLibs():void {
			this.stop();
			_libStack = [];
		}
		
		/**
		 * 	Adds a collection of <code>SpectrumRenderer</code> library classes to the
		 * 	effects sequence.
		 * 	
		 * 	@param	collection 	An array that contains a collection of the
		 * 						<code>SpectrumRenderer</code> library classes to add.
		 * 
		 * 	@see #addLib()
		 * 	@see #removeAllLibs()
		 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
		 */
		public function addLibCollection(collection:Array):void {
			_libStack = _libStack.concat(collection);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function isPlaying():Boolean {
			return _isPlaying;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function play():void {
			if (_isPlaying || _libStack.length == 0) return;
			_isPlaying = true;
			_vSound.play();
			if(_mode == SequencerMode.AUTOMATIC) _seqRef = setInterval(updateLib, _duration);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function stop():void {
			if (!_isPlaying) return;
			_isPlaying = false;
			if (_seqRef > 0) clearInterval(_seqRef);
			_seqRef = -1;
			_vSound.stop();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			_width = width;
			_height = height;
			_vSound.resize(width, height);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function dispose():void {
			this.stop();
			this.removeChild(_vSound);
			_vSound.dispose();
			_vSound = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	A Number that stores the VSoundSequencer width.
		 */
		private var _width:Number;
		
		/**
		 * 	@private
		 * 
		 * 	A Number that stores the VSoundSequencer height.
		 */
		private var _height:Number;
		
		/**
		 * 	@private
		 * 
		 * 	A reference to the VSound object for this VSoundSequencer.
		 */
		private var _vSound:VSound;
		
		/**
		 * 	@private
		 * 
		 * 	An array of SpectrumRenderer libraries used to set the sequence of effects
		 * 	used by the VSound object.
		 */
		private var _libStack:Array;
		
		/**
		 * 	@private
		 * 
		 * 	An Integer used to store the reference to the interval closure function.
		 */
		private var _seqRef:int;
		
		/**
		 * 	@private
		 * 
		 * 	An Integer that indicates the current position of the cursor in the _libStack
		 * 	array.
		 */
		private var _libCursor:uint;
		
		/**
		 * 	@private
		 * 
		 * 	An Integer that represents the duration of each SpectrumRenderer effect
		 * 	rendering.
		 */
		private var _duration:uint;
		
		/**
		 * 	@private
		 * 
		 * 	A string that represents the displaying mode of the VSoundSequencer.
		 */
		private var _mode:String;
		
		/**
		 * 	@private
		 * 
		 * 	A Boolean value that indicates whether the VSoundSequencer is playing
		 * 	(true), or not (false).
		 */
		private var _isPlaying:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Initializes the VSoundSequencer object. This method is called from the
		 * 	constructor function.
		 * 
		 * 	@param	width	The width of the <code>VSoundSequencer</code> instance.
		 * 	@param	height	The height of the <code>VSoundSequencer</code> instance.
		 */
		private function initObj(width:Number, height:Number):void {
			_width = width;
			_height = height;
			_vSound = new VSound(_width, _height);
			this.addChild(_vSound);
			_libStack = [StarRenderer, PondRenderer, ThunderBoltRenderer, FireBirdRenderer];
			_seqRef = -1;
			_libCursor = 0;
			_isPlaying = false;
			_duration = 20000;
			_mode = SequencerMode.AUTOMATIC;
			updateLib();
		}
		
		/**
		 * 	@private
		 * 
		 * 	Replaces the current SpectrumRenderer library by the next one contained in
		 * 	the _libStack array.
		 */
		private function updateLib():void {
			_vSound.setRendererLib(_libStack[_libCursor]);
			_libCursor++;
			if (_libCursor >= _libStack.length) _libCursor = 0;
			this.dispatchEvent(new SequencerEvent(SequencerEvent.LIBRARY_UPDATE));
		}
	}
}