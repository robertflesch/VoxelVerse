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
	// AnalogClock.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 14/03/2010 18:51
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import org.flashapi.swing.core.Clock;
	import org.flashapi.swing.core.ClockBase;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.ClockUIRef;
	import org.flashapi.swing.skin.Skinable;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("AnalogClock.png")]
	
	/**
	 * 	<img src="AnalogClock.png" alt="AnalogClock" width="18" height="18"/>
	 * 
	 * 	The <code>AnalogClock</code> class creates instances of analog clock objects.
	 * 	Analog clock objects are composed of hours, minutes and seconds needles and
	 * 	a backgound dial. 
	 * 
	 * 	<p><strong>The <code>AnalogClock</code> class supports the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">radius</code></td>
	 * 			<td>Sets the radius of the clock dial.</td>
	 * 			<td>Recognized values are numbers.</td>
	 * 			<td><code>radius</code></td>
	 * 			<td><code>Undocumented</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@includeExample AnalogClockExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AnalogClock extends ClockBase implements Observer, LafRenderer, Clock, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>AnalogClock</code> instance.
		 */
		public function AnalogClock() {
			super();
			initObj();
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
		
		private var _radius:Number = 50;
		/**
		 * 	Sets or gets the radius of the clock dial. This property is not
		 * 	implemented by the <code>AnalogClock</code> skin object.
		 * 
		 * 	@default 50
		 */
		public function get radius():Number {
			return _radius;
		}
		public function set radius(value:Number):void {
			spas_internal::lafDTO.radius = _radius = value;
			this.resize(_radius, _radius);
		}
		
		/**
		 * @private
		 */
		override public function set skin(value:Skinable):void {
			if ($hasSkin) {
				_dial.removeChildAt(0);
				_needleH.removeChildAt(0);
				_needleM.removeChildAt(0);
				_needleS.removeChildAt(0);
			}
			super.skin = value;
			if($skinObject) {
				_dial.graphics.clear();
				_needleH.graphics.clear();
				_needleM.graphics.clear();
				_needleS.graphics.clear();
				
				var bmp:Bitmap;
				var pt:Point;
				
				_dial.addChildAt($skinObject.getDialBitmap(), 0);
				
				bmp = $skinObject.getHoursNeedleBitmap();
				pt = $skinObject.hoursNeedleCenter;
				bmp.x = -pt.x; bmp.y = -pt.y;
				_needleH.addChildAt(bmp, 0);
				
				bmp = $skinObject.getMinutesNeedleBitmap();
				pt = $skinObject.minutesNeedleCenter;
				bmp.x = -pt.x; bmp.y = -pt.y;
				_needleM.addChildAt(bmp, 0);
				
				bmp = $skinObject.getSecondsNeedleBitmap();
				pt = $skinObject.secondsNeedleCenter;
				bmp.x = -pt.x; bmp.y = -pt.y; 
				_needleS.addChildAt(bmp, 0);
			}
			
			_needsPosUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function get height():Number {
			return _dial.height;
		}
		
		/**
		 * 	@private
		 */
		override public function get width():Number {
			return _dial.width;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function updateTime():void {
			var dayPercent:Number = ($hour > 12 ? $hour - 12 : $hour) / 12;
			var hourPercent:Number = $minute / 60;
			var minutePercent:Number = $second / 60;
			_needleH.rotation = 360 * dayPercent + hourPercent * (360 / 12) + 180;
			_needleM.rotation = 360 * hourPercent + 180;
			_needleS.rotation = 360 * minutePercent + 180;
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			var skinObj:Object = getSkinObj();
			spas_internal::lafDTO.currentTarget = _dial;
			if (_needsPosUpdate) updatePositions(skinObj);
			skinObj.drawDial();
			spas_internal::lafDTO.currentTarget = _needleH;
			skinObj.drawHoursNeedle();
			spas_internal::lafDTO.currentTarget = _needleM;
			skinObj.drawMinutesNeedle();
			spas_internal::lafDTO.currentTarget = _needleS;
			skinObj.drawSecondsNeedle();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			spas_internal::lafDTO.color = lookAndFeel.getColor();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _needleContainer:Sprite;
		private var _dial:Sprite;
		private var _needleH:Sprite;
		private var _needleM:Sprite;
		private var _needleS:Sprite;
		private var _needsPosUpdate:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			initSize(100, 100);
			createContainers();
			createTimerEvent();
			spas_internal::lafDTO.radius = _radius;
			initLaf(ClockUIRef);
			spas_internal::setSelector(Selectors.CLOCK);
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			_dial = new Sprite();
			spas_internal::uioSprite.addChild(_dial);
			_needleContainer = new Sprite();
			spas_internal::uioSprite.addChild(_needleContainer);
			_needleH = new Sprite();
			_needleM = new Sprite();
			_needleS = new Sprite();
			_needleContainer.addChild(_needleH);
			_needleContainer.addChild(_needleM);
			_needleContainer.addChild(_needleS);
			var filterArray:Array = [new DropShadowFilter(2, 2, 2, .5)];
			_needleContainer.filters = filterArray;
			updateTime();
		}
		
		private function updatePositions(skinObj:Object):void {
			var r:Number = _radius;
			var pt:Point = skinObj.getHoursPosition();
			_needleH.x = r + pt.x; _needleH.y = r + pt.y;
			pt = skinObj.getMinutesPosition();
			_needleM.x = r + pt.x; _needleM.y = r + pt.y;
			pt = skinObj.getSecondsPosition();
			_needleS.x = r + pt.x; _needleS.y = r + pt.y;
			_needsPosUpdate = false;
		}
	}
}