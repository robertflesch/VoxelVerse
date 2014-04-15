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
	// SimpleCheckBoxGroup.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 22/02/2010 22:38
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.CheckGroupBase;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.SimpleCheckBox;
	import org.flashapi.swing.util.Iterator;
	
	/**
	 * 	The <code>SimpleCheckBoxGroup</code> class is used to group together a set of
	 * 	<code>SimpleCheckBox</code> buttons.
	 * 
	 * 	<p>Several check box button in a <code>SimpleCheckBoxGroup</code> can be in
	 * 	the "on" state at any given time.</p>
	 * 
	 * 	@see org.flashapi.swing.SimpleCheckBox
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SimpleCheckBoxGroup extends CheckGroupBase {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SimpleCheckBoxGroup</code> instance.
		 * 
		 * 	@param	target 	The <code>UIContainer</code> where to display the buttons
		 * 					of the group.
		 */
		public function SimpleCheckBoxGroup(target:UIContainer = null) {
			super(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function dataProviderChangedHandler(e:ListEvent):void {
			var it:Iterator = $dataProvider.iterator;
			//if(_target == null) throw new
			while(it.hasNext()) {
				var obj:Object = it.next();
				var scb:SimpleCheckBox = new SimpleCheckBox();
				setDataProviderCommonProperties(scb, obj);
			}
			it.reset();
			this.dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
	}
}