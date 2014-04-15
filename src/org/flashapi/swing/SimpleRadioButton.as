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
	// SimpleRadioButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 21:00
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.SimpleRadioButtonGroup;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("RadioButton.png")]
	
	/**
	 * 	<img src="RadioButton.png" alt="RadioButton" width="18" height="18"/>
	 * 
	 *  A <code>SimpleRadioButton</code> object has the same properties as
	 * 	<code>RadioButton</code> object except that you can not specifie its
	 * 	<code>label</code>. A <code>SimpleRadioButton</code> group is composed
	 * 	of two or more <code>SimpleRadioButton</code> instances with the same
	 * 	group property. The user selects only one member of the group at a time.
	 * 	Selecting an unselected group member deselects the currently selected
	 * 	<code>SimpleRadioButton</code> instance within that group.
	 * 
	 *  @includeExample SimpleRadioButtonExample.as
	 * 
	 * 	@see org.flashapi.swing.RadioButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SimpleRadioButton extends RadioButton implements Observer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>SimpleRadioButton</code> instance.
		 */
		public function SimpleRadioButton() {
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
		 * 	@private
		 */
		override public function set width(value:Number):void { }
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void { }
		
		/**
		 * 	@private
		 */
		override public function set label(value:String):void { }
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function clickHandler(e:UIMouseEvent):void {
			var g:SimpleRadioButtonGroup = $group as SimpleRadioButtonGroup;
			var it:Iterator = g.iterator;
			while(it.hasNext()) {
				var item:SimpleRadioButton = it.next() as SimpleRadioButton;
				if(item == this && $enabled) {
					item.selected = true;
					g.data = item.data;
					g.spas_internal::setSelectedItem(this);
					g.spas_internal::setSelectedIndex(this);
				}
				else if(item != this && item.selected) item.selected = false;
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