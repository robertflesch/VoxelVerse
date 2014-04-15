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

package org.flashapi.swing.list {
	
	// -----------------------------------------------------------
	// DropListBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.1.1, 10/04/2010 14:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.flashapi.swing.button.SelectableItem;
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.DataBindingMode;
	import org.flashapi.swing.constants.Direction;
	import org.flashapi.swing.constants.DropButtonPosition;
	import org.flashapi.swing.constants.DropListPosition;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.effect.Effect;
	import org.flashapi.swing.effect.SlideIn;
	import org.flashapi.swing.effect.SlideOut;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.icons.core.StateIcon;
	import org.flashapi.swing.layout.AbsoluteLayout;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.util.Iterator;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the drop list object has finished using the data provided by the DataProvider object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.DATA_PROVIDER_FINISHED
	 */
	[Event(name = "dataProviderFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when the drop list object has finished using the data provided by the XMLQuery object.
	 *
	 *  @eventType org.flashapi.swing.event.DataBindingEvent.XML_QUERY_FINISHED
	 */
	[Event(name = "xmlQueryFinished", type = "org.flashapi.swing.event.DataBindingEvent")]
	
	/**
	 *  Dispatched when an item is clicked into the drop list object.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.ITEM_CLICKED
	 */
	[Event(name="itemClicked", type="org.flashapi.swing.event.ListEvent")]
	
	/**
	 *  Dispatched when the drop list object changes value due to mouse or keyboard interaction.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.LIST_CHANGED
	 */
	[Event(name = "listChanged", type = "org.flashapi.swing.event.ListEvent")]
	
	/**
	 * 	The <code>DropListBase</code> class is the base class for all SPAS 3.0 "drop-down"
	 * 	list objects. <code>DropListBase</code> instances contains an arrow button that
	 * 	lets user activate or deactivate the "drop-down" list.
	 * 
	 * 	<p>When a <code>DropListBase</code> object is inactive, it only displays 
	 * 	the arrow button and all controls associated with this <code>DropListBase</code> object.
	 * 	When activated, it displays (drops down) a list of values, from which the user may
	 * 	select one. When the user selects a new value, the <code>DropButtonListBase</code>
	 * 	object reverts to its inactive state.</p>
	 * 
	 * <p><strong><code>DropListBase</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">icon-color</code></td>
	 * 			<td>Sets the color of the icon displayed within this object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>iconColor</code></td>
	 * 			<td><code>Properties.ICON_COLOR</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DropListBase extends ALM implements Listable {
		
		//TODO : data and index properties are defined by the UIObject and Listable interface
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DropListBase</code> instance with the 
		 * 	specified parameters.
		 * 
		 * 	@param	label	The text displayed on the <code>DropListBase</code>
		 * 					instance.
		 * 	@param	width	The width of the <code>DropListBase</code> instance, in
		 * 					pixels.
		 * 	@param	size	The number of items displayed within the drop-down list
		 * 					object.
		 * 	@param	checkModeRef	A string that represents the reference passed as
		 * 	the <code>caller</code> parameter to the <code>checkStrictMode()</code>
		 * 	method of the associated <code>XMLQuery</code> object.
		 */
		public function DropListBase(label:String = "", width:Number = 150, size:uint = 5, checkModeRef:String = "") {
			super();
			initObj(label, width, size, checkModeRef);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Defines the height for each item in the within drop-down.
		 * 
		 * 	@default 20
		 */
		public var lineHeight:Number = 20;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>defaultLabel</code> property.
		 * 
		 * 	@see #defaultLabel
		 */
		protected var $defaultLabel:String = null;
		/**
		 * 	Sets or gets the default text label displayed on the face of this
		 * 	<code>DropListBase</code> object. If not <code>null</code> the text displayed 
		 * 	on the face of the <code>DropListBase</code> remains  <code>defaultLabel</code>.
		 * 
		 * 	@default null
		 */
		public function get defaultLabel():String {
			return $defaultLabel;
		}
		public function set defaultLabel(value:String):void {
			$defaultLabel = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>buttonPosition</code> property.
		 * 
		 * 	@see #buttonPosition
		 */
		protected var $buttonPosition:String = DropButtonPosition.RIGHT;
		/**
		 * 	Sets or gets the horizontal position of the arrow button. Valid values are:
		 * 	<ul>
		 * 		<li>DropButtonPosition.RIGHT,</li>
		 * 		<li>DropButtonPosition.LEFT.</li>
		 * 	</ul>
		 * 
		 * 	@default DropButtonPosition.RIGHT
		 */
		public function get buttonPosition():String {
			return $buttonPosition;
		}
		public function set buttonPosition(value:String):void {
			spas_internal::lafDTO.buttonPosition = $buttonPosition = value;
			setRefresh();
		}
		
		private var _defaultListPosition:String = DropListPosition.BOTTOM;
		/**
		 * 	Indicates whether the drop-down list will be displayed below the
		 * 	<code>DropListBase</code> object (<code>DropListPosition.BOTTOM</code>),
		 * 	or above it (<code>DropListPosition.TOP</code>).
		 * 
		 * 	@default DropListPosition.BOTTOM
		 */
		public function get defaultListPosition():String {
			return _defaultListPosition;
		}
		public function set defaultListPosition(value:String):void {
			_defaultListPosition = value;
			getPosition();
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the drop-down list
		 * 	will implement a SPAS 3.0 integrated effect when it is closed
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #hasListDisplayEffect
		 * 	@see #listEndEffect
		 * 	@see #listStartEffect
		 * 	@see org.flashapi.swing.effect.Effect
		 */
		public function get hasListRemoveEffect():Boolean {
			return IUIObject($itemsList).hasRemoveEffect;
		}
		public function set hasListRemoveEffect(value:Boolean):void {
			IUIObject($itemsList).hasRemoveEffect = value;
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the drop-down list
		 * 	will implement a SPAS 3.0 integrated effect when it is displayed
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #hasListRemoveEffect
		 * 	@see #listEndEffect
		 * 	@see #listStartEffect
		 * 	@see org.flashapi.swing.effect.Effect
		 */
		public function get hasListDisplayEffect():Boolean {
			return IUIObject($itemsList).hasDisplayEffect;
		}
		public function set hasListDisplayEffect(value:Boolean):void {
			IUIObject($itemsList).hasDisplayEffect = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>iconColor</code> property.
		 * 
		 * 	@see #iconColor
		 */
		protected var $iconColor:Object;
		/**
		 *  Sets or gets the color of the icon displayed by this drop button control
		 * 	instance. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 *  
		 *  @see org.flashapi.swing.color.SVGCK
		 *  @see org.flashapi.swing.Icon
		 *  @see org.flashapi.swing.brushes.Brush
		 *  @see #iconColors
		 */
		public function get iconColor():* {
			return $iconColor;
		}
		public function set iconColor(value:*):void {
			var val:* = value == "none" ? "none" : getColor(value);
			$iconColor = $iconColors.up = $iconColors.down =
			$iconColors.over = $iconColors.disabled = val;
			setIconColors(false);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>iconColors</code> property.
		 * 
		 * 	@see #iconColors
		 */
		protected var $iconColors:ColorState;
		/**
		 * 	A <code>ColorState</code> object that sets and gets the color of the icon
		 * 	for each state of the drop button. <code>ColorState</code> instances define
		 * 	five different states:
		 * <ul>
		 * 		<li><code>ColorState.disabled</code>,</li>
		 * 		<li><code>ColorState.down</code>,</li>
		 * 		<li><code>ColorState.over</code>,</li>
		 *  	<li><code>ColorState.up</code>.</li>
		 * 	</ul>
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are
		 * 	the same as the values used for for the <code>color</code> property.
		 * 	The default value for each state is <code>StateObjectValue.NONE</code>.
		 * 	To unset a color state value, use the <code>StateObjectValue.NONE</code>
		 * 	constant.</p>
		 *  
		 *  @see org.flashapi.swing.core.UIObject#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #iconColor
		 */
		public function get iconColors():ColorState {
			return $iconColors;
		}
		public function set iconColors(value:ColorState):void {
			$iconColors = value;
			setRefresh();
		}
		
		/*
		protected var _labelPlacement:String;
		public function set labelPlacement(value:String):void { _labelPlacement = value; setRefresh(); }
		public function get labelPlacement():String { return _labelPlacement; }*/
		
		/**
		 * 	@private
		 */
		override public function get length():int {
			return $itemsList.length;
		}
		
		/**
		 * 	Sets or gets the <code>Effect</code> class used as "remove effect" 
		 * 	for the drop-down list.
		 * 
		 *  @default FadeOut
		 * 
		 * 	@see #listStartEffect
		 * 	@see #hasListRemoveEffect
		 * 	@see #hasListDisplayEffect
		 * 	@see org.flashapi.swing.effect.Effect
		 * 	@see org.flashapi.swing.effect.FadeOut
		 * 	@see org.flashapi.swing.UIObject.removeEffectRef
		 */
		public function get listEndEffect():Class {
			return IUIObject($itemsList).removeEffectRef;
		}
		public function set listEndEffect(value:Class):void {
			IUIObject($itemsList).removeEffectRef = value;
		}
		
		/**
		 * 	Sets or gets the <code>Effect</code> class used as "display effect" 
		 * 	for the drop-down list.
		 * 
		 *  @default FadeIn
		 * 
		 * 	@see #hasListRemoveEffect
		 * 	@see #hasListDisplayEffect
		 * 	@see #listStartEffect
		 * 	@see org.flashapi.swing.effect.Effect
		 * 	@see org.flashapi.swing.effect.FadeIn
		 * 	@see org.flashapi.swing.UIObject.removeEffectRef
		 */
		public function get listStartEffect():Class {
			return IUIObject($itemsList).displayEffectRef;
		}
		public function set listStartEffect(value:Class):void {
			IUIObject($itemsList).displayEffectRef = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set quality(value:String):void {
			$quality = IUIObject($itemsList).quality = value;
		}
		
		/**
		 * 	@private
		 */
		override public function get selectedIndex():int {
			return $itemsList.selectedIndex;
		}
		
		/**
		 * 	@private
		 */
		override protected function changeCurrentIndex():void {
			$itemsList.selectedIndex = $selectedIndex;
			$listItem = $itemsList.listItem;
			$label = $value = $itemsList.value;
			$data = $itemsList["data"];
			setRefresh(); //setLabel();
		}
		
		/*
		Sets or gets the selected item of the drop list from a value.
		<strong>Valid values are <code>value</code> parameter of each item or data provider object</strong>
		
		public function get setSelected():String { return _value; }
		public function set setSelected(value:String):void {
			itemsList.setSelected = value;
			_listItem = itemsList.listItem;
			this.label = _value = itemsList.value;
			_data = itemsList.data;
		}
		*/
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>size</code> property.
		 * 
		 * 	@see #size
		 */
		protected var $size:uint;
		/**
		 * 	Sets of gets the number of items displayed within drop-down list object.
		 * 
		 * 	@default 5
		 */
		public function get size():uint {
			return $size;
		}
		public function set size(value:uint):void {
			$size = $itemsList.size = value;
		}
		
		/*override public function set target(value:*):void {
			super.target = value;
			$stage.addChild(listContainer);
		}*/
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value that indicates whether the drop-down
		 * 	list is hidden (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@see #isListDisplayed
		 */
		protected var $isListHidden:Boolean = true;
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the drop-down 
		 * 	list object is currently visible (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get isListDisplayed():Boolean {
			return ($isListHidden == false);
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
			var l:ListItem = $itemsList.addItem(value, data);
			return l;
		}
		
		/**
		 * 	@private
		 */
		override public function addItemAt(index:int, value:*, data:* = null):ListItem {
			var l:ListItem = $itemsList.addItemAt(index, value, data);
			return l;
		}
		
		/**
		 * 	@private
		 */
		override public function removeItem(item:ListItem):void {
			$itemsList.removeItem(item);
			//removeListItemEvent(item);
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function removeItemAt(index:int):void {
			//var li:ListItem = $itemsList.getItemAt(index);
			$itemsList.removeItemAt(index);
			//removeListItemEvent(li);
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function getItemAt(index:int):ListItem {
			return $itemsList.getItemAt(index);
		}
		
		/**
		 * 	@private
		 */
		override public function removeAll():void {
			// ! ! ! Not yet tested.
			$itemsList.removeAll();
			$evtColl.removeEventByClassDefinition(SelectableItem);
			setRefresh();
		}
		
		/**
		 * 	Resets the <code>DropListBase</code> object. Sets <code>item</code>
		 * 	and <code>data</code> properties to <code>null</code> and the <code>value</code>
		 * 	property to <code>""</code> (empty string).
		 * 
		 * 	@param	label The text to display on the face of the <code>DropListBase</code>
		 * 			when reseted. If <code>null</code>, uses the text specified by the
		 * 			<code>label</code> property. Default value is <code>null</code>.
		 */
		public function reset(label:String = null):void {
			$itemsList.reset();
			this.label = label == null ? $label : label;
			$listItem = null;
			$value = "";
			$data = null;
		}
		
		/**
		 * 	@private
		 */
		override public function updateItemAt(index:int, value:*, data:* = null):ListItem {
			var li:ListItem = $itemsList.updateItemAt(index, value, data);
			return li;
		}
		
		/**
		 * 	Returns a reference to the <code>ItemsList</code> instance that is used
		 * 	as drop-down list object for this <code>DropListBase</code> instance.
		 * 
		 * 	@return The drop-down list object for this <code>DropListBase</code>
		 * 			instance.
		 */
		public function getItemsList():ItemsList {
			return $itemsList;
		}
		
		//--------------------------------------------------------------------------
		//
		//  protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the <code>ItemsList</code> instance that
		 * 	is used as drop-down list object for this <code>DropListBase</code>
		 * 	instance.
		 * 
		 * 	@see #getItemsList()
		 */
		protected var $itemsList:ItemsList;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the <code>Canvas</code> container that is 
		 * 	used to hold and display the drop-down list object whithin this 
		 * 	<code>DropListBase</code> instance.
		 * 
		 * 	@see #$itemsList
		 */
		protected var $listContainer:Canvas;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the <code>StateIcon</code> instance that
		 * 	is used as arrow icon for the drop button control within this <code>DropListBase</code>
		 * 	instance.
		 * 
		 * 	@see #getItemsList()
		 */
		protected var $stateIcon:StateIcon = null;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the
		 * 	<code>DropListBase</code> is allowed to dispatch a <code>ListEvent.LIST_CHANGED</code>
		 * 	(<code>true</code>), or not (<code>false</code>).
		 */
		protected var $validateChangedHandler:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function initIconColors():void {
			$iconColors.up = lookAndFeel.getOutIconColor();
			$iconColors.down = lookAndFeel.getPressedIconColor();
			$iconColors.over = lookAndFeel.getOverIconColor();
			$iconColors.disabled = lookAndFeel.getInactiveIconColor();
		}
		
		/**
		 * @private
		 */
		protected function setIconColors(defineStateIcon:Boolean):void { }
		
		/*
		protected function addListItemEvent(listItem:ListItem):ListItem {
			//$evtColl.addEvent(listItem.item, UIMouseEvent.PRESS, stopStageEventPropagation);
			return listItem;
		}
		
		protected function removeListItemEvent(listItem:ListItem):void {
			//$evtColl.removeEvent(listItem.item, UIMouseEvent.PRESS, stopStageEventPropagation);
		}*/
		
		/**
		 * @private
		 */
		protected function stopStageEventPropagation(e:ListEvent):void {
			//hideList();
			$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, getListValues);
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_DOWN, dropListMouseOutsideHandler);
		}
		
		/**
		 * @private
		 */
		protected function getListValues(e:ListEvent):void {
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, getListValues);
			$label = $itemsList.value;
			$value = $itemsList.value;
			$data = $itemsList["data"];
			$listItem = $itemsList.listItem;
			var ind:int = $itemsList["index"];
			spas_internal::setIndex(ind);
			$selectedIndex = ind;
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICKED));
			$validateChangedHandler = true;
			hideList();
			resetAppearence();
		}
		
		/**
		 * @private
		 */
		protected function resetAppearence():void { }
		
		/**
		 * @private
		 */
		protected function setLabel():void { }
		
		/**
		 * @private
		 */
		protected function dropListMouseOutsideHandler(e:MouseEvent):void {
			if(!$listContainer.container.hitTestPoint($stage.mouseX, $stage.mouseY)) hideList();
		}
		
		/**
		 * @private
		 */
		protected function hideList():void {
			if ($isListHidden) return;
			$isListHidden = true;
			initListForDisplay();
			$evtColl.removeEvent($itemsList, ListEvent.ITEM_CLICKED, getListValues);
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_DOWN, dropListMouseOutsideHandler);
			if (IUIObject($itemsList).hasRemoveEffect)
				$evtColl.addEvent($itemsList, UIOEvent.REMOVED, removeMoveDetectionEvent);
			else {
				$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, detectDropListMove);
				changeHandler();
			}
			var fx:Effect = IUIObject($itemsList).removeEffect;
			if (fx is SlideOut) {
				var dir:String;
				switch(_defaultListPosition) {
					case DropListPosition.BOTTOM :
						dir = Direction.UP;
						break;
					case DropListPosition.TOP :
						dir = Direction.DOWN;
						break;
				}
				(fx as SlideOut).direction = dir;
			}
			$itemsList.remove();
		}
		
		/**
		 * @private
		 */
		protected function initListForDisplay():void {}
		
		/**
		 * @private
		 */
		protected function showList():void {
			$isListHidden = false;
			$itemsList.display();
			//_dropListPosition = getPosition();
			setListPosition();
			$listContainer.display();
			UIDescriptor.getUIManager().topLevelManager.spas_internal::addObject($listContainer);
			initListForDisplay();
			$evtColl.addEvent($itemsList, ListEvent.ITEM_CLICKED, getListValues);
			$evtColl.addEvent($stage, MouseEvent.MOUSE_MOVE, detectDropListMove);
			$evtColl.addEvent($itemsList, UIOEvent.REMOVED, removeItemContainer);
		}
		
		/**
		 * @private
		 */
		private function removeItemContainer(e:UIOEvent):void {
			$listContainer.remove();
		}
		
		/**
		 * @private
		 */
		protected function dataProviderChangedHandler(e:ListEvent):void {
			/*var it:Iterator = $dataProvider.iterator;
			it.reset();
			var i:int = 0;
			var obj:Object;
			var li:ListItem;
			while(it.hasNext()) {
				obj = it.next();
				li = $dataBindingMode == DataBindingMode.INCREMENT ?
					addItem(obj.label, obj.data) : updateItemAt(i, obj.label, obj.data);
				if(obj.icon) li.item.setIcon(obj.icon);
				if (obj.className) li.item.className = className;
				i++;
			}*/
			$itemsList.dataProvider = $dataProvider;
			dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
			updateItemList();
		}
		
		/**
		 * @private
		 */
		protected function xmlQueryChangedHandler(e:ListEvent):void {
			var data:XML = $xmlQuery.xml;
			checkStrictMode(_checkModeRef);
			if (data.@urlPath) $urlPath = data.@urlPath.toString();
			/*var i:int = 0;
			var l:String;
			var d:String;
			var li:ListItem;
			for each(var prop:XML in data.item) {
				l = prop.@label.toString();
				d = prop.@data.toString();
				li = $dataBindingMode == DataBindingMode.INCREMENT ?
					addItem(l, d) : updateItemAt(i, l, d);
				if(prop.@icon) li.item.setIcon(prop.@icon.toString());
				if (prop.@className) li.item.className = prop.@className.toString();
				++i;
			}*/
			$itemsList.xmlQuery = $xmlQuery;
			dispatchEvent(new DataBindingEvent(DataBindingEvent.XML_QUERY_FINISHED));
			updateItemList();
		}
		
		/**
		 * @private
		 */
		protected function listRemovedHandler(e:UIOEvent):void {
			setIconState();
		}
		
		/**
		 * @private
		 */
		protected function setIconState():void {
			if ($stateIcon == null) return;
			$stateIcon.nextState = $isListHidden ? 1 : 0;
			$stateIcon.paint();
		}
		
		/**
		 * @private
		 */
		protected function createItemsList():void { }
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _listPosition:Point;
		//private var _dropListPosition:Point;
		private var _checkModeRef:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number, size:uint, checkModeRef:String):void {
			$label = $value = label;
			$width = width;
			$height = 24;
			$size = size;
			_checkModeRef = checkModeRef;
			createColorsObj();
			spas_internal::lafDTO.buttonPosition = $buttonPosition;
			$iconColors = new ColorState(this);
			createList();
			createEvents();
			spas_internal::lafDTO.spas_internal::setSize($width, $height);
			spas_internal::isInitialized(1);
		}
		
		private function setListPosition(e:Event = null):void {
			if(spas_internal::uioSprite.parent == null) return;
			//if(_dropListPosition == null) _dropListPosition = getPosition();
			//_listPosition = spas_internal::CONTAINER.parent.localToGlobal(_dropListPosition);
			_listPosition = spas_internal::uioSprite.parent.localToGlobal(getPosition());
			$listContainer.move(_listPosition.x, _listPosition.y);
		}
		
		private function detectDropListMove(e:MouseEvent):void {
			//var newPosition:Point = spas_internal::CONTAINER.parent.localToGlobal(_dropListPosition);
			var newPosition:Point = spas_internal::uioSprite.parent.localToGlobal(getPosition());
			if(!newPosition.equals(_listPosition)) {
				$listContainer.move(newPosition.x, newPosition.y);
				$listContainer.setToTopLevel();
				_listPosition = newPosition;
			}
		}
		
		private function getPosition():Point {
			/*var pos:Point = new Point(spas_internal::CONTAINER.x);
			pos.y = _defaultListPosition == DropListPosition.BOTTOM ?
				spas_internal::CONTAINER.y + spas_internal::CONTAINER.getBounds(null).height : spas_internal::CONTAINER.y - IUIObject(itemsList).getBounds(null).height;
			return pos;*/
			var pos:Point = new Point(spas_internal::uioSprite.x);
			//var sHeight:Number = $stage.stageHeight;
			var yPos:Number = spas_internal::uioSprite.y;
			var dir:String;
			switch(_defaultListPosition) {
				case DropListPosition.BOTTOM :
					pos.y = yPos + spas_internal::uioSprite.getBounds(null).height;
					dir = Direction.DOWN;
					break;
				case DropListPosition.TOP :
					pos.y = yPos - IUIObject($itemsList).getBounds(null).height;
					dir = Direction.UP;
					break;
			}
			var fx:Effect = IUIObject($itemsList).displayEffect;
			if (fx is SlideIn) (fx as SlideIn).direction = dir;
			return pos;
		}
		
		private function changeHandler():void {
			if ($validateChangedHandler) dispatchEvent(new ListEvent(ListEvent.LIST_CHANGED));
			setLabel();
			$validateChangedHandler = false;
		}
		
		private function removeMoveDetectionEvent(e:UIOEvent):void {
			$evtColl.removeEvent($itemsList, UIOEvent.REMOVED, removeMoveDetectionEvent);
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_MOVE, detectDropListMove);
			changeHandler();
		}
		
		private function createList():void {
			$listContainer = new Canvas();
			$listContainer.layout = new AbsoluteLayout();
			$listContainer.target = $stage;
			createItemsList();
			ALM($itemsList).invalidateStrictMode = true;
			IUIObject($itemsList).target = $listContainer;
			IUIObject($itemsList).hasDisplayEffect = IUIObject($itemsList).hasRemoveEffect =
				IUIObject($itemsList).shadow = $isListHidden = true;
			IUIObject($itemsList).displayEffectRef = SlideIn;
			IUIObject($itemsList).removeEffectRef = SlideOut;
			$evtColl.addEvent($stage, Event.RESIZE, setListPosition);
		}
		
		private function createEvents():void {
			$evtColl.addEvent(this, ListEvent.DATA_PROVIDER_CHANGED, dataProviderChangedHandler);
			$evtColl.addEvent(this, ListEvent.XML_QUERY_CHANGED, xmlQueryChangedHandler);
			$evtColl.addEvent($itemsList, UIOEvent.REMOVED, listRemovedHandler);
			$evtColl.addEvent($itemsList, ListEvent.ITEM_PRESSED, stopStageEventPropagation);
		}
	}
}