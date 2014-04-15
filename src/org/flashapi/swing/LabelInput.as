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
	// EditableLabel.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 26/12/2010 22:15
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.LabelInputUIRef;
	import org.flashapi.swing.text.TLGBase;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("LabelInput.png")]
	
	/**
	 * 	<img src="LabelInput.png" alt="LabelInput" width="18" height="18"/>
	 * 
	 * 	The <code>LabelInput</code> class creates objects composed of a "label"
	 * 	and an "input" text control. The "label" control allows to display the
	 * 	text specified by the <code>title</code> property. The "input" text 
	 * 	control provides users the interface to edit the <code>LabelInput</code>
	 * 	instance. The resulting component is closely similar to "labelized" input
	 * 	fields displayed within form controls.
	 * 
	 * 	<p>The "input" text control of the <code>LabelInput</code> class is a 
	 * 	single-line editable component. To use a multiple-lines editable component
	 * 	use the <code>LabelTextArea</code> class instead.</p>
	 * 
	 * 	<p><code>TextInput</code> and <code>Label</code> instances, used as "label"
	 * 	"input" controls, can be accessed through the <code>editableText</code> and
	 * 	<code>labelControl</code> properties of this <code>LabelInput</code>
	 * 	instance.</p>
	 * 
	 * 	@see org.flashapi.swing.LabelTextArea
	 * 	@see org.flashapi.swing.Label
	 * 	@see org.flashapi.swing.TextInput
	 * 
	 *  @includeExample LabelFieldsExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LabelInput extends TLGBase implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>LabelInput</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	title		The text displayed within the label control.
		 * 	@param	defaultText	The default text displayed within the input control.
		 * 	@param	width		The width of this <code>LabelInput</code> instance,
		 * 						in pixels.
		 * 	@param	baseline	The <code>x</code> position value of the input control.
		 * 	@param	height		The height of this <code>LabelInput</code> instance,
		 * 						in pixels.
		 */
		public function LabelInput(title:String = "", defaultText:String = "", width:Number = 250, baseline:Number = 100, height:Number = 20) {
			super(LabelInputUIRef, Selectors.LABEL_INPUT, title, defaultText, width, baseline, height);
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
		 *  Sets or get the plain text displayed within the <code>TextInput</code>
		 * 	instance of this <code>LabelInput</code> object.
		 * 
		 * 	@default An empty <code>String</code>.
		 */
		public function get label():String {
			return $editableText.text;
		}
		public function set label(value:String):void {
			$editableText.text = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			$editableText.lockLaf(lookAndFeel.getTextInputLaf(), true);
			setLabelLaf();
		}
		
		/**
		 *  @private
		 */
		override protected function createEditableText(width:Number):void {
			$editableText = new TextInput($defaultText, width);
			$editableText.height = $height;
			createEditableTextEvents();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::isInitialized(1);
		}
	}
}