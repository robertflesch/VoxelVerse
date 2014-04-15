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

package org.flashapi.swing.managers {
	
	// -----------------------------------------------------------
	// DnDManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/06/2009 16:49
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.containers.IMainContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.core.UIOSprite;
	import org.flashapi.swing.dnd.DefaultDnDImage;
	import org.flashapi.swing.dnd.DnDAction;
	import org.flashapi.swing.dnd.DnDImage;
	import org.flashapi.swing.dnd.DnDImageProxy;
	import org.flashapi.swing.dnd.DnDOperation;
	import org.flashapi.swing.event.DnDEvent;
	import org.flashapi.tween.event.MotionEvent;
	import org.flashapi.swing.exceptions.SingletonException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.Icon;
	import org.flashapi.tween.Tween;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the Drag and Drop operation has been accepted by the
	 * 	targeted <code>DisplayObject</code>.
	 *
	 *  @eventType org.flashapi.swing.event.DnDEvent.DND_DROP_ACCEPTED
	 */
	[Event(name = "dndDropAccepted", type = "org.flashapi.swing.event.DnDEvent")]
	
	/**
	 *  Dispatched when the Drag and Drop operation has been canceled due to
	 * 	a call to the <code>cancelDragDrop()</code> method.
	 *
	 *  @eventType org.flashapi.swing.event.DnDEvent.DND_DROP_CANCELED
	 */
	[Event(name = "dndDropCanceled", type = "org.flashapi.swing.event.DnDEvent")]
	
	/**
	 *  Dispatched when a Drag and Drop operation has been accepted or canceled
	 * 	and all motion effect, relative to this Drag and Drop operation, have
	 * 	rendered.
	 *
	 *  @eventType org.flashapi.swing.event.DnDEvent.DND_FINISH
	 */
	[Event(name = "dndFinish", type = "org.flashapi.swing.event.DnDEvent")]
	
	/**
	 *  Dispatched when the Drag and Drop operation starts, due to a user
	 * 	interration.
	 *
	 *  @eventType org.flashapi.swing.event.DnDEvent.DND_START
	 */
	[Event(name = "dndStart", type = "org.flashapi.swing.event.DnDEvent")]
	
	/**
	 *  Dispatched when the user stops the current Drag and Drop operation by 
	 * 	releasing the mouse button.
	 *
	 *  @eventType org.flashapi.swing.event.DnDEvent.DND_COMPLETE
	 */
	[Event(name = "dndComplete", type = "org.flashapi.swing.event.DnDEvent")]
	
	/**
	 * 	[This class is under development.]
	 * 
	 * 	The <code>DnDManager</code> singleton defines the object which is responsible
	 * 	for Drag and Drop operations management within the SPAS 3.0 API.
	 * 
	 * 	@see org.flashapi.swing.UIManager#dragManager
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DnDManager {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>DnDManager</code> instance.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException 
		 * 	 			A <code>SingletonException</code> if you try to instanciate 
		 * 				the <code>DnDManager</code> class.
		 */
		public function DnDManager() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _isDragging:Boolean = false;
		/**
		 *  Returns a <code>Boolean</code> value that indicates whether a drag and
		 * 	drop operation is currently in progress (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get isDragging():Boolean {
			return _isDragging;
		}
		
		private var _defaultDragImage:Class = DefaultDnDImage;
		/**
		 *  Sets or gets the class reference for the default image used during a
		 * 	drag and drop operation.
		 * 
		 * 	@default DefaultDnDImage
		 */
		public function get defaultDragImage():Class {
			return _defaultDragImage;
		}
		public function set defaultDragImage(value:Class):void {
			_defaultDragImage = value;
		}
		
		private static var _currOp:DnDOperation = null;
		/**
		 * 	Returns the <code>DnDOperation</code> object that has initiated 
		 * 	the current drag and drop operation. If no drag and drop operation
		 * 	is currently defined, returns <code>null</code>.
		 * 
		 * 	@default null
		 */
		public function get dragOperation():DnDOperation {
			return _currOp;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Starts a drag and drop operation.
		 * 
		 * 	@param	source 	The <code>DnDOperation</code> object that is used to 
		 * 					initiate the drag and drop operation.
		 */
		public function startDragDrop(source:DnDOperation):void {
			if (!source.spas_internal::isEligible() || _isDragging ||
				_currOp == source) return;
			_currOp = source;
			initDragImage();
		}
		
		/**
		 * 	Forces the <code>DisplayObject</code> specified by the <code>target</code>
		 * 	paremeter to accept a drop operation.
		 * 
		 * 	@param	target	The <code>DisplayObject</code> which will accept the 
		 * 					current drop operation.
		 */
		public function acceptDragDrop(target:DisplayObject):void {
			_dragAbort = false;
			dispatchEvent(DnDEvent.DND_DROP_ACCEPTED);
			if(_currOp.hasAcceptDropAnimation) {
				_tween.duration = _currOp.dropAcceptedDuration;
				_tween.start = 1;
				_tween.end = .15;
				_tween.play();
			} else finalizeDrag();
		}
		
		/**
		 * 	Cancels the current drag and drop operation.
		 */
		public function cancelDragDrop():void {
			_dragAbort = true;
			dispatchEvent(DnDEvent.DND_DROP_CANCELED);
			if(_currOp.hasCancelDropAnimation) {
				_tween.duration = _currOp.dropCanceledDuration;
				_tween.start = [_imageContainer.x, _imageContainer.y];
				_tween.end = [_origin.x, _origin.y];
				_tween.play();
			} else finalizeDrag();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function getInstance():DnDManager {
			_constructorAccess = false;
			return new DnDManager();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		//---> Singleton management:
		private static var _instanciable:Boolean = true;
		private static var _constructorAccess:Boolean = true;
		
		private static var _imageContainer:Sprite;
		private static var _currImage:DnDImage = null;
		private static var _evtColl:EventCollector;
		private static var _origin:Point;
		private static var _tween:Tween;
		private static var _dragAbort:Boolean;
		private var _stage:Stage;
		private var _icon:Icon;
		private var _mousePos:Point;
		private var _currTgt:UIObject = null;
		
		//---> State management:
		private var _currState:uint;
		
		private static const DRAG_OVER_INITIATOR:uint = 0;
		private static const DRAG_OUT:uint = 1;
		private static const DROP_ENABLED:uint = 2;
		private static const DROP_DISABLED:uint = 3;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if (!_instanciable)
				throw new SingletonException(Locale.spas_internal::ERRORS.DND_SINGLETON_ERROR );
			_instanciable = false;
			_mousePos = new Point();
			_constructorAccess = true;
			_stage = UIDescriptor.getUIManager().stage;
			_imageContainer = new Sprite();
			_tween = new Tween();
			_tween.target = _imageContainer;
			_evtColl = new EventCollector();
			_evtColl.addEvent(_tween, MotionEvent.UPDATE, motionEffect);
			_evtColl.addEvent(_tween, MotionEvent.FINISH, finalizeDrag);
			_icon = new Icon();
			_icon.shadow = true;
			_icon.target = _imageContainer;
		}
		
		private function initDragImage():void {
			_evtColl.addEvent(_stage, MouseEvent.MOUSE_UP, stopDragImage);
			if (!checkDragEnabled()) return;
			
			var uio:UIObject = _currOp.initiator;
			_imageContainer.scaleX = _imageContainer.scaleY = 1;
			var uioCont:Sprite = uio.spas_internal::uioSprite;
			var r:Rectangle = uio.getBounds(uioCont.parent);
			_currImage = (_currOp.dragImage == null) ?
				new DefaultDnDImage() : new DnDImageProxy(_currOp.dragImage);
			_currImage.opacity = _currOp.dragImageAlpha;
			_currImage.resize(r.width, r.height);
			
			_currState = DRAG_OVER_INITIATOR;
			var pt:Point;
			if (_currOp.spas_internal::anchorsImageToMouse) {
				_origin = new Point(_stage.mouseX, _stage.mouseY);
				_origin.offset(_currOp.xOffset, _currOp.yOffset);
				pt = new Point(_origin.x, _origin.y);
				_currOp.spas_internal::imagePosition = pt;
				_imageContainer.x = pt.x;
				_imageContainer.y = pt.y;
			} else {
				pt = new Point(r.x, r.y);
				_origin = uioCont.localToGlobal(pt);
				_origin.offset(_currOp.xOffset, _currOp.yOffset);
				_currOp.spas_internal::imagePosition = _origin;
				_imageContainer.x = _origin.x;
				_imageContainer.y = _origin.y;
			} 
			_evtColl.addEvent(_stage, MouseEvent.MOUSE_MOVE, startDragImage);
		}
		
		private function finalizeDrag(e:MotionEvent = null):void {
			doDragDropAction();
			_stage.removeChild(_imageContainer);
			_imageContainer.removeChild(_currImage as DisplayObject);
			_currImage.finalize();
			_currImage = null;
			_isDragging = false;
			dispatchEvent(DnDEvent.DND_FINISH);
			_currOp.spas_internal::imagePosition = null;
			_currOp = null;
			changeIcon(null);
		}
		
		private function startDragImage(e:MouseEvent):void {
			_imageContainer.addChild(_currImage as DisplayObject);
			_evtColl.removeEvent(_stage, MouseEvent.MOUSE_MOVE, startDragImage);
			_stage.addChild(_imageContainer);
			_imageContainer.startDrag(false, _currOp.bounds);
			dispatchEvent(DnDEvent.DND_START);
			_evtColl.addEvent(_stage, MouseEvent.MOUSE_MOVE, dndMoveHandler);
			_icon.display(_imageContainer.mouseX + 20, _imageContainer.mouseY + 10);
			_isDragging = true;
		}
		
		private function dndMoveHandler(e:MouseEvent):void {
			_mousePos.x = e.stageX;
			_mousePos.y = e.stageY;
			var objList:Array = _stage.getObjectsUnderPoint(_mousePos);
			//--> currState = DRAG_OUT : Sets the stage cursor state when the  
			// application is created from the Flash IDE main timeline:
			_currState = DRAG_OUT;
			
			var len:int = objList.length - 1;
			var obj:*;
			
			for (; len >= 0; --len) {
				obj = objList[len];
				if (obj is DnDImage) continue;
				else {
					if (getTarget(obj)) break;
				}
			}
			
			
			
			/*if (l > 1) {
				var i:int = 0
				var listLength:int = l - 2;
				for (; i <= listLength; i++) {
					if(getTarget(objList[i])) break;
				}
			}
			else {
				_currState = DRAG_OUT;
				if (_currTgt != null) {
					_currTgt = null;
					//dispatchEvent(DnDEvent.DND_EXIT);
				}
				
			}*/
			
			_currOp.spas_internal::setDragImagePosition(_imageContainer.x, _imageContainer.y);
			
			switch(_currState) {
				case DRAG_OVER_INITIATOR:
					changeIcon(_currOp.dragInitialIcon);
					break;
				case DRAG_OUT:
					changeIcon(_currOp.dragOutIcon);
					break;
				case DROP_ENABLED:
					changeIcon(_currOp.dropEnabledIcon);
					break;
				case DROP_DISABLED:
					changeIcon(_currOp.dropDisabledIcon);
					break;
			}
		}
		
		//private var _onDragEvent
		
		private function getTarget(obj:DisplayObject):Boolean {
			//--> The initial object can be an UIOSprite object:
			var s:DisplayObject = obj is UIOSprite ? obj : obj.parent;
			
			var dropTgt:UIObject = null;
			var breakMainLoop:Boolean = false;
			
			while (s) {
				if (s is UIOSprite) {
					dropTgt = (s as UIOSprite).target;
					_currTgt = dropTgt;
					if (dropTgt == _currOp.initiator) {
						_currState = DRAG_OVER_INITIATOR;
						breakMainLoop = true;
						break;
					} else if (!dropTgt.spas_internal::parentDropEnbd) {
						_currState = DROP_DISABLED;
						breakMainLoop = true;
						break;
					} else if (dropTgt.spas_internal::dropEnbd) {
						breakMainLoop = checkDropFormat(dropTgt);
						_currState = breakMainLoop ? DROP_ENABLED : DROP_DISABLED;
						if (breakMainLoop) break;
					} else {
						if (dropTgt.target is IMainContainer) {
							breakMainLoop = true;
							_currState = DROP_DISABLED;
							break;
						} else if (dropTgt is IMainContainer) {
							//breakMainLoop = true;
							_currState = DRAG_OUT;
							break;
						}
					}
				}
				s = s.parent;
			}
			
			_currTgt = dropTgt;
			return breakMainLoop;
			
			/*
			while (s) {
				if (s is UIOSprite) {
					dropTgt = (s as UIOSprite).target;
					//trace(dropTgt, dropTgt.spas_internal::dropEnbd, dropTgt.spas_internal::parentDropEnbd);
					if (dropTgt == _currOp.initiator) {
						_currState = DRAG_OVER_INITIATOR;
						breakMainLoop = true;
						break;
					} else if (dropTgt.spas_internal::parentDropEnbd == false) {
						_currState = DROP_DISABLED;
						breakMainLoop = true;
						break;
					} else if (dropTgt.spas_internal::dropEnbd) {
						breakMainLoop = !checkDropFormat(dropTgt);
						_currState = breakMainLoop ? DROP_DISABLED : DROP_ENABLED;
					} else {
						_currState = DROP_DISABLED;
						breakMainLoop = true;
					}
					
					
					/*if (dropTgt == _currTgt) {
						// Dispatch a "dragOver" event
						//dispatchDragEvent(DragEvent.DRAG_OVER, event, dropTarget);
						isOverOldTgt = true;
						//trace(dropTarget);
						break;
					} else {
						// Dispatch a "dragEnter" event and see if a new object
						// steals the target.
						//dispatchDragEvent(DragEvent.DRAG_ENTER, event, dropTarget);
						
						// If the potential target accepted the drag, our target
						// now points to the dropTarget. Bail out here, but make 
						// sure we send a dragExit event to the oldTarget.
						if (_currTgt == dropTgt) {
							isOverOldTgt = false;
							break;
						}
					}
				}
				s = s.parent;
			}
			*/
			//trace(dropTgt);
			
			/*if (_currTgt) {
				var isOverOldTgt:Boolean = false;
				newTgt = null;
				while (s) {
					if (s is UIOSprite) {
						newTgt = (s as UIOSprite).target;
						if (newTgt.spas_internal::dropEnbd) dropTgt = newTgt;
						if (dropTgt == _currTgt) {
							// Dispatch a "dragOver" event
							//dispatchDragEvent(DragEvent.DRAG_OVER, event, dropTarget);
							isOverOldTgt = true;
							//trace(dropTarget);
							break;
						} else {
							// Dispatch a "dragEnter" event and see if a new object
							// steals the target.
							//dispatchDragEvent(DragEvent.DRAG_ENTER, event, dropTarget);
							
							// If the potential target accepted the drag, our target
							// now points to the dropTarget. Bail out here, but make 
							// sure we send a dragExit event to the oldTarget.
							if (_currTgt == dropTgt) {
								isOverOldTgt = false;
								break;
							}
						}
					}
					s = s.parent;
				}
			}
			if (newTgt == null) {
				//trace("called");
				// Dispatch a "dragExit" event on the old target.
			   // dispatchDragEvent(DragEvent.DRAG_EXIT, event, oldTarget);
				if (_currTgt == oldTgt) _currTgt = null;
			}
			if (!_currTgt) {
				while (s) {
					if (s is UIOSprite) {
						newTgt = (s as UIOSprite).target;
						if(newTgt.spas_internal::dropEnbd) {
							dropTgt = newTgt;
							break;
						}
					}
					s = s.parent;
				}
			}*/
		}
		
		private function checkDragEnabled():Boolean {
			_mousePos.x = _stage.mouseX;
			_mousePos.y = _stage.mouseY;
			var objList:Array = _stage.getObjectsUnderPoint(_mousePos);
			var l:int = objList.length;
			if (l > 0) {
				var obj:DisplayObject = objList[l - 1];
				//--> The initial object can be an UIOSprite object:
				var s:DisplayObject = obj is UIOSprite ? obj : obj.parent;
				var uio:UIObject = null;
				while (s) {
					if (s is UIOSprite) {
						uio = (s as UIOSprite).target;
						if (!uio.spas_internal::parentDragEnbd) return false;
					}
					s = s.parent;
				}
				return true;
			} else return false;
		}
			
		private function stopDragImage(e:MouseEvent):void {
			_evtColl.removeEvent(_stage, MouseEvent.MOUSE_UP, stopDragImage);
			if(_evtColl.hasRegisteredEvent(_stage, MouseEvent.MOUSE_MOVE, dndMoveHandler)) _evtColl.removeEvent(_stage, MouseEvent.MOUSE_MOVE, dndMoveHandler);
			_imageContainer.stopDrag();
			if(_isDragging) {
				_icon.remove();
				_currOp.spas_internal::setDragImagePosition(_imageContainer.x, _imageContainer.y);
				dispatchEvent(DnDEvent.DND_COMPLETE);
				_currState == DROP_ENABLED ? acceptDragDrop(_currTgt) : cancelDragDrop();
				_isDragging = false;
			} else {
				_evtColl.removeEvent(_stage, MouseEvent.MOUSE_MOVE, startDragImage);
				_currOp = null;
			}
		}
		
		private function doDragDropAction():void {
			switch(_currOp.action) {
				case DnDAction.DND_ACTION_NONE :
					break;
				case DnDAction.DND_ACTION_MOVE :
					break;
				case DnDAction.DND_ACTION_COPY :
					break; 
				case DnDAction.DND_ACTION_LINK :
					break;
			}
		}
		
		private static function motionEffect(e:MotionEvent):void {
			if (_dragAbort) {
				var arr:Array = e.value as Array;
				_imageContainer.x = arr[0];
				_imageContainer.y = arr[1];
			} else {
				var v:Number = Number(e.value);
				var w:Number = _imageContainer.width;
				var h:Number = _imageContainer.height;
				_imageContainer.scaleX = _imageContainer.scaleY = v;
				//_imageContainer.x += w - (w * v / 2);
				//_imageContainer.y += h - (h * v / 2);
			}
		}
		
		private function dispatchEvent(type:String):void {
			var e:DnDEvent = new DnDEvent(type);
			//e.dropTarget = _imageContainer.dropTarget;
			e.spas_internal::dragOp = _currOp;
			e.spas_internal::dropTgt = _currTgt;
			_currOp.dispatchEvent(e);
		}
		
		private function changeIcon(brush:Class = null):void {
			if (brush == null) _icon.deleteBrush();
			else {
				if (_icon.brushRef == brush) return;
				_icon.setBrush(brush);
				_icon.paint();
			}
		}
		
		private function checkDropFormat(tgt:UIObject):Boolean {
			var opFormat:Array = _currOp.spas_internal::dropFmt;
			var tgtFormat:Array = tgt.spas_internal::dropFmt;
			var l1:int = opFormat.length;
			var l2:int = tgtFormat.length;
			if (l1 == 0 && l2 == 0) return true;
			if (l1 > 0) {
				if (l2 == 0) return false;
				else {
					var i:int = l1 - 1;
					var l:int;
					var fmt:String;
					for (; i >= 0; i--) {
						fmt = opFormat[i].format;
						l = l2 - 1;
						for (; l >= 0; l--) {
							if (fmt == tgtFormat[l].format) return true;
						}
					}
				}
			}
			return false;
		}
	}
}