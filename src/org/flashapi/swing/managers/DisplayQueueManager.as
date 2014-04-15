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
	// DisplayQueueManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 13/01/2009 02:19
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.QueueMode;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.event.UIOEvent;
	
	/**
	 * 	[This class is experimental.]
	 * 	The <code>DisplayQueueManager</code> class lets you easilly manage displaying
	 * 	of several <code>UIObjects</code>, within a SPAS 3.0 application, by controling
	 * 	their display effects.
	 * 
	 *  @includeExample DQMExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DisplayQueueManager {
		
		// TODO: Create a DqmProxy Object to strore properties within the array stack.
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DisplayQueueManager</code> instance.
		 */
		public function DisplayQueueManager() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _queueMode:String = QueueMode.SEQUENTIAL;
		/**
		 * 	Sets or gets the type of sequence that is used to render the displaying
		 * 	of <code>UIObject</code> instances managed by this <code>DisplayQueueManager</code>
		 * 	object. Even if possible values are the constants of the <code>QueueMode</code>,
		 * 	the current version of the <code>DisplayQueueManager</code> class only
		 * 	accepts <code>QueueMode.SEQUENTIAL</code> as value for this property.
		 * 
		 * 	@default QueueMode.SEQUENTIAL
		 */
		public function get queueMode():String {
			return _queueMode;
		}
		public function set queueMode(value:String):void {
			_queueMode = value;
		}
		
		private var _isPlaying:Boolean = false;
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the
		 * 	<code>UIObject</code> instances managed by this <code>DisplayQueueManager</code>
		 * 	object are currently displaying (<code>true</code>), or not(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		private var _isPaused:Boolean= false;
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the
		 * 	displaying sequence of this <code>DisplayQueueManager</code> is
		 * 	currently paused (<code>true</code>), or not(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get isPaused():Boolean {
			return _isPaused;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	[Will be refactored.]
		 * 	Adds an object to the <code>DisplayQueueManager</code> with the specified
		 * 	parameters.
		 * 	
		 * 	@param	target	The parent <code>UIContainer</code> object where to display
		 * 					the <code>UIObject</code> specified by the <code>object</code>
		 * 					parameter.
		 * 	@param	object	The <code>UIObject</code> to be managed by this
		 * 					<code>DisplayQueueManager</code>.
		 * 	@param	callback	A closure function which is called once the <code>UIObject</code>
		 * 		has been displayed. The <code>callback</code> function must accept an
		 * 		<code>Object</code> as its unique parameter, to access the following
		 * 		properties: <code>target</code> (which represents the parent <code>UIContainer</code>
		 * 		object) and <code>object</code> (which represents the <code>UIObject</code>
		 * 		itself).
		 * 	@param	effect	A reference to the class that is used as display effect by
		 * 					the <code>UIObject</code>. This class must implements the
		 * 					<code>Effect</code> interface.
		 * 	@param	duration	The duration of the display effect, in milliseconds.
		 * 
		 * 	@see #addAll()
		 */
		public function add(target:*, object:*, callback:Function = null, effect:Class = null, duration:Number = 350):void {
			_stack.splice(0, 0, [target, object, callback, effect, duration]);
		}
		
		/**
		 * 	[Will be refactored.]
		 * 	Adds a collection of objects to the <code>DisplayQueueManager</code>.
		 * 	Each object within the collection is specified by an <code>Array</code>
		 * 	that contains the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>index</th>
		 * 			<th>Type of object</th>
		 * 			<th>Description</th>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>0</code></td>
		 * 			<td><code>UIContainer</code></td>
		 * 			<td>The target container where to display the <code>UIObject</code>.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>1</code></td>
		 * 			<td><code>UIObject</code></td>
		 * 			<td>The <code>UIObject</code> to be managed by this <code>DisplayQueueManager</code>.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>2</code></td>
		 * 			<td><code>Function</code></td>
		 * 			<td>The closure function which is called once the <code>UIObject</code>
		 * 			has been displayed.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>3</code></td>
		 * 			<td><code>Class</code></td>
		 * 			<td>The reference to the class that is used as display effect by
		 * 			the <code>UIObject</code>. This class must implements the
		 * 			<code>Effect</code> interface.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>4</code></td>
		 * 			<td><code>uint</code></td>
		 * 			<td>The duration of the display effect, in milliseconds.</td>
		 * 		</tr>
		 * 	</table>
		 * 
		 * 	<p>Array objects of the collection must be comma separated.</p>
		 * 
		 * 	@param	... collection	A collection of comma separated array objects
		 * 							that define a <code>UIObject</code> to add
		 * 							to this <code>DisplayQueueManager</code>.
		 * 
		 * 	@see #add()
		 */
		public function addAll(... collection:*):void {
			var l:int = collection.length - 1;
			if (l < 1) return;
			var i:uint = 0;
			var arr:Array;
			for (; i <= l; ++i) {
				arr = collection[i];
				var f:Function = arr[2] != null ? arr[2] : null;
				var fx:Class = arr[3] != null ? arr[3] : null;
				this.add(arr[0], arr[1], f, fx, arr[4]);
			}
		}
		
		/**
		 * 	Removes the <code>UIObject</code> instance specified by the <code>obj</code>
		 * 	parameter from this <code>DisplayQueueManager</code> object.
		 * 
		 * 	@param	obj	The object to remove from this <code>DisplayQueueManager</code>.
		 */
		public function remove(obj:*):void {
			var id:int = _stack.indexOf(obj);
			_stack.splice(id, 1);
		}
		
		/**
		 * 	Removes all <code>UIObject</code> instances from this
		 * 	<code>DisplayQueueManager</code> object.
		 */
		public function removeAll():void {
			_stack = [];
		}
		
		/**
		 * 	Starts displaying <code>UIObject</code> instances managed by this
		 * 	<code>DisplayQueueManager</code> object.
		 * 
		 * 	@see #pause()
		 * 	@see #resume()
		 */
		public function play():void {
			if (_isPlaying) return;
			_isPlaying = true;
			_currentId = _stack.length - 1;
			displayNextObject();
		}
		
		/**
		 * 	[Not implemented yet.]
		 */
		public function pause():void {
			if (_isPaused) return;
			_isPaused = true;
			_isPlaying = false;
		}
		
		/**
		 * 	[Not implemented yet.]
		 */
		public function resume():void {
			if (_isPlaying) return;
			_isPaused = false;
			_isPlaying = true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _stack:Array;
		private var _currentId:int;
		private var _evtColl:EventCollector;
		private var _callback:Function = null;
		private var _infoObj:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_evtColl = new EventCollector();
			_stack = [];
		}
		
		private function displayNextObject(e:UIOEvent = null):void {
			if (_callback != null) _callback(_infoObj);
			if (_currentId < 0) return;
			var arr:Array = _stack[_currentId];
			switch(_queueMode) {
				case QueueMode.SEQUENTIAL :
					_currentId--;
					break;
			}
			var tgt:* = arr[0];
			var obj:* = arr[1];
			_infoObj = { target:tgt, object:obj };
			_callback = arr[2];
			if (tgt != null) {
				if (arr[3] != null && obj is IUIObject) {
					obj.hasDisplayEffect = true;
					obj.displayEffectRef = arr[3];
					obj.displayEffectDuration = arr[4];
				}
				if (obj is IUIObject)
					_evtColl.addOneShotEvent(obj as IEventDispatcher, UIOEvent.DISPLAYED, displayNextObject);
				tgt.addElement(obj);
				if (!(obj is IUIObject)) displayNextObject();
			} else { 
				if (obj is IUIObject) {
					_evtColl.addOneShotEvent(obj as IEventDispatcher, UIOEvent.DISPLAYED, displayNextObject);
					obj.display();
				}
			}
		}
	}
}