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
	// AccordionHeader.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/03/2010 21:17
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.ABM;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.plaf.libs.ButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>AccordionHeader</code> class defines the appearance of the navigation
	 * 	buttons of an <code>Accordion</code> object.
	 * 
	 * 	@see org.flashapi.swing.Accordion
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 **/
	public class AccordionHeader extends ABM implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Constructor. Creates a new <code>AccordionHeader</code> instance.
		 * 	
		 * 	@param	label Text to display on the <code>AccordionHeader</code> instance. 
		 * 	@param	width The headers width, in pixels.
		 * 	@param	height The headers height, in pixels.
		 * 	@param	htmlText Specifies whether the text to display is HTML or not.
		 */
		public function AccordionHeader(label:String = null, width:Number = NaN, height:Number = NaN, htmlText:Boolean = false) {
			super();
			initObj(label, width, height, htmlText);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number, height:Number, htmlText:Boolean):void {
			var lab:String = label == null ? Locale.spas_internal::LABELS.ACCORDION_HEADER_LABEL : label;
			init(lab, width, height, htmlText);
			initLaf(ButtonUIRef);
			createTextureManager(spas_internal::background);
			initMinSize(5, 5);
			$padL = $padR = 10;
			$vAlign = VerticalAlignment.MIDDLE;
			$hAlign = HorizontalAlignment.CENTER; 
			$labelPlacement = LabelPlacement.RIGHT;
			initTextField();
			spas_internal::setSelector(Selectors.ACCORDION_HEADER);
			spas_internal::isInitialized(1);
		}
	}
}