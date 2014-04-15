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
	// LabelTextArea.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/12/2010 22:30
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.LabelTextAreaUIRef;
	import org.flashapi.swing.text.TLGBase;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("LabelTextArea.png")]
	
	/**
	 * 	<img src="LabelTextArea.png" alt="LabelTextArea" width="18" height="18"/>
	 * 
	 * 	The <code>LabelTextArea</code> class creates objects composed of a "label"
	 * 	and an "textarea" control. The "label" control allows to display the
	 * 	text specified by the <code>title</code> property. The "textarea" control
	 * 	provides users the interface to edit the <code>LabelTextArea</code>
	 * 	instance. The resulting component is closely similar to "labelized" textarea
	 * 	fields displayed within form controls.
	 * 
	 * 	<p>The "textarea" text control of the <code>LabelTextArea</code> class is a 
	 * 	multiple-lines editable component. To use a single-line editable component
	 * 	use the <code>LabelInput</code> class instead.</p>
	 * 
	 * 	<p><code>TextArea</code> and <code>Label</code> instances, used as "label"
	 * 	"input" controls, can be accessed through the <code>editableText</code> and
	 * 	<code>labelControl</code> properties of this <code>TextArea</code> 
	 * 	instance.</p>
	 * 
	 * 	@see org.flashapi.swing.LabelInput
	 * 	@see org.flashapi.swing.Label
	 * 	@see org.flashapi.swing.TextArea
	 * 
	 *  @includeExample LabelFieldsExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LabelTextArea extends TLGBase implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>LabelTextArea</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	title		The text displayed within the label control.
		 * 	@param	defaultText	The default text displayed within the text control.
		 * 	@param	width		The width of this <code>LabelTextArea</code> instance,
		 * 						in pixels.
		 * 	@param	baseline	The <code>x</code> position value of the text control.
		 * 	@param	height		The height of this <code>LabelTextArea</code> instance,
		 * 						in pixels.
		 */
		public function LabelTextArea(title:String = "", defaultText:String = "", width:Number = 250, baseline:Number = 100, height:Number = 100) {
			super(LabelTextAreaUIRef, Selectors.LABEL_TEXTAREA, title, defaultText, width, baseline, height);
			initObj(defaultText);
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
		
		private var _text:String;
		/**
		 *  Sets or get the plain text displayed within the <code>TextArea</code>
		 * 	instance of this <code>LabelTextArea</code> object.
		 * 
		 * 	@default An empty <code>String</code>.
		 */
		public function get text():String {
			return _text;
		}
		public function set text(value:String):void {
			$editableText.text = _text = value;
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
			$editableText.lockLaf(lookAndFeel.getTextAreaLaf(), true);
			setLabelLaf();
		}
		
		/**
		 *  @private
		 */
		override protected function createEditableText(width:Number):void {
			$editableText = new TextArea(width, $height);
			$editableText.text = $defaultText;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(defaultText:String):void {
			_text = defaultText;
			spas_internal::isInitialized(1);
		}
	}
}