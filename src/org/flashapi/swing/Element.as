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
	// Element.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/02/2010 21:17
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.ProxyEventDispatcher;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.UIOEvent;
	
	use namespace flash_proxy;
	use namespace spas_internal;
	
	[IconFile("Element.png")]
	
	/**
	 * 	<img src="Element.png" alt="Element" width="18" height="18"/>
	 * 
	 * 	The <code>Element</code> class represents any element within a SPAS 3.0 
	 * 	application. It provides a generic mechanism for working with any kind of objects
	 * 	added to SPAS 3.0 <code>UIContainers</code> instances. Elements can define
	 * 	external graphical objects (such as SWF files or images), <code>UIObjects</code>
	 * 	and <code>DisplayObjectContainers</code>.
	 * 
	 * 	<p>The concept of element classes solves the problem of working with objects
	 * 	which have incompatible APIs with the SPAS 3.0 Framework.</p>
	 * 
	 *  @includeExample ElementExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	dynamic public class Element extends ProxyEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor.
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>Element</code> instance.
		 */
		public function Element() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override flash_proxy function getProperty(name:*):* {
			if(name in _element) return _element[name];
			return "Property does not exist";
		}
		
		/**
		 * 	@private
		 */
        override flash_proxy function setProperty(name:*, value:*):void {
			_element[name] = value;
			if(!_isUIObject) {
				var e:Event = new Event(Event.CHANGE);
				_element.dispatchEvent(e);
			}
        }
		
		/**
		 * 	@private
		 */
		override flash_proxy function callProperty(name:*, ... args):* {
			name = String(name);
			var callType:String = name.slice(0,3);
			var callVariable:String = name.slice(3);
			switch(callType) {
                case 'get':
					if(callVariable in _element) return _element[name];
					return null;
					break;
                case 'set': _variables[callVariable] = args[0];
					return null;
					break;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var target:*;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal function setElement(value:*):void {
			_element = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function addLayoutListener(isUIObject:Boolean):void {
			_isUIObject = isUIObject;
			if (isUIObject) spas_internal::target.eventCollector.addEvent(_element, UIOEvent.METRICS_CHANGED, addToLayoutManagerQueue);
			else {
				if (!hasResizableProperty(_element)) return;
				spas_internal::elementStack[_element] =
					{ target:target, width:_element.width, height:_element.height };
				spas_internal::target.eventCollector.addEvent(_element, Event.CHANGE, Element.spas_internal::proxyLayoutListener);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _element:*;
		private var _isUIObject:Boolean = false;
		private var _variables:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Layout listener proxy API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static var elementStack:Dictionary = new Dictionary(true);
		
		/**
		 * 	@private
		 */
		spas_internal static function proxyLayoutListener(e:Event):void {
			var obj:Object = spas_internal::elementStack[tgt];
			//--> Bugfix :
			// The element object fires the proxyLayoutListener action even if the Event.CHANGE has not been registred.
			if(obj == null) return;
			// TypeError: Error #1009: Il est impossible d'accéder à la propriété ou à la méthode d'une référence d'objet nul.
			// at org.flashapi.swing::Element$/http://www.flashapi.org/spas/internal::proxyLayoutListener()
			//--<
			var tgt:* = e.target;
			var w:Number = tgt.width;
			var h:Number = tgt.height;
			var objTgt:* = obj.target;
			if (obj.width != w || obj.height != h) {
				obj.width = w; obj.height = h;
				objTgt.spas_internal::addToLayoutManagerQueue(e);
				spas_internal::elementStack[tgt] = obj;
			}
		}
		
		/**
		 * 	@private
		 */
		spas_internal static function removeLayoutListener(value:*):void {
			if (value is IUIObject) value.target.eventCollector.removeEvent(value, UIOEvent.METRICS_CHANGED, addToLayoutManagerQueue);
			else {
				if (!hasResizableProperty(value)) return;
				var obj:Object = spas_internal::elementStack[value];
				obj.target.eventCollector.removeEvent(value, Event.CHANGE, Element.spas_internal::proxyLayoutListener);
				spas_internal::elementStack[value] = null;
				delete spas_internal::elementStack[value];
			}
		}
		
		private static function hasResizableProperty(obj:*):Boolean {
			return (obj.hasOwnProperty("width") && obj.hasOwnProperty("height"));
		}
		
		private static function addToLayoutManagerQueue(e:UIOEvent):void {
			var elm:* = e.target;
			if (elm is UIContainer) elm.spas_internal::addToLayoutManagerQueue(e);
			elm.target.spas_internal::addToLayoutManagerQueue(e);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_variables = { };
			$objectDescriptor = "[object Element]";
		}
	}
}