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

package org.flashapi.swing.validators {
	
	// -----------------------------------------------------------
	// AbstractValidator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/01/2011 16:33
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.util.InterfaceValidator;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>AbstractValidator</code> class is the base for creating validation
	 * 	services whith the SPAS 3.0 API.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractValidator implements Validator {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>AbstractValidator</code> instance with
		 * 	the specified parameters.
		 * 
		 * 	@param	composerClass	A <code>Class</code> object reference that is used
		 * 							to compose specific error validation messages.
		 */
		public function AbstractValidator(composerClass:Class) {
			super();
			initObj(composerClass);
		}
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>composerClass</code> property.
		 * 
		 * 	@see #composerClass
		 */
		protected var $composerClass:Class;
		/**
		 * 	@inheritDoc
		 */
		public function get composerClass():Class {
			return $composerClass;
		}
		public function set composerClass(value:Class):void {
			setComposerClass(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function validate(value:String):Boolean {
			return false;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get message():String {
			return new $composerClass().compose();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected function setComposerClass(value:Class):void {
			InterfaceValidator.validate(value,
				"org.flashapi.swing.localization.validation::LocaleValidation",
				Locale.spas_internal::ERRORS.LOCALE_VALIDATION_ERROR);
			$composerClass = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(composerClass:Class):void {
			setComposerClass(composerClass);
		}
	}
}