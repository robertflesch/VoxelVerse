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

package org.flashapi.swing.renderer {
	
	// -----------------------------------------------------------
	// DefaultItemEditor.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 30/03/2010 14:12
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.MouseEvent;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.event.ItemEditorEvent;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.plaf.libs.EditableLabelUIRef;
	import org.flashapi.swing.TextInput;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when a user changes some values of the associated <code>ItemRenderer</code>
	 * 	instance and validates the changes.
	 *
	 *  @eventType org.flashapi.swing.event.ItemEditorEvent.VALIDATED
	 */
	[Event(name = "validated", type = "org.flashapi.swing.event.ItemEditorEvent")]
	
	/**
	 *  Dispatched when a user obort the editing process of the associated
	 * 	<code>ItemRenderer</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ItemEditorEvent.CANCELED
	 */
	[Event(name = "canceled", type = "org.flashapi.swing.event.ItemEditorEvent")]
	
	/**
	 * 	The <code>DefaultItemEditor</code> class defines the default object for
	 * 	editing <code>ItemRenderer</code> instances. This control consists in a
	 * 	<code>TextInput</code> object which allows users to edit the specified
	 * 	<code>ItemRenderer</code> object when needed.
	 * 
	 * 	@see org.flashapi.swing.renderer.ItemRenderer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DefaultItemEditor extends UIObject implements Observer, LafRenderer, ItemEditor {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DefaultItemEditor</code> object with the
		 *  specified parameters.
		 * 
		 * 	@param	width	The width of the <code>DefaultItemEditor</code> object,
		 * 					in pixels.
		 * 	@param	height	The height of the <code>DefaultItemEditor</code> object,
		 * 					in pixels.
		 */
		public function DefaultItemEditor(width:Number = 150, height:Number = 20) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get text():String {
			return _input.text;
		}
		public function set text(value:String):void {
			_input.text = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function set index(value:int):void {
			spas_internal::setIndex(value);
		}
		
		/**
		 *  @private
		 */
		private var _input:TextInput;
		/**
		 * 	@inheritDoc
		 */
		public function get inputControl():* {
			return _input;
		}
		
		private var _itemRenderer:ItemRenderer;
		/**
		 * 	@inheritDoc
		 */
		public function get itemRenderer():ItemRenderer {
			return _itemRenderer;
		}
		public function set itemRenderer(value:ItemRenderer):void {
			_itemRenderer = value;
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void {
			_input.height = super.height = value;
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			_input.width = super.width = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				_input.focus = true;
				createUIObject(x, y);
				doStartEffect();
			}
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_itemRenderer = null;
			$evtColl.removeEvent(_input, TextEvent.VALIDATED, validateHandler);
			_input.finalize();
			_input = null;
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function remove():void {
			if($displayed) {
				unload();
				if (_input.focus) _input.focus = false;
			}
		}
		
		/**
		 *  Resets the editable label object.
		 */
		public function reset():void { }
		
		/**
		 *  @private
		 */
		override public function resize(width:Number, height:Number):void {
			_input.resize(width, height);
			super.resize(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_input.lockLaf(lookAndFeel.getTextInputLaf(), true);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			$width = width;
			$height = height;
			createControls();
			initLaf(EditableLabelUIRef);
			createEvents();
			spas_internal::setSelector("defaultitemeditor");
			spas_internal::isInitialized(1);
		}
		
		private function createControls():void {
			_input = new TextInput();
			_input.verticalAlignment = VerticalAlignment.TOP;
			_input.target = spas_internal::uioSprite;
			_input.display();
		}
		
		private function createEvents():void {
			$evtColl.addEvent(_input, TextEvent.VALIDATED, validateHandler);
			$evtColl.addEvent($stage, MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function validateHandler(e:TextEvent):void {
			this.dispatchEvent(new ItemEditorEvent(ItemEditorEvent.VALIDATED));
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			if(!spas_internal::uioSprite.hitTestPoint(e.stageX, e.stageY, true))
				this.dispatchEvent(new ItemEditorEvent(ItemEditorEvent.CANCELED));
		}
	}
}