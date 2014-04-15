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
	// DigitalClock.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 15/03/2010 21:25
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.flashapi.swing.constants.DigitalClockHourFormat;
	import org.flashapi.swing.core.Clock;
	import org.flashapi.swing.core.ClockBase;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.DigitalClockUIRef;
	import org.flashapi.swing.text.UITextFormat;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DigitalClock.png")]
	
	/**
	 * 	<img src="DigitalClock.png" alt="DigitalClock" width="18" height="18"/>
	 * 
	 * 	The <code>DigitalClock</code> class creates instances of digital clock
	 * 	objects. A digital clock is a type of clock that displays the time digitally,
	 * 	as opposed to an analog clock.
	 * 
	 * 	<p><strong><code>DigitalClock</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-weight</code></td>
	 * 			<td>Sets the font weight of the object.</td>
	 * 			<td>Recognized values are <code class="css">normal</code> or
	 * 			<code class="css">bold</code>.</td>
	 * 			<td><code>boldFace</code></td>
	 * 			<td><code>Properties.FONT_WEIGHT</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.AnalogClock
	 * 
	 * 	@includeExample DigitalClockExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DigitalClock extends ClockBase implements Observer, LafRenderer, Clock, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>DigitalClock</code> instance.
		 */
		public function DigitalClock() {
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
		
		private var _boldFace:Boolean;
		/**
		 *  A <code>FontState</code> object that specifies the text font weight for 
		 * 	this <code>DigitalClock</code> instance.
		 * 
		 * 	@default null
		 */
		public function get boldFace():Boolean {
			return _boldFace;
		}
		public function set boldFace(value:Boolean):void {
			_boldFace = value;
			//if (_boldFace != null) _fmt.bold = _boldFace;
			spas_internal::textRef.defaultTextFormat = _fmt;
			forceTimeUpdate();
		}
		
		private var _fontColor:* = NaN;
		/**
		 *  Sets or gets the text color for this <code>DigitalClock</code> instance.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a>
		 * 	recommendation to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> 
		 *  section of the document to get valid SVG color keyword names.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 *  @default The color specified by the current Look and Feel.
		 */
		public function get fontColor():* {
			return _fontColor;
		}
		public function set fontColor(value:*):void {
			_fontColor = getColor(value);
			if (!isNaN(_fontColor)) _fmt.color = _fontColor;
			spas_internal::textRef.defaultTextFormat = _fmt;
			forceTimeUpdate();
		}
		
		private var _displaySeconds:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the seconds
		 * 	are displayed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get displaySeconds():Boolean {
			return _displaySeconds;
		}
		public function set displaySeconds(value:Boolean):void {
			_displaySeconds = value;
			forceTimeUpdate();
		}
		
		private var _timeSeparator:String = ":";
		/**
		 * 	Sets or gets the separator character in the clock display.
		 * 
		 * 	@default :
		 */
		public function get timeSeparator():String {
			return _timeSeparator;
		}
		public function set timeSeparator(value:String):void {
			_timeSeparator = value;
			forceTimeUpdate();
		}
		
		private var _hourFormat:uint = DigitalClockHourFormat.TWENTY_FOUR_HOURS;
		/**
		 * 	Sets or gets the hour format in the 12 hour or 24 hour format. 
		 * 	Valid values are <code>DigitalClockHourFormat.TWENTY_FOUR_HOURS</code> 
		 * 	or <code>DigitalClockHourFormat.TWELVE_HOURS</code>.
		 * 
		 * 	@default DigitalClockHourFormat.TWENTY_FOUR_HOURS
		 */
		public function get hourFormat():uint {
			return _hourFormat;
		}
		public function set hourFormat(value:uint):void {
			_hourFormat = value;
			forceTimeUpdate();
		}
		
		/**
		 * 	@private
		 */
		override public function get width():Number {
			return spas_internal::textRef.width;
		}
		
		/**
		 * 	@private
		 */
		override public function get height():Number {
			return spas_internal::textRef.height;
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
			if (_hourFormat == DigitalClockHourFormat.TWENTY_FOUR_HOURS)
				formatTime24($hour, $minute, $second);
			else if (_hourFormat == DigitalClockHourFormat.TWELVE_HOURS)
				formatTime12($hour, $minute, $second);
			
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_fmt = lookAndFeel.getTextFormat().clone();
			if (!isNaN(_fontColor)) _fmt.color = _fontColor;
			//if (_boldFace != null) _fmt.bold = _boldFace;
			spas_internal::textRef.defaultTextFormat = _fmt;
			forceTimeUpdate();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _fmt:UITextFormat;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createTextField();
			createTimerEvent();
			initLaf(DigitalClockUIRef);
			spas_internal::setSelector(Selectors.DIGIT_CLOCK);
			spas_internal::isInitialized(1);
		}
		
		private function createTextField():void {
			spas_internal::textRef = new TextField();
			spas_internal::textRef.text = "00" + _timeSeparator + "00";
			//spas_internal::textRef.border = true;
			spas_internal::textRef.selectable = false;
			spas_internal::textRef.autoSize = TextFieldAutoSize.LEFT
			spas_internal::uioSprite.addChild(spas_internal::textRef);
			//updateTime();
		}
		
		/**
		 * 	Transforms the time to a formatted 24-hour time string.
		 *
		 * 	@param   h   The hour.
		 * 	@param   m   The minute.
		 * 	@param   s   The second.
		 * 
		 * 	@author Colin MOOCK
		 */
		private function formatTime24 (h:Number, m:Number, s:Number):void {
			var ts:String = "";
			if (h < 10) ts += "0";
			ts += h + _timeSeparator;
			formatTime(ts, m, s);
		}
		
		/**
		 * 	Transforms the time to a formatted 12-hour time string.
		 *
		 * 	@param   h   The hour.
		 * 	@param   m   The minute.
		 * 	@param   s   The second.
		 * 
		 * 	@author Colin MOOCK
		 */
		private function formatTime12 (h:Number, m:Number, s:Number):void {
			var ts:String = "";
			if (h == 0) ts += "12" + _timeSeparator;
			else if (h > 12) ts += (h - 12) + _timeSeparator;
			else ts += h + _timeSeparator;
			formatTime(ts, m, s);
		}
		
		private function formatTime (ts:String, m:Number, s:Number):void {
			if (m < 10) ts += "0";
			ts +=  String(m);
			if (_displaySeconds) {
				ts += _timeSeparator;
				if (s < 10) ts += "0";
				ts += String(s);
			}
			spas_internal::textRef.text = ts;
		}
		
		private function forceTimeUpdate():void {
			if(!$timer.running) updateTime();
		}
	}
}