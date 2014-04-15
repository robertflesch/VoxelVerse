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
	// FXCharacter.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 23/02/2010 14:55
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.TextFXEvent;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	public dynamic class FXCharacter extends Sprite {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		public function FXCharacter(effect:TextFX, character:String, index:uint) {
			super();
			_effect = effect;
			_bmp = new Bitmap();
			addChild(_bmp);
			_textField = new TextField();
			_textField.autoSize = TextFieldAutoSize.LEFT;
			createBitmap(character);
			_index = index;
			_eventCollector.addEvent(_effect, TextFXEvent.CHANGED, textFXEventHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _displayed:Boolean = false;
		/**
		 * 
		 */
		public function get displayed():Boolean { return _displayed; }
		public function set displayed(value:Boolean):void { _displayed = value; }
		
		private var _index:uint;
		/**
		 * 
		 */
		public function get index():uint { return _index; }
		
		private var _target:*;
		/**
		 * 
		 */
		public function get target():Sprite { return _target; }
		public function set target(value:Sprite):void { _target = value; }
		
		private var _effect:TextFX;
		/**
		 * 
		 */
		public function get effect():TextFX { return _effect; }
		
		private var _char:String = "";
		/**
		 * 
		 */
		public function get character():String { return _char; }
		public function set character(value:String):void { createBitmap(value); }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function display(x:Number = undefined, y:Number = undefined):void {
			if (_displayed) return;
			this.x = x; this.y = y;
			_target.addChild(this);
			_displayed = true;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function remove():void {
			if (!_displayed) return;
			_target.removeChild(this);
			_displayed = false;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function finalize():void { 
			remove();
			_eventCollector.finalize();
			_eventCollector = null;
			_bmpd.dispose();
			_bmp = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private 
		 */
		spas_internal function updateFormat():void {
			_textField.defaultTextFormat = _effect.format;
			_textField.text = _char;
			if (_bmpd != null) _bmpd.dispose();
			_bmpd = new BitmapData(_textField.width, _textField.height, true, 0x00000000);
			_bmpd.draw(_textField);
			_bmp.bitmapData = _bmpd;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _eventCollector:EventCollector = new EventCollector();
		private var _bmp:Bitmap;
		private var _textField:TextField
		private var _bmpd:BitmapData;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function textFXEventHandler(e:TextFXEvent):void {
			var fx:TextEffect = _effect.renderingEffect;
			if(e.target == _effect) {
				switch(_effect.effectMode) {
					case TextFX.FX_IN : fx.renderInEffect(_effect, this, e); break;
					case TextFX.FX_OUT : fx.renderOutEffect(_effect, this, e); break;
				}
			}
		}
		
		private function createBitmap(char:String):void {
			_textField.defaultTextFormat = _effect.format;
			_textField.text = _char = char;
			if (_bmpd != null) _bmpd.dispose();
			_bmpd = new BitmapData(_textField.width, _textField.height, true, 0x00000000);
			_bmpd.draw(_textField);
			_bmp.bitmapData = _bmpd;
		}
	}
}