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

package org.flashapi.swing.net {
	
	// -----------------------------------------------------------
	// URLPath.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/07/2007 17:55
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>URLPath</code> class allows to encapsulate an URI an provides methods
	 * 	to manipulate URL paths to external files or assets.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class URLPath {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>URLPath</code> instance with the
		 * 	URI path.
		 * 
		 * 	@param	path	A string to encapsulate within this <code>URLPath</code>
		 * 					object as global path to a valid URL.
		 */
		public function URLPath(path:String = "") {
			super();
			initObj(path);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>path</code> property.
		 * 
		 * 	@see #path
		 */
		protected var $path:String = "";
		/**
		 * 	Returns the URL path encapsulated within this <code>URLPath</code> object.
		 * 
		 * 	@default ""
		 */
		public function get path():String {
			return $path;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//http://stackoverflow.com/questions/548576/as3-string-util-to-convert-to-x-www-form-urlencoded
		
		/**
		 * 	Returns the full path to a file, according to the <code>path</code> property,
		 * 	by only setting the name of the file, including its extension.
		 * 
		 * 	@param	name	The name of an external file, including its extension.
		 * 
		 * 	@return	The full path to a file, according to the <code>path</code>
		 * 			property.
		 */
		public function getFile(name:String = ""):String {
			return $path + name;
		}
		
		/**
		 * 	Encodes in a URL-encoded format and returns the full path to a file,
		 * 	according to the <code>path</code> property, by only setting the name
		 * 	of the file, including its extension.
		 * 
		 * 	@param	name	The name of an external file, including its extension.
		 * 
		 * 	@return	Returns the full path to a file, encoded in a URL-encoded format
		 * 			according to the <code>path</code> property.
		 */
		public function getEncodedFile(name:String = ""):String {
			return escape($path + name);
		}
		
		/**
		 * 	Returns the URL path encapsulated within this <code>URLPath</code> 
		 * 	object, encoded in a URL-encoded format.
		 * 
		 * 	@default ""
		 * 
		 * 	@return The global URL path encoded in a URL-encoded format.
		 */
		public function getEncodedPath():String {
			return escape($path);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(path:String):void {
			$path = path;
		}
	}
}