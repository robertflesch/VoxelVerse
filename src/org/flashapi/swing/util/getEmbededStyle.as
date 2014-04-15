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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// getEmbededStyle.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/06/2008 23:43
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.StyleSheet;
	import flash.utils.ByteArray;
	
	//--------------------------------------------------------------------------
	//
	// 	Global function
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	Converts a valid embeded CSS file to an ActionScript <code>StyleSheet</code>
	 * 	object.
	 * 
	 * 	@return An ActionScript <code>StyleSheet</code> object which is identical 
	 * 			to the embeded CSS file.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public function getEmbededStyle(assetType:Class):StyleSheet {
		var ba:ByteArray = new assetType() as ByteArray;
		var style:StyleSheet = new StyleSheet();
		style.parseCSS(ba.readUTFBytes(ba.length));
		return style;
	}
}