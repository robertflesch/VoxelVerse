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
	// GridLayout.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 08/06/2008 17:49
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.LayoutHorizontalDirection;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	
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
	 * 	The <code>GridLayout</code> class lays out a container object in a
	 * 	rectangular grid of cells. The container is divided into equal-sized
	 * 	rectangle areas, and each of its child element is placed in a different
	 * 	rectangle.
	 * 	
	 * 	<p>Each child element takes all the available space within the cell.
	 * 	If the container is resized, the <code>GridLayout</code> object changes
	 * 	the cells sizes so that they are larger as possible.</p>
	 * 
	 *  @includeExample GridLayoutExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class GridLayout extends AbstractLayout implements Layout {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>GridLayout</code> object with the specified
		 * 	number of rows and columns.
		 * 
		 * 	@param	rows	The numner of rows, with the value zero meaning any number
		 * 					of rows.
		 * 	@param	cols	The numner of columns, with the value zero meaning any number
		 * 					of columns.
		 * 	@param	hgap	The horizontal gap between each row, in pixels.
		 * 	@param	vgap	The vertical gap between each column, in pixels.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IllegalArgumentException
		 * 	An <code>IllegalArgumentException</code> error if both values, the number of
		 * 	rows and columns, are set to <code>0</code>.
		 */
		public function GridLayout(rows:int, cols:int, hgap:int = 0, vgap:int = 0) {
			super();
			initObj(rows, cols, hgap, vgap);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the width of the
		 * 	child elements fit the width of their parent cells (<code>true</code>),
		 * 	or not (<code>false</code>).
		 */
		public var constrainctWidth:Boolean = true;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the height of the
		 * 	child elements fit the height of their parent cells (<code>true</code>),
		 * 	or not (<code>false</code>).
		 */
		public var constrainctHeight:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function moveObjects(bounds:Rectangle, caller:* = null):void {
			//TODO: optimize this !
			var s:int = $elementsList.length;
			$layoutHeight = $target.height;
			$layoutWidth = $target.width;
			//var flag:Boolean = hasBoundsChanged(bounds);
			getGridDimensions();
			//if (_hasListChanged || flag) {
			if (s > 0){
				var i:int;
				if ($horizontalOrientation == LayoutHorizontalDirection.LEFT_TO_RIGHT)
					for(i = 0; i < s; i++) objLayout(i);
				else if ($horizontalOrientation == LayoutHorizontalDirection.RIGHT_TO_LEFT)
					for (i = s - 1; i >= 0; i--) objLayout(i);
				$hasListChanged = false;
				_obj = null;
			}
			if ($autoSizeAnimated) playAutosizeAnimation();
			else if ($animated) playLayoutAnimation();
			else dispatchFinishedEvent();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _obj:* = null;
		private var _rows:int;
		private var _cols:int;
		private var _hgap:int;
		private var _vgap:int;
		private var _cellWidth:Number = 0;
		private var _cellHeight:Number = 0;
		private var _padT:Number;
		private var _padR:Number;
		private var _padB:Number;
		private var _padL:Number;
		private var _curPos:Point;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(rows:int, cols:int, hgap:int, vgap:int):void {
			_rows = rows;
			_cols = cols;
			_hgap = hgap;
			_vgap = vgap;
			_curPos = new Point();
		}
		
		private function getGridDimensions():void {
			_cellWidth =
				(spas_internal::bounds.width - spas_internal::bounds.x - (_cols - 1) * _hgap) / _cols;
			_cellHeight =
				(spas_internal::bounds.height - spas_internal::bounds.y - (_rows - 1) * _vgap) / _rows;
		}
		
		private function objLayout(cursor:int):void {
			_obj = $elementsList[cursor];
			invalidateEvent(_obj, true);
			var vr:Number = getVRatio();
			var hr:Number = getHRatio();
			if(constrainctWidth) _obj.width = _cellWidth - hr;
			if(constrainctHeight) _obj.height = _cellHeight - vr;
			//trace(hr, vr);
			_curPos.x =
				spas_internal::bounds.x + (_cellWidth + _hgap) * (cursor%_cols) + Math.ceil(hr/2);
			_curPos.y =
				spas_internal::bounds.y + (_cellHeight + _vgap) * Math.floor(((cursor/_cols)%_rows)) +  Math.ceil(vr/2);
			if ($animated) $virtualChoords[_obj] = new Point(_curPos.x, _curPos.y);
			else _obj.x = _curPos.x, _obj.y = _curPos.y;
			invalidateEvent(_obj, false);	
		}
		
		private function invalidateEvent(element:*, value:Boolean):void { 
			if (element is UIObject)
				element.spas_internal::invalidateChangeEvent =
				element.spas_internal::deactivateMetricsChanges = value;
		}
		
		private function getHRatio():Number {
			var r:Rectangle = _obj.getBounds(null);
			var fixedSize:Number = isNaN(_obj.width) ? 0 : _obj.width;
			return r.width - fixedSize;
		}
		
		private function getVRatio():Number {
			var r:Rectangle = _obj.getBounds(null);
			var fixedSize:Number = isNaN(_obj.height) ? 0 : _obj.height;
			return r.height - fixedSize;
		}
	}
}