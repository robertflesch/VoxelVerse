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

package org.flashapi.swing.plaf.libs {
	
	// -----------------------------------------------------------
	// MuteButtonUIRef.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/03/2010 22:43
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.spas.media.SpasMuteButtonUI;
	import org.flashapi.swing.util.Observable;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>MuteButtonUIRef</code> is the Library Reference for 
	 * 	Look And Feel of <code>MuteButton</code> objects.
	 * 
	 * 	@see org.flashapi.swing.media.MuteButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MuteButtonUIRef implements LafLibRef {
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns the default Look And Feel reference for the <code>MuteButtonUIRef</code>
		 * 	Library.
		 * 
		 * 	@return	The default Look And Feel reference for this <code>LafLibRef</code>
		 * 			object.
		 */
		public static function getDefaultUI():Class {
			return SpasMuteButtonUI;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public static properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		public static var lafList:Observable;
		
		/**
		 *  @private
		 */
		public static var laf:Object;
	}
}