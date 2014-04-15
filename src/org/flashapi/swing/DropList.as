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
	// DropList.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 15/03/2010 22:29
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.MouseEvent;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.constants.DropButtonPosition;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.TextEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.icons.core.StateIcon;
	import org.flashapi.swing.list.DropListBase;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.plaf.libs.DropListUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DropList.png")]
	
	/**
	 * 	<img src="DropList.png" alt="DropList" width="18" height="18"/>
	 * 
	 * 	The <code>DropList</code> class contains a drop-down list from which the
	 * 	user can select a single value. Its functionality is similar to that of
	 * 	the <code>SELECT</code> form element in HTML.
	 * 	The <code>DropList</code> can be editable, in which case the user can
	 * 	type entries into the <code>TextInput</code> portion of the <code>DropList</code>
	 * 	that are not in the list.
	 * 	
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>DropList</code> instance.
	 * 	Each item for <code>DataProvider</code> objects have to contain the
	 * 	following properties:
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>value</code> parameter for the
	 * 			<code>DropList.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code>
	 * 			parameter for the <code>DropList.addItem()</code> method,</li>
	 * 		<li><code>className:String</code>; the <code>className</code>
	 * 			parameter for <code>DropList</code> items,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the icon rendered by
	 * 			<code>DropList</code> items.</li>
	 * 	</ul>
	 * 	</p>
	 * 	
	 * 	<p>The following codes illustrate three different ways of adding items
	 * 	to a <code>DropList</code>:</p>
	 * 	<p>
	 * 		- using the <code>DropList.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var dl:DropList = new DropList();
	 * 
	 * 			dl.addItem("Label 1", myData1);
	 * 			dl.addItem("Label 2", myData2);
	 * 			var li3:ListItem = dl.addItem("Label 3", myData3);
	 * 			li3.item.setIcon("myIcon.jpg");
	 * 			var li4:ListItem = dl.addItem("Label 4", myData4);
	 * 			li4.item.setIcon("myIcon.jpg");
	 * 
	 * 			dl.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>DropList.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var dl:DropList = new DropList();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 			dp.addAll(  { label:"Label 1", data:myData1 },
	 * 						{ label:"Label 2", data:myData2 },
	 * 						{ label:"Label 3", data:myData3, icon:"myIcon.jpg" },
	 * 						{ label:"Label 4", data:myData4, icon:"myIcon.jpg" });
	 * 			dl.dataProvider = dp;
	 * 
	 * 			dl.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>DropList.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item label="Label 1" data="myData1" /&gt;
	 *								&lt;item label="Label 2" data="myData2" /&gt;
	 *								&lt;item label="Label 3" data="myData3" icon="myIcon.jpg" /&gt;
	 * 								&lt;item label="Label 4" data="myData4" icon="myIcon.jpg" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var dl:DropList = new DropList();
	 * 			dl.xmlQuery = request;
	 * 
	 * 			dl.display();
	 * 		</listing>
	 * 	</p>
	 *
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.list.ALM#xmlQuery
	 * 	@see org.flashapi.swing.databinding.XMLQuery
	 * 	@see org.flashapi.swing.plaf.DropListUI
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@includeExample DropListExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DropList extends DropListBase implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DropList</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	label	The text displayed on the <code>DropList</code>
		 * 					instance.
		 * 	@param	width	The width of the <code>DropList</code> instance, in pixels.
		 * 	@param	size	The number of items displayed within the drop-down list
		 * 					object.
		 */
		public function DropList(label:String = "", width:Number = 150, size:uint = 5) {
			super(label, width, size, "DropList");
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _buttonTopRadius:Number = NaN;
		/**
		 * 	Sets or gets the top corner radius, in pixels, for this <code>DropList</code>
		 * 	instance. If <code>NaN</code>, the top corner radius is the value
		 * 	defined by the current Look and Feel of the button.
		 * 
		 *  @default NaN
		 * 
		 * 	@see #buttonBottomRadius
		 */
		public function get buttonTopRadius():Number {
			return _buttonTopRadius;
		}
		public function set buttonTopRadius(value:Number):void {
			_buttonTopRadius = value;
			fixButtonRadius();
		}
		
		private var _buttonBottomRadius:Number = NaN;
		/**
		 * 	Sets or gets the bottom corner radius, in pixels, for this <code>DropList</code>
		 * 	instance. If <code>NaN</code>, the bottom corner radius is the value
		 * 	defined by the current Look and Feel of the button.
		 * 
		 *  @default NaN
		 * 
		 * 	@see #buttonTopRadius
		 */
		public function get buttonBottomRadius():Number {
			return _buttonBottomRadius;
		}
		public function set buttonBottomRadius(value:Number):void {
			_buttonBottomRadius = value;
			fixButtonRadius();
		}
		
		private var _editable:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the drop list can
		 * 	be edited (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get editable():Boolean {
			return _editable;
		}
		public function set editable(value:Boolean):void {
			_editable = _textInput.editable = value;
		}
		
		/**
		 * 	Returns the value of the <code>TextInput</code> label when the 
		 * 	<code>editable</code> property is <code>true</code>.
		 * 
		 * 	@default ""
		 */
		public function get editedLabel():String {
			return _textInput.text;
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			IUIObject($itemsList).width = super.width = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set label(value:String):void {
			$label = value;
			setLabel();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if(!$displayed) {
				move(x, y);
				createUIObject();
				doStartEffect();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			$itemsList.remove();
			$listContainer.remove();//$stage.removeChild(listContainer);
			UIDescriptor.getUIManager().topLevelManager.spas_internal::removeObject($listContainer);
			if($displayed) unload();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			$listContainer.removeElements();
			$itemsList.finalize();
			$listContainer.finalize();
			_textInput.finalize();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function createItemsList():void {
			$itemsList = new ListBox($width, $size);
		}
		
		/**
		 * 	@private
		 */
		override protected function refresh():void {
			fixButtonPosition();
			setLabel();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			IUIObject($itemsList).lockLaf(lookAndFeel.getListLaf(), true);
			_textInput.lockLaf(lookAndFeel.getTextInputLaf(), true);
			_button.lockLaf(lookAndFeel.getButtonLaf(), true);
			fixButtonRadius();
			initIconColors();
			_button.drawIcon(lookAndFeel.getIcon(), _button.getRect(null));
			setIconColors(true);
		}
		
		/**
		 * @private
		 */
		override protected function setIconColors(defineStateIcon:Boolean):void {
			var icon:Icon = _button.icon;
			if (icon.brush is StateIcon) {
				if(defineStateIcon) $stateIcon = icon.brush as StateIcon;
				(icon.brush as StateBrush).colors = $iconColors;
			} else {
				if(defineStateIcon) $stateIcon = null;
				icon.brush.color = $iconColors.up;
			}
			setIconState();
		}
		
		/**
		 * @private
		 */
		override protected function setLabel():void {
			_textInput.text = $defaultLabel == null ? $label : $defaultLabel;
			var W:Number = _button.x + _button.width;
			_textInput.x = $buttonPosition == DropButtonPosition.RIGHT ? 0 : W;
			_textInput.width = $buttonPosition == DropButtonPosition.RIGHT ? _button.x : $width-W;
		}
		
		/**
		 * @private
		 */
		override protected function initListForDisplay():void {
			ListBox($itemsList).vscrollValue = 0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _textInput:TextInput;
		private var _button:IconizedButton;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createObjs();
			initLaf(DropListUIRef);
			createEvents();
			spas_internal::setSelector(Selectors.DROP_LIST);
			spas_internal::isInitialized(1);
		}
		
		private function fixButtonPosition():void {
			_button.x = $buttonPosition == DropButtonPosition.RIGHT ?
				$width - $height : 0;
		}
		
		private function fixButtonRadius():void {
			if ($buttonPosition == DropButtonPosition.RIGHT) {
				_button.topRightCorner = isNaN(_buttonTopRadius) ?
					lookAndFeel.getButtonTopRadius() : _buttonBottomRadius;
				_button.bottomRightCorner = isNaN(_buttonBottomRadius) ?
					lookAndFeel.getButtonBottomRadius() : _buttonBottomRadius;
				_button.topLeftCorner = _button.bottomLeftCorner = 0;
			} else {
				_button.topLeftCorner = isNaN(_buttonTopRadius) ?
					lookAndFeel.getButtonTopRadius() : _buttonBottomRadius;
				_button.bottomLeftCorner = isNaN(_buttonBottomRadius) ?
					lookAndFeel.getButtonBottomRadius() : _buttonBottomRadius;
				_button.topRightCorner = _button.bottomRightCorner = 0;
			}
		}
		
		private function createEvents():void {
			$evtColl.addEvent(_button, UIMouseEvent.PRESS, dropListMouseDownHandler);
			$evtColl.addEvent(_button, UIMouseEvent.RELEASE, mouseUpHandler);
			
			$evtColl.addEvent(_textInput, TextEvent.TEXT_FOCUS_IN, editHandler);
			$evtColl.addEvent(_textInput, UIMouseEvent.PRESS_OUTSIDE, pressOutsideHandler);
			$evtColl.addEvent(_textInput, TextEvent.EDITED, editedTextChangedHandler);
			$evtColl.addEvent(_textInput, TextEvent.VALIDATED, validateHandler);
		}
		
		private function editHandler(e:TextEvent):void {
			if (!_editable) return;
			if($active && $enabled) {
				_textInput.text = $label;
				if($autoFocus) _textInput.focus = true;
				if($itemsList.displayed) hideList();
			}
		}
		
		private function pressOutsideHandler(e:UIMouseEvent):void {
			editionIsFinished();
		}
		
		private function validateHandler(e:TextEvent):void {
			editionIsFinished();
		}
		
		private function editedTextChangedHandler(e:TextEvent):void {
			$label = _textInput.text;
		}
		
		private function editionIsFinished():void {
			$label = _textInput.text;
			setLabel();
			this.dispatchEvent(new ListEvent(ListEvent.EDITED));
		}
		
		private function mouseUpHandler(e:UIMouseEvent):void {
			if ($active && $enabled) {
				if (!$isListHidden)
					$evtColl.addEvent($stage, MouseEvent.MOUSE_DOWN, dropListMouseOutsideHandler);
				$stateIcon = _button.icon.brush is StateIcon ?
					(_button.icon.brush as StateIcon) : null;
				setIconState();
			}
		}
		
		private function dropListMouseDownHandler(e:MouseEvent):void { 
			if ($active && $enabled) $itemsList.displayed ? hideList() : showList();
		}
		
		private function createObjs():void {
			_button = new IconizedButton();
			_textInput = new TextInput();
			_button.height = _button.width = _textInput.height = $height;
			_textInput.target = _button.target = spas_internal::uioSprite;
			_button.display();
			_textInput.display();
		}
	}
}