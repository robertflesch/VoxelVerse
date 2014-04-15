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

package org.flashapi.swing.skin {
	
	// -----------------------------------------------------------
	// ClockSkin.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 08/06/2009 15:15
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.describeType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.geom.Geometry;
	import org.flashapi.swing.plaf.spas.SpasUI;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>ClockSkin</code> class defines the skin class for <code>AnalogClock</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.AnalogClock
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ClockSkin extends Skin implements Skinable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ClockSkin</code> object with the
		 * 	specified name.
		 * 
		 * 	@param name	The instance name for this <code>ClockSkin</code> object.
		 */
		public function ClockSkin(name:String = "") {
			super(name);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A point that specifies the center position of the hours needle.
		 */
		public var hoursNeedleCenter:Point = Geometry.ORIGIN;
		
		/**
		 * 	A point that specifies the center position of the minutes needle.
		 */
		public var minutesNeedleCenter:Point = Geometry.ORIGIN;
		
		/**
		 * 	A point that specifies the center position of the seconds needle.
		 */
		public var secondsNeedleCenter:Point = Geometry.ORIGIN;
		
		/**
		 * 	A point that represents the hours needle origin.
		 */
		public var hoursNeedlePosition:Point = Geometry.ORIGIN;
		
		/**
		 * 	A point that represents the minutes needle origin.
		 */
		public var minutesNeedlePosition:Point = Geometry.ORIGIN;
		
		/**
		 * 	A point that represents the seconds needle origin.
		 */
		public var secondsNeedlePosition:Point = Geometry.ORIGIN;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _bgSkin:BitmapData = null;
		private var _bgSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the dial of the clock.
		 */
		public function get dial():* {
			return _bgSkinData;
		}
		public function set dial(value:*):void {
			_bgSkinData = value;
			setSkinObj(value, "_bgSkin");
		}
		
		private var _hSkin:BitmapData = null;
		private var _hSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the clock hours
		 * 	needle.
		 */
		public function get hoursNeedleSkin():* {
			return _hSkinData;
		}
		public function set hoursNeedleSkin(value:*):void {
			_hSkinData = value;
			setSkinObj(value, "_hSkin");
		}
		
		private var _mSkin:BitmapData = null;
		private var _mSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the clock minutes
		 * 	needle.
		 */
		public function get minutesNeedleSkin():* {
			return _mSkinData;
		}
		public function set minutesNeedleSkin(value:*):void {
			_mSkinData = value;
			setSkinObj(value, "_mSkin");
		}
		
		private var _sSkin:BitmapData = null;
		private var _sSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the clock seconds
		 * 	needle.
		 */
		public function get secondsNeedleSkin():* {
			return _sSkinData;
		}
		public function set secondsNeedleSkin(value:*):void {
			_sSkinData = value;
			setSkinObj(value, "_sSkin");
		}
		
		/**
		 * @private
		 */
		public function get scale9Grid():Rectangle {
			return null;
		}
		public function set scale9Grid(value:Rectangle):void  { }
		
		/**
		 * @private
		 */
		override public function set smoothing(value:Boolean):void {
			super.smoothing = value;
			updateSmoothing();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function clone():Skinable {
			var ps:ClockSkin = new ClockSkin();
			var descp:XML = describeType(this);
			assignProp(ps, descp..variable);
			assignProp(ps, descp..accessor);
			return ps as Skinable;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 *
		 * 	Draws the clock dial.
		 */
		public function drawDial():void {
			if (_bgSkin != null) _dialBmc.bitmapData = _bgSkin;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 *
		 * 	Draws the clock hours needle.
		 */
		public function drawHoursNeedle():void {
			if (_hSkin != null) _hBmc.bitmapData = _hSkin;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * Draws the clock minutes needle.
		 */
		public function drawMinutesNeedle():void {
			if (_mSkin != null) _mBmc.bitmapData = _mSkin;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Draws the clock seconds needle.
		 */
		public function drawSecondsNeedle():void {
			if (_sSkin != null) _sBmc.bitmapData = _sSkin;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns the coordinates of the hours needle origin point.
		 * 
		 * 	@return A point that represents the hours needle origin.
		 */
		public function getHoursPosition():Point {
			return hoursNeedlePosition;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns the coordinates of the minutes needle origin point.
		 * 
		 * 	@return A point that represents the minutes needle origin.
		 */
		public function getMinutesPosition():Point {
			return minutesNeedlePosition;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns the coordinates of the seconds needle origin point.
		 * 
		 * 	@return A point that represents the seconds needle origin.
		 */
		public function getSecondsPosition():Point {
			return secondsNeedlePosition;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns the default color of the skin.
		 * 
		 * 	@return	The default color of the skin.
		 */
		public function getColor():uint {
			return SpasUI.DEFAULT_COLOR;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function getDialBitmap():Bitmap {
			return _dialBmc;
		}
		
		/**
		 * @private
		 */
		spas_internal function getHoursNeedleBitmap():Bitmap {
			return _hBmc;
		}
		
		/**
		 * @private
		 */
		spas_internal function getMinutesNeedleBitmap():Bitmap {
			return _mBmc;
		}
		
		/**
		 * @private
		 */
		spas_internal function getSecondsNeedleBitmap():Bitmap {
			return _sBmc;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _dialBmc:Bitmap;
		private var _hBmc:Bitmap;
		private var _mBmc:Bitmap;
		private var _sBmc:Bitmap;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_dialBmc = new Bitmap();
			_hBmc = new Bitmap();
			_mBmc = new Bitmap();
			_sBmc = new Bitmap();
			updateSmoothing();
		}
		
		private function setSkinObj(value:*, target:String):void {
			if(value!=null) {
				var bmp:BitmapData;
				if (value is BitmapData) {
					this[target] = value.clone();
					$bmpColl.add(this[target]);
				} else if (value is DisplayObject) {
					bmp = new BitmapData(value.width, value.height, true, 0);
					bmp.draw(value);
					this[target] = bmp.clone();
					$bmpColl.add(this[target]);
					bmp.dispose(); bmp = null;
				} /*else {
					var loader:Loader = new Loader();
					loader.load(value);
					eventCollector.addOneShotEvent(loader, Event.COMPLETE, completeEvent);
				}*/
			}
			/*function completeEvent(e:Event):void {
				var c:DisplayObject = e.target.content;
				bmp = new BitmapData(c.width, c.height, false, 0);
				bmp.draw(c);
				this[target] = bmp.clone();
				bmpCollector.add(this[target]);
				bmp.dispose(); bmp = null;
			}*/
		}
		
		private function updateSmoothing():void {
			_dialBmc.smoothing = _hBmc.smoothing =
			_mBmc.smoothing = _sBmc.smoothing = $smoothing;
		}
	}
}