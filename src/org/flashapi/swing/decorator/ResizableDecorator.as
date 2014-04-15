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
	// ResizableDecorator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/03/2011 14:44
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.event.ResizerEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.ui.Resizer;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>ResizableDecorator</code> class provides decoration mechanism to give
	 * 	<code>UIObject</code> instances an easy-to-implement way for rendring
	 * 	<code>ResizableUIObject</code> objects.
	 * 
	 * 	@see org.flashapi.swing.core.ResizableUIObject
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class ResizableDecorator {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ResizableDecorator</code> instance.
		 * 
		 * 	@param	target	The <code>UIObject</code> object to be decorated.
		 */
		public function ResizableDecorator(target:UIObject) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _target:UIObject;
		/**
		 * 	Returns a reference to the decorated <code>UIObject</code> instance.
		 */
		public function get target():UIObject {
			return _target;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all internal process
		 * 	of a <code>ResizableDecorator</code> instance are killed before you delete it.
		 * 	<p><strong>After calling this function you must set the object to <code>null</code>
		 * 	to definitely kill it.</strong></p>
		 */
		public function finalize():void {
			var evtColl:EventCollector = _target.eventCollector;
			evtColl.removeEvent(_resizer, ResizerEvent.RESIZE_START, sizeStartHandler);
			evtColl.removeEvent(_resizer, ResizerEvent.RESIZE_UPDATE, sizeUpdateHandler);
			evtColl.removeEvent(_resizer, ResizerEvent.RESIZE_FINISH, sizeFinishHandler);
			evtColl.removeEvent(_target, UIOEvent.METRICS_CHANGED, updateMetrics);
			_target.spas_internal::uioSprite.removeChild(_resizer);
			_target = null;
			_resizer.finalize();
			_resizer = null;
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
			_resizer.deactivateHandles(rest);
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
			_resizer.activateHandles(rest);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _resizer:Resizer;
		private var _invalidateMetricsChanged:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:UIObject):void {
			_target = target;
			var cont:Sprite = _target.spas_internal::uioSprite;
			_resizer = new Resizer(cont, _target.width, _target.height);
			var evtColl:EventCollector = _target.eventCollector;
			evtColl.addEvent(_resizer, ResizerEvent.RESIZE_START, sizeStartHandler);
			evtColl.addEvent(_resizer, ResizerEvent.RESIZE_UPDATE, sizeUpdateHandler);
			evtColl.addEvent(_resizer, ResizerEvent.RESIZE_FINISH, sizeFinishHandler);
			evtColl.addEvent(_target, UIOEvent.METRICS_CHANGED, updateMetrics);
			cont.addChild(_resizer);
		}
		
		private function updateMetrics(e:UIOEvent):void {
			if (_invalidateMetricsChanged) return;
			_resizer.fitToTargetRect();
			_resizer.refresh();
		}
		
		private function sizeStartHandler(e:ResizerEvent):void {
			_target.invalidateMetricsChanges = _invalidateMetricsChanged = true;
			_target.dispatchEvent(new ResizerEvent(ResizerEvent.RESIZE_START));
		}
		
		private function sizeUpdateHandler(e:ResizerEvent):void {
			updateSize();
			_target.dispatchEvent(new ResizerEvent(ResizerEvent.RESIZE_UPDATE));
		}
		
		private function sizeFinishHandler(e:ResizerEvent):void {
			updateSize();
			_target.invalidateMetricsChanges = false;
			_target.dispatchEvent(new UIOEvent(UIOEvent.METRICS_CHANGED));
			_target.dispatchEvent(new ResizerEvent(ResizerEvent.RESIZE_FINISH));
			_invalidateMetricsChanged = false;
		}
		
		private function updateSize():void {
			var s:Rectangle = _resizer.getSizeRect();
			var l:Number = s.left;
			var t:Number = s.top;
			var cont:Sprite = _target.spas_internal::uioSprite;
			cont.x = l;
			cont.y = t;
			_target.resize(s.right - l, s.bottom - t);
		}
	}
}