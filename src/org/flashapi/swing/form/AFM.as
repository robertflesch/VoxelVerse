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
	// AFM.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 23/02/2010 00:13
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.flashapi.swing.BubbleHelp;
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.AnchorPosition;
	import org.flashapi.swing.constants.FormLabelPosition;
	import org.flashapi.swing.constants.LayoutHorizontalAlignment;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.WebServiceEvent;
	import org.flashapi.swing.list.ALM;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.net.rpc.WebService;
	import org.flashapi.swing.net.rpc.WebServiceBase;
	import org.flashapi.swing.Text;
	import org.flashapi.swing.util.Iterator;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>AFM</code> class defines the abstract API for SPAS 3.0 HTML-like
	 * 	forms.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AFM extends ALM implements Listable, FormObject {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AFM</code> instance.
		 * 
		 * 	@param	containerClass	A reference to the <code>FormItemContainer</code>
		 * 	class that is used to create and manage form item objects within this
		 * 	<code>FormObject</code> instance.
		 * 	@param	lafClass	The Look and Feel class used to render the user interface
		 * 	of this <code>FormObject</code> instance.
		 * 	@param	url	The URI where is located the Web sevice to use with this 
		 * 	<code>FormObject</code> instance.
		 */
		public function AFM(containerClass:Class, lafClass:Class, url:String = null) {
			super();
			initObj(containerClass, lafClass, url);
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
			_url = $service.url = value;
		}
		
		private var _errorWidth:Number = 250;
		/**
		 * 	Sets or gets the width of error message controls, in pixels.
		 * 
		 * 	@default 250
		 */
		public function get errorWidth():Number {
			return _errorWidth;
		}
		public function set errorWidth(value:Number):void {
			_errorWidth = value;
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
		 * 	@inheritDoc
		 */
		public function get variables():Dictionary {
			var d:Dictionary = new Dictionary;
			var it:Iterator = $objList.iterator;
			var fic:FormItemContainer;
			while (it.hasNext()) {
				fic = it.next().item;
				if (fic.variable != null) d[fic.variable] = fic.value;
			}
			it.reset();
			return d;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>webService</code> property.
		 * 
		 * 	@see #webService
		 */
		protected var $service:WebService;
		/**
		 * 	@inheritDoc
		 */
		public function get webService():WebService {
			return $service;
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
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>labelsPosition</code> property.
		 * 
		 * 	@see #labelsPosition
		 */
		protected var $labelsPosition:String;
		/**
		 * 	Sets or gets the position of all label controls displayed within this
		 * 	<code>FormObject</code> instance. Possible values are constants from
		 * 	the <code>FormLabelPosition</code> class.
		 * 
		 * 	@see org.flashapi.swing.constants.FormLabelPosition
		 */
		public function get labelsPosition():String {
			return $labelsPosition;
		}
		public function set labelsPosition(value:String):void {
			$labelsPosition = value;
			var it:Iterator = $objList.iterator;
			var fic:FormItemContainer;
			var pos:String = $labelsPosition != null ? $labelsPosition : FormLabelPosition.LEFT;
			while (it.hasNext()) {
				fic = it.next().item;
				fic.labelPosition = pos;
			}
			it.reset();
			//updateItemList();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function submit():void {
			spas_internal::submitForm();
		}
		
		/**
		 * 	@private
		 */
		override public function addItem(value:*, data:* = null):ListItem {
			var fic:IUIObject = new _containerClass(this, value);
			fic.target = spas_internal::uioSprite;
			var li:ListItem = new ListItem(fic as FormItemContainer, $objList, value, data);
			updateItemList();
			setRefresh();
			return li;
		}
		
		/**
		 * 	@private
		 */
		override public function removeAll():void {
			var it:Iterator = $objList.iterator;
			while (it.hasNext()) {
				var fic:FormItemContainer = it.next().item;
				if (fic.displayed) fic.remove();
				fic.finalize();
			}
			it.reset();
			super.removeAll();
		}
		
		/**
		 * 	@private
		 */
		override public function removeItem(item:ListItem):void {
			var fic:FormItemContainer = item.item;
			if (fic.displayed) fic.remove();
			fic.finalize();
			$objList.remove(item);
			updateItemList();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function removeItemAt(index:int):void {
			var li:ListItem = getItemAt(index) as ListItem;
			var fic:FormItemContainer = li.item;
			if (fic.displayed) fic.remove();
			fic.finalize();
			super.removeItemAt(index);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function reset():void {
			var it:Iterator = $objList.iterator;
			var fic:FormItemContainer;
			while (it.hasNext()) {
				fic = it.next().item;
				fic.reset();
			}
			it.reset();
			removeErrorMessage();
			updateItemList();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			_errorHelp.finalizeElements();
			_helpTxt = null;
			_errorHelp.finalize();
			_errorHelp = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal var itemsXPosition:Number;
		
		//spas_internal var itemTabIndex:int = -1;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal function displayErrorMessage(message:String, fic:Canvas):void {
			_helpTxt.text = message;
			var xPos:Number = (_currentWidth - _errorWidth) / 2;
			var h:Number = _errorHelp.height + _errorHelp.anchorSize;
			var yPos:Number = fic.y - h;
			_errorHelp.setAnchorPosition();
			
			if (yPos < 0) {
				if (fic.y + fic.height + h < $target.height) {
					yPos = fic.y + fic.height + _errorHelp.anchorSize;
					_errorHelp.setAnchorPosition(.25, AnchorPosition.TOP);
				}
			}
			_errorHelp.display(xPos, yPos);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function removeErrorMessage():void {
			if(_errorHelp.displayed) {
				_helpTxt.text = "";
				_errorHelp.remove();
			}
		}
		
		private var _btnCont:Canvas;
		/**
		 * 	@private
		 */
		spas_internal function getButtonsContainer():Canvas {
			return _btnCont;
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			var it:Iterator = $objList.iterator;
			var fic:FormItemContainer;
			while (it.hasNext()) {
				fic = it.next().item;
				fic.changeFormItemLookAndFeel();
			}
			it.reset();
			updateItemList();
		}
		
		/**
		 *  @private
		 */
		spas_internal function refreshItemList():void {
			this.updateItemList();
		}
		
		/**
		 *  @private
		 */
		spas_internal function dispatchItemClickedEvent():void {
			this.dispatchEvent(new ListEvent(ListEvent.ITEM_CLICKED));
		}
		
		/**
		 *  @private
		 */
		spas_internal function submitForm():void {
			if(_onSubmit != null && _forceSubmitFunction) _onSubmit(this);
			if (_url == null) return;
			$service.close();
			var it:Iterator = $objList.iterator;
			var isFormValid:Boolean = true;
			var fic:FormItemContainer;
			while (it.hasNext()) {
				fic = it.next().item;
				if (fic.validator != null) {
					fic.isValid = fic.validator.validate(fic.value);
					if (!fic.isValid) {
						fic.displayInvalidItem();
						isFormValid = false;
					}
				}
				if (fic.variable != null) $service.request[fic.variable] = fic.value;
			}
			it.reset();
			if (isFormValid) {
				if (_onSubmit != null && !_forceSubmitFunction) _onSubmit(this);
				if (_outputRequest) this.print($service.request);
				$service.send();
			}
		}
		
		/**
		 *  @private
		 */
		spas_internal function getRequest():Array {
			var it:Iterator = $objList.iterator;
			var arr:Array = [];
			var fic:FormItemContainer;
			while (it.hasNext()) {
				fic = it.next().item;
				if (fic.validator != null) {
					fic.isValid = fic.validator.validate(fic.value);
					if (!fic.isValid) return null;
				}
				if (fic.variable != null) arr.push( { variable:fic.variable, value:fic.value } );
			}
			it.reset();
			return arr;
		}
		
		/**
		 *  @private
		 */
		spas_internal function resetForm():void {
			this.reset();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			updateItemList();
			setEffects();
		}
		
		/**
		 * @private
		 */
		override protected function updateItemList():void {
			_lastYPosition = spas_internal::itemsXPosition = 0;
			$dataList = new Dictionary();
			var it:Iterator = $objList.iterator;
			var fic:FormItemContainer;
			while (it.hasNext()) {
				fic = it.next().item as FormItemContainer;
				if (fic.displayed) fic.remove();
			}
			it.reset();
			var next:ListItem;
			while(it.hasNext()) {
				next = it.next() as ListItem;
				fic = next.item as FormItemContainer;
				if (fic.labelPosition != $labelsPosition) fic.labelPosition = $labelsPosition;
				$dataList[fic] = next;
				fic.display(0, _lastYPosition);
				_lastYPosition += fic.height + $verticalGap;
				if (fic.verticalBaseLine > spas_internal::itemsXPosition)
					spas_internal::itemsXPosition = fic.verticalBaseLine;
			}
			it.reset();
			while (it.hasNext()) {
				next = it.next() as ListItem;
				fic = next.item;
				fic.x += (spas_internal::itemsXPosition - fic.verticalBaseLine);
			}
			it.reset();
			fixSize();
			if (_btnCont.numElements > 0) {
				_btnCont.width = $width;
				if(_btnCont.displayed) _btnCont.move(0, _lastYPosition);
				else _btnCont.display(0, _lastYPosition);
			} else _btnCont.remove();
			_currentWidth = spas_internal::uioSprite.getBounds(null).width;
		}
		
		/**
		 * 	@private
		 */
		protected function createWebService():void {
			$service = new WebServiceBase(_url);
			$evtColl.addEvent($service, WebServiceEvent.RESULT, submitResultHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _lastYPosition:Number;
		private var _errorHelp:BubbleHelp;
		private var _helpTxt:Text;
		private var _currentWidth:Number;
		private var _containerClass:Class;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(containerClass:Class, lafClass:Class, url:String):void {
			_url = url;
			_containerClass = containerClass;
			initMinSize(50, 50);
			$verticalGap = 6;
			$horizontalGap = 15;
			createBtnCont();
			initLaf(lafClass);
			createErrorHelpObj();
			createWebService();
			spas_internal::setSelector("form");
		}
		
		private function fixSize():void {
			var r:Rectangle = spas_internal::uioSprite.getBounds(null);
			$width = r.width;
			$height = r.height;
		}
		
		private function createBtnCont():void {
			_btnCont = new Canvas(200);
			_btnCont.target = spas_internal::uioSprite;
			_btnCont.horizontalGap = 10;
			_btnCont.layout.horizontalAlignment = LayoutHorizontalAlignment.CENTER;
			_btnCont.autoHeight = true;
		}
		
		private function submitResultHandler(e:WebServiceEvent):void {
			if (_onResponse != null) _onResponse(e.result);
		}
		
		private function createErrorHelpObj():void {
			_errorHelp = new BubbleHelp(_errorWidth);
			_helpTxt = new Text(_errorWidth);
			_errorHelp.target = spas_internal::uioSprite;
			_helpTxt.boldFace = true;
			_helpTxt.fontColor = 0xFFFFFF;
			_errorHelp.color = 0xFF0000;
			_errorHelp.borderColor = 0x990000;
            _helpTxt.autoHeight = _errorHelp.autoHeight =
			_errorHelp.shadow = _errorHelp.showAnchor = true;
			_errorHelp.addElement(_helpTxt);
		}
	}
}