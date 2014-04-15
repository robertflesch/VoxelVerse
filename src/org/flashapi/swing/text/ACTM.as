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

package org.flashapi.swing.text {
	
	// -----------------------------------------------------------
	// ACTM.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 13/08/2009 18:13
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.net.DataLoader;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>ACTM</code> class (for Abstract Complex Text Methods) is the base
	 * 	class for objects that allow to display texts on several lines.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ACTM extends ATM {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ACTM</code> object with the specified
		 * 	parameters.
		 * 
		 * 	@param	width	The width of the text object, in pixels.
		 * 	@param	height	The height of the text object, in pixels.
		 */
		public function ACTM(width:Number = 100, height:Number = 100) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function set autoSize(value:Boolean):void {
			$autoSize = value;
			setRefresh();
		}
		
		private var _wordwrap:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the text object has
		 * 	word wrap (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get wordWrap():Boolean  {
			return _wordwrap;
		}
		public function set wordWrap(value:Boolean):void {
			_wordwrap = textRef.wordWrap = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Text management methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Appends the string specified by the <code>value</code> parameter to the
		 * 	end of the text of the text object.
		 * 
		 * 	@param	value	The string to append to the existing text.
		 * 
		 * 	@see #loadText()
		 * 	@see #text
		 */
		public function appendText(value:String):void {
			$text += value;
			$needsTextUpdate = true;
			setRefresh();
		}
		
		/**
		 * 	Loads a text file specified by the <code>uri</code> parameter and replace
		 * 	the current text displayd withis the <code>ACTM</code> instance by the
		 * 	loaded one.
		 * 
		 * 	@param	uri	The url of text file to load within this <code>ACTM</code>
		 * 				instance.
		 * 
		 * 	@see #appendText()
		 * 	@see #text
		 */
		public function loadText(uri:String):void {
			removeTextLoader();
			_textLoader = new DataLoader();
			$evtColl.addEvent(_textLoader, LoaderEvent.COMPLETE, textLoadedHandler);
			_textLoader.load(uri, DataFormat.HTML);
		}
		
		/**
		 * 	@private	
		 */
		override public function finalize():void {
			removeTextLoader();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textLoader:DataLoader = null;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function createContainer():void {
			if(spas_internal::isBorderInstance) createBorderIstanceContainer();
			textRef.multiline = true
			textRef.wordWrap = _wordwrap;
			textRef.selectable = $selectable;
			spas_internal::isBorderInstance ?
				spas_internal::uioSprite.addChildAt(textRef, 1) :
				spas_internal::uioSprite.addChild(textRef);
			$evtColl.addEvent(textRef, Event.CHANGE, textChangedHandler);
		}
		
		/**
		 * 	@private
		 */
		protected function fixSize():void {
			textRef.autoSize = TextFieldAutoSize.LEFT;
			textRef.wordWrap = $autoWidth && !_wordwrap ? false : true;
			var d:Number = spas_internal::icon == null ? 0 :
				$horizontalGap + spas_internal::icon.width;
			switch($autoSize) {
				case true :
					break;
				case false :
					var w:Number = $width;
					var h:Number = $height;
					if ($autoWidth) w = textRef.width + d;
					else if ($autoHeight) h = textRef.height;
					textRef.autoSize = TextFieldAutoSize.NONE;
					spas_internal::lafDTO.textWidth = textRef.width = w - d;
					spas_internal::lafDTO.textHeight = textRef.height = h;
					break;
			}
			textRef.wordWrap = _wordwrap;
			if($autoSize || $autoWidth || $autoHeight) spas_internal::metricsChanged = true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			spas_internal::lafDTO.textWidth = $width = width;
			spas_internal::lafDTO.textHeight = $height = height;
			$text = "";
			//_editable = _border = false;
			$editable = false;
		}
		
		/**
		 * 	@private
		 */
		private function textLoadedHandler(e:LoaderEvent):void {
			$text = String(e.data);
			removeTextLoader();
			$needsTextUpdate = true;
			setRefresh();
		}
		
		private function removeTextLoader():void {
			if (_textLoader == null) return;
			$evtColl.removeEvent(_textLoader, LoaderEvent.COMPLETE, textLoadedHandler);
			_textLoader.finalize();
			_textLoader = null;
		}
	}
}