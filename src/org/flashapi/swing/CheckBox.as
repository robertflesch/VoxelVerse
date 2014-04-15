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
	// CheckBox.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 19:52
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.CheckBoxGroup;
	import org.flashapi.swing.button.core.ButtonsGroup;
	import org.flashapi.swing.button.core.CheckButtonBase;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.plaf.libs.CheckBoxUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("CheckBox.png")]
	
	/**
	 * 	<img src="CheckBox.png" alt="CheckBox" width="18" height="18"/>
	 * 
	 * 	The <code>CheckBox</code> class consists of an optional label and a small box
	 * 	that can contain a check mark or not. You can place the optional text label to
	 * 	the left, right, top, or bottom of the <code>CheckBox</code> instance. When a
	 * 	user clicks a <code>CheckBox</code> control or its associated text, the
	 * 	<code>CheckBox</code> control changes its state from checked to unchecked or
	 * 	from unchecked to checked.
	 * 
	 * 	@includeExample CheckBoxExample.as
	 * 
	 * 	@see org.flashapi.swing.RadioButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CheckBox extends CheckButtonBase implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>CheckBox</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	label Text to display within the <code>CheckBox</code> instance. 
		 * 					If the label is wider than the width of the <code>CheckBox</code>
		 * 					instance, it is truncated and terminated by an ellipsis
		 * 					(...). The default value is <code>Checkbox</code>.
		 * 	@param	width 	The width of the <code>CheckBox</code> instance, in pixels.
		 * 					If <code>NaN</code>, the checkbox width is internally computed
		 * 					to allow label to not being truncated. In that case, the
		 * 					<code>autoWidth</code> is set to <code>true</code>.
		 * 					Default value is <code>NaN</code>.
		 * 	@param	height 	The height of the <code>CheckBox</code> instance, in pixels.
		 * 					If <code>NaN</code>, the checkbox height is internally computed
		 * 					to allow label to not being truncated. In that case, the
		 * 					<code>autoHeight</code> is set to <code>true</code>.
		 * 					Default value is <code>NaN</code>.
		 * 	@param	htmlText 	Specifies whether the text to display within the
		 * 						<code>CheckBox</code> instance is HTML (<code>true</code>),
		 * 						or not (<code>false</code>).
		 * 						Default value is <code>false</code>.
		 * 	
		 * 	<p><strong>Note: </strong>if width and height parameters are both set to
		 * 	<code>NaN</code>, the <code>autoSize</code> property is automatically set to
		 * 	<code>true</code>.</p>
		 */
		public function CheckBox(label:String = null, width:Number = NaN, height:Number = NaN, html:Boolean = false) {
			super(label == null ? Locale.spas_internal::LABELS.CHECKBOX_LABEL : label,
				width, height, html, CheckBoxUIRef);
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
			var grp:CheckBoxGroup = value as CheckBoxGroup;
			$toggle = grp.enableMultipleSelections;
			//_eventCollector.addEvent(this, UIMouseEvent.CLICK, clickHandler);
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
			 * est désactivé, en mode enableMultipleSelection.
			 */
			var g:CheckBoxGroup = $group as CheckBoxGroup;
			var it:Iterator = g.iterator;
			var item:CheckBox;
			if(!g.enableMultipleSelections) {
				while(it.hasNext()) {
					item = it.next() as CheckBox;
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
					item = it.next() as CheckBox;
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
			$horizontalGap = 5;
			spas_internal::setSelector(Selectors.CHECK_BOX);
			spas_internal::isInitialized(1);
		}
	}
}