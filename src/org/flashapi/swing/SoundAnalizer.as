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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	//  SoundAnalizer.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version beta 3, 18/06/2009 21:01
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.border.AbstractBorder;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.MediaEvent;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.managers.MediaRessourceManager;
	import org.flashapi.swing.media.MediaRessourceUser;
	import org.flashapi.swing.sound.analizer.AnalizerLibrary;
	import org.flashapi.swing.sound.analizer.DefaultAnalizer;
	import org.flashapi.swing.sound.SoundAnalizerDTO;
	import org.flashapi.swing.sound.XSound;
	import org.flashapi.swing.util.InterfaceValidator;
	
	use namespace spas_internal;
	
	[IconFile("SoundAnalizer.png")]
	
	/**
	 * 	<img src="SoundAnalizer.png" alt="SoundAnalizer" width="18" height="18"/>
	 * 
	 *	The <code>SoundAnalizer</code> class creates onjects that display a visual
	 * 	representation of a sound. The <code>AnalizerLibrary</code> interface lets
	 * 	you create your own libraries of <code>SoundSpectrum</code> objects that
	 * 	can be rendered through a <code>SoundAnalizer</code> instance.
	 * 
	 *  @includeExample SoundAnalizerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SoundAnalizer extends AbstractBorder implements MediaRessourceUser, Initializable  {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>SoundAnalizer</code> instance with
		 * 					the specified parameters.
		 * 
		 * 	@param	sound 	The <code>XSound</code> instance that will be visually
		 * 					rendered by using this <code>SoundAnalizer</code> instance.
		 * 	@param	width 	The width of the <code>SoundAnalizer</code> instance, in
		 * 					pixels.
		 * 	@param	height 	The height of the <code>SoundAnalizer</code> instance, in
		 * 					pixels.
		 */
		public function SoundAnalizer(sound:XSound = null, width:Number = 300, height:Number = 80) {
			super();
			initObj(sound, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function set color(value:*):void {
			print(
				Locale.spas_internal::ERRORS["GET_DEPRECATED_PROP_WARNING_MESSAGE"]("color", "backgroundColor")
			);
		}
		
		/**
		 *  @private
		 */
		override public function set texture(value:*):void {
			print(
				Locale.spas_internal::ERRORS["GET_DEPRECATED_PROP_WARNING_MESSAGE"]("texture", "backgroundTexture")
			);
		}
		
		/**
		 *  @private
		 */
		override public function set gradientMode(value:Boolean):void {
			print(
				Locale.spas_internal::ERRORS["GET_DEPRECATED_PROP_WARNING_MESSAGE"]("gradientMode", "backgroundGradientMode")
			);
		}
		
		/**
		 *  @private
		 */
		override public function set gradientProperties(value:Object):void {
			print(
				Locale.spas_internal::ERRORS["GET_DEPRECATED_PROP_WARNING_MESSAGE"]("gradientProperties", "backgroundGradientProperties")
			);
		}
		
		private var _sound:XSound;
		/**
		 * 	Sets or gets the <code>XSound</code> instance that will be visually
		 * 	rendered by using this <code>SoundAnalizer</code> instance.
		 */
		public function get sound():XSound {
			return _sound;
		}
		public function set sound(value:XSound):void {
			removeSoundEvents();
			_sound = _soundDTO.sound = value;
			createSoundEvents();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Override sizing API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {
			$backgroundTextureManager.height = $height = value;
			super.height = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			$backgroundTextureManager.width = value;
			super.width = value;
		}
		
		/**
		 * 	@private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = ($borderStyle == BorderStyle.NONE) ?
				spas_internal::background.getBounds(spas_internal::getCoordinateSpace(targetCoordinateSpace)) :
				spas_internal::borders.getBounds(spas_internal::getCoordinateSpace(targetCoordinateSpace))
			return r;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Set the the <code>AnalizerLibrary</code> instance to be used to render
		 * 	the <code>XSound</code> object associated to this <code>SoundAnalizer</code>
		 * 	instance.
		 * 
		 * 	@param	value	A reference to a <code>Class</code> object that implements
		 * 					the <code>AnalizerLibrary</code> interface.
		 * 
		 * 	@throws	org.flashapi.swing.exceptions.InvalidInheritanceException An
		 * 	<code>InvalidInheritanceException</code> error if the <code>value</code>
		 * 	parameter does not implement the <code>AnalizerLibrary</code> interface.
		 * 
		 * 	@see #setLibrary()
		 * 	@see org.flashapi.swing.sound.analizer.AnalizerLibrary
		 */
		public function setLibrary(value:Class):void {
			if (_library != null) {
				_library.finalize(_soundDTO);
				_library = null;
			}
			InterfaceValidator.validate(
				value, "org.flashapi.swing.sound.analizer::AnalizerLibrary",
				Locale.spas_internal::ERRORS.SOUND_ANALYSER_LIB_ERROR
			);
			_library = new value();
			_library.initSpectrum(_soundDTO);
			$backgroundColor = _library.getBackgroundColor();
			$backgroundTextureManager.gradientProperties = _library.getGradientProperties();
			$backgroundGradientMode = _library.getGradientMode();
			$borderStyle = _library.getBorderStyle();
			_timer.delay = _library.getRessourceManagerDelay();
		}
		
		/**
		 * 	Returns a reference to the <code>AnalizerLibrary</code> instance
		 * 	that is currently used by this <code>SoundAnalizer</code> instance to
		 * 	visually render a <code>XSound</code> object.
		 * 
		 * 	@return The <code>AnalizerLibrary</code> instance that currently
		 * 			visually renders the associated <code>XSound</code> object.
		 * 
		 * 	@see #setLibrary()
		 */
		public function getLibrary():AnalizerLibrary {
			return _library;
		}
		
		/**
		 * @inheritDoc
		 */
		public function updateAfterEvent():void {
			if (_sound != null) updateSpectrum();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			_timer.stop();
			//_byteArray.clear();
			MediaRessourceManager.spas_internal::removeFromMediaStack(this);
			if (_library != null) {
				_library.finalize(_soundDTO);
				_library = null;
			}
			_soundDTO.spas_internal::finalize();
			_byteArray = null;
			_soundEvtColl.finalize();
			_soundEvtColl = null;
			$borderDecorator.finalize();
			if (_sound != null) _sound = null;
			super.finalize();
		}
		
		/**
		 *  Removes this <code>SoundAnalizer</code> instance from the <code>MediaRessourceManager</code>
		 * 	stack. Once the <code>SoundAnalizer</code> instance has been "freezed" the
		 * 	associated <code>XSound</code> object is no longer rendered. To render
		 * 	the <code>XSound</code> object again, use the <code>unfreeze()</code> method.
		 * 
		 * 	@see #unfreeze()
		 */
		public function freeze():void {
			MediaRessourceManager.spas_internal::removeFromMediaStack(this);
		}
		
		/**
		 *  Add this <code>SoundAnalizer</code> instance to the <code>MediaRessourceManager</code>
		 * 	stack, if it has been previously removed by using the <code>freeze()</code>
		 * 	method.
		 * 
		 * 	@see #freeze()
		 */
		public function unfreeze():void {
			MediaRessourceManager.spas_internal::addToMediaStack(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			$borderDecorator.drawBackground();
			$borderDecorator.drawBorders();
			drawMask();
			updateSize();
			setEffects();
		}
		
		private function updateSize():void {
			var needLibUpdate:Boolean = (_soundDTO.width != $width || _soundDTO.height != $height);
			_soundDTO.spas_internal::setSize($width, $height);
			if (needLibUpdate) _library.resizeSpectrum(_soundDTO);
		}
		
		/**
		 *  @private
		 */
		protected function drawMask():void {
			var f:Figure = Figure.setFigure(_contentMask);
			f.clear();
			f.beginFill(0);
			f.drawRectangle(0, 0, $width, $height);
			f.endFill();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _byteArray:ByteArray; 
		private var _contentMask:Shape;
		private var _soundEvtColl:EventCollector;
		private var _library:AnalizerLibrary;
		private var _soundDTO:SoundAnalizerDTO;
		private var _timer:Timer;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(sound:XSound, width:Number, height:Number):void {
			_sound = sound;
			_byteArray = new ByteArray(); 
			_soundEvtColl = new EventCollector();
			createSoundEvents();
			$width = width;
			$height = height;
			createBackground();
			initMinSize();
			_timer = new Timer(1000, 1);
			$evtColl.addEvent(_timer, TimerEvent.TIMER_COMPLETE, onManagerDelay);
			spas_internal::lafDTO.cornerRadius = $cornerRadius = 0;
			createContainers();
			createBackgroundTextureManager(spas_internal::background);
			$borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
			createDTO();
			setLibrary(DefaultAnalizer);
			spas_internal::setSelector(Selectors.SOUND_ANALIZER); 
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			spas_internal::uioSprite.addChild(spas_internal::background);
			$content = new Sprite();
			spas_internal::uioSprite.addChild($content);
			_contentMask = new Shape();
			spas_internal::uioSprite.addChild(_contentMask);
			$content.mask = _contentMask;
			spas_internal::uioSprite.addChild(spas_internal::borders);
			
		}
		
		private function updateSpectrum():void {
			SoundMixer.computeSpectrum(_byteArray, true);
			_library.drawSpectrum(_soundDTO);
		}
		
		private function addSoundEvents():void {
			_soundEvtColl.addEvent(_sound, MediaEvent.PLAY, playHandler);
			_soundEvtColl.addEvent(_sound, MediaEvent.PAUSE, stopHandler);
			_soundEvtColl.addEvent(_sound, MediaEvent.STOP, stopHandler);
		}
		
		protected function removeSoundEvents():void {
			_soundEvtColl.removeAllEvents();
		}
		
		private function createSoundEvents():void {
			if (_sound != null) addSoundEvents();
		}
		
		private function playHandler(e:MediaEvent):void {
			if (_timer.running) _timer.stop();
			MediaRessourceManager.spas_internal::addToMediaStack(this);
		}
		
		private function stopHandler(e:MediaEvent):void {
			if (_timer.running) return;
			_timer.reset();
			_timer.start();
		}
		
		private function onManagerDelay(e:TimerEvent):void {
			MediaRessourceManager.spas_internal::removeFromMediaStack(this);
		}
		
		private function createDTO():void {
			_soundDTO = new SoundAnalizerDTO();
			_soundDTO.target = $content;
			_soundDTO.byteArray = _byteArray;
			_soundDTO.sound = _sound;
			_soundDTO.spas_internal::setSize($width, $height);
		}
	}
}