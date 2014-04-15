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

package org.flashapi.swing.ui {
	
	// -----------------------------------------------------------
	// Resizer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 10/03/2011 17:45
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.button.core.ResizerHandle;
	import org.flashapi.swing.constants.CursorType;
	import org.flashapi.swing.constants.ROD;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.ResizerEvent;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the resizing operation starts.
	 *
	 *  @eventType org.flashapi.swing.event.ResizerEvent.RESIZE_START
	 */
	[Event(name = "resizeStart", type = "org.flashapi.swing.event.ResizerEvent")]
	
	/**
	 *  Dispatched when the resizing operation is finished: the user releases the
	 * 	mouse button after having performed a resizing operation.
	 *
	 *  @eventType org.flashapi.swing.event.ResizerEvent.RESIZE_FINISH
	 */
	[Event(name = "resizeFinish", type = "org.flashapi.swing.event.ResizerEvent")]
	
	/**
	 *  Dispatched when the bounds of the <code>Resizer</code> instance change
	 * 	during a resizing operation.
	 *
	 *  @eventType org.flashapi.swing.event.ResizerEvent.RESIZE_UPDATE
	 */
	[Event(name = "resizeUpdate", type = "org.flashapi.swing.event.ResizerEvent")]
	
	/**
	 * 	The <code>Resizer</code> class creates a utility object that enables resizing
	 * 	operations for any display object, from its edges. The <code>Resizer</code>
	 * 	class encapsulates the code required to:
	 * 	<ol>
	 * 		<li>Create the resize drag handle</li>
	 * 		<li>Monitor drag related events, and</li>
	 * 		<li>Resize the element its bound to.</li>
	 * 	</ol>
	 * 
	 * 	<p>All developers need to do is monitor when the display object is resized
	 * 	and resize its contents relative to the new dimensions.</p>
	 * 
	 * 	<p><code>Resizer</code> instances have eight handles that allow users to
	 * 	resize the display object in any direction (like Microsoft OS window objects.</p>
	 * 
	 *  @includeExample ResizerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class Resizer extends Sprite implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Resizer</code> instance with the 
		 * 					specified parameters.
		 * 
		 * 	@param	target	A <code>Sprite</code> object that will be associated
		 * 					to this <code>Resizer</code> instance.
		 * 	@param	width	The width of the <code>Resizer</code> instance, in pixels.
		 * 	@param	height	The height of the <code>Resizer</code> instance, in pixels.
		 */
		public function Resizer(target:Sprite, width:Number = 400, height:Number = 400) {
			super();
			initObj(target, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		private var _cursorType:String;
		/**
		 * 	Returns a <code>CursorType</code> class constant that represents the type
		 * 	of cursor associated with the handle currently selected by the user. If no
		 * 	resizing action is currently specified, returns <code>null</code>.
		 * 
		 * 	@return	The type of cursor associated with the handle selected by the user.
		 * 
		 * 	@default null
		 */
		public function getCursorType():String {
			return _cursorType;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_currentHandle = null;
			_resizeEvtColl.finalize();
			_resizeEvtColl = null;
			while (this.numChildren > 0) {
				try { this.removeChildAt(0); }
				catch (e:Error) { }
			}
			_target = null;
			_stage = null;
			_uimanager = null;
			_rect = null;
			_localMousePos = null;
		}
		
		/**
		 * 	Returns a <code>Rectangle</code> object that represents the current bounds
		 * 	of this <code>Resizer</code> instance.
		 * 
		 * 	@return	A <code>Rectangle</code>; the current bounds of this <code>Resizer</code>
		 * 			instance.
		 */
		public function getSizeRect():Rectangle {
			return _rect;
		}
		
		/**
		 * 	Resizes the <code>Resizer</code> instance with the specified <code>width</code>
		 * 	and <code>height</code>. Use this method to fit the size of the <code>Resizer</code>
		 * 	instance to the display object size after being changed.
		 * 
		 * 	@param	x	The new horizontal position of the <code>Resizer</code> instance, 
		 * 				in pixels. (Tipically the <code>x</code> value of the target
		 * 				display object.)
		 * 	@param	y	The new vertical position of the <code>Resizer</code> instance, 
		 * 				in pixels. (Tipically the <code>y</code> value of the target
		 * 				display object.)
		 * 	@param	width	The new width of the <code>Resizer</code> instance, in
		 * 					pixels. (Tipically the <code>width</code> value of the 
		 * 					target display object.)
		 * 	@param	height	The new height of the <code>Resizer</code> instance, in
		 * 					pixels. (Tipically the <code>height</code> value of the 
		 * 					target display object.)
		 */
		public function resize(x:Number, y:Number, width:Number, height:Number):void {
			_rect.x = x;
			_rect.y = y;
			_rect.width = width;
			_rect.height = height;
			initResizeHandler();
			setResizeHandlersPositions();
		}
		
		/**
		 * 	Updates the size of the <code>Resizer</code> instance to fit to the 
		 * 	value returned by the <code>getRect()</code> method of the target 
		 * 	display object.
		 * 
		 * 	@see #fitToTargetBounds()
		 */
		public function fitToTargetRect():void {
			_rect = _target.getRect(_target);
		}
		
		/**
		 * 	Updates the size of the <code>Resizer</code> instance to fit to the 
		 * 	value returned by the <code>getBounds()</code> method of the target
		 * 	display object.
		 * 
		 * 	@see #fitToTargetRect()
		 */
		public function fitToTargetBounds():void {
			_rect = _target.getBounds(_target);
		}
		
		private var _isResizing:Boolean = false;
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the user is
		 * 	resizing the target display object (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@return	<code>true</code> if the the target display object is currently
		 * 			resized; <code>false</code> otherwise.
		 */
		public function isResizing():Boolean {
			return _isResizing;
		}
		
		/**
		 * 	Deactivates a collection of handles to prevent resizing from these specified
		 * 	handles. You use the constants of the <code>ROD</code> class to define
		 * 	handle objects to deactivate.
		 * 
		 * 	@param	... rest	A collection of handle objects to deactivate, defined
		 * 						by their <code>ROD</code> names.
		 * 
		 * 	@see #activateHandles()
		 * 	@see org.flashapi.swing.constants.ROD
		 */
		public function deactivateHandles(... rest):void {
			var l:int = rest.length;
			var i:int = 0;
			var h:ResizerHandle;
			for (; i < l; i++) {
				h = getHandle(rest[i]);
				h.active = h.buttonMode = false;
			}
		}
		
		/**
		 * 	Activates a collection of handles to allow resizing from these specified
		 * 	handles. You use the constants of the <code>ROD</code> class to define
		 * 	handle objects to activate.
		 * 
		 * 	@param	... rest	A collection of handle objects to activate, defined
		 * 						by their <code>ROD</code> names.
		 * 
		 * 	@see #deactivateHandles()
		 * 	@see org.flashapi.swing.constants.ROD
		 */
		public function activateHandles(... rest):void {
			var l:int = rest.length;
			var i:int = 0;
			var h:ResizerHandle;
			for (; i < l; i++) {
				h = getHandle(rest[i]);
				h.active = h.buttonMode = true;
			}
		}
		
		/**
		 * 	Updates the position of all handels within this <code>Resizer</code>
		 * 	instance.
		 */
		public function refresh():void {
			setResizeHandlersPositions();
			initResizeHandler();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _target:Sprite;
		private var _stage:Stage;
		private var _uimanager:*;
		private var _currentHandle:ResizerHandle;
		private var _rect:Rectangle;
		private var _storedCursorType:String;
		private var _resizeEvtColl:EventCollector;
		private var _localMousePos:Point;
		
		private static const RESIZE_HANDLER_NAMES:Array =
			[ROD.TOP, ROD.TOP_LEFT, ROD.TOP_RIGHT, ROD.LEFT, ROD.BOTTOM_LEFT,
			ROD.BOTTOM, ROD.RIGHT, ROD.BOTTOM_RIGHT];
		private static const SIZE:Number = 5;
		private static const ANGLE_OFFSET:Number = 15;
		private static const HANDLER_NAMES_LENGTH:int = 7;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:Sprite, width:Number, height:Number):void {
			_target = target;
			_uimanager = UIDescriptor.getUIManager();
			_stage = _uimanager.stage;
			_resizeEvtColl = new EventCollector();
			createResizeHandlers();
			_rect = new Rectangle();
			this.resize(0, 0, width, height);
		}
		
		private function createResizeHandlers():void {
			var cursorTypes:Array = [
				[CursorType.N_RESIZE_CURSOR], [CursorType.NW_RESIZE_CURSOR],
				[CursorType.NE_RESIZE_CURSOR], [CursorType.W_RESIZE_CURSOR],
				[CursorType.SW_RESIZE_CURSOR], [CursorType.S_RESIZE_CURSOR],
				[CursorType.E_RESIZE_CURSOR], [CursorType.SE_RESIZE_CURSOR]
				];
			var i:int = RESIZE_HANDLER_NAMES.length - 1;
			var handle:ResizerHandle;
			for(; i >= 0; i--) {
				handle = new ResizerHandle();
				handle.name = RESIZE_HANDLER_NAMES[i];
				handle.associatedCursor = cursorTypes[i][0];
				_resizeEvtColl.addEvent(handle, MouseEvent.MOUSE_OVER, rollOverHandler);
				_resizeEvtColl.addEvent(handle, MouseEvent.MOUSE_OUT, rollOutHandler);
				_resizeEvtColl.addEvent(handle, MouseEvent.MOUSE_DOWN, downHandler);
				handle.buttonMode = true;
				this.addChild(handle);
			}
		}
		
		private function initResizeHandler():void {
			var ads:Number = ANGLE_OFFSET - SIZE;
			var oh2ad:Number = _rect.height - 2 * ANGLE_OFFSET;
			var ow2ad:Number = _rect.width - 2 * ANGLE_OFFSET;
			var data:Array = [
				[[0, 0, ow2ad, SIZE]],
				[[0, 0, ANGLE_OFFSET, SIZE], [0, SIZE, SIZE, ANGLE_OFFSET]],
				[[0, 0, ANGLE_OFFSET, SIZE], [ads, SIZE, ANGLE_OFFSET, ANGLE_OFFSET]],
				[[0, 0, SIZE, oh2ad]],
				[[0, 0, SIZE, ANGLE_OFFSET], [SIZE, ads, ANGLE_OFFSET, ANGLE_OFFSET]],
				[[0, 0, ow2ad, SIZE]],
				[[0, 0, SIZE, oh2ad]],
				[[0, -SIZE, ANGLE_OFFSET - SIZE, 0], [ads, -ANGLE_OFFSET, ANGLE_OFFSET, 0]]
				];
			var i:int = HANDLER_NAMES_LENGTH;
			var handle:ResizerHandle;
			for(; i >= 0; i--) {
				handle = getHandle(RESIZE_HANDLER_NAMES[i]);
				with(Figure.setFigure(handle)) {
					clear();
					beginFill(0, 0);
					drawRectangle(data[i][0][0], data[i][0][1], data[i][0][2], data[i][0][3]);
					if (data[i][1])
						drawRectangle(data[i][1][0], data[i][1][1], data[i][1][2], data[i][1][3]);
					endFill();
				}
			}
		}
		
		private function downHandler(e:MouseEvent):void {
			if (!e.target.active) return;
			_isResizing = true;
			fitToTargetRect();
			var tgt:ResizerHandle = e.target as ResizerHandle;
			startDragHandler(tgt);
			_resizeEvtColl.addEvent(_stage, MouseEvent.MOUSE_UP, upHandler);
		}
		
		private function upHandler(e:MouseEvent):void {
			_uimanager.cursor.type = _storedCursorType;
			stopDragHandler();
			_resizeEvtColl.removeEvent(_stage, MouseEvent.MOUSE_UP, upHandler);
			_isResizing = false;
			dispatchResizeEvt(ResizerEvent.RESIZE_FINISH);
		}
		
		private function rollOverHandler(e:MouseEvent):void {
			if (_isResizing || !e.target.active) return;
			_storedCursorType = _uimanager.cursor.type;
			_uimanager.cursor.type = (e.target as ResizerHandle).associatedCursor;
		}
		
		private function rollOutHandler(e:MouseEvent):void {
			if (_isResizing || !e.target.active) return;
			_uimanager.cursor.type = _storedCursorType;
		}
		
		private function mouseMoveHandler(e:MouseEvent):void {
			setLocalMousePos();
			switch(_cursorType) {
				case CursorType.N_RESIZE_CURSOR :
					_rect.top = _localMousePos.y;
					break;
				case CursorType.NW_RESIZE_CURSOR :
					_rect.top = _localMousePos.y;
					_rect.left = _localMousePos.x;
					break;
				case CursorType.NE_RESIZE_CURSOR :
					_rect.top = _localMousePos.y;
					_rect.right = _localMousePos.x;
					break;
				case CursorType.W_RESIZE_CURSOR :
					_rect.left = _localMousePos.x;
					break;
				case CursorType.SW_RESIZE_CURSOR :
					_rect.left = _localMousePos.x;
					_rect.bottom = _localMousePos.y;
					break;
				case CursorType.S_RESIZE_CURSOR :
					_rect.bottom = _localMousePos.y;
					break;
				case CursorType.SE_RESIZE_CURSOR :
					_rect.bottom = _localMousePos.y;
					_rect.right = _localMousePos.x;
					break;
				case CursorType.E_RESIZE_CURSOR :
					_rect.right = _localMousePos.x;
					break;
			}
			dispatchResizeEvt(ResizerEvent.RESIZE_UPDATE);
		}
		
		private function startDragHandler(handle:ResizerHandle):void {
			_currentHandle = handle;
			_cursorType = handle.associatedCursor;
			_resizeEvtColl.addEvent(_stage, MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			dispatchResizeEvt(ResizerEvent.RESIZE_START);
		}
		
		private function setLocalMousePos():void {
			_localMousePos = new Point(this.mouseX + _target.x, this.mouseY + _target.y);
		}
		
		private function stopDragHandler():void {
			setLocalMousePos();
			switch(_cursorType) {
				case CursorType.N_RESIZE_CURSOR :
				case CursorType.NE_RESIZE_CURSOR :
					_rect.top = _localMousePos.y;
					break;
				case CursorType.NW_RESIZE_CURSOR :
					_rect.top = _localMousePos.y;
					_rect.left = _localMousePos.x;
					break;
				case CursorType.SW_RESIZE_CURSOR :
				case CursorType.W_RESIZE_CURSOR :
					_rect.left = _localMousePos.x;
					break;
			}
			
			_resizeEvtColl.removeEvent(_stage, MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			setResizeHandlersPositions();
			initResizeHandler();
			_cursorType = null;
		}
		
		private function setResizeHandlersPositions():void {
			var w:Number = _rect.right - _rect.left;
			var h:Number = _rect.bottom - _rect.top;
			var data:Array = [
				[ANGLE_OFFSET, 0], [0, 0], [w - ANGLE_OFFSET, 0],
				[0, ANGLE_OFFSET], [0, h - ANGLE_OFFSET],
				[ANGLE_OFFSET, h - SIZE], [w - SIZE, ANGLE_OFFSET],
				[w- ANGLE_OFFSET, h]
			];
			var i:int = HANDLER_NAMES_LENGTH;
			var handle:Sprite;
			for(; i >= 0; i--) {
				handle = getHandle(RESIZE_HANDLER_NAMES[i]);
				handle.x = data[i][0];
				handle.y = data[i][1];
			}
		}
		
		private function getHandle(name:String):ResizerHandle {
			var handle:ResizerHandle = this.getChildByName(name) as ResizerHandle;
			return handle;
		}
		
		private function dispatchResizeEvt(type:String):void {
			this.dispatchEvent(new ResizerEvent(type));
		}
	}
}