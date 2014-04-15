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
	// SimpleCheckBox.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 20:59
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.ButtonsGroup;
	import org.flashapi.swing.button.SimpleCheckBoxGroup;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("CheckBox.png")]
	
	/**
	 * 	<img src="CheckBox.png" alt="CheckBox" width="18" height="18"/>
	 * 
	 *  A <code>SimpleCheckBox</code> object has the same properties as a
	 * 	<code>CheckBox</code> object except that you can not specifie its
	 * 	<code>label</code> property.
	 * 	When a user clicks a <code>SimpleCheckBox</code> control, the
	 * 	<code>SimpleCheckBox</code> control changes its state from checked
	 * 	to unchecked or from unchecked to checked.
	 * 
	 *  @includeExample SimpleCheckBoxExample.as
	 * 
	 * 	@see org.flashapi.swing.CheckBox
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SimpleCheckBox extends CheckBox implements Observer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>SimpleCheckBox</code> instance.
		 */
		public function SimpleCheckBox() {
			super("", 22, 22, false);
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
		spas_internal static const INIT_ID:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void { }
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void { }
		
		/**
		 *  @private
		 */
		override public function set label(value:String):void { }
		
		/**
		 *  @private
		 */
		override public function set group(value:ButtonsGroup):void {
			setButtonGroup(value);
			var grp:SimpleCheckBoxGroup = value as SimpleCheckBoxGroup;
			$toggle = grp.enableMultipleSelections;
			$evtColl.addEvent(this, UIMouseEvent.CLICK, clickHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function clickHandler(e:UIMouseEvent):void {
			/*
			 * TODO: la documentation doit indiquer que la propriétés
			 * value, data et selectedItem sont définies même si le bouton clické
			 * est désactivé, en mode enableMultipleSelections.
			 */
			var g:SimpleCheckBoxGroup = $group as SimpleCheckBoxGroup;
			var it:Iterator = g.iterator;
			var item:SimpleCheckBox;
			if(!g.enableMultipleSelections) {
				while(it.hasNext()) {
					item = it.next() as SimpleCheckBox;
					if(item == this && $enabled) {
						item.selected = true;
						g.value = item.label;
						g.data = item.data;
						g.spas_internal::setSelectedItem(this);
						g.spas_internal::setSelectedIndex(this);
					}
					else if(item != this && item.selected) item.selected = false;
				}
			} else {
				g.spas_internal::resetAllData();
				g.spas_internal::setSelectedItem(this);
				g.value = $label;
				g.data = $data;
				while(it.hasNext()) {
					item = it.next() as SimpleCheckBox;
					if (item.selected) {
						g.values.push($label);
						g.allData.push($data);
						g.selectedItems.push(this);
					}
				}
			}
			it.reset();
			setChange($group);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::isInitialized(2);
		}
	}
}