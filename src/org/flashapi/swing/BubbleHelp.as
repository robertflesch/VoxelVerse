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
	//  BubbleHelp.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.3, 14/03/2010 19:25
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.Shape;
	import flash.geom.Point;
	import org.flashapi.swing.constants.AnchorPosition;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.layout.FlowLayout;
	import org.flashapi.swing.plaf.libs.BubbleHelpUIRef;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.util.RangeChecker;
	
	use namespace spas_internal;
	
	[IconFile("BubbleHelp.png")]
	
	/**
	 * 	<img src="BubbleHelp.png" alt="BubbleHelp" width="18" height="18"/>
	 * 
	 * 	The <code>BubbleHelp</code> class provides context help functionalities to
	 * 	SPAS 3.0 applications. It allows you to create as much help as needed at the
	 * 	exact place desired. Contrary to <code>BoxHelp</code> instances, which can
	 * 	only display plain text, <code>BubbleHelp</code> instances can be used to
	 * 	display any kind of display objects, including <code>UIObject</code> instances.
	 * 
	 * 	<p>Each <code>BubbleHelp</code> instance shows a balloon-like boxhelp, inside
	 * 	of which you can add all elements you want, and an anchor. You can choose to
	 * 	display or not the anchor of a <code>BubbleHelp</code> object.</p>
	 * 
	 *  @includeExample BubbleHelpExample.as
	 * 
	 * 	@see org.flashapi.swing.ToolTip
	 * 	@see org.flashapi.swing.BoxHelp
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BubbleHelp extends UIContainer implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BubbleHelp</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	width 	The width of the <code>BubbleHelp</code> instance, in
		 * 					pixels.
		 * 	@param	height 	The height of the <code>BubbleHelp</code> instance, in
		 * 					pixels.
		 */
		public function BubbleHelp(width:Number = 100, height:Number = 50) {
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
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>showAnchor</code> property.
		 * 
		 * 	@see #showAnchor
		 */
		protected var $showAnchor:Boolean = false;
		[Inspectable(defaultValue="false", name="showAnchor")]
		/**
		 * 	A <code>Boolean</code> value that indicates whether the bubblehelp anchor
		 * 	is visible (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	<p>To set the anchor position, use the <code>setAnchorPosition()</code>
		 * 	method</p>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #setAnchorPosition()
		 */
		public function get showAnchor():Boolean {
			return $showAnchor;
		}
		public function set showAnchor(value:Boolean):void {
			$showAnchor = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>anchorCoordinates</code> property.
		 * 
		 * 	@see #anchorCoordinates
		 */
		protected var $anchorPoint:Point;
		/**
		 * 	Returns a point wich indicates the coordinates of the <code>BubbleHelp</code>
		 * 	anchor.
		 * 
		 * 	@see #anchorPercent
		 * 	@see #anchorPosition
		 */
		public function get anchorCoordinates():Point {
			setAnchorPoint();
			return $anchorPoint;
		}
		
		private var _anchorPosition:String = AnchorPosition.BOTTOM;
		/**
		 * 	Sets or gets the position of the <code>BubbleHelp</code> anchor.
		 * 	Possible values are <code>AnchorPosition</code> class constants.
		 * 	
		 * 	@default AnchorPosition.BOTTOM
		 * 
		 * 	@see #anchorPercent
		 * 	@see #anchorCoordinates
		 */
		public function get anchorPosition():String {
			return _anchorPosition;
		}
		public function set anchorPosition(value:String):void {
			spas_internal::lafDTO.anchorPosition = _anchorPosition = value;
			setRefresh();
		}
		
		private var _anchorPercent:Number = .25;
		/**
		 * 	Sets or gets the vertical, or horizontal, position value of the
		 * 	<code>BubbleHelp</code> anchor, in percentage of the width, or
		 * 	height, of the bubblehelp.
		 * 
		 * 	If <code>anchorPosition</code> is <code>AnchorPosition.TOP</code> or
		 * 	<code>AnchorPosition.BOTTOM</code> the percentage value is relative
		 * 	to the <code>BubbleHelp</code> width.
		 * 	If <code>anchorPosition</code> is <code>AnchorPosition.LEFT</code> or
		 * 	<code>AnchorPosition.RIGHT</code> the percentage value is relative
		 * 	to the <code>BubbleHelp</code> height.
		 * 
		 * 	@default 0.25
		 * 
		 * 	@see #AnchorPosition
		 * 	@see #anchorCoordinates
		 */
		public function get anchorPercent():Number {
			return _anchorPercent;
		}
		public function set anchorPercent(value:Number):void {
			RangeChecker.checkNum(value, 1, 0, "percent");
			setRefresh();
		}
		
		/**
		 * 	Returns the size of the <code>BubbleHelp</code> anchor, in pixels, as
		 * 	specified by the current Look and Feel.
		 */
		public function get anchorSize():Number {
			return lookAndFeel.getAnchorSize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets all needed properties to adjust the position of the <code>BubbleHelp</code>
		 * 	anchor.
		 * 
		 * 	@param	percent		The percent value to place the anchor along the horizontal
		 * 						axis (if the <code>anchorPosition</code> is <code>AnchorPosition.LEFT</code>
		 * 						or <code>AnchorPosition.RIGHT</code>), or along the
		 * 						vertical axis (if <code>anchorPosition</code> property 
		 * 						<code>AnchorPosition.TOP</code> or <code>AnchorPosition.BOTTOM</code>).
		 * 						This value is calculated depending on the width, or the
		 * 						height of the <code>BubbleHelp</code> instance. Default
		 * 						value is <code>0.25</code>.
		 * 	@param	position 	An <code>AnchorPosition</code> class constant that indicates
		 * 						on which <code>BubbleHelp</code> border to display the anchor.
		 * 						Default value is <code>AnchorPosition.BOTTOM</code>.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException  An
		 * 			<code>IndexOutOfBoundsException</code> if the value for the <code>percent</code>
		 * 			 parameter is lower than <code>0</code>, or greater than <code>1</code>.
		 * 
		 * 	@see #showAnchor
		 * 	@see #AnchorPosition
		 * 	@see #anchorCoordinates
		 * 	@see #anchorPercent
		 */
		public function setAnchorPosition(percent:Number = 0.25, position:String = "bottom"):void {
			RangeChecker.checkNum(percent, 1, 0, "percent");
			_anchorPercent = percent;
			spas_internal::lafDTO.anchorPosition = _anchorPosition = position;
			setRefresh();
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
			setAnchorPoint();
			lookAndFeel.drawBackground();
			if ($showAnchor) lookAndFeel.drawAnchor();
			drawMask();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			spas_internal::lafDTO.backgroundAlpha = $backgroundAlpha = NaN;
			$anchorPoint = new Point();
			initSize(width, height);
			initMinSize();
			createContainers();
			createTextureManager(spas_internal::background);
			spas_internal::lafDTO.cornerRadius = $cornerRadius =
			$horizontalGap = $verticalGap = $padL = $padT = $padR = $padB = 5;
			spas_internal::lafDTO.controlPoint = new Point();
			spas_internal::lafDTO.anchorPosition = _anchorPosition;
			initLaf(BubbleHelpUIRef);
			$layout = new FlowLayout();
			spas_internal::initLayout();
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			createBackground();
			spas_internal::lafDTO.currentTarget = spas_internal::background;
			spas_internal::uioSprite.addChild($content);
			$contentMask = new Shape();
			spas_internal::uioSprite.addChild($contentMask);
			$content.mask = $contentMask;
		}
		
		private function drawMask():void {
			var f:Figure = Figure.setFigure($contentMask);
			f.clear();
			f.beginFill(0);
			f.drawRectangle($padL, $padT, $width - $padR, $height - $padB);
			f.endFill();
		}
		
		private function setAnchorPoint():void {
			var ax:Number;
			var ay:Number;
			var size:Number = lookAndFeel.getAnchorSize();
			switch (_anchorPosition) {
				case AnchorPosition.BOTTOM :
					ay = $height + size;
					ax = _anchorPercent * $width;
					break;
				case AnchorPosition.TOP :
					ay = -size;
					ax = _anchorPercent * $width;
					break;
				case AnchorPosition.LEFT :
					ax = -size;
					ay = _anchorPercent * $height;
					break;
				case AnchorPosition.RIGHT :
					ax = $width + size;
					ay = _anchorPercent * $height;
					break;
			}
			spas_internal::lafDTO.controlPoint.x = $anchorPoint.x = ax;
			spas_internal::lafDTO.controlPoint.y = $anchorPoint.y = ay;
		}
	}
}