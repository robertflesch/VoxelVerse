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

package org.flashapi.swing.framework.locale {
	
	// -----------------------------------------------------------
	// Locale.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/01/2011 14:15
	* @see http://www.flashapi.org/
	*/
	
	//--------------------------------------------------------------------------
	//
	//  Localization APIs
	//
	//--------------------------------------------------------------------------
	
	//--> English US Localization API:
	import org.flashapi.swing.framework.locale.us.LocaleErrors;
	import org.flashapi.swing.framework.locale.us.LocaleLabels;
	import org.flashapi.swing.framework.locale.us.LocaleLang;
	
	/*
	//--> French Localization API:
	import org.flashapi.swing.framework.locale.fr.LocaleErrors;
	import org.flashapi.swing.framework.locale.fr.LocaleLabels;
	import org.flashapi.swing.framework.locale.fr.LocaleLang;
	*/
	
	//--------------------------------------------------------------------------
	//
	//  End of localization APIs
	//
	//--------------------------------------------------------------------------
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>Locale</code> class is the core interface for setting the localization 
	 * 	of the SPAS 3.0 core API.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Locale {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new Locale
		 * 				instance.
		 */
		public function Locale() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static const LANG:String = LocaleLang.LANG;
		
		/**
		 * @private
		 */
		spas_internal static const ERRORS:Class = LocaleErrors;
		
		/**
		 * @private
		 */
		spas_internal static const LABELS:Class = LocaleLabels;
	}
}