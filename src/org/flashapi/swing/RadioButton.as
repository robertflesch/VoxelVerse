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
	// RadioButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 17/03/2010 21:27
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.button.core.ButtonsGroup;
	import org.flashapi.swing.button.core.CheckButtonBase;
	import org.flashapi.swing.button.RadioButtonGroup;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.plaf.libs.RadioButtonUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("RadioButton.png")]
	
	/**
	 * 	<img src="RadioButton.png" alt="RadioButton" width="18" height="18"/>
	 * 
	 * 	The <code>RadioButton</code> class lets the user make a single choice within
	 * 	a set of mutually exclusive choices. A <code>RadioButton</code> group is composed
	 * 	of two or more <code>RadioButton</code> instances with the same group property.
	 * 	The user selects only one member of the group at a time. Selecting an unselected
	 * 	group member deselects the currently selected <code>RadioButton</code> instance
	 * 	within that group.
	 * 
	 * 	@includeExample RadioButtonExample.as
	 * 
	 * 	@see org.flashapi.swing.button.RadioButtonGroup
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RadioButton extends CheckButtonBase implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>RadioButton</code> instance with the
		 * 					specified parameters
		 * 	
		 * 	@param	label 	Text to display within the <code>RadioButton</code> instance. 
		 * 					If the label is wider than the width of the <code>RadioButton</code>
		 * 					instance, it is truncated and terminated by an ellipsis
		 * 					(...). The default value is <code>Radio button</code>.
		 * 	@param	width 	The width of the <code>RadioButton</code> instance, in 
		 * 					pixels. If <code>NaN</code>, the button width is internally 
		 * 					computed to allow label to not being truncated. In that case, 
		 * 					the <code>autoWidth</code> is set to <code>true</code>.
		 * 					Default value is <code>NaN</code>.
		 * 	@param	height 	The height of the <code>RadioButton</code> instance, in 
		 * 					pixels. If <code>NaN</code>, the button height is internally 
		 * 					computed to allow label to not being truncated. In that case, 
		 * 					the <code>autoHeight</code> is set to <code>true</code>.
		 * 					Default value is <code>NaN</code>.
		 * 	@param	htmlText 	Specifies whether the text to display within the
		 * 						<code>RadioButton</code> instance is HTML (<code>true</code>),
		 * 						or not (<code>false</code>).
		 * 						Default value is <code>false</code>.
		 * 	
		 * 	<p><strong>Note: </strong>if width and height parameters are both set to
		 * 	<code>NaN</code>, the <code>autoSize</code> property is automatically set to
		 * 	<code>true</code>.</p>
		 */
		public function RadioButton(label:String = null, width:Number = NaN, height:Number = NaN, html:Boolean = false) {
			super(label == null ? Locale.spas_internal::LABELS.RADIO_BUTTON_LABEL : label,
				width, height, html, RadioButtonUIRef);
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
		
		/**
		 *  @private
		 */
		override public function set group(value:ButtonsGroup):void {
			super.group = value;
			$toggle = false;
			//setButtonGroup(value);
			//_eventCollector.addEvent(this, UIMouseEvent.CLICK, clickHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$horizontalGap = 5;
			spas_internal::setSelector(Selectors.RADIO_BUTTON);
			spas_internal::isInitialized(1);
		}
		
		/**
		 *  @private
		 */
		override protected function clickHandler(e:UIMouseEvent):void {
			var g:RadioButtonGroup = $group as RadioButtonGroup;
			var it:Iterator = g.iterator;
			while(it.hasNext()) {
				var item:RadioButton = it.next() as RadioButton;
				if(item == this && $enabled) {
					item.selected = true;
					g.value = item.label;
					g.data = item.data;
					g.spas_internal::setSelectedItem(this);
					g.spas_internal::setSelectedIndex(this);
				}
				else if(item != this && item.selected) item.selected = false;
			}
			it.reset();
			setChange($group);
		}
	}
}