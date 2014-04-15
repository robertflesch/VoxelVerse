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
	// ProgressPanel.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 19/03/2011 13:54
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.IconTextFieldLayout;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.plaf.libs.ProgressPanelUIRef;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.util.RangeChecker;
	
	use namespace spas_internal;
	
	[IconFile("ProgressPanel.png")]
	
	/**
	 * 	<img src="ProgressPanel.png" alt="ProgressPanel" width="18" height="18"/>
	 * 
	 * 	The <code>ProgressPanel</code> class creates a control that visually indicates the
	 * 	progress of a lengthy. <code>ProgressPanel</code> objects are composed of a background
	 * 	panel, a label to display custom information and a visual progress bar control.
	 * 
	 * <p><strong><code>ProgressPanel</code> instances support the following CSS
	 * properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-color</code></td>
	 * 			<td>Sets the font color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>fontColor</code></td>
	 * 			<td><code>Properties.COLOR</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">font-size</code></td>
	 * 			<td>Sets the font size of the object.</td>
	 * 			<td>Recognized values are positive integers.</td>
	 * 			<td><code>fontSize</code></td>
	 * 			<td><code>Properties.FONT_SIZE</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-style</code></td>
	 * 			<td>Sets the font style of the object.</td>
	 * 			<td>Recognized values are <code class="css">normal</code> or
	 * 			<code class="css">italic</code>.</td>
	 * 			<td><code>italicized</code></td>
	 * 			<td><code>Properties.FONT_STYLE</code></td>
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
	 * 	@see org.flashapi.swing.ProgressBar
	 * 	@see org.flashapi.swing.Panel
	 * 	@see org.flashapi.swing.Label
	 * 	@see org.flashapi.swing.Initializator#progressPanel
	 * 
	 *  @includeExample ProgressPanelExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class ProgressPanel extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ProgressPanel</code> instance with 
		 * 					the specified parameters.
		 * 
		 * 	@param	width 	The width of the <code>ProgressPanel</code> instance,
		 * 					in pixels.
		 * 	@param	label 	The plain text displayed by default on the face of the
		 * 					<code>ProgressPanel</code> instance.
		 * 	@param	height 	The height of the <code>ProgressPanel</code> instance,
		 * 					in pixels. If <code>NaN</code>, the <code>autoHeight</code>
		 * 					property of this <code>ProgressPanel</code> instance is
		 * 					set to <code>true</code>. Default value is <code>NaN</code>.
		 */
		public function ProgressPanel(width:Number = 200, label:String = "", height:Number = NaN) {
			super();
			initObj(width, label, height);
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
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fontColor</code> property.
		 * 
		 * 	@see #fontColor
		 */
		protected var _fontColor:* = NaN;
		/**
		 * 	Sets or get the color of the text displayed on the face of this
		 * 	<code>ProgressPanel</code> instance. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 * 	<p>In <code>NaN</code> the color of the text is defined by the current
		 * 	Look and Feel.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 * 	@default NaN
		 */
		public function get fontColor():* {
			return _labelControl.fontColor;
		}
		public function set fontColor(value:*):void {
			_fontColor = getColor(value);
			_labelControl.fontColor = isNaN(_fontColor) ? lookAndFeel.getDefaultLabelColor() : _fontColor;
			setRefresh();
		}
		
		/**
		 *  Sets or gets the point size of text previously defined by the Look
		 * 	and Feel text format.
		 * 
		 *  @default The Look and Feel text format font size.
		 */
		public function get fontSize():Number {
			return _labelControl.fontSize;
		}
		public function set fontSize(value:Number):void {
			_labelControl.fontSize = value;
			setRefresh();
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the text displayed
		 * 	on the face of this <code>ProgressPanel</code> instance is boldface
		 * 	(<code>true</code>), or not (<code>false</code>). 
		 * 
		 *  @default false
		 */
		public function get boldFace():Boolean {
			return _labelControl.boldFace;
		}
		public function set boldFace(value:Boolean):void {
			_labelControl.boldFace = value;
			setRefresh();
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the text displayed
		 * 	on the face of this <code>ProgressPanel</code> instance is italicized
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get italicized():Boolean {
			return _labelControl.italicized;
		}
		public function set italicized(value:Boolean):void {
			_labelControl.italicized = value;
			setRefresh();
		}
		
		/**
		 *  Sets or gets the alpha transparency of the progress bar track.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 * 
		 *  @default 1
		 */
		public function get trackOpacity():Number {
			return _barControl.trackOpacity;
		}
		public function set trackOpacity(value:Number):void {
			_barControl.trackOpacity = value;
		}
		
		private var _panel:Panel;
		/**
		 * 	Returns a reference to the panel <code>Panel</code> container
		 * 	for this <code>ProgressPanel</code> instance.
		 * 
		 * 	@see #labelControl
		 */
		public function get panel():Panel {
			return _panel;
		}
		
		/**
		 * 	Returns a number that corresponds to the current value proportionally to the
		 * 	progress bar length.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #value
		 */
		public function get progressValue():Number {
			return _barControl.progressValue;
		}
		
		private var _barControl:ProgressBar;
		/**
		 * 	Returns a reference to the panel <code>Label</code> instance that 
		 * 	displays custom text within  this <code>ProgressPanel</code> instance.
		 * 
		 * 	@see #labelPlacement
		 * 	@see #showLabel
		 */
		public function get barControl():ProgressBar {
			return _barControl;
		}
		
		private var _labelControl:Label;
		/**
		 * 	Returns a reference to the panel <code>Label</code> instance that 
		 * 	displays custom text within  this <code>ProgressPanel</code> instance.
		 * 
		 * 	@see #labelPlacement
		 * 	@see #showLabel
		 */
		public function get labelControl():Label {
			return _labelControl;
		}
		
		private var _labelPlacement:String = LabelPlacement.TOP;
		/**
		 * 	Sets or gets the position of the text label within this <code>ProgressPanel</code>
		 * 	instance. Possible values are <code>LabelPlacement.BOTTOM</code> or
		 * 	<code>LabelPlacement.TOP</code>.
		 * 
		 * 	@default LabelPlacement.TOP
		 * 
		 * 	@see #labelControl
		 * 	@see #showLabel
		 */
		public function get labelPlacement():String {
			return _labelPlacement;
		}
		public function set labelPlacement(value:String):void {
			_labelPlacement = value; setRefresh();
		}
		
		private var _hasLabel:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>Label</code>
		 * 	object used to display custom text within this <code>ProgressPanel</code> 
		 * 	instance is visible (<code>true</code>), or not (<code>false</code>). 
		 * 
		 * 	@default true
		 * 
		 * 	@see #labelControl
		 * 	@see #labelPlacement
		 * 	@see #showPanel
		 */
		public function get showLabel():Boolean {
			return _hasLabel;
		}
		public function set showLabel(value:Boolean):void {
			if (_hasLabel != value) $height = NaN;
			_hasLabel = value;
			if(isNaN($height)) setRefresh();
		}
		
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
			return _barControl.value;
		}
		public function set value(value:Number):void {
			_barControl.value = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void { 
			$width = value;
			fixBoundsWidth();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set padding(value:Number):void {
			$padding = value;
			if (!isNaN(value)) {
				$padB = $padL = $padR = $padT = value;
				fixBoundsWidth();
				setRefresh();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function set paddingBottom(value:Number):void {
			$padB = value;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set paddingLeft(value:Number):void {
			$padL = value;
			fixBoundsWidth();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set paddingRight(value:Number):void {
			$padR = value;
			fixBoundsWidth();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set paddingTop(value:Number):void {
			$padT = value;
			setRefresh();
		}
		
		private var _label:String;
		/**
		 * 	Sets or gets the plain text displayed on the face of this <code>ProgressPanel</code> 
		 * 	instance.
		 * 
		 * 	@default An empty string.
		 */
		public function get label():String {
			return _label;
		}
		public function set label(value:String):void {
			_label = value;
			setRefresh();
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
			return _panel.getBounds(targetCoordinateSpace);
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return _panel.getRect(targetCoordinateSpace);
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_barControl.finalize();
			_barControl = null;
			_labelControl.finalize();
			_labelControl = null;
			_panel.finalize();
			_panel = null;
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function resize(width:Number, height:Number):void { 
			$width = width;
			fixBoundsWidth();
			$height = height;
			$autoHeight = false;
			setRefresh();
			dispatchUIOEvent(UIOEvent.RESIZED);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			panel.display();
			refresh();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			var xPos:Number = _left + $padL;
			var yPos:Number = _top + $padT;
			if (_hasLabel) {
				_labelControl.width = _boundsWidth;
				_labelControl.text = _label;
				if(!_labelControl.displayed) _labelControl.display();
				var itfl:IconTextFieldLayout = new IconTextFieldLayout();
				fixBoundsHeight();
				var itemArea:Rectangle = new Rectangle(xPos, yPos, _boundsWidth, _boundsHeight);
				var ld:Number = lookAndFeel.getLabelDelay();
				itfl.spas_internal::setLayoutProperties(itemArea, VerticalAlignment.MIDDLE, HorizontalAlignment.LEFT, ld, ld);
				switch(_labelPlacement) {
					case LabelPlacement.TOP :
						itfl.spas_internal::setLayout(_labelControl.spas_internal::uioSprite, _barControl.spas_internal::uioSprite);
						break
					case LabelPlacement.BOTTOM :
						itfl.spas_internal::setLayout(_barControl.spas_internal::uioSprite, _labelControl.spas_internal::uioSprite);
						break
				}
				itfl.spas_internal::finalize();
				itfl = null;
			} else {
				if (_labelControl.displayed) _labelControl.remove();
				_barControl.move(xPos, yPos);
				fixBoundsHeight();
			}
			
			fixHeight();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_panel.lockLaf(lookAndFeel.getPanelLaf(), true);
			_barControl.lockLaf(lookAndFeel.getProgressBarLaf(), true);
			_labelControl.lockLaf(lookAndFeel.getLabelLaf(), true);
			_labelControl.width = $width - lookAndFeel.getLeftOffset() - lookAndFeel.getRightOffset()
			if (isNaN(_fontColor)) _labelControl.fontColor = lookAndFeel.getDefaultLabelColor();
			_top = lookAndFeel.getTopOffset(); 
			_bottom = lookAndFeel.getBottomOffset(); 
			_left = lookAndFeel.getLeftOffset(); 
			_right = lookAndFeel.getRightOffset(); 
			fixBoundsWidth();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _top:Number; 
		private var _bottom:Number; 
		private var _left:Number; 
		private var _right:Number;
		private var _boundsHeight:Number;
		private var _boundsWidth:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, label:String, height:Number):void {
			$width = width;
			$height = height;
			$autoHeight = isNaN(height);
			_label = label;
			createContainers();
			initLaf(ProgressPanelUIRef);
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			_panel = new Panel();
			_panel.setLayout();
			_panel.hasMask = true;
			_panel.target = spas_internal::uioSprite;
			_panel.padding = $padB = $padL = $padR = $padT = $padding = 0;
			
			_barControl = new ProgressBar();
			_labelControl = new Label(_label);
			
			_barControl.target = _labelControl.target = _panel.content;
			_barControl.display();
		}
		
		private function fixHeight():void {
			if($autoHeight) $height = _boundsHeight + _top + _bottom + $padB + $padT;
			_panel.resize($width, $height);
		}
		
		private function fixBoundsHeight():void {
			var h:Number = _hasLabel ? _labelControl.getBounds(null).height : 0;
			_boundsHeight = _barControl.getBounds(null).height + lookAndFeel.getLabelDelay() + h;
		}
		
		private function fixBoundsWidth():void {
			_barControl.width = _boundsWidth = $width - _left - _right - $padL - $padR;
		}
	}
}