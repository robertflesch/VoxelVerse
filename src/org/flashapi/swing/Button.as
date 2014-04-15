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
	// Button.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 18/06/2009 19:44
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.GroupButtonBase;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.plaf.libs.ButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Button.png")]
	
	/**
	 * 	<img src="Button.png" alt="Button" width="18" height="18"/>
	 * 
	 *  The <code>Button</code> class is a commonly used rectangular button. Buttons look
	 * 	like they can be pressed. They can have a text label, an icon, or both, on their
	 * 	face.
	 * 	
	 * 	<p>You can customize the look of a <code>Button</code> instance and change its
	 * 	functionality from a push button to a toggle button. You can change the button
	 * 	appearance by using a Look and Feel class that implement the <code>ButtonUI</code>
	 * 	interface.</p>
	 * 	
	 * 	<p>The label of a <code>Button</code> instance that uses the SPAS 3.0 default
	 * 	Look and Feel is bold typeface.</p>
	 * 
	 * 	<p>The <code>paddingLeft</code> and <code>paddingRight</code> properties are 
	 * 	set by default to <code>10</code> pixels.</p>
	 * 
	 *  @includeExample ButtonExample.as
	 *
	 * 	@see org.flashapi.swing.plaf.ButtonUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 * */
	public class Button extends GroupButtonBase implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Button</code> instance with the
		 * 					specified parameters.
		 * 	
		 * 	@param	label 	Text to display within the <code>Button</code> instance. 
		 * 					If the label is wider than the width of the <code>Button</code>
		 * 					instance, it is truncated and terminated by an ellipsis
		 * 					(...). The default value is <code>Label</code>.
		 * 	@param	width 	The width of the <code>Button</code> instance, in pixels.
		 * 					If <code>NaN</code>, the button width is internally computed
		 * 					to allow label to not being truncated. In that case, the
		 * 					<code>autoWidth</code> is set to <code>true</code>.
		 * 					Default value is <code>NaN</code>.
		 * 	@param	height 	The height of the <code>Button</code> instance, in pixels.
		 * 					If <code>NaN</code>, the button height is internally computed
		 * 					to allow label to not being truncated. In that case, the
		 * 					<code>autoHeight</code> is set to <code>true</code>.
		 * 					Default value is <code>NaN</code>.
		 * 	@param	htmlText 	Specifies whether the text to display within the
		 * 						<code>Button</code> instance is HTML (<code>true</code>),
		 * 						or not (<code>false</code>).
		 * 						Default value is <code>false</code>.
		 * 	
		 * 	<p><strong>Note: </strong>if width and height parameters are both set to
		 * 	<code>NaN</code>, the <code>autoSize</code> property is automatically set to
		 * 	<code>true</code>.</p>
		 */
		public function Button(label:String = null, width:Number = NaN, height:Number = NaN, htmlText:Boolean = false) {
			super(label == null ? Locale.spas_internal::LABELS.BUTTON_LABEL : label,
				width, height, htmlText, ButtonUIRef);
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
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createTextureManager(spas_internal::background);
			initMinSize(5, 5);
			$padL = $padR = 10;
			$hAlign = HorizontalAlignment.CENTER; 
			spas_internal::setSelector(Selectors.BUTTON);
			spas_internal::isInitialized(1);
			if (spas_internal::isComponent) this.display();
		}
	}
}