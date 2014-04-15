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
	// CheckBoxGroup.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 21/12/2008 15:15
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.CheckGroupBase;
	import org.flashapi.swing.CheckBox;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.util.Iterator;
	
	/**
	 * 	The <code>CheckboxGroup</code> class is used to group together a set of
	 * 	<code>CheckBox</code> buttons.
	 * 
	 * 	<p>Several check box button in a <code>CheckboxGroup</code> can be in
	 * 	the "on" state at any given time.</p>
	 * 
	 * 	@see org.flashapi.swing.CheckBox
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CheckBoxGroup extends CheckGroupBase {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>CheckBoxGroup</code> instance.
		 * 
		 * 	@param	target 	The <code>UIContainer</code> where to display the buttons
		 * 					of the group.
		 */
		public function CheckBoxGroup(target:UIContainer = null) {
			super(target);
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
				var cb:CheckBox = new CheckBox(obj.label, w, h);
				if (s) {
					cb.selected = true;
					//_value = l, data = obj.data;
				}
				setDataProviderCommonProperties(cb, obj);
			}
			it.reset();
			this.dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
	}
}