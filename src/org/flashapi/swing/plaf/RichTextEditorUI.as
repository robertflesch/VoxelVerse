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

package org.flashapi.swing.plaf {
	
	// -----------------------------------------------------------
	// RichTextEditorUI
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 24/01/2009 15:40
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>RichTextEditorUI</code> interface defines the interface required to
	 * 	create <code>RichTextEditor</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.RichTextEditor
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface RichTextEditorUI extends LookAndFeel {
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>RichTextEditor</code> buttons. This class must implement the
		 * 	<code>ButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>RichTextEditor</code> buttons.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonUI
		 */
		function getButtonLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>RichTextEditor</code> text field. This class must implement the
		 * 	<code>TextAreaUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>RichTextEditor</code> text field.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextAreaUI
		 */
		function getTextAreaLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>RichTextEditor</code> combobox. This class must implement the
		 * 	<code>ComboBoxUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>RichTextEditor</code> combobox.
		 * 
		 * 	@see org.flashapi.swing.plaf.ComboBoxUI
		 */
		function getComboBoxLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>RichTextEditor</code> color button. This class must implement the
		 * 	<code>ColorButtonUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>RichTextEditor</code>color button.
		 * 
		 * 	@see org.flashapi.swing.plaf.ColorButtonUI
		 */
		function getColorButtonLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>RichTextEditor</code> button bar. This class must implement the
		 * 	<code>ButtonBarUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>RichTextEditor</code> button bar.
		 * 
		 * 	@see org.flashapi.swing.plaf.ButtonBarUI
		 */
		function getButtonBarLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>RichTextEditor</code> separator. This class must implement the
		 * 	<code>SeparatorUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>RichTextEditor</code> separator.
		 * 
		 * 	@see org.flashapi.swing.plaf.SeparatorUI
		 */
		function getSeparatorLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>RichTextEditor</code> text input. This class must implement the
		 * 	<code>TextInputUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>RichTextEditor</code> text input.
		 * 
		 * 	@see org.flashapi.swing.plaf.TextInputUI
		 */
		function getTextInputLaf():Class;
	}
}