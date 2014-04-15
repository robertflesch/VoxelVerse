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

package org.flashapi.swing.sound.analizer {
	
	// -----------------------------------------------------------
	//  DefaultAnalizer.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.1, 04/06/2009 15:32
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import org.flashapi.tween.constant.EaseType;
	import org.flashapi.tween.motion.Quadratic;
	import org.flashapi.swing.sound.SoundAnalizerDTO;
	
	/**
	 * 	The <code>DefaultAnalizer</code> class creates a basic <code>AnalizerLibrary</code>
	 * 	library to specify the default rendering library for <code>SoundAnalizer</code>
	 * 	objects:
	 * 	<p><img src = "../../../../../doc-images/default-analizer.jpg" alt="DefaultAnalizer" /></p>
	 * 
	 * 	@see org.flashapi.swing.SoundAnalizer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DefaultAnalizer extends AbstractAnalizer implements AnalizerLibrary {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DefaultAnalizer</code> object.
		 */
		public function DefaultAnalizer() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function initSpectrum(soundDTO:SoundAnalizerDTO):void {
			var tgt:Sprite = soundDTO.target;
			tgt.graphics.clear();
			var b:Bar;
			var i:int = 0;
			_bars = [];
			getBarWidth(soundDTO);
			for (; i < _barNum; i++) {
				b = new Bar(soundDTO.height, _barWidth);
				b.x = i * (_barWidth + _barSpacing);
				tgt.addChild(b);
				_bars.push(b);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function resizeSpectrum(soundDTO:SoundAnalizerDTO):void {
			getBarWidth(soundDTO);
			var l:int = _bars.length-1;
			for (; l >=0 ; l--) {
				_bars[l].reisze(soundDTO.height, _barWidth);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function finalize(soundDTO:SoundAnalizerDTO):void {
			_easingFunc = null;
			var b:Bar;
			var tgt:Sprite = soundDTO.target;
			var l:int = _bars.length-1;
			for (; l >=0 ; l--) {
				b = _bars[l];
				tgt.removeChild(b);
				b = null;
			}
			_bars = [];
			_bars = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function drawSpectrum(soundDTO:SoundAnalizerDTO):void {
			var i:int = 0;
			var ba:ByteArray = soundDTO.byteArray;
			var float:Number;
			var a:Array = [];
			//var t:Number;
			var valuesAverage:Number;
			var b:Bar;
			var j:uint = 11;
			var nexId:int = 0;
			var h:Number = soundDTO.height;
			setSpectrumValue(256);
			a.reverse();
			setSpectrumValue(512);
			i = 0
			for (; i < a.length; ++i) {
				valuesAverage = _easingFunc(a[i], 0, 1, 1);
				if (valuesAverage > 1) valuesAverage = 1;
				b = _bars[i];
				b.update(valuesAverage * h);
			}
			function setSpectrumValue(max:uint):void {
				for (; i < max; ++i, ++j) {
					float = ba.readFloat();
					if (j >= 11) {
						a[nexId++] = float;
						j = 0;
					}
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _barWidth:Number;
		private var _barSpacing:Number = 2;
		private var _bars:Array;
		private var _barNum:uint = 48;
		private var _easingFunc:Function;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$backgroundColor = 0;
			_easingFunc = new Quadratic(EaseType.OUT).equation;
			$gradientMode = true;
			$gradientProperties = { colors:[0x333333, 0] };
		}
		
		private function getBarWidth(dto:SoundAnalizerDTO):void {
			_barWidth = (dto.width - ( _barNum - 1) * _barSpacing) / _barNum;
		}
	}
}

////////////////////////////////////////////////////////////////////////////////
//
// 	Bar class from the Audio Spectrum Analyzer Example by Mike Creighton.
//
//	Copyright (C) 2009 Mike Creighton
//	@see http://www.todaycreate.com/2007/02/18/actionscript-3-spectrum-analyzer
//
//	The Bar class is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	This Audio Spectrum Analyzer Example by Mike Creighton
//	is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////

import flash.display.GradientType;
import flash.display.Sprite;
import flash.geom.Matrix;
import org.flashapi.swing.color.ColorUtil;
import org.flashapi.swing.geom.Geometry;

class Bar extends Sprite {
	
	private var _maxHeight:Number;
	private var _barWidth:Number;
	private var _currentValue:Number;
	private var _angle:Number = Geometry.degreeToRadian(90); //90 * Math.PI / 180; 
	private var _matrix:Matrix;

	public function Bar(maxHeight:Number, barWidth:Number) {
		super();
		initObj(maxHeight, barWidth);
	}
	
	public function reisze(maxHeight:Number, barWidth:Number):void {
		_maxHeight = maxHeight;
		_barWidth = barWidth;
	}
	
	public function update(value:Number):void {
		graphics.clear();
		if(value >= _currentValue) _currentValue = value;		
		else {
			_currentValue += - _currentValue / 9; 
			if(_currentValue < 0) _currentValue = 0;
		}
		var delay:Number = _maxHeight - _currentValue;
		var newColor:uint = ColorUtil.interpolate(0x222222, 0xFFFFFF, _currentValue/4);
		_matrix.createGradientBox(_barWidth, _currentValue, _angle, 0, delay);
		var colors:Array = [newColor, 0x222222];
		with(graphics) {
			beginGradientFill(GradientType.LINEAR, colors, [1, 1], [0, 0xFF], _matrix);
			drawRect(0, delay, _barWidth, _currentValue);
			beginFill(0x00FFFF);
			drawRect(0, delay-2, _barWidth, 1);
			endFill();
		}
	}
	
	private function initObj(maxHeight:Number, barWidth:Number):void {
		_maxHeight = maxHeight;
		_barWidth = barWidth;
		_currentValue = 0;
		_matrix = new Matrix();
		update(_currentValue);
	}
}