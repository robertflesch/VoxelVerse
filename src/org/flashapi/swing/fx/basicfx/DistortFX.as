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
	
package org.flashapi.swing.fx.basicfx {
	
	// -----------------------------------------------------------
	// DistortFX.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 12/06/2009 21:26
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import org.flashapi.swing.event.EffectEvent;
	import org.flashapi.swing.fx.FX;
	import org.flashapi.swing.fx.FXBase;
	import org.flashapi.swing.geom.distort.Distortion;
	
	/**
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 */
	public class DistortFX extends FXBase implements FX {
		
		public function DistortFX(target:*, source:*, vPrecision:Number = 4, hPrecision:Number = 4, smooth:Boolean = true) {
			super(source);
			initObj(target, source, vPrecision, hPrecision, smooth);
		}
		
		public function get vPrecision():Number {
			return _distortion.vPrecision;
		}
		public function set vPrecision(value:Number):void {
			_distortion.vPrecision = value;
		}
		
		public function get hPrecision():Number {
			return _distortion.hPrecision;
		}
		public function set hPrecision(value:Number):void {
			_distortion.hPrecision = value;
		}
		
		
		override public function get width():Number {
			return _distortion.width;
		}
		
		override public function get height():Number {
			return _distortion.height;
		}
		
		public function render():void {
			_distortion.render();
		}
		
		public function remove():void {
			_target.removeChild(uioSprite);
			this.dispatchEvent(new EffectEvent(EffectEvent.REMOVE));
		}
		
		public function finalize():void {
			if (_target.contains(uioSprite)) _target.removeChild(uioSprite);
			_distortion.dispose();
			_distortion = null;
			_target = null;
			src = null;
			_uio = null;
			uioSprite = null;
		}
		
		public function setTransform(topLeft:Point, topRight:Point, bottomRight:Point, bottomLeft:Point):void {
			_distortion.setTransform(topLeft, topRight, bottomRight, bottomLeft);
		}
		
		public function setChoordTransform(x1:Number, y1:Number, x2:Number, y2:Number, x3:Number, y3:Number, x4:Number, y4:Number):void {
			_distortion.setChoordTransform(x1, y1, x2, y2, x3, y3, x4, y4);
		}
		
		private var _distortion:Distortion;
		
		private function initObj(target:*, source:*, vPrecision:Number, hPrecision:Number, smooth:Boolean):void {
			_target = target;
			_target.addChild(uioSprite);
			_distortion = new Distortion(source, uioSprite, vPrecision, hPrecision, smooth);
		}
		
	}
}
