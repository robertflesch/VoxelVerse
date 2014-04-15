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
	// VSound.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/11/2010 09:15
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setInterval;
	import org.flashapi.vsound.lib.SpectrumRenderer;
	import org.flashapi.vsound.lib.StarRenderer;
	
	/**
	 * 	The <code>VSound</code> class lets you create a visual representation of a
	 * 	sound, depending on the specific graphical library you choose. A graphical
	 * 	library effect is an object that implements the <code>SpectrumRenderer</code>
	 * 	interface.
	 * 
	 * 	<p>The aim of the VSound project is to provide Flash developers an
	 * 	easy-to-use and optimized set of compute spectrum effects. Most of all
	 * 	existing compute spectrum effects can be easily included within the library
	 * 	set and used with the <code>VSound</code> class.</p>
	 * 
	 * 	<p>The default <code>SpectrumRenderer</code> library effect used by the
	 * 	<code>VSound</code> class is the <code>StarRenderer</code> class, develped
	 * 	by <a href="http://matteley.wordpress.com/" title="Matt ELEY">Matt ELEY</a>:</p>
	 * 	<p><img src = "../../../vsound-images/star_renderer.jpg" alt="StarRenderer effect." /></p>
	 * 
	 * 	@includeExample VSoundExample.as
	 * 
	 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
	 * 	@see org.flashapi.vsound.lib.StarRenderer
	 * 	@see org.flashapi.vsound.VSoundSequencer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class VSound extends Sprite implements VSoundDisplayObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>VSound</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	width	The width of the <code>VSound</code> instance, in pixels.
		 * 					The default value is <code>400</code> pixels.
		 * 	@param	height	The height of the <code>VSound</code> instance, in pixels.
		 * 					The default value is <code>250</code> pixels.
		 * 
		 */
		public function VSound(width:Number = 400, height:Number = 250) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Acessors
		//
		//--------------------------------------------------------------------------
		
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
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function isPlaying():Boolean {
			return Boolean(_playerRef > 0);
		}
		
		/**
		 *  Returns the reference of the <code>Class</code> that is used as library
		 * 	object to define the current <code>SpectrumRenderer</code> instance.
		 * 	
		 * 	@return The library object that defines the current <code>SpectrumRenderer</code>
		 * 			instance.
		 * 
		 * 	@see #setRendererLib()
		 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
		 */
		public function getRendererLib():Class {
			return Class(getDefinitionByName(getQualifiedClassName(_renderer)));
		}
		
		/**
		 * 	Defines a library object, specified by the <code>rendererLib</code>
		 * 	parameter, to set a new <code>SpectrumRenderer</code> instance.
		 * 
		 * 	@param	rendererLib	The library object used to define the new 
		 * 						<code>SpectrumRenderer</code> instance.
		 * 
		 * 	@see #setRendererLib()
		 * 	@see org.flashapi.vsound.lib.SpectrumRenderer
		 */
		public function setRendererLib(rendererLib:Class):void {
			var isPlaying:Boolean = Boolean(_playerRef > 0);
			this.deleteRenderer();
			_renderer = new rendererLib();
			_renderer.init(_bitmapBuffer);
			_renderer.resize(_width, _height);
			if (isPlaying) this.play();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function play():void {
			if (_playerRef > 0) return;
			_playerRef = setInterval(renderSpectrum, 80);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function stop():void {
			if (_playerRef < 0) return;
			clearInterval(_playerRef);
			_playerRef = -1;
			if (_fadeOut) initFadeOut();
			
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function resize(width:Number, height:Number):void {
			_width = width;
			_height = height;
			var isPlaying:Boolean = Boolean(_playerRef > 0);
			stopRendering();
			initBitmap();
			if (isPlaying) this.play();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function dispose():void {
			deleteRenderer();
			if (_fadeRef > 0) clearInterval(_fadeRef);
			_bitmapBuffer.dispose();
			_bitmapBuffer = null;
			this.removeChild(_bitmap);
			_bitmap = null;
			_rect = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	A Number that stores the VSound width.
		 */
		private var _width:Number;
		
		/**
		 * 	@private
		 * 
		 * 	A Number that stores the VSound height.
		 */
		private var _height:Number;
		
		/**
		 * 	@private
		 * 
		 * 	A SpectrumRenderer which is the current graphical library for this VSound
		 * 	object.
		 */
		private var _renderer:SpectrumRenderer;
		
		/**
		 * 	@private
		 * 
		 * 	An Integer used to store the reference to the interval closure function
		 * 	used for rendering effects.
		 */
		private var _playerRef:int;
		
		/**
		 * 	@private
		 * 
		 * 	The BitmapData instance that is used by this VSound object to render the
		 * 	visual effect defined by the current SpectrumRenderer instance.
		 */
		private var _bitmapBuffer:BitmapData;
		
		/**
		 * 	@private
		 * 
		 * 	The Bitmap object that holds the buffer BitmapData.
		 */
		private var _bitmap:Bitmap;
		
		/**
		 * 	@private
		 * 
		 * 	A Boolean that indicates whether to use the fade out effect when the stop()
		 * 	method is called (true), or not (false).
		 */
		private var _fadeOut:Boolean;
		
		/**
		 * 	@private
		 * 
		 * 	The rectangle used by the fade out ColorTransform effect.
		 */
		private var _rect:Rectangle;
		
		/**
		 * 	@private
		 * 
		 * 	An Integer used to store the reference to the interval closure function
		 * 	used by the the fade out effect.
		 */
		private var _fadeRef:int;
		
		/**
		 * 	@private
		 * 
		 * 	An Integer used to count down the fade out effect duration.
		 */
		private var _fadeCounter:int;
		
		/**
		 * 	@private
		 * 
		 * 	The fade out ColorTransform effect.
		 */
		private static const FADE_OUT:ColorTransform = new ColorTransform(1, 1, 1, 0.95, 0, 0, 0, 0);
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Initializes the VSound object. This method is called from the constructor
		 * 	function.
		 * 
		 * 	@param	width	The width of the <code>VSound</code> instance.
		 * 	@param	height	The height of the <code>VSound</code> instance.
		 */
		private function initObj(width:Number, height:Number):void {
			_width = width;
			_height = height;
			initBitmap();
			_bitmap = new Bitmap(_bitmapBuffer);
			this.addChild(_bitmap);
			setRendererLib(StarRenderer);
			_playerRef = _fadeRef = -1;
			_fadeOut = true;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Renders the current SpectrumRenderer effect each time this function is
		 * 	called by the effect setInterval() method.
		 */
		private function renderSpectrum():void {
			_bitmapBuffer.unlock();
			_renderer.update(_bitmapBuffer);
			_bitmapBuffer.lock();
		}
		
		/**
		 * 	@private
		 * 
		 * 	Initializes the fade out effect each time the stop() method is called from
		 * 	the external API.
		 */
		private function initFadeOut():void {
			_rect = _bitmapBuffer.rect;
			_fadeCounter = 55;
			_fadeRef = setInterval(renderFadeOut, 15);
		}
		
		/**
		 * 	@private
		 * 
		 * 	Renders the fade out.
		 */
		private function renderFadeOut():void {
			_bitmapBuffer.unlock();
			_bitmapBuffer.colorTransform(_rect, FADE_OUT);
			_bitmapBuffer.lock();
			if (--_fadeCounter == 0) {
				clearInterval(_fadeRef);
				_fadeRef = -1;
			}
		}
		
		/**
		 * 	@private
		 * 
		 * 	Disposes the current SpectrumRenderer effect.
		 */
		private function deleteRenderer():void {
			stopRendering();
			if (_renderer != null) {
				_renderer.dispose();
				_renderer = null;
			}
		}
		
		/**
		 * 	@private
		 * 
		 * 	Creates a new instance of the buffer BitmapData.
		 */
		private function initBitmap():void {
			if (_bitmapBuffer != null) _bitmapBuffer.dispose();
			_bitmapBuffer = new BitmapData(_width, _height, false, 0x00000000);
		}
		
		/**
		 * 	@private
		 * 
		 * 	An internal method that is used to momentally stop the effect rendering
		 * 	without lauching the fade out effect.
		 */
		private function stopRendering():void {
			_fadeOut = false;
			this.stop();
			_fadeOut = true;
		}
	}
}