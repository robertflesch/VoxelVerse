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

package org.flashapi.swing.layout {

	// -----------------------------------------------------------
	// FlowLayout.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 22/01/2010 10:32
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.LayoutHorizontalAlignment;
	import org.flashapi.swing.constants.LayoutHorizontalDirection;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.LayoutVerticalAlignment;
	import org.flashapi.swing.constants.LayoutVerticalDirection;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.layout.AbstractLayout;
	import org.flashapi.swing.ScrollPane;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------

	/**
	 *  The "finished" <code>LayoutEvent</code> occurs after child elements are added
	 * 	or removed, bounds of the <code>UIContainer</code> object change and after 
	 * 	all other changes that could affect the layout have been performed.
	 *
	 *  @eventType org.flashapi.swing.event.LayoutEvent.FINISHED
	 */
	[Event(name="finished", type="org.flashapi.swing.event.LayoutEvent")]
	
	/**
	 * 	A flow layout arranges components in a directional flow, much like lines of text
	 * 	in a paragraph. The flow direction is determined either by <code>setHorizontalOrientation()</code>
	 * 	or <code>setVerticalOrientation()</code> methods; it may be one of the following values:
	 * 	<br>when <code>orientation</code> property is <code>LayoutOrientation.HORIZONTAL</code>
	 * 	<ul>
	 * 		<li>LayoutHorizontalDirection.LEFT_TO_RIGHT,</li>
	 * 		<li>LayoutHorizontalDirection.RIGHT_TO_LEFT,</li>
	 * 	</ul>
	 * 	or when <code>orientation</code> is <code>LayoutOrientation.VERTICAL</code>
	 * 	<ul>
	 *		<li>LayoutVerticalDirection.TOP_TO_BOTTOM,</li>
	 * 		<li>LayoutVerticalDirection.BOTTOM_TO_TOP.</li>
	 * 	</ul>
	 * 
	 * 	<p><code>FlowLayout</code> objects are typically used to arrange <code>UIObjects</code>
	 * 	within a panel. The line horizontal alignment is specified by the
	 * 	<code>horizontalAlignment</code> property. Possible values are:
	 * 	</p>
	 * 	<ul>
	 * 		<li>LayoutHorizontalAlignment.LEFT,</li>
	 * 		<li>LayoutHorizontalAlignment.RIGHT,</li>
	 * 		<li>LayoutHorizontalAlignment.CENTER.</li>
	 * 	</ul>
	 * 	<p>The line vertical alignment is determined by the <code>verticalAlignment</code>
	 *  property. Possible values are:</p>
	 * 	<ul>
	 * 		<li>LayoutVerticalAlignment.TOP,</li>
	 * 		<li>LayoutVerticalAlignment.MIDDLE,</li>
	 * 		<li>LayoutVerticalAlignment.BOTTOM,</li>
	 * 		<li>LayoutVerticalAlignment.BASELINE.</li>
	 * 	</ul>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FlowLayout extends AbstractLayout implements Layout {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>FlowLayout</code> instance with the 
		 * 					specified orientation.
		 * 
		 * @param	orientation	The orientation of the layout. Possible values are
		 * 						<code>LayoutOrientation.HORIZONTAL</code> and
		 * 						<code>LayoutOrientation.VERTICAL</code>.
		 */
		public function FlowLayout(orientation:String = "horizontal") {
			super();
			initObj(orientation);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		override public function set horizontalAlignment(value:String):void {
			switch (value) {
				case LayoutHorizontalAlignment.LEADING :
					$hAlignment = LayoutHorizontalAlignment.LEFT;
					break;
				case LayoutHorizontalAlignment.TRAILING :
					$hAlignment = LayoutHorizontalAlignment.RIGHT;
					break;
				default :
					$hAlignment = value;
			}
			if(spas_internal::bounds != null) moveObjects(spas_internal::bounds);
		}
		
		/**
		 * 	@inheritDoc
		 */
		override public function set orientation(value:String):void {
			$orientation = value;
			if(spas_internal::bounds != null) moveObjects(spas_internal::bounds);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function moveObjects(bounds:Rectangle, caller:* = null):void {
			spas_internal::bounds = bounds;
			if ($elementsList.length > 0) {
				//trace(bounds, spas_internal::_bounds);
				var l:Number = $elementsList.length - 1;
				_vGapSize = l * $target.verticalGap;
				_hGapSize = l * $target.horizontalGap;
				_targetIsScrollPane = $target is ScrollPane;
				getPaddingProperties();
				$layoutHeight = $target.height;
				$layoutWidth = $target.width;
				switch($orientation) {
					case LayoutOrientation.HORIZONTAL :
						$target.autoSize || $target.autoHeight || _targetIsScrollPane ?
							computeHorizontalLayout() : setHorizontalLayout();
						break;
					case LayoutOrientation.VERTICAL :
						$target.autoSize || $target.autoWidth || _targetIsScrollPane  ?
							computeVerticalLayout() : setVerticalLayout();
						break
				}
				$hasListChanged = false;
			}
			_objBounds = null;
			_obj = null;
			if ($autoSizeAnimated || $animated) playAnimation();
			else dispatchFinishedEvent();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _mrgT:Number = 0;
		private var _mrgR:Number = 0;
		private var _mrgB:Number = 0;
		private var _mrgL:Number = 0;
		private var _padT:Number;
		private var _padR:Number;
		private var _padB:Number;
		private var _padL:Number;
		private var _targetIsScrollPane:Boolean = false;
		private var _objBounds:Rectangle = null;
		private var _obj:* = null;
		private var _vGapSize:Number = 0;
		private var _hGapSize:Number = 0;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(orientation:String):void {
			$orientation = orientation;
			_curPos = new Point();
		}
		
		private function getObjBounds(obj:*):void {
			_objBounds = obj.getBounds(null);
		}
		
		private function setVirtualChoords(obj:*):void {
			if ($animated && $virtualChoords[obj] == null) $virtualChoords[obj] = new Point();
		}
		
		private var _curPos:Point;
		
		private function setHorizontalLayout():void {
			
			var s:uint = $elementsList.length;
			var xPos:Number = spas_internal::bounds.x;
			
			var i:int;
			var hg:Number = $target.horizontalGap;
			
			var lineWidth:Number = 0;
			if ($horizontalOrientation == LayoutHorizontalDirection.LEFT_TO_RIGHT)
				for(i = 0; i < s; ++i) objLayout(i);
			else if ($horizontalOrientation == LayoutHorizontalDirection.RIGHT_TO_LEFT)
				for(i = s-1; i >= 0; i--) objLayout(i);
			
			function objLayout(cursor:int):void {
				
				_obj = $elementsList[cursor];
				invalidateEvent(_obj, true);
				setVirtualChoords(_obj);
				getObjBounds(_obj);
				
				getMarginProperties();
				fixObjectAutoHeight(spas_internal::bounds.y);
				if(cursor == s-1) fixObjectAutoWidth(_mrgL + xPos);
				fixObjectPercentWidth();
				fixObjectPercentHeight();
				if ($hAlignment == LayoutHorizontalAlignment.LEFT) {
					_curPos.x = _mrgL + xPos;
					setObjPos();
				}
				xPos += setXPos(_objBounds.width);
			}
			lineWidth = xPos - hg - spas_internal::bounds.x;
			
			
			function fixHorizontalPosition():void {
				getMarginProperties();
				switch ($hAlignment) {
					case LayoutHorizontalAlignment.RIGHT :
						_curPos.x = spas_internal::bounds.width - _mrgR - _objBounds.width - xPos;
						xPos += _objBounds.width + $target.horizontalGap + _mrgL + _mrgR;
						break;
					case LayoutHorizontalAlignment.CENTER :
						_curPos.x = _mrgL + (spas_internal::bounds.width - lineWidth) / 2 + xPos;
						xPos += setXPos(_objBounds.width);
						break;
				}
				setObjPos();
			}
			function fixVerticalPosition():void {
				switch ($vAlignment) {
					case LayoutVerticalAlignment.TOP :
						_curPos.y = _mrgT + spas_internal::bounds.y;
						break;
					case LayoutVerticalAlignment.MIDDLE :
						_curPos.y = (spas_internal::bounds.y + spas_internal::bounds.height) / 2 - (_mrgT + _objBounds.height + _mrgB) / 2;
						break;
					case LayoutVerticalAlignment.BOTTOM :
						_curPos.y =  spas_internal::bounds.y + spas_internal::bounds.height - (_mrgT + _objBounds.height + _mrgB);
						break;
				}
			}
			
			if ($hAlignment != LayoutHorizontalAlignment.LEFT) {
				xPos = 0;
				if ($horizontalOrientation == LayoutHorizontalDirection.LEFT_TO_RIGHT) {
					if ($hAlignment == LayoutHorizontalAlignment.CENTER) {
						xPos = spas_internal::bounds.x;
						ascElmSort(s, fixHorizontalPosition);
					} else dscElmSort(s, fixHorizontalPosition);
				//---> TODO: LayoutHorizontalDirection.RIGHT_TO_LEFT has not been checked.
				} else if ($horizontalOrientation == LayoutHorizontalDirection.RIGHT_TO_LEFT) {
					if ($hAlignment == LayoutHorizontalAlignment.RIGHT) {
						xPos = spas_internal::bounds.x;
						ascElmSort(s, fixHorizontalPosition);
					} else dscElmSort(s, fixHorizontalPosition);
				}
			} 
			
			$layoutHeight = $target.height;
			$layoutWidth = $target.autoWidth ? _padL + lineWidth + _padR : $target.width;
			if (!$autoSizeAnimated) $target.width = $layoutWidth;
			
			function setObjPos():void {
				fixVerticalPosition();
				if ($animated) $virtualChoords[_obj] = new Point(_curPos.x, _curPos.y);
				else _obj.x = _curPos.x, _obj.y = _curPos.y;
				invalidateEvent(_obj, false);	
			}
		}
		
		private function ascElmSort(size:int, action:Function):void {
			var i:int = 0;
			for(; i < size; ++i) {
				_obj = $elementsList[i];
				getObjBounds(_obj);
				action();
			}
		}
		
		private function dscElmSort(size:int, action:Function):void {
			var i:int = size-1;
			for(; i >= 0; i--) {
				_obj = $elementsList[i];
				getObjBounds(_obj);
				action();
			}
		}
		
		private function setXPos(width:Number):Number {
			return _mrgL + width + _mrgR + $target.horizontalGap;
		}
		
		private function setVerticalLayout():void {
			
			var s:uint = $elementsList.length;
			var yPos:Number = spas_internal::bounds.y;
			var i:int;
			var vg:Number = $target.verticalGap;
			
			var lineHeight:Number = 0;
			if ($verticalOrientation == LayoutVerticalDirection.TOP_TO_BOTTOM)
				for(i = 0; i < s; ++i) objLayout(i);
			else if ($verticalOrientation == LayoutVerticalDirection.BOTTOM_TO_TOP)
				for(i = s-1; i >= 0; i--) objLayout(i);
			
			function objLayout(cursor:int):void {
				_obj = $elementsList[cursor];
				invalidateEvent(_obj, true);
				setVirtualChoords(_obj);
				getObjBounds(_obj);
				getMarginProperties();
				fixObjectAutoWidth(spas_internal::bounds.x);
				if(cursor == s-1) fixObjectAutoHeight(_mrgT + yPos);
				fixObjectPercentWidth();
				fixObjectPercentHeight();
				if($vAlignment == LayoutVerticalAlignment.TOP) {
					_curPos.y = _mrgT + yPos;
					setObjPos();
				}
				yPos += setYPos(_objBounds.height);
				
			}
			lineHeight = yPos - vg - spas_internal::bounds.y;
			
			function fixVerticalPosition():void {
				getMarginProperties();
				switch ($vAlignment) {
					case LayoutVerticalAlignment.BOTTOM :
						_curPos.y = spas_internal::bounds.height - _mrgB - _objBounds.height - yPos;
						yPos += _objBounds.height + $target.verticalGap + _mrgT + _mrgB;
						break;
					case LayoutVerticalAlignment.MIDDLE :
						_curPos.y = _mrgT + (spas_internal::bounds.height - lineHeight) / 2 + yPos;
						yPos += setYPos(_objBounds.height);
						break;
				}
				setObjPos();
			}
			function fixHorizontalPosition():void {
				switch ($hAlignment) {
					case LayoutHorizontalAlignment.LEFT :
						_curPos.x = _mrgL + spas_internal::bounds.x;
						break;
					case LayoutHorizontalAlignment.CENTER :
						_curPos.x = (spas_internal::bounds.x + spas_internal::bounds.width) / 2 - (_mrgL + _objBounds.width + _mrgR) / 2;
						break;
					case LayoutHorizontalAlignment.RIGHT :
						_curPos.x =  spas_internal::bounds.x + spas_internal::bounds.width - (_mrgL + _objBounds.width + _mrgR);
						break;
				}
			}
			
			if ($vAlignment != LayoutVerticalAlignment.TOP) {
				yPos = 0;
				if ($verticalOrientation == LayoutVerticalDirection.TOP_TO_BOTTOM) {
					if ($vAlignment == LayoutVerticalAlignment.MIDDLE) {
						yPos = spas_internal::bounds.y;
						ascElmSort(s, fixVerticalPosition);
					} else dscElmSort(s, fixVerticalPosition);
				//---> TODO: LayoutVerticalDirection.BOTTOM_TO_TOP has not been checked.
				} else if ($verticalOrientation == LayoutVerticalDirection.BOTTOM_TO_TOP) {
					if ($vAlignment == LayoutVerticalAlignment.BOTTOM) {
						yPos = spas_internal::bounds.y;
						ascElmSort(s, fixVerticalPosition);
					} else dscElmSort(s, fixVerticalPosition);
				}
			}
			
			$layoutHeight = $target.autoHeight ? _padT + lineHeight + _padB : $target.height;
			$layoutWidth =  $target.width;
			if (!$autoSizeAnimated) $target.height = $layoutHeight; 
			
			function setObjPos():void {
				fixHorizontalPosition();
				if ($animated) $virtualChoords[_obj] = new Point(_curPos.x, _curPos.y);
				else _obj.x = _curPos.x, _obj.y = _curPos.y;
				invalidateEvent(_obj, false);	
			}
		}
		
		private function setYPos(height:Number):Number {
			return _mrgT + height + _mrgB + $target.verticalGap;
		}
		
		private function computeHorizontalLayout():void {
			var s:uint = $elementsList.length;
			var vg:Number = $target.verticalGap;
			var hg:Number = $target.horizontalGap;
			
			var i:int;
			
			var layoutTable:LayoutTable = new LayoutTable(this);
			var line:LayoutLine;
			
			var yPos:Number = spas_internal::bounds.y;
			var yDelay:Number = 0;
			
			var xPos:Number;
			
			if ($horizontalOrientation == LayoutHorizontalDirection.LEFT_TO_RIGHT)
				for(i = 0; i < s; ++i) objLayout(i);
			else if ($horizontalOrientation == LayoutHorizontalDirection.RIGHT_TO_LEFT)
				for(i = s-1; i >= 0; i--) objLayout(i);
			
			function objLayout(cursor:int):void {
				_obj = $elementsList[cursor];
				setVirtualChoords(_obj);
				invalidateEvent(_obj, true);
				getObjBounds(_obj);
				getMarginProperties();
				fixObjectPercentWidth();
				fixObjectPercentHeight();
				setComplexLayout();
			}
			
			function setComplexLayout():void {
				var nextWidth:Number = 0;
				if(layoutTable.stack.length == 0) nextWidth = createNewLine(0);
				else if($target.autoSize) line.add(_obj, hg);
				else {
					fixObjectAutoWidth(xPos);
					nextWidth = _mrgL + _objBounds.width + _mrgR;
					if(spas_internal::bounds.width  >= xPos + nextWidth - spas_internal::bounds.x) line.add(_obj, hg);
					else  nextWidth = createNewLine(vg);
				}
				xPos += (hg + nextWidth);
			}
			
			function createNewLine(gap:Number):Number {
				xPos = spas_internal::bounds.x;
				line = new LayoutLine();
				fixObjectAutoWidth(spas_internal::bounds.x);
				line.add(_obj, 0);
				layoutTable.addLine(line, gap);
				return _mrgL + _objBounds.width + _mrgR;
			}
			
			function getVerticalPosition():void {
				switch($vAlignment) {
					case LayoutVerticalAlignment.TOP :
						yDelay = _mrgT;
						break;
					case LayoutVerticalAlignment.MIDDLE :
						yDelay = (line.height - _objBounds.height) / 2;
						break;
					case LayoutVerticalAlignment.BOTTOM :
						yDelay = line.height - _objBounds.height - _mrgB;
						break;
				}
				_curPos.y = yPos +  yDelay;
			}
			
			function getHorizontalPosition(lineWidth:Number):void {
				switch($hAlignment) {
					case LayoutHorizontalAlignment.LEFT :
						_curPos.x = _mrgL + xPos;
						break;
					case LayoutHorizontalAlignment.RIGHT :
						_curPos.x = _mrgL + xPos + (spas_internal::bounds.width - spas_internal::bounds.x - lineWidth);
						break;
					case LayoutHorizontalAlignment.CENTER :
						_curPos.x = _mrgL + xPos + (spas_internal::bounds.width - spas_internal::bounds.x - lineWidth) / 2;
						break;
				}
			}
			
			s = layoutTable.stack.length;
			
			for(i = 0; i < s; ++i) {
				line = layoutTable.stack[i];
				xPos = spas_internal::bounds.x;
				var j:int = 0;
				var len:int = line.stack.length;
				for (; j < len; ++j) {
					_obj = line.stack[j];
					getObjBounds(_obj);
					getMarginProperties();
					getHorizontalPosition(line.width);
					getVerticalPosition();
					xPos += setXPos(_objBounds.width);
					setObjComplexPos();
				}
				yPos += line.height + vg;
			}
			
			var w:Number = _padL + layoutTable.width + _padR;
			var h:Number = _padT + layoutTable.height + _padB;
			
			if ($target.autoSize || $target.autoWidth) {
				$autoSizeAnimated ? ($layoutHeight = h, $layoutWidth = w) : $target.resize(w, h);
			}
			else if(_targetIsScrollPane) { 
				if($target.autoHeight) $autoSizeAnimated ? $layoutHeight = h : $target.height = h;
				else $target.redraw();
			} else $autoSizeAnimated ? $layoutHeight = h : $target.height = h;
			
		}
		
		private function computeVerticalLayout():void {
			var s:uint = $elementsList.length;
			var vg:Number = $target.verticalGap;
			var hg:Number = $target.horizontalGap;
			
			var i:int;
			
			var layoutTable:LayoutTable = new LayoutTable(this);
			var row:LayoutRow;
			
			var xPos:Number = spas_internal::bounds.x;
			var xDelay:Number = 0;
			
			var yPos:Number;
			
			if ($verticalOrientation == LayoutVerticalDirection.TOP_TO_BOTTOM)
				for(i = 0; i < s; ++i) objLayout(i);
			else if ($verticalOrientation == LayoutVerticalDirection.BOTTOM_TO_TOP)
				for(i = s-1; i >= 0; i--) objLayout(i);
			
			function objLayout(cursor:int):void {
				_obj = $elementsList[cursor];
				invalidateEvent(_obj, true);
				getObjBounds(_obj);
				getMarginProperties();
				setComplexLayout();
			}
			
			function createNewRow(gap:Number):Number {
				yPos = spas_internal::bounds.y;
				row = new LayoutRow();
				fixObjectAutoHeight(yPos);
				row.add(_obj, 0);
				layoutTable.addRow(row, gap);
				return _mrgT + _objBounds.height + _mrgB;
			}
			
			function setComplexLayout():void {
				var nextHeight:Number = 0;
				if(layoutTable.stack.length == 0) nextHeight = createNewRow(0);
				else if($target.autoSize) row.add(_obj, vg);
				else {
					fixObjectAutoHeight(yPos);
					nextHeight = _mrgT + _objBounds.height + _mrgB;
					if(spas_internal::bounds.height >= yPos + nextHeight - spas_internal::bounds.y) row.add(_obj, vg);
					else  nextHeight = createNewRow(hg);
				}
				yPos += vg + nextHeight;
			}
			
			function getHorizontalPosition():void {
				switch($hAlignment) {
					case LayoutHorizontalAlignment.LEFT :
						xDelay = _mrgL;
						break;
					case LayoutHorizontalAlignment.CENTER :
						xDelay = (row.width - _objBounds.width) / 2;
						break;
					case LayoutHorizontalAlignment.RIGHT :
						xDelay = row.width - _objBounds.width - _mrgR;
						break;
				}
				_curPos.x = xPos +  xDelay;
			}
			
			function getVerticalPosition(lineHeight:Number):void {
				switch($vAlignment) {
					case LayoutVerticalAlignment.TOP :
						_curPos.y = _mrgT + yPos;
						break;
					case LayoutVerticalAlignment.BOTTOM :
						_curPos.y = _mrgT + yPos + (spas_internal::bounds.height - lineHeight);
						break;
					case LayoutVerticalAlignment.MIDDLE :
						_curPos.y = _mrgT + yPos + (spas_internal::bounds.height - lineHeight) / 2;
						break;
				}
			}
			
			s = layoutTable.stack.length;
			
			for(i = 0; i < s; ++i) {
				row = layoutTable.stack[i];
				yPos = spas_internal::bounds.y;
				var j:int = 0;
				var len:int = row.stack.length;
				for(; j < len; ++j) {
					_obj = row.stack[j];
					getObjBounds(_obj);
					getMarginProperties();
					getVerticalPosition(row.height);
					getHorizontalPosition();
					yPos += setYPos(_objBounds.height);
					setObjComplexPos();
				}
				xPos += row.width + hg;
			}
			
			var w:Number = _padL + layoutTable.width + _padR;
			var h:Number = _padT + layoutTable.height + _padB;
			
			if ($target.autoSize || $target.autoHeight) {
				$autoSizeAnimated ? ($layoutHeight = h, $layoutWidth = w) : $target.resize(w, h);
			}
			else if(_targetIsScrollPane) {
				if($target.autoWidth) $autoSizeAnimated ? $layoutWidth = w : $target.width = w;
				else $target.redraw();
			} else $autoSizeAnimated ? $layoutWidth = w : $target.width = w;
		}
		
		private function setObjComplexPos():void {
			if ($animated) $virtualChoords[_obj] = new Point(_curPos.x, _curPos.y);
			else _obj.x = _curPos.x, _obj.y = _curPos.y;
			invalidateEvent(_obj, false);
		}
		
		private function getMarginProperties():void {
			if(_obj.hasOwnProperty("marginTop")) {
				_mrgT = _obj.marginTop;
				_mrgB = _obj.marginBottom;
				_mrgR = _obj.marginRight;
				_mrgL = _obj.marginLeft;
			} else _mrgT = _mrgB = _mrgR = _mrgL = 0;
		}
		
		private function fixObjectPercentWidth():void {
			if (!_obj.hasOwnProperty("percentWidth")) return;
			if (isNaN(_obj.percentWidth)) return;
			var newWidth:Number =
				(spas_internal::bounds.width - _hGapSize - spas_internal::bounds.x) * _obj.percentWidth / 100 - getVRatio() - _mrgL - _mrgR;
			var minWidth:Number = isNaN(_obj.minWidth) ? 0 : _obj.minWidth;
			if (newWidth > minWidth) {
				_obj.width = newWidth;
				setContainerNewBoundaries();
			}
		}
		
		private function fixObjectPercentHeight():void {
			if (!_obj.hasOwnProperty("percentHeight")) return;
			if (isNaN(_obj.percentHeight)) return;
			var newHeight:Number =
				(spas_internal::bounds.height - _vGapSize - spas_internal::bounds.y) * _obj.percentHeight / 100 - getHRatio() - _mrgT - _mrgB;
			var minHeight:Number = isNaN(_obj.minHeight) ? 0 : _obj.minHeight;
			if (newHeight > minHeight) {
				_obj.height = newHeight;
				setContainerNewBoundaries();
			}
		}
		
		private function fixObjectAutoWidth(position:Number):void {
			if(!_obj.hasOwnProperty("fixToParentWidth")) return;
			if (_obj.fixToParentWidth && !$target.autoWidth) {
				var newWidth:Number = spas_internal::bounds.width - getVRatio() - _mrgL - _mrgR - position;
				var minWidth:Number = isNaN(_obj.minWidth) ? 0 : _obj.minWidth;
				if (newWidth > minWidth) {
					_obj.width = newWidth;
					setContainerNewBoundaries();
				}
			}
		}
		
		private function fixObjectAutoHeight(position:Number):void {
			if (!_obj.hasOwnProperty("fixToParentHeight")) return;
			if (_obj.fixToParentHeight && !$target.autoHeight) {
				var newHeight:Number = spas_internal::bounds.height - getHRatio() - _mrgT - _mrgB - position ;
				var minHeight:Number = isNaN(_obj.minHeight) ? 0 : _obj.minHeight;
				if(newHeight > minHeight) {
					_obj.height = newHeight;
					setContainerNewBoundaries();
				}
			}
		}
		
		private function getVRatio():Number {
			var r:Rectangle = _obj.getBounds(null);
			var fixedSize:Number = isNaN(_obj.width) ? 0 : _obj.width;
			return r.width - fixedSize;
		}
		
		private function getHRatio():Number {
			var r:Rectangle = _obj.getBounds(null);
			var fixedSize:Number = isNaN(_obj.height) ? 0 : _obj.height;
			return r.height - fixedSize;
		}
		
		private function setContainerNewBoundaries():void {
			getObjBounds(_obj);
			if (_obj is UIContainer && _obj.layout.elementsListLength > 0) {
				var l:Number = isNaN(_obj.paddingLeft) ? 0 : _obj.paddingLeft;
				var r:Number = isNaN(_obj.paddingRight) ? 0 : _obj.paddingRight;
				var t:Number = isNaN(_obj.paddingTop) ? 0 : _obj.paddingTop;
				var b:Number = isNaN(_obj.paddingBottom) ? 0 : _obj.paddingBottom;
				var newBounds:Rectangle = new Rectangle(l, t, _obj.width - r, _obj.height - b);
				_obj.layout.moveObjects(newBounds);
			}
		}
		
		private function getPaddingProperties():void {
			_padT = isNaN($target.paddingTop) ? 0 : $target.paddingTop;
			_padR = isNaN($target.paddingRight) ? 0 : $target.paddingRight;
			_padB = isNaN($target.paddingBottom) ? 0 : $target.paddingBottom;
			_padL = isNaN($target.paddingLeft) ? 0 : $target.paddingLeft;
		}
		
		private function invalidateEvent(element:*, value:Boolean):void { 
			if (element is UIObject)
				element.spas_internal::invalidateChangeEvent =
				element.spas_internal::deactivateMetricsChanges = value;
		}
	}
}

/**
 * 
 */
class LayoutTable {
	
	// -----------------------------------------------------------
	// LayoutTable
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 03/12/2007 16:43
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.layout.FlowLayout;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	Constructor.
	 */	
	public function LayoutTable(layout:FlowLayout):void {
		super();
		this.layout = layout;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public properties
	//
	//--------------------------------------------------------------------------
	
	public var width:Number = 0;
	public var height:Number = 0;
	public var stack:Array = [];
	public var lastLineHeight:Number = 0;
	public var lastRowWidth:Number = 0;
	public var layout:FlowLayout;
	
	//--------------------------------------------------------------------------
	//
	//  Public methods
	//
	//--------------------------------------------------------------------------
	
	public function addLine(line:LayoutLine, gap:Number):void {
		stack.push(line);
		line.table = this;
		if(line.width > width) width = line.width;
		height += line.height + gap;
		lastLineHeight = line.height;
	}
	
	public function addRow(row:LayoutRow, gap:Number):void {
		stack.push(row);
		row.table = this;
		if(row.height > height) height = row.height;
		width += row.width + gap;
		lastRowWidth = row.width;
	}
}	

/**
 * 
 */
class LayoutGridBase {
	
	// -----------------------------------------------------------
	// LayoutGridBase
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/12/2007 13:11
	* @see http://www.flashapi.org/
	*/
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	Constructor.
	 */	
	public function LayoutGridBase():void {
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public properties
	//
	//--------------------------------------------------------------------------
	
	public var width:Number = 0;
	public var height:Number = 0;
	public var stack:Array = [];
	public var mrgT:Number = 0;
	public var mrgB:Number = 0;
	public var mrgR:Number = 0;
	public var mrgL:Number = 0;
	public var table:LayoutTable = null;
	
	//--------------------------------------------------------------------------
	//
	//  Public methods
	//
	//--------------------------------------------------------------------------
	
	public function getMargin(obj:*):void {
		if(obj.hasOwnProperty("marginTop")) {
			mrgT = obj.marginTop;
			mrgB = obj.marginBottom;
			mrgR = obj.marginRight;
			mrgL = obj.marginLeft;
		}
	}
}

/**
 * 
 */
class LayoutRow extends LayoutGridBase {
	
	// -----------------------------------------------------------
	// LayoutRow
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/12/2007 13:11
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	Constructor.
	 */	
	public function LayoutRow():void {
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public methods
	//
	//--------------------------------------------------------------------------
	
	public function add(obj:*, gap:Number):void {
		stack.push(obj);
		var bounds:Rectangle = obj.getBounds(null);
		getMargin(obj);
		height += mrgT + bounds.height + mrgB + gap;
		var objWidth:Number = mrgL + bounds.width + mrgR;
		if(objWidth > width) width = objWidth;
		if(table != null) {
			if(height > table.height) table.height = height;
			if(table.lastRowWidth < width) {
				table.width = table.width - table.lastRowWidth + width;
				table.lastRowWidth = width;
			}
		}
	}
}

/**
 * 
 */
class LayoutLine extends LayoutGridBase {
	
	// -----------------------------------------------------------
	// LayoutLine
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 03/12/2007 16:43
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	Constructor.
	 */	
	public function LayoutLine():void {
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public methods
	//
	//--------------------------------------------------------------------------
	
	public function add(obj:*, gap:Number):void {
		stack.push(obj);
		var bounds:Rectangle = obj.getBounds(null);
		getMargin(obj);
		width += mrgL + bounds.width + mrgR + gap;
		var objHeight:Number = mrgT + bounds.height + mrgB;
		if(objHeight > height) height = objHeight;
		if(table != null) {
			if(width > table.width) table.width = width;
			if(table.lastLineHeight < height) {
				table.height = table.height - table.lastLineHeight + height;
				table.lastLineHeight = height;
			}
		}
	}
}