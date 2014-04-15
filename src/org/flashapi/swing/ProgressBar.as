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
	// ProgressBar.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 19/03/2011 14:04
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.plaf.libs.ProgressBarUIRef;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.util.RangeChecker;
	
	use namespace spas_internal;
	
	[IconFile("ProgressBar.png")]
	
	/**
	 * 	<img src="ProgressBar.png" alt="ProgressBar" width="18" height="18"/>
	 * 
	 * 	The <code>ProgressBar</code> class creates a control that visually indicates the
	 * 	progress of a lengthy.
	 * 
	 * <p><strong><code>ProgressBar</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">track-opacity</code></td>
	 * 			<td>Sets the alpha transparency value of the progress bar track.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>trackOpacity</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">bar-opacity</code></td>
	 * 			<td>Sets the alpha transparency value of the progress bar.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>barOpacity</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">track-highlight-opacity</code></td>
	 * 			<td>Sets the alpha transparency value of the highlighted track bar.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>trackHighlightOpacity</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">track-highlight-color</code></td>
	 * 			<td>Sets the color value of the highlighted track bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>trackHighlightColor</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">track-color</code></td>
	 * 			<td>Sets the color value of the progress bar track.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>trackColor</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.ProgressPanel
	 * 
	 *  @includeExample ProgressBarExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class ProgressBar extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ProgressBar</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width 	The width of the <code>ProgressBar</code> instance, in
		 * 					pixels.
		 * 	@param	height 	The height of the <code>ProgressBar</code> instance, in
		 * 					pixels.
		 */
		public function ProgressBar(width:Number = 200, height:Number = 4) {
			super();
			initObj(width, height);
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
		
		private var _trackOpacity:Number = 1;
		/**
		 *  Sets or gets the alpha transparency of the progress bar track.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 * 
		 *  @default 1
		 */
		public function get trackOpacity():Number {
			return _trackOpacity;
		}
		public function set trackOpacity(value:Number):void {
			_trackOpacity = spas_internal::lafDTO.trackOpacity = value;
			spas_internal::lafDTO.currentTarget = _trackContainer;
			lookAndFeel.drawTrack();
		}
		
		private var _trackHighlightOpacity:Number = 1;
		/**
		 *  Sets or gets the alpha transparency of the progress bar highlighted track.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 * 
		 *  @default 1
		 */
		public function get trackHighlightOpacity():Number {
			return _trackHighlightOpacity;
		}
		public function set trackHighlightOpacity(value:Number):void {
			_trackHighlightOpacity = spas_internal::lafDTO.trackHighlightOpacity = value;
			spas_internal::lafDTO.currentTarget = _highlightContainer;
			lookAndFeel.drawTrackHighlight();
		}
		
		private var _barOpacity:Number = 1;
		/**
		 *  Sets or gets the alpha transparency of the progress bar.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 * 
		 *  @default 1
		 */
		public function get barOpacity():Number {
			return _barOpacity;
		}
		public function set barOpacity(value:Number):void {
			_barOpacity = spas_internal::lafDTO.barOpacity = value;
			spas_internal::lafDTO.currentTarget = _barContainer;
			lookAndFeel.drawBar();
		}
		
		private var _progressValue:Number = 0;
		/**
		 * 	Returns a number that corresponds to the current value proportionally to the
		 * 	progress bar length.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #value
		 */
		public function get progressValue():Number {
			return _progressValue;
		}
		
		private var _highlightValue:Number = 0;
		/**
		 * 	Returns a number that corresponds to the current value proportionally to the
		 * 	highlighted track bar length.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #trackHighlightValue
		 */
		public function get highlightValue():Number {
			return _highlightValue;
		}
		
		private var _trackHighlightValue:Number = 0;
		/**
		 * 	Sets or gets the current value of the highlighted track in percent, from
		 * 	<code>0</code> to <code>100</code>.
		 * 
		 * 	@default 0
		 * 
		 *  @throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 	<code>IndexOutOfBoundsException</code> error if the <code>value</code>
		 * 	parameter is lower than <code>0</code> or greater than <code>100</code>.
		 * 
		 * 	@see #progressValue
		 * 	@see #value
		 */
		public function get trackHighlightValue():Number {
			return _trackHighlightValue;
		}
		public function set trackHighlightValue(value:Number):void {
			RangeChecker.checkNum(value, 100, 0, "trackHighlightValue");
			_trackHighlightValue = value;
			fixHighlightProperties();
			spas_internal::lafDTO.currentTarget = _highlightContainer;
			lookAndFeel.drawTrackHighlight();
		}
		
		private var _value:Number = 0;
		/**
		 * 	Sets or gets the current value of the progress bar in percent, from
		 * 	<code>0</code> to <code>100</code>.
		 * 
		 * 	@default 0
		 * 
		 *  @throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 	<code>IndexOutOfBoundsException</code> error if the <code>value</code>
		 * 	parameter is lower than <code>0</code> or greater than <code>100</code>.
		 * 
		 * 	@see #progressValue
		 */
		public function get value():Number {
			return _value;
		}
		public function set value(value:Number):void {
			RangeChecker.checkNum(value, 100, 0, "value");
			_value = value;
			fixBarProperties();
			/*spas_internal::lafDTO.currentTarget = _trackContainer;
			lookAndFeel.drawTrack();*/
			spas_internal::lafDTO.currentTarget = _barContainer;
			lookAndFeel.drawBar();
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void { 
			spas_internal::lafDTO.barLength = $width = value;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void { 
			spas_internal::lafDTO.height = $height = value;
			setRefresh();
		}
		
		private var _trackHighlightColor:* = NaN;
		[Inspectable(defaultValue="#EAEAEA", name="trackHighlightColor", type="Color")]
		/**
		 *  Sets or gets the highlighted track color for this <code>ProgressBar</code>.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 *  @see #borderColor
		 *  @see #trackColor
		 *  @see #color
		 */
		public function get trackHighlightColor():* {
			return _trackHighlightColor;
		}
		public function set trackHighlightColor(value:*):void {
			if (value == Color.DEFAULT) {
				_useHighlightTrackDefaultLafColor = true;
				fixHighlightTrackLafColor();
			} else {
				spas_internal::lafDTO.trackHighlightColor = _trackHighlightColor = getColor(value);
				_useHighlightTrackDefaultLafColor = false;
			}
			spas_internal::lafDTO.currentTarget = _highlightContainer;
			lookAndFeel.drawTrackHighlight();
		}
		
		private var _trackColor:* = NaN;
		[Inspectable(defaultValue="#EAEAEA", name="trackColor", type="Color")]
		/**
		 *  Sets or gets the track color for this <code>ProgressBar</code>.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 *  @see #borderColor
		 *  @see #trackHighlightColor
		 *  @see #color
		 */
		public function get trackColor():* {
			return _trackColor;
		}
		public function set trackColor(value:*):void {
			if (value == Color.DEFAULT) {
				_useTrackDefaultLafColor = true;
				fixTrackLafColor();
			} else {
				spas_internal::lafDTO.trackColor = _trackColor = getColor(value);
				_useTrackDefaultLafColor = false;
			}
			spas_internal::lafDTO.currentTarget = _trackContainer;
			lookAndFeel.drawTrack();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle = spas_internal::uioSprite.getBounds(targetCoordinateSpace);
			return new Rectangle(r.x, 0, r.width, $height);
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, $width, $height);
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_view.removeChild(_trackContainer);
			_view.removeChild(_highlightContainer);
			_view.removeChild(_barContainer);
			_view.removeChild(_borderContainer);
			spas_internal::uioSprite.removeChild(_view);
			_view = null;
			_trackContainer = null;
			_highlightContainer = null;
			_barContainer = null;
			_borderContainer = null;
			super.finalize();
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
			fixBarProperties();
			fixHighlightProperties();
			spas_internal::lafDTO.currentTarget = _trackContainer;
			lookAndFeel.drawTrack();
			spas_internal::lafDTO.currentTarget = _highlightContainer;
			lookAndFeel.drawTrackHighlight();
			spas_internal::lafDTO.currentTarget = _barContainer;
			lookAndFeel.drawBar();
			spas_internal::lafDTO.currentTarget = _borderContainer;
			lookAndFeel.drawBorder();
			drawBounds();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			fixDefaultLafColor();
			fixDefaultLafBorderColor();
			fixHighlightTrackLafColor();
			fixTrackLafColor();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _view:Sprite;
		private var _trackContainer:Sprite;
		private var _barContainer:Sprite;
		private var _borderContainer:Sprite;
		private var _highlightContainer:Sprite;
		private var _useHighlightTrackDefaultLafColor:Boolean = true;
		private var _useTrackDefaultLafColor:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			initSize(width, height);
			spas_internal::lafDTO.barLength = width;
			spas_internal::lafDTO.height = height;
			spas_internal::lafDTO.borderAlpha =
			spas_internal::lafDTO.trackHighlightOpacity =
			spas_internal::lafDTO.trackOpacity =
			spas_internal::lafDTO.barOpacity = 1;
			createContainers();
			initLaf(ProgressBarUIRef);
			spas_internal::isInitialized(1);
		}
		
		private function fixHighlightTrackLafColor():void {
			if(_useHighlightTrackDefaultLafColor) {
				spas_internal::lafDTO.trackHighlightColor =
					_trackHighlightColor = lookAndFeel.getTrackHighlightColor();
			}
		}
		
		private function fixTrackLafColor():void {
			if(_useTrackDefaultLafColor) {
				spas_internal::lafDTO.trackColor =
					_trackColor = lookAndFeel.getTrackColor();
			}
		}
		
		private function createContainers():void {
			_view = new Sprite();
			_trackContainer = new Sprite();
			_highlightContainer = new Sprite();
			_barContainer = new Sprite();
			_borderContainer = new Sprite();
			_view.addChild(_trackContainer);
			_view.addChild(_highlightContainer);
			_view.addChild(_barContainer);
			_view.addChild(_borderContainer);
			spas_internal::uioSprite.addChild(_view);
		}
		
		private function fixBarProperties():void {
			_progressValue = spas_internal::lafDTO.progressValue = 
				Math.ceil(_value * $width / 100);
		}
		
		private function fixHighlightProperties():void {
			_highlightValue = spas_internal::lafDTO.highlightValue = 
				Math.ceil(_trackHighlightValue * $width / 100);
		}
		
		private function drawBounds():void {
			with(_view.graphics) {
				clear();
				beginFill(0, 0);
				drawRect(0, 0, $width, $height);
				endFill();
			}
		}
	}
}