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
	// ButtonGroup.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 22/02/2010 22:38
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Button;
	import org.flashapi.swing.button.core.ButtonsGroup;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.util.Iterator;
	
	/**
	 * 	This class is used to create a multiple-exclusion scope for a set of buttons.
	 * 	A <code>ButtonGroup</code> can be used with any set of objects that inherit
	 * 	from <code>ABM</code>.
	 * 
	 * 	@see org.flashapi.swing.button.core.ABM
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ButtonGroup extends ButtonsGroup {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ButtonGroup</code> instance.
		 * 
		 * 	@param	target 	The <code>UIContainer</code> where to display the buttons
		 * 					of the group.
		 * 	@param	buttonClass	The class that represents the type of buttons displayed
		 * 						by this group.
		 */
		public function ButtonGroup(target:UIContainer = null, buttonClass:Class = null) {
			super(target);
			initObj(buttonClass);
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
				var b:Button = new ClassObj(obj.label, w, h);
				if(obj.icon != null) b.setIcon(obj.icon);
				if (s) {
					b.selected = true;
					$value = l, data = obj.data;
				}
				setDataProviderCommonProperties(b, obj);
			}
			it.reset();
			this.dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		private var ClassObj:Class = Button;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(buttonClass:Class):void {
			if (buttonClass != null) ClassObj = buttonClass;
		}
	}
}