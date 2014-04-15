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

package org.flashapi.swing.form {
	
	// -----------------------------------------------------------
	// MultiForm.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version beta 1, 09/02/2009 11:59
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.Dictionary;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.WebServiceEvent;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.list.ALM;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.net.rpc.WebService;
	import org.flashapi.swing.net.rpc.WebServiceBase;
	import org.flashapi.swing.util.Iterator;

	use namespace spas_internal;
	
	/**
	 * 	The <code>MultiForm</code> class is a <code>List</code> utility class that
	 * 	allows to manage and send data stored within several different <code>FormObjects</code>
	 * 	at one time. This class is useful to easilly create complex quizzes or polls.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MultiForm extends ALM implements Listable, FormObject {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>MultiForm</code> object with the specified
		 * 	URI.
		 * 
		 * 	@param	url	The URI where is located the Web sevice to use with this 
		 * 	<code>MultiForm</code> instance.
		 */
		public function MultiForm(url:String = null) {
			super();
			initObj(url);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _onResponse:Function = null;
		/**
		 * 	@inheritDoc
		 */
		public function get onResponse():Function {
			return _onResponse;
		}
		public function set onResponse(value:Function):void {
			_onResponse = value;
		}
		
		private var _onSubmit:Function = null;
		/**
		 * 	@inheritDoc
		 */
		public function get onSubmit():Function {
			return _onSubmit;
		}
		public function set onSubmit(value:Function):void {
			_onSubmit = value;
		}
		
		private var _url:String;
		/**
		 * 	@inheritDoc
		 */
		public function get url():String {
			return _url;
		}
		public function set url(value:String):void {
			_url = _service.url = value;
		}
		
		/**
		 *  @private
		 */
		protected var _service:WebService;
		/**
		 * 	@inheritDoc
		 */
		public function get webService():WebService {
			return _service;
		}
		
		private var _outputRequest:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get outputRequest():Boolean {
			return _outputRequest;
		}
		public function set outputRequest(value:Boolean):void {
			_outputRequest = value;
		}
		
		private var _forceSubmitFunction:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get forceSubmitFunction():Boolean {
			return _forceSubmitFunction;
		}
		public function set forceSubmitFunction(value:Boolean):void {
			_forceSubmitFunction = value;
		}
		
		/**
		 * 	[Not implemented yet.]
		 * 	
		 * 	@inheritDoc
		 */
		public function get variables():Dictionary {
			var d:Dictionary = new Dictionary;
			return d;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			checkFormObjectValue(value);
			var li:ListItem = new ListItem(value, $objList, "", data);
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			checkFormObjectValue(value);
			var li:ListItem = new ListItem(value, $objList, "", data, index);
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function removeItem(item:ListItem):void {
			$objList.remove(item);
			$listItem = null;
			$value = null;
			$data = null;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function reset():void {
			var it:Iterator = $objList.iterator;
			var f:* ;
			while (it.hasNext()) {
				f = it.next().item;
				f.reset();
			}
			it.reset();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function submit():void {
			if(_onSubmit != null && _forceSubmitFunction) _onSubmit(this);
			if (_url == null) return;
			_service.close();
			var it:Iterator = $objList.iterator;
			var isFormValid:Boolean = true;
			var l:int;
			var f:*;
			var request:Array;
			while (it.hasNext()) {
				f = it.next().item;
				request = f.spas_internal::getRequest();
				if (request == null) {
					isFormValid = false;
					break;
				} else {
					l = request.length - 1;
					var obj:Object
					for (; l >= 0; l--) {
						obj = request[l];
						_service.request[obj.variable] = obj.value;
					}
				}
			}
			it.reset();
			if (isFormValid) {
				if (_onSubmit != null && !_forceSubmitFunction) _onSubmit(this);
				if (_outputRequest) this.print(_service.request);
				_service.send();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(url:String):void {
			_url = url;
			createWebService();
		}
		
		private function checkFormObjectValue(obj:*):void {
			if (!(obj is FormObject))
				throw new IllegalArgumentException(Locale.spas_internal::ERRORS.FORM_OBJECT_ERROR + obj);
		}
		
		private function createWebService():void {
			_service = new WebServiceBase(_url);
			$evtColl.addEvent(_service, WebServiceEvent.RESULT, submitResultHandler);
		}
		
		private function submitResultHandler(e:WebServiceEvent):void {
			if (_onResponse != null) _onResponse(e.result);
		}
	}
}