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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// SizeUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 16/06/2009 23:02
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	use namespace spas_internal;
	
	/**
	 *  Dispatched when the size of the associated <code>UIObject</code> has
	 * 	changed between two calls of the <code>checkMetricsChanges()</code>
	 * 	method.
	 *
	 *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name = "change", type = "flash.events.Event")]
	
	/**
	 * 	The <code>SizeUtil</code> class is an utility class that is internally used by
	 * 	<code>UIObject</code> instances to store and manage their size properties.
	 * 
	 * 	<p><strong>TechNote:</strong> As it is not possible to compare <code>NaN</code>
	 * 	with another <code>NaN</code> with the equality operator (<code>==</code>),
	 * 	we use the <code>Number.MIN_VALUE</code> instead of <code>NaN</code> metrics
	 * 	values.</p>
	 * 
	 * 	@see org.flashapi.swing.core.UIObject
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SizeUtil extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SizeUtil</code> instance.
		 * 
		 * 	@param	target	The <code>UIObject</code> instance associated with this
		 * 					<code>SizeUtil</code> object.
		 */
		public function SizeUtil(target:UIObject) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _width:Number = -1;
		/**
		 * 	Sets or gets the stored width for the associated <code>UIObject</code>
		 * 	instance.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#width
		 */
		public function get width():Number {
			return _width == -1 ? NaN : _width;
		}
		public function set width(value:Number):void {
			_width = getNaNValue(value);
		}
		
		private var _height:Number = -1;
		/**
		 * 	Sets or gets the stored height for the associated <code>UIObject</code>
		 * 	instance.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#height
		 */
		public function get height():Number {
			return _height == -1 ? NaN : _height;
		}
		public function set height(value:Number):void {
			_height = getNaNValue(value);
		}
		
		private var _percentWidth:Number = -1;
		/**
		 * 	Sets or gets the stored percent width for the associated <code>UIObject</code>
		 * 	instance.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#percentWidth 
		 */
		public function set percentWidth(value:Number):void {
			_percentWidth = getNaNValue(value);
		}
		
		private var _percentHeight:Number = -1;
		/**
		 * 	Sets or gets the stored percent height for the associated <code>UIObject</code>
		 * 	instance.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#percentHeight
		 */
		public function set percentHeight(value:Number):void {
			_percentHeight = getNaNValue(value);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Verifies whether the size of the associated <code>UIObject</code> has
		 * 	changed, or not.
		 */
		public function checkMetricsChanges():void {
			if (_target.spas_internal::deactivateMetricsChanges || _target.invalidateMetricsChanges) return;
			var e:Event = new Event(Event.CHANGE);
			if (_target.spas_internal::metricsChanged) {
				_target.spas_internal::metricsChanged = false;
				dispatchEvent(e);
				return;
			}
			var w:Number = getNaNValue(_target.width);
			var h:Number = getNaNValue(_target.height);
			var pw:Number = getNaNValue(_target.percentWidth);
			var ph:Number = getNaNValue(_target.percentHeight);
			if (_width != w || _height != h || _percentWidth != pw || _percentHeight != ph) {
				_width = w; _height = h;
				_percentWidth = pw;
				_percentHeight = ph;
				dispatchEvent(e);
			}
		}
		
		/**
		 * 	Initializes the srored size for the associated <code>UIObject</code>.
		 * 
		 * 	@param	width The initial width of the associated <code>UIObject</code>.
		 * 	@param	height The initial height of the associated <code>UIObject</code>.
		 */
		public function initMetrics(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_target = null;
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _target:UIObject;
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:UIObject):void {
			_target = target;
		}
		
		private function getNaNValue(value:Number):Number {
			return isNaN(value) ? -1 : value;
		}
	}
}