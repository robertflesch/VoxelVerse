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

package org.flashapi.swing.decorator {
	
	// -----------------------------------------------------------
	// BorderDecorator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 22/04/2011 01:13
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.border.BorderDTO;
	import org.flashapi.swing.constants.BorderPosition;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.TextureType;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.Label;
	import org.flashapi.swing.managers.TextureManager;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>BorderDecorator</code> class provides decoration mechanism to give
	 * 	<code>UIObject</code> instances an easy-to-implement way for rendring
	 * 	<code>Border</code> objects.
	 * 
	 * 	@see org.flashapi.swing.border.Border
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BorderDecorator {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>BorderDecorator</code> instance.
		 * 
		 * 	@param	border	The <code>Border</code> object to be decorated.
		 * 	@param	textureManager	The <code>TextureManager</code> associated with
		 * 							the <code>Border</code> object to be decorated.
		 */
		public function BorderDecorator(border:Border, textureManager:TextureManager = null) {
			super();
			initObj(border, textureManager);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates whether the <code>BorderDecorator</code> instance is rendered
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public var active:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _border:Border;
		/**
		 * 	Returns a reference to the decorated <code>Border</code> instance.
		 */
		public function get border():Border {
			return _border;
		}
		
		/**
		 * 	Returns the top-left-corner radius value for the decorated <code>Border</code>
		 * 	instance.
		 */
		public function get topLeftCorner():Number {
			return _dto.tlcr;
		}
		
		/**
		 * 	Returns the top-right-corner radius value for the decorated <code>Border</code>
		 * 	instance.
		 */
		public function get topRightCorner():Number {
			return _dto.trcr;
		}
		
		/**
		 * 	Returns the bottom-right-corner radius value for the decorated <code>Border</code>
		 * 	instance.
		 */
		public function get bottomRightCorner():Number {
			return _dto.brcr;
		}
		
		/**
		 * 	Returns the bottom-left-corner radius value for the decorated <code>Border</code>
		 * 	instance.
		 */
		public function get bottomLeftCorner():Number {
			return _dto.blcr;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Draws the bagkground of the decorated <code>Border</code> instance.
		 * 
		 * 	@see #drawBorders()
		 * 	@see #clearBackground()
		 */
		public function drawBackground():void {
			if (!active) return;
			getDTO();
			if (_textureManager == null) return;
			var gm:Boolean = _dto.gradientMode;
			var d1:Number = 0;
			var d2:Number = 0;
			var d3:Number = 0;
			if (_dto.borderStyle != BorderStyle.NONE) {
				d1 = _dto.borderWidth / 2;
				if (Boolean(_dto.borderWidth % 2)) d3 = .5;
				else d2 = .5;
			}
			_textureManager.setShape = function():void {
				with (_textureManager.figure) {
					drawRoundedBox(d1, d1, _dto.width - d1 + d2, _dto.height - d1 + d3, _dto.tlcr - d1, _dto.trcr - d1, _dto.brcr - d1, _dto.blcr - d1);
					endFill();
				}
			}
			if (_textureManager.texture == null && !gm) {
				_textureManager.color = _dto.bgColor;
				_textureManager.alpha = _dto.bgAlpha;
				_textureManager.draw();
			} else if(gm) _textureManager.draw(TextureType.GRADIENT); 
			else _textureManager.draw(TextureType.TEXTURE);
		}
		
		/**
		 * 	Draws the border lines of the decorated <code>Border</code> instance.
		 * 
		 * 	@see #drawBackground()
		 * 	@see #clearBorders()
		 */
		public function drawBorders():void {
			if (!active) return;
			_line.clear();
			if (_dto.borderStyle == BorderStyle.NONE) return;
			_line.dto = _dto;
			_line.drawBorders(_titleMetrics, _borderPos);
			//trace(fix, _borders.x);
			_borders.x = _borderOrigin.x;
			_borders.y = _borderOrigin.y;
		}
		
		/**
		 * 	Clears the bagkground of the decorated <code>Border</code> instance.
		 * 
		 * 	@see #drawBackground()
		 */
		public function clearBackground():void {
			_textureManager.clear();
		}
		
		/**
		 * 	Clears the border lines of the decorated <code>Border</code> instance.
		 * 
		 * 	@see #drawBorders()
		 */
		public function clearBorders():void {
			_line.clear();
		}
		
		/**
		 * 	@copy org.flashapi.swing.core.IUIObject#finalize()
		 */
		public function finalize():void {
			_border = null;
			_line.finalize();
			_line = null;
			_textureManager.finalize();
			_textureManager = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function fixBorderOrigin(x:Number, y:Number):void {
			_borderOrigin = new Point(x, y);
		}
		
		/**
		 * @private
		 */
		spas_internal function fixTitlePosition(title:Label, vAlign:String, hAlign:String, hasTitle:Boolean):void {
			if (hasTitle) {
				var xPos:Number;
				var yPos:Number;
				var c1:Number = _dto.tlcr;
				var c2:Number = _dto.trcr;
				var titleDelay:Number = 4;
				var vTitleDelay:Number = 2;
				_borderPos = BorderLineDecorator.TOP;
				var bw:Number = _dto.borderWidth / 2;
				//var metrics:TextLineMetrics = title.textField.getLineMetrics(0);
				switch(vAlign) {
					case BorderPosition.TOP:
						yPos = -title.height / 2;
						break;
					case BorderPosition.ABOVE_TOP:
						yPos = -title.height - vTitleDelay - bw;
						break;
					case BorderPosition.BELOW_TOP:
						yPos = vTitleDelay + bw;
						break;
					case BorderPosition.BOTTOM:
						yPos = _dto.height - title.height / 2;
						c1 = _dto.blcr;
						c2 = _dto.brcr;
						_borderPos = BorderLineDecorator.BOTTOM;
						break;
					case BorderPosition.ABOVE_BOTTOM:
						yPos = _dto.height - title.height - vTitleDelay - bw;
						c1 = _dto.blcr;
						c2 = _dto.brcr;
						_borderPos = BorderLineDecorator.BOTTOM;
						break;
					case BorderPosition.BELOW_BOTTOM:
						yPos = _dto.height + vTitleDelay + bw;
						c1 = _dto.blcr;
						c2 = _dto.brcr;
						_borderPos = BorderLineDecorator.BOTTOM;
						break;
				}
				switch(hAlign) {
					case HorizontalAlignment.LEFT :
						xPos = c1 + titleDelay + bw;
						break;
					case HorizontalAlignment.CENTER :
						xPos = (_dto.width - title.width) / 2;
						break;
					case HorizontalAlignment.RIGHT :
						xPos = _dto.width - c2 - title.width - titleDelay - bw;
						break;
				}
				title.move(xPos, yPos);
				_titleMetrics = (vAlign == BorderPosition.TOP || vAlign == BorderPosition.BOTTOM) ?
					new Rectangle(title.x, title.y, title.width, title.height) : null;
			} else _titleMetrics = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textureManager:TextureManager;
		private var _borders:Sprite;
		private var _borderOrigin:Point;
		private var _line:BorderLineDecorator;
		private var _titleMetrics:Rectangle = null;
		private var _dto:BorderDTO;
		private var _borderPos:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(border:Border, textureManager:TextureManager):void {
			_border = border;
			getUIOContainers();
			_textureManager = textureManager;
			_borderOrigin = new Point(0, 0);
			_dto = new BorderDTO();
			_dto.tlcr = _dto.trcr = _dto.brcr = _dto.blcr = 0;
		}
		
		private function getDTO():void {
			var o:IUIObject = _border as IUIObject;
			_dto.cornerRadius = isNaN(o.cornerRadius) ? 0 : o.cornerRadius;
			_dto.width = _border.backgroundWidth;
			_dto.height = _border.backgroundHeight;
			_dto.bgColor = isNaN(o.backgroundColor) ?
				getBackgroundColor(o) : o.backgroundColor;
			_dto.bgAlpha = o.backgroundAlpha;
			
			_dto.tlcr = isNaN(_border.topLeftCorner) ?
				_dto.cornerRadius : _border.topLeftCorner;
			_dto.trcr = isNaN(_border.topRightCorner) ?
				_dto.cornerRadius : _border.topRightCorner;
			_dto.brcr = isNaN(_border.bottomRightCorner) ?
				_dto.cornerRadius : _border.bottomRightCorner;
			_dto.blcr = isNaN(_border.bottomLeftCorner) ?
				_dto.cornerRadius : _border.bottomLeftCorner;
			
			_dto.borderColor = isNaN(o.borderColor) ?
				getBorderColor(o) : o.borderColor;
			_dto.btColor = isNaN(_border.borderTopColor) ?
				_dto.borderColor : _border.borderTopColor;
			_dto.brColor = isNaN(_border.borderRightColor) ?
				_dto.borderColor : _border.borderRightColor;
			_dto.bbColor = isNaN(_border.borderBottomColor) ?
				_dto.borderColor : _border.borderBottomColor;
			_dto.blColor = isNaN(_border.borderLeftColor) ?
				_dto.borderColor : _border.borderLeftColor;
			
			_dto.borderAlpha = isNaN(o.borderAlpha) ?
				getBorderAlpha(o) : o.borderAlpha;
			_dto.btAlpha = isNaN(_border.borderTopOpacity) ?
				_dto.borderAlpha : _border.borderTopOpacity;
			_dto.brAlpha = isNaN(_border.borderRightOpacity) ?
				_dto.borderAlpha : _border.borderRightOpacity;
			_dto.bbAlpha = isNaN(_border.borderBottomOpacity) ?
				_dto.borderAlpha : _border.borderBottomOpacity;
			_dto.blAlpha = isNaN(_border.borderLeftOpacity) ?
				_dto.borderAlpha : _border.borderLeftOpacity;
			_dto.shadowAlpha = _border.borderShadowOpacity;
			_dto.highlightAlpha = _border.borderHighlightOpacity;
			
			_dto.gradientMode = o.backgroundGradientMode;
			_dto.borderWidth = Math.round(_border.borderWidth);
			_dto.borderStyle = _border.borderStyle;
			
			_dto.shadowColor = isNaN(_border.borderShadowColor) ?
				0x333333 : _border.borderShadowColor;
			_dto.highlightColor = isNaN(_border.borderHighlightColor) ?
				0xFFFFFF : _border.borderHighlightColor;
			
			o = null;
		}
		
		private function getBackgroundColor(obj:*):uint {
			return obj is LafRenderer ? obj.lookAndFeel.getBackgroundColor() : 0xFFFFFF;
		}
		
		private function getBorderColor(obj:*):uint {
			return obj is LafRenderer ? obj.lookAndFeel.getBorderColor() : 0x333333;
		}
		
		private function getBorderAlpha(obj:*):Number {
			return obj is LafRenderer ? obj.lookAndFeel.getBorderAlpha() : 1;
		}
		
		private function getUIOContainers():void {
			//_background = _border.backgroundContainer;
			_borders = _border.bordersContainer;
			_borders.cacheAsBitmap = true;
			_line = new BorderLineDecorator(_borders);
		}
	}
}