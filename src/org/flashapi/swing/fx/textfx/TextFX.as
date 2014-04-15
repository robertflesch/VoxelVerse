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

package org.flashapi.swing.fx.textfx {
	
	// -----------------------------------------------------------
	//  TextFX.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.1, 16/12/2009 21:07
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.event.EffectEvent;
	import org.flashapi.swing.event.TextFXEvent;
	import org.flashapi.swing.fx.FX;
	import org.flashapi.swing.fx.FXBase;
	import org.flashapi.swing.fx.textfx.lib.TypeWriter;
	import org.flashapi.swing.util.ArrayList;
	import org.flashapi.swing.util.Iterator;
	
	/**
	 * 
	 */
	public class TextFX extends FXBase implements FX {
	   
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * @param	target
		 * @param	text
		 * @param	effect
		 * @param	duration
		 */
		public function TextFX(target:*, text:String = "", effect:TextEffect = null, duration:int = 1000) {
			super(null);
			_target = target;
			_text = text;
			_renderingFX = effect == null ? new TypeWriter() : effect;
			_duration = duration;
			createCharacterSet();
			_timer = new Timer(0);
			_timer.addEventListener(TimerEvent.TIMER, dispatchChangeEvent);
			_target.addChild(uioSprite);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 */
		public static const FX_IN:String = "fxIn";
		
		/**
		 * 
		 */
		public static const FX_OUT:String = "fxOut";
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------		
		
		/**
		 *  @private
		 */
		override public function get height():Number { return uioSprite.height; }
		
		private var _delay:Number;
		/**
		 * 
		 */
		public function get delay():Number { return _delay; }
		
		private var _effectMode:String = TextFX.FX_IN;
		/**
		 * 
		 * 	@default TextFX.FX_IN
		 */
		public function get effectMode():String { return _effectMode; }
		public function set effectMode(value:String):void { _effectMode = value; }
		
		private var _renderingFX:TextEffect;
		/**
		 * 
		 */
		public function get renderingEffect():TextEffect { return _renderingFX; }
		public function set renderingEffect(value:TextEffect):void { _renderingFX = value; }
		
		private var _totalCount:uint;
		/**
		 * 
		 */
		public function get totalCount():uint { return _totalCount; }
		
		/**
		 * 
		 */
		override public function get width():Number { return uioSprite.width; }
		
		private var _text:String = "";
		/**
		 * 	Sets or gets the text to be used with this effect.
		 * 
		 * 	@default ""
		 */
		public function get text():String { return _text; }
		public function set text(value:String):void {
			deleteCharacterSet();
			_text = value;
			createCharacterSet();
		}
		
		private var _format:TextFormat = new TextFormat(WebFonts.ARIAL, 12);
		/**
		 * 
		 */
		public function get format():TextFormat { return _format; }
		public function set format(value:TextFormat):void { 
			_format = value;
			var it:Iterator = _characterSet.iterator;
			var fxc:*;
			while(it.hasNext()) {
				fxc = it.next();
				fxc.updateFormat();
			}
			it.reset();
		}
		
		private var _isRendering:Boolean = false;
		/**
		 *  Returns <code>true</code> if the effect is rendering, <code>false</code>
		 * 	otherwise.
		 */
		public function get isRendering():Boolean { return _isRendering; }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		public function render():void {
			if (_isRendering) return;
			refresh();
		}
		
		public function display():void {
			if (_target is UIContainer) _target.addElement(uioSprite);
			else if (_target is DisplayObjectContainer) _target.addChild(uioSprite);
		}
		
		public function remove():void {
			_timer.stop();
			_timer.reset();
			_isRendering = false;
			if (_target is UIContainer) _target.removeElement(uioSprite);
			else if(_target is DisplayObjectContainer) _target.removeChild(uioSprite);
			this.dispatchEvent(new EffectEvent(EffectEvent.REMOVE));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _characterSet:ArrayList = new ArrayList();
		private var _timer:Timer;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function createCharacterSet():void {
			_characterSet.clear();
			_totalCount = _text.length;
			var fxc:FXCharacter;
			var i:int = 0;
			for(; i < _totalCount; ++i) {
				fxc = new FXCharacter(this, _text.substr(i, 1), i);
				fxc.target = uioSprite;
				_characterSet.add(fxc);
			}
		}
		
		private function deleteCharacterSet():void {
			var it:Iterator = _characterSet.iterator;
			while(it.hasNext()) { 
				var fxc:* = it.next();
				fxc.finalize();
				fxc = null;
			}
			it.reset();
			_characterSet.clear();
		}
		
		private function getDelay():void {
			_delay = Math.round(_duration / _text.length);
		}
		
		private function refresh():void {
			_isRendering = true;
			_timer.reset();
			_effectMode == TextFX.FX_IN ? _renderingFX.initInEffect(this) : _renderingFX.initOutEffect(this);
			getDelay();
			_timer.delay = _delay;
			_timer.start();
		}
		
		private function dispatchChangeEvent(e:TimerEvent):void {
			var d:Number = e.target.currentCount * e.target.delay;
			var tcc:uint =  _timer.currentCount;
			if (d > _duration) {
				_timer.stop();
				_timer.reset();
				_isRendering = false;
				this.dispatchEvent(new TextFXEvent(TextFXEvent.FINISHED, d, tcc));
			} else this.dispatchEvent(new TextFXEvent(TextFXEvent.CHANGED, d, tcc));
		}
	}
}