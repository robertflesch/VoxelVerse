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
	* @version 1.0.1, 22/02/2010 22:39
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.ButtonsGroup;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.ListEvent;
	import org.flashapi.swing.SimpleRadioButton;
	import org.flashapi.swing.util.Iterator;
	
	/**
	 * 	The <code>SimpleRadioButtonGroup</code> class is used to group together a set of
	 * 	<code>SimpleRadioButton</code> buttons.
	 * 
	 * 	<p>Exactly one radio button in a <code>SimpleRadioButtonGroup</code> can be in
	 * 	the "on" state at any given time.</p>
	 * 
	 * 	@see org.flashapi.swing.SimpleRadioButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SimpleRadioButtonGroup extends ButtonsGroup {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SimpleRadioButtonGroup</code> instance.
		 * 
		 * 	@param	target 	The <code>UIContainer</code> where to display the buttons
		 * 					of the group.
		 */
		public function SimpleRadioButtonGroup(target:UIContainer = null) {
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
				var srb:SimpleRadioButton = new SimpleRadioButton();
				setDataProviderCommonProperties(srb, obj);
			}
			it.reset();
			this.dispatchEvent(new DataBindingEvent(DataBindingEvent.DATA_PROVIDER_FINISHED));
		}
	}
}