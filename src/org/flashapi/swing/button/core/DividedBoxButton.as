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

package org.flashapi.swing.button.core {
	
	// -----------------------------------------------------------
	// DividedBoxButton.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.5, 15/03/2010 22:39
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.DividedBoxOrientation;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.SizeAdjuster;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.DividedBox;
	import org.flashapi.swing.plaf.libs.DividerButtonUIRef;
	import org.flashapi.swing.util.MeasureUtil;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>DividedBoxButton</code> class creates objects that represent the
	 * 	buttons used as dividers by the <code>DividedBox</code> class.
	 * 
	 * 	<p>This class must not be directly instantiated.</p>
	 * 
	 * 	@see org.flashapi.swing.DividedBox
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DividedBoxButton extends UIObject implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DividedBoxButton</code> instance.
		 * 
		 * 	@param	uio	The <code>DividedBox</code> object associated with this
		 * 				<code>DividedBoxButton</code> instance.
		 * 	@param	target	The sprite container where the <code>DividedBox</code> object
		 * 					will be displayed.
		 * 	@param	separatorTarget	The separator object associated with this
		 * 							<code>DividedBoxButton</code> instance.
		 */
		public function DividedBoxButton(uio:DividedBox, target:Sprite, separatorTarget:Sprite) {
			super();
			initObj(uio, target, separatorTarget);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				createUIObject(x, y);
				createEvents();
				doStartEffect();
			}
		}
		
		/**
		 *  @private
		 */
		override public function remove():void {
			if ($displayed) {
				unload();
				$evtColl.removeAllEvents();
			}
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
			drawButtonTrack();
			lookAndFeel.drawOutState();
			fixPositions();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		spas_internal function setObjects(obj1:Object, obj2:Object):void {
			_obj1 = obj1;
			_obj2 = obj2;
			initPercentMap();
		}
		
		private var _orientation:String;
		/**
		 *  @private
		 */
		spas_internal function set orientation(value:String):void {
			_orientation = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _uio:DividedBox;
		private var _obj1:Object;
		private var _obj2:Object;
		private var _buttonTrack:Shape;
		private var _buttonCont:Sprite;
		private var _trackCont:Sprite;
		private var _percentSizes:Array;
		private var _isDragged:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function initObj(uio:DividedBox, target:Sprite, separatorTarget:Sprite):void {
			_percentSizes = new Array(4);
			_uio = uio;
			createContainers();
			initSize(width, height);
			initMinSize(5, 5);
			createColorsObj();
			initLaf(DividerButtonUIRef);
			_isDragged = false;
			spas_internal::uioSprite.buttonMode = true;
			spas_internal::lafDTO.currentTarget = _buttonCont;
			this.target = target;
			spas_internal::setSelector(Selectors.DIVIDER);
			spas_internal::isInitialized(1);
		}
		
		private function createEvents():void {
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OVER, mouseOverHandler);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OUT, mouseOutHandler);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_DOWN, mouseDownHandler);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			//lookAndFeel.drawOverState();
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			lookAndFeel.drawOutState();
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			var h:Number = _uio.height;
			var w:Number = _uio.width;
			var pl:Number = _uio.paddingLeft;
			var pt:Number = _uio.paddingTop;
			lookAndFeel.drawPressedState();
			var t:Number = _uio.dividerThickness;
			_orientation == DividedBoxOrientation.HORIZONTAL ?
				lookAndFeel.drawSeparator(_trackCont, t, h) :
				lookAndFeel.drawSeparator(_trackCont, w, t);
			$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, stageMouseUpHandler);
			$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, dragEnter);
			setPercentMap();
			var r:Rectangle = _orientation == DividedBoxOrientation.HORIZONTAL ?
				new Rectangle(pl, 0, w - _uio.paddingRight - _buttonCont.height + pl, 0) :
				new Rectangle(0, pt, 0, h - _uio.paddingBottom - _buttonCont.height + pt);
			spas_internal::uioSprite.startDrag(false, r);
		}
		
		private function dragEnter(e:MouseEvent):void {
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, dragEnter);
			_isDragged = true;
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			invalidateUpdate(false);
			lookAndFeel.drawOverState();
			lookAndFeel.clearSeparator(_trackCont);
			spas_internal::uioSprite.stopDrag();
			if (_isDragged) {
				setObjectsSize();
				_uio.spas_internal::updateLayout();
				_uio.spas_internal::updateDividers();
			}
			_isDragged = false;
		}
		
		private function stageMouseUpHandler(e:MouseEvent):void {
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, stageMouseUpHandler);
			mouseUpHandler(e);
		}
		
		private function setObjectsSize():void {
			var pos:Number;
			var pad:Number = _orientation == DividedBoxOrientation.HORIZONTAL ? _uio.paddingLeft : _uio.paddingTop;
			var maxBound:Number;
			var r1:Number; var r2:Number;
			var minSize1:Number; var minSize2:Number;
			var flag1:Boolean = (_obj1 is SizeAdjuster);
			var flag2:Boolean = (_obj2 is SizeAdjuster);
			var size:Number;
			var gap:Number;
			if (_orientation == DividedBoxOrientation.HORIZONTAL) {
				gap = _uio.horizontalGap;
				r1 = MeasureUtil.getWidthRatio(_obj1 as DisplayObject);
				r2 = MeasureUtil.getWidthRatio(_obj2 as DisplayObject);
				flag1 ?  (minSize1 = _obj1.getRealMinWidth()) :
					(minSize1 = isNaN(_obj1.minWidth) ? 0 : _obj1.minWidth);
				flag2 ? (minSize2 = _obj2.getRealMinWidth()) :
					(minSize2 = isNaN(_obj2.minWidth) ? 0 : _obj2.minWidth);
				pos = spas_internal::uioSprite.x + pad;
				size = flag2 ? _obj2.getRealWidth() : _obj2.width;
				maxBound = _obj2.x + size;
				if (pos >= maxBound - minSize2) size = maxBound - _obj1.x - r1 - minSize2 - gap;
				else {
					size = (pos - pad > _obj1.x + minSize1 + r1) ? (pos - _obj1.x - pad - r1) : minSize1;
				}
				flag1 ? _obj1.setRealWidth(size) : _obj1.width = size;
				_percentSizes[1] = size;
				if (pos >= maxBound - minSize2) size = minSize2;
				else size = maxBound - (size + _obj1.x) - gap - r2;
				flag2 ? _obj2.setRealWidth(size) : _obj2.width = size;
				_percentSizes[3] = size;
			} else if (_orientation == DividedBoxOrientation.VERTICAL) {
				gap = _uio.verticalGap;
				r1 = MeasureUtil.getHeightRatio(_obj1 as DisplayObject);
				r2 = MeasureUtil.getHeightRatio(_obj2 as DisplayObject);
				flag1 ?  (minSize1 = _obj1.getRealMinHeight()) :
					(minSize1 = isNaN(_obj1.minHeight) ? 0 : _obj1.minHeight);
				flag2 ? (minSize2 = _obj2.getRealMinHeight()) :
					(minSize2 = isNaN(_obj2.minHeight) ? 0 : _obj2.minHeight);
				pos = spas_internal::uioSprite.y + pad;
				size = flag2 ? _obj2.getRealHeight() : _obj2.height;
				maxBound = _obj2.y + size;
				if (pos >= maxBound - minSize2) size = maxBound - _obj1.y - r1 - minSize2 - gap;
				else {
					size = (pos - pad > _obj1.y + minSize1 + r1) ? (pos - _obj1.y - pad - r1) : minSize1;
				}
				flag1 ? _obj1.setRealHeight(size) : _obj1.height = size;
				_percentSizes[1] = size;
				if (pos >= maxBound - minSize2) size = minSize2;
				else size = maxBound - (size + _obj1.y) - gap - r2;
				flag2 ? _obj2.setRealHeight(size) : _obj2.height = size;
				_percentSizes[3] = size;
			}
			fixPercentSizes();
		}
		
		private function drawButtonTrack():void {
			var size:Number = _orientation == DividedBoxOrientation.HORIZONTAL ? _uio.height : _uio.width;
			with (_buttonTrack.graphics) {
				clear();
				beginFill(0, 0);
				drawRect(0, 0, _uio.dividerThickness, size);
				endFill();
			}
		}
		
		private function createContainers():void {
			_buttonTrack = new Shape();
			spas_internal::uioSprite.addChildAt(_buttonTrack, 0);
			_trackCont = new Sprite();
			spas_internal::uioSprite.addChildAt(_trackCont, 1);
			_buttonCont = new Sprite();
			spas_internal::uioSprite.addChildAt(_buttonCont, 2);
			drawButtonTrack();
		}
		
		private function fixPositions():void {
			var xPos:Number;
			var yPos:Number;
			var xThumbPos:Number;
			var yThumbPos:Number;
			var rot:Number;
			var t:Number = _uio.dividerThickness;
			switch(_orientation) {
				case DividedBoxOrientation.HORIZONTAL : 
					xPos = _obj2.x - _uio.horizontalGap/2 - t/2;
					rot = yPos = 0;
					xThumbPos = (_buttonTrack.width - _buttonCont.width) / 2;
					yThumbPos = (_uio.height - _buttonCont.height) / 2;
					break;
				case DividedBoxOrientation.VERTICAL : 
					xPos = 0;
					rot = 90;
					yPos = _obj2.y - _uio.verticalGap/2 - t/2;
					xThumbPos = (_buttonTrack.width + _buttonCont.width) / 2
					yThumbPos = (_buttonTrack.height - _buttonCont.height) / 2;
					_buttonTrack.x = _uio.width;
					break;
			}
			_buttonTrack.rotation = _buttonCont.rotation = rot;
			_buttonCont.x = xThumbPos, _buttonCont.y = yThumbPos;
			this.x = xPos, this.y = yPos;
		}
		
		private function setPercentMap():void {
			invalidateUpdate(true);
			if (_orientation == DividedBoxOrientation.HORIZONTAL) {
				_percentSizes[0] = isNaN(_obj1.percentWidth);
				_percentSizes[2] = isNaN(_obj2.percentWidth);
				_obj1.percentWidth = _obj2.percentWidth = NaN; 
			} else {
				_percentSizes[0] = isNaN(_obj1.percentHeight);
				_percentSizes[2] = isNaN(_obj2.percentHeight);
				_obj1.percentHeight = _obj2.percentHeight = NaN;
			}
		}
		
		private function initPercentMap():void {
			if (_orientation == DividedBoxOrientation.HORIZONTAL) {
				_percentSizes[0] = isNaN(_obj1.percentWidth);
				_percentSizes[2] = isNaN(_obj2.percentWidth);
			} else {
				_percentSizes[0] = isNaN(_obj1.percentHeight);
				_percentSizes[2] = isNaN(_obj2.percentHeight);
			}
		}
		
		private function invalidateUpdate(value:Boolean):void {
			_obj1.spas_internal::invalidateLayoutUpdate = _obj2.spas_internal::invalidateLayoutUpdate =
			_obj1.invalidateRefresh = _obj2.invalidateRefresh = value;
		}
		
		private function fixPercentSizes():void {
			var s:Number;
			var ne:Number = _uio.numElements -1;
			if (_orientation == DividedBoxOrientation.HORIZONTAL) {
				s = _uio.width - _uio.paddingLeft - _uio.paddingRight - ne * _uio.horizontalGap;
				_obj1.percentWidth = _percentSizes[0] ? NaN : getPercentSize(s, _percentSizes[1]);
				_obj2.percentWidth = _percentSizes[2] ? NaN : getPercentSize(s, _percentSizes[3]);
			} else {
				s = _uio.height - _uio.paddingTop - _uio.paddingBottom - ne * _uio.verticalGap;
				_obj1.percentHeight = _percentSizes[0] ? NaN : getPercentSize(s, _percentSizes[1]);
				_obj2.percentHeight = _percentSizes[2] ? NaN : getPercentSize(s, _percentSizes[3]);
				//trace(_percentSizes[1], _percentSizes[3]);
			}
		}
		
		private function getPercentSize(size:Number, value:Number):Number {
			return value / size * 100 ;
		}
	}
}