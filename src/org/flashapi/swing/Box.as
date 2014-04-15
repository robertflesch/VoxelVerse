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
	//  Box.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.5, 14/03/2010 18:55
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.Shape;
	import org.flashapi.swing.border.AbstractBorderContainer;
	import org.flashapi.swing.border.TitleBorder;
	import org.flashapi.swing.constants.BorderPosition;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.layout.FlowLayout;
	import org.flashapi.swing.plaf.libs.BoxUIRef;
	import org.flashapi.swing.util.Observable;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Box.png")]
	
	/**
	 * 	<img src="Box.png" alt="Box" width="18" height="18"/>
	 * 
	 *	The <code>Box</code> control is a rectangular or rounded rectangular box based partly
	 * 	on the CSS box model.
	 * 
	 * 	<p>Each box has a content area (e.g., text, an image, etc.) and optional surrounding
	 * 	padding, border, and margin areas; the size of each area is specified by properties
	 * 	defined below. The following diagram shows how these areas relate and
	 * 	the terminology used to refer to pieces of margin, border, and padding:</p>
	 * 	<p><img src = "../../../doc-images/boxdim.gif" alt="Image illustrating the
	 * 	relationship between content, padding, borders, and margins." /></p>
	 * 
	 * 	<p>The margin, border, and padding can be broken down into left, right, top, and
	 * 	bottom segments (e.g., in the diagram, "LM" for left margin, "RP" for right padding,
	 * 	"TB" for top border, etc.).</p>
	 * 	
	 * 	<p>The perimeter of each of the four areas (content, padding, border, and margin)
	 * 	is called an "edge", so each box has four edges:</p>
	 * 	<ul>
	 * 		<li><strong>content edge or inner edge</strong><br />
	 * 		The content edge surrounds the element rendered content.</li>
	 * 		<li><strong>padding edge</strong><br />
	 * 		The padding edge surrounds the box padding. If the padding has <code>0</code> 
	 * 		pixel width, the padding edge is the same as the content edge. The padding edge
	 * 		of a box defines the edges of the containing block established by the box.</li>
	 * 		<li><strong>border edge</strong><br />
	 * 		The border edge surrounds the box border. If the border has <code>0</code> pixel
	 * 		width, the border edge is the same as the padding edge.</li>
	 * 		<li><strong>margin edge or outer edge </strong><br />
	 * 		The margin edge surrounds the box margin. If the margin has <code>0</code> pixel
	 * 		width, the margin edge is the same as the border edge.</li>
	 * 	</ul>
	 * 
	 * 	@includeExample BoxExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Box extends AbstractBorderContainer implements Observer, TitleBorder, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Box</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	width 	The width of the <code>Box</code> instance, in pixels.
		 * 	@param	height 	The height of the <code>Box</code> instance, in pixels.
		 * 	@param	borderStyle The type of border for this the <code>Box</code>
		 * 						instance, defined by the <code>BorderStyle</code> class.
		 * 						Default value is <code>BorderStyle.NONE</code>.
		 */
		public function Box(width:Number = 100, height:Number = 100, borderStyle:String = "none") {
			super();
			initObj(width, height, borderStyle);
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
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		public static const lafList:Observable = new Observable();
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		public static var laf:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *   @private
		 */
		override public function get backgroundWidth():Number {
			return $width;
		}
		
		/**
		 *   @private
		 */
		override public function get backgroundHeight():Number {
			return $height;
		}
		
		/**
		 *  @private
		 */
		override public function set color(value:*):void {
			print(
				Locale.spas_internal::ERRORS["GET_DEPRECATED_PROP_WARNING_MESSAGE"]("color", "backgroundColor")
			);
		}
		
		/**
		 *  @private
		 */
		override public function set texture(value:*):void {
			print(
				Locale.spas_internal::ERRORS["GET_DEPRECATED_PROP_WARNING_MESSAGE"]("texture", "backgroundTexture")
			);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>title</code> property.
		 * 
		 * 	@see #title
		 */
		protected var $title:String = null;
		/**
		 * 	@inheritDoc
		 */
		public function get title():String {
			return $title;
		}
		public function set title(value:String):void { 
			$title = value;
			if (value != null) {
				_titleLabel.text = value;
				_titleLabel.display();
			} else {
				_titleLabel.remove();
				_titleLabel.text = "";
			}
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>titlePosition</code> property.
		 * 
		 * 	@see #titlePosition
		 */
		protected var $titlePosition:String = BorderPosition.TOP;
		/**
		 * 	@inheritDoc
		 */
		public function get titlePosition():String {
			return $titlePosition;
		}
		public function set titlePosition(value:String):void {
			$titlePosition = value;
			if ($title != null) setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>titleAlignment</code> property.
		 * 
		 * 	@see #titleAlignment
		 */
		protected var $titleAlignment:String = HorizontalAlignment.LEFT;
		/**
		 * 	@inheritDoc
		 */
		public function get titleAlignment():String {
			return $titleAlignment;
		}
		public function set titleAlignment(value:String):void {
			$titleAlignment = value;
			if ($title != null) setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set gradientMode(value:Boolean):void {
			print(
				Locale.spas_internal::ERRORS["GET_DEPRECATED_PROP_WARNING_MESSAGE"]("gradientMode", "backgroundGradientMode")
			);
		}
		
		/**
		 *  @private
		 */
		override public function set gradientProperties(value:Object):void {
			print(
				Locale.spas_internal::ERRORS["GET_DEPRECATED_PROP_WARNING_MESSAGE"]("gradientProperties", "backgroundGradientProperties")
			);
		}
		
		private var _titleLabel:Label;
		/**
		 *  A reference to the <code>Label</code> instance used by this <code>Box</code>
		 * 	instance to display the <code>title</code> text.
		 * 
		 * 	@see #title
		 */
		public function get titleLabel():Label {
			return _titleLabel;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>useRoundedPadding</code> property.
		 * 
		 * 	@see #useRoundedPadding
		 */
		protected var $useRoundedPadding:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the mask used to
		 * 	hide objects that are out of box bounds uses rounded corners (<code>true</code>),
		 * 	or not (<code>false</code>). Setting <code>useRoundedPadding</code> to
		 * 	<code>false</code> allows faster rendering but can occurs some visual
		 * 	problems when corner radius properties are different from <code>0</code>.
		 * 
		 * 	@default false
		 */
		public function get useRoundedPadding():Boolean {
			return $useRoundedPadding;
		}
		public function set useRoundedPadding(value:Boolean):void {
			$useRoundedPadding = value;
			drawMask();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Override metric properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {
			$backgroundTextureManager.height = value;
			super.height = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			$backgroundTextureManager.width = value;
			super.width = value;
		}
		
		/**
		 * 	@private
		 */
		override public function resize(width:Number, height:Number):void { 
			$backgroundTextureManager.width = width;
			$backgroundTextureManager.height = height;
			super.resize(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			_titleLabel.finalize();
			_titleLabel = null;
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
			$borderDecorator.drawBackground();
			$borderDecorator.spas_internal::fixTitlePosition(_titleLabel, $titlePosition, $titleAlignment, $title != null);
			$borderDecorator.drawBorders();
			drawMask();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		protected function drawMask():void {
			var f:Figure = Figure.setFigure($contentMask);
			f.clear();
			f.beginFill(0);
			//f.lineStyle(_borderWidth, 0, 0);
			$useRoundedPadding ?
				f.drawRoundedRectangle($padL, $padT, $width - $padR, $height - $padB, $cornerRadius, $cornerRadius) :
				f.drawRectangle($padL, $padT, $width - $padR, $height - $padB);
			f.endFill();
		}
		
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			spas_internal::lafDTO.cornerRadius = $cornerRadius = lookAndFeel.getDefaultRadius();
			super.setSpecificLafChanges();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number, borderStyle:String):void {
			createBackground();
			$width = width;
			$height = height;
			initMinSize();
			$borderStyle = borderStyle;
			initLaf(BoxUIRef);
			createContainers();
			createBackgroundTextureManager(spas_internal::background);
			$layout = new FlowLayout();
			spas_internal::initLayout();
			//$borderColor = lookAndFeel.getBorderColor();
			$horizontalGap = $verticalGap = $padL = $padT = $padR = $padB = 5;
			$borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
			spas_internal::setSelector(Selectors.BOX); 
			spas_internal::isInitialized(1);
		}
		
		private function createContainers():void {
			spas_internal::uioSprite.addChild($content);
			spas_internal::uioSprite.addChild(spas_internal::borders);
			$contentMask = new Shape();
			spas_internal::uioSprite.addChild($contentMask);
			$content.mask = $contentMask;
			_titleLabel = new Label();
			_titleLabel.target = spas_internal::uioSprite;
		}
	}
}