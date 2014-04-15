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

package org.flashapi.swing.dnd {
	
	// -----------------------------------------------------------
	// DnDOperation.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 11/08/2009 12:11
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.icons.DragInitialIcon;
	import org.flashapi.swing.icons.DragOutIcon;
	import org.flashapi.swing.icons.DropDisabledIcon;
	import org.flashapi.swing.icons.DropEnabledIcon;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched by the current <code>DnDOperation</code> instance when the
	 * 	drag operation is finilazed.
	 *  <p>You can use this event to perform any final cleanup of the Drag and Drop
	 * 	operation.</p>
	 *
	 *  @eventType org.flashapi.swing.events.DnDEvent.DND_FINISH
	 */
	[Event(name = "dndFinish", type = "org.flashapi.swing.events.DnDEvent")]
	
	/**
	 *  Dispatched by the current <code>DnDOperation</code> instance when the
	 * 	drag operation starts. A Drag and Drop operation starts when the
	 * 	<code>DnDManager.startDragDrop()</code> method has been called
	 * 	and once the user has moved the mouse with the left button pressed.
	 *  
	 *  @eventType org.flashapi.swing.events.DnDEvent.DND_START
	 */
	[Event(name = "dndStart", type = "org.flashapi.swing.events.DnDEvent")]
	
	/**
	 *  Dispatched by the current <code>DnDOperation</code> instance when the
	 * 	drag operation is completed. That means that the user has released the
	 * 	mouse left button after he started a Drag and Drop operation.
	 * 
	 *  <p>You can use this event to manually control the result of a
	 * 	Drag and Drop operation.</p>
	 *
	 *  @eventType org.flashapi.swing.events.DnDEvent.DND_COMPLETE
	 */
	[Event(name = "dndComplete", type = "org.flashapi.swing.events.DnDEvent")]
	
	/**
	 *  Dispatched by the current <code>DnDOperation</code> instance when the
	 * 	drag operation is accepted. This event is dispatched each time the
	 * 	<code>DnDManager.acceptDragDrop()</code> method is called.
	 *
	 *  @eventType org.flashapi.swing.events.DnDEvent.DND_DROP_ACCEPTED
	 */
	[Event(name = "dndDropAccepted", type = "org.flashapi.swing.events.DnDEvent")]
	
	/**
	 *  Dispatched by the current <code>DnDOperation</code> instance when the
	 * 	drag operation has been refused or canceled. This event is dispatched each time the
	 * 	<code>DnDManager.cancelDragDrop()</code> method is called.
	 *
	 *  @eventType org.flashapi.swing.events.DnDEvent.DND_DROP_CANCELED
	 */
	[Event(name = "dndDropCanceled", type = "org.flashapi.swing.events.DnDEvent")]

	/**
	 * 	The <code>DnDOperation</code> is the entity responsible for the
	 * 	initiation and the management of a Drag and Drop operation.
	 * 
	 * 	@see org.flashapi.swing.managers.DnDManager
	 * 	@see org.flashapi.swing.managers.DnDManager#startDrag()
	 * 	@see org.flashapi.swing.UIManager#dragManager
	 * 
	 *  @includeExample DnDExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DnDOperation extends EventDispatcher implements IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DnDOperation</code> instance.
		 * 
		 * @param	initiator	The <code>UIObject</code> instance that is responsible
		 * 						for the initiation of the Drag and Drop operation.
		 * @param	dragImage	The object used to create a visual representation of
		 * 						the initiator (drag image) during a Drag and Drop
		 * 						operation. If <code>null</code>, the drag image is
		 * 						replaced by a <code>DefaultDragImage</code> object.
		 * @param	dragImageAlpha	The transparency of the drag image, from <code>0</code>
		 * 							(fully transparent) to <code>1</code> (fully opaque).
		 * @param	bounds	A <code>Rectangle</code> object that contains values relative
		 * 					to the coordinates of the initiator parent that specifies a
		 * 					constraint area for the Drag and Drop operation.
		 */
		public function DnDOperation(initiator:UIObject = null, dragImage:DisplayObject = null, dragImageAlpha:Number = 0.5, bounds:Rectangle = null) {
			super();
			initObj(initiator, dragImage, dragImageAlpha, bounds);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Indicates whether the <code>DnDOperation</code> uses a motion effect to specify
		 * 	that a Drag and Drop operation has been canceled (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@see #dropCanceledDuration
		 */
		public var hasCancelDropAnimation:Boolean = true;
		
		/**
		 * 	Indicates whether the <code>DnDOperation</code> uses a motion effect to specify
		 * 	that a Drag and Drop operation has succeded (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@see #dropAcceptedDuration
		 */
		public var hasAcceptDropAnimation:Boolean = true;
		
		/**
		 * 	Indicates the horizontal offset of the drag image, in pixels.
		 * 
		 * 	@see #yOffset
		 */
		public var xOffset:Number = 0;
		
		/**
		 * 	Indicates the vertical offset of the drag image, in pixels.
		 * 
		 * 	@see #xOffset
		 */
		public var yOffset:Number = 0; 
		
		/**
		 * 	[Not implemented yet.]
		 */
		public var action:String = DnDAction.DND_ACTION_MOVE;
		
		/**
		 * 	The icon diplayed when the Drag and Drop operation is initiated.
		 */
		public var dragInitialIcon:Class = DragInitialIcon;
		
		/**
		 * 	The icon diplayed when leaving the drop target.
		 */
		public var dragOutIcon:Class = DragOutIcon;
		
		/**
		 * 	The icon diplayed when drop is enable.
		 */
		public var dropEnabledIcon:Class = DropEnabledIcon;
		
		/**
		 * 	The icon diplayed when drop is not enable.
		 */
		public var dropDisabledIcon:Class = DropDisabledIcon;
		
		/**
		 * 	The duration of the motion effect when a Drag and Drop operation has
		 * 	succeded.
		 * 
		 * 	@see #hasCancelDropAnimation
		 */
		public var dropAcceptedDuration:Number = 150;
		
		/**
		 * 	The duration of the motion effect when a Drag and Drop operation has been
		 * 	canceled.
		 * 
		 * 	@see #hasAcceptDropAnimation
		 */
		public var dropCanceledDuration:Number = 250;
		
		/**
		 * 	The icon diplayed when the mouse moves over the application container.
		 */
		public var documentDragIcon:Class = DragOutIcon;
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _bounds:Rectangle = null;
		/**
		 * 	A <code>Rectangle</code> object that contains values relative to the coordinates
		 * 	of the initiator parent that specifies a constraint area for the Drag and
		 * 	Drop operation. If <code>null</code> the Drag and Drop operation is
		 * 	performed without bound limitations.
		 * 
		 * 	@default null
		 */
		public function get bounds():Rectangle {
			return _bounds;
		}
		public function set bounds(value:Rectangle):void {
			_bounds = value;
		}
		
		private var _dragImageAlpha:Number = .5;
		/**
		 * 	Sets or gets the transparency of the drag image, from <code>0</code> (fully
		 * 	transparent) to <code>1</code> (fully opaque).
		 * 
		 * 	@default 0.5
		 */
		public function get dragImageAlpha():Number {
			return _dragImageAlpha;
		}
		public function set dragImageAlpha(value:Number):void {
			_dragImageAlpha = value;
		}
		
		private var _initiator:UIObject;
		/**
		 * 	Sets or gets the <code>UIObject</code> instance that is responsible for the 
		 * 	initiation of the Drag and Drop operation.
		 */
		public function get initiator():UIObject {
			return _initiator;
		}
		public function set initiator(value:UIObject):void {
			_initiator = value;
		}
		
		private var _dragImage:DisplayObject;
		/**
		 * 	Sets or gets the object used to create a visual representation of
		 * 	the initiator (drag image) during a Drag and Drop operation. If
		 * 	<code>null</code>, the drag image is replaced by a <code>DefaultDragImage</code>
		 * 	object.
		 * 
		 * 	@see org.flashapi.swing.dnd.DefaultDragImage
		 */
		public function get dragImage():DisplayObject {
			return _dragImage;
		}
		public function set dragImage(value:DisplayObject):void {
			_dragImage = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var dropFmt:Array = [];
		/**
		 * 	Returns an <code>Array</code> that contains all <code>DnDFormat</code> objects
		 * 	for this Drag and Drop operation.
		 * 
		 * 	@see org.flashapi.swing.dnd.DnDFormat
		 */
		public function get dropFormat():Array {
			return spas_internal::dropFmt;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var imagePosition:Point;
		/**
		 * 	While a Drag and Drop operation is in progress, the <code>dragImagePosition</code>
		 * 	property returns a point that represents the coordinates of the drag image.
		 * 	The coordinates of the <code>Point</code> object are relative to the stage.
		 * 
		 * 	<p>If no Drag and Drop operation is in progress, the <code>dragImagePosition</code>
		 * 	property returns <code>null</code>.</p>
		 * 	
		 * 	@default null
		 */
		public function get dragImagePosition():Point {
			return spas_internal::imagePosition;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var anchorsImageToMouse:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the drag image  
		 * 	position is anchored to the position of the mouse (<code>true</code>),  
		 * 	or not (<code>false</code>). Use the <code>anchorsImageToMousePos</code>
		 * 	property to specify a custom position for the drag image defined by the
		 * 	<code>dragImage</code> property.
		 * 
		 * 	@default false
		 * 
		 * 	@see #dragImage
		 */
		public function get anchorsImageToMousePos():Boolean {
			return spas_internal::anchorsImageToMouse;
		}
		public function set anchorsImageToMousePos(value:Boolean):void {
			spas_internal::anchorsImageToMouse = value;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Add a new drop format to this <code>DnDOperation</code> object.
		 * 
		 * 	@param	format The drop format to add to this <code>DnDOperation</code> object.
		 * 
		 * 	@see org.flashapi.swing.dnd.DnDFormat
		 */
		public function addDropFormat(format:DnDFormat):void {
			spas_internal::dropFmt.push(format);
		}
		
		/**
		 * 	Checks whether this object has registered the <code>DnDFormat</code> object
		 * 	specified by the <code>format</code> parameter.
		 * 
		 * 	@param	format	The drop format to check.
		 * 
		 * 	@return	A value of <code>true</code> if the drop format is registered;
		 * 			<code>false</code> otherwise.
		 * 
		 * 	@see org.flashapi.swing.dnd.DnDFormat
		 */
		public function hasDropFormat(format:DnDFormat):Boolean {
			var l:int = spas_internal::dropFmt.length -1;
			for (; l >= 0; l--) {
				if (spas_internal::dropFmt[l] == format) return true;
			}
			return false;
		}
		
		/**
		 * 	Removes the specified drop format from this <code>DnDOperation</code> object.
		 * 
		 * 	@param	format 	The drop format to remove from this <code>DnDOperation</code>
		 * 					object.
		 * 
		 * 	@see org.flashapi.swing.dnd.DnDFormat
		 */
		public function removeDropFormat(format:DnDFormat):void {
			var l:int = spas_internal::dropFmt.length -1;
			for (; l >= 0; l--) {
				if (spas_internal::dropFmt[l] == format)
					spas_internal::dropFmt.splice(l, 1);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function isEligible():Boolean {
			return _initiator.dragEnabled ? true : false;
			//return (_event.type == UIMouseEvent.PRESS || _event.buttonDown) ? true : false;
		}
		
		/**
		 * @private
		 */
		spas_internal function setDragImagePosition(x:Number, y:Number):void {
			spas_internal::imagePosition.x = x;
			spas_internal::imagePosition.y = y;
		}
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(initiator:UIObject, dragImage:DisplayObject, dragImageAlpha:Number, bounds:Rectangle):void {
			_initiator = initiator;
			_bounds = bounds;
			_dragImage = dragImage;
			_dragImageAlpha = dragImageAlpha;
		}
	}
}