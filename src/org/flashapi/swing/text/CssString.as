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

package org.flashapi.swing.text {
	
	// -----------------------------------------------------------
	// CssString.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/09/2008 15:38
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>CssString</code> allows to encapsulate and manage strings that
	 * 	define CSS properties. This class is useful for creating explicit CSS
	 * 	rules within a SPAS 3.0 application and use them as main syle with the
	 * 	<code>Application.styleSheet</code> property.
	 * 
	 * 	@see org.flashapi.swing.Application#styleSheet
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CssString {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>CssString</code> object with the
		 * 	specified parameters.
		 * 
		 * 	@param	css	A <code>String</code> that represents a valid set of CSS rules.
		 */
		public function CssString(css:String = "") {
			super();
			initObj(css);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Appends the set of CSS rules specified by the <code>value</code> parameter
		 * 	to the end of the <code>CssString</code> object.
		 * 
		 * 	@param	value 	A set of CSS rules to add at the end of this 
		 * 					<code>CssString</code> object.
		 * 
		 * 	@see #getStyles()
		 */
		public function appendStyle(value:String):void {
			_styles += value;
		}
		
		/**
		 * 	Returns a string that contains all CSS rules added to this <code>CssString</code>
		 * 	object.
		 * 
		 * 	@return
		 * 
		 * 	@see #appendStyle()
		 */
		public function getStyles():String {
			return _styles;
		}
		
		/*
		public function setXmlStyle(value:XML):void {
			_styles += String(value);
		}
		*/
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _styles:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(css:String):void {
			_styles = css;
		}
	}
}