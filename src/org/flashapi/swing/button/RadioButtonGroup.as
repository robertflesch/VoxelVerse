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

package org.flashapi.swing.button {
	
	// -----------------------------------------------------------
	// RadioButtonGroup.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 22/02/2010 22:38
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.ButtonsGroup;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.ButtonsGroupEvent;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.exceptions.IndexOutOfBoundsException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.RadioButton;
	import org.flashapi.swing.util.Iterator;
	
	use namespace spas_internal;
	
	/**
	 *  Dispatched each time this <code>ButtonsGroup</code> changes, due to a user
	 * 	action.
	 *
	 *  @eventType org.flashapi.swing.event.ButtonsGroupEvent.GROUP_CHANGED
	 */
	[Event(name = "groupChanged", type = "org.flashapi.swing.event.ButtonsGroupEvent")]
	
	/**
	 * 	The <code>RadioButtonGroup</code> class is used to group together a set of
	 * 	<code>RadioButton</code> buttons.
	 * 
	 * 	<p>Exactly one radio button in a <code>RadioButtonGroup</code> can be in
	 * 	the "on" state at any given time.</p>
	 * 
	 * 	@see org.flashapi.swing.RadioButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RadioButtonGroup extends ButtonsGroup {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>RadioButtonGroup</code> instance.
		 * 
		 * 	@param	target 	The <code>UIContainer</code> where to display the buttons
		 * 					of the group.
		 */
		public function RadioButtonGroup(target:UIContainer = null) {
			super(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Sets the index of the radio button group.
		 */
		public function set index(value:int):void {
			var l:int = $stack.length;
			if (index > l)
				throw new IndexOutOfBoundsException(Locale.spas_internal::ERRORS.GROUP_INDEX_ERROR);
			$index = value;
			var rb:RadioButton;
			var i:int = l - 1;
			for (; i >= 0; i--) {
				rb = $stack[i];
				if (rb.selected && i != value) {
					rb.selected = false;
					if (value == -1) {
						$value = null;
						$data = null;
						$selectedItem = null;
						return;
					}
				}
				else if (i == value && !rb.selected) {
					rb.selected = true;
					$value = rb.label;
					$data = rb.data;
					$selectedItem = rb;
				}
				else if (rb.selected && i == value) return;
			}
			this.dispatchEvent(new ButtonsGroupEvent(ButtonsGroupEvent.GROUP_CHANGED));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function dataProviderChangedHandler(e:ListEvent):void {
			var it:Iterator = $dataProvider.iterator;
			//if(_target == null) throw new
			while(it.hasNext()) {
				var obj:Object = it.next();
				var l:String = obj.label != null ? obj.label : "";
				var w:Number = obj.width != null ? obj.width : NaN;
				var h:Number = obj.height != null ? obj.height : NaN;
				var s:Boolean = obj.selected != null ? obj.selected : false;
				var rb:RadioButton = new RadioButton(obj.label, w, h);
				if (s) {
					rb.selected = true;
					$value = l, data = obj.data;
				}
				setDataProviderCommonProperties(rb, obj);
			}
			it.reset();
			this.dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
	}
}