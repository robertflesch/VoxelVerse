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
	
// -----------------------------------------------------------
// Version.as
// -----------------------------------------------------------

/**
* @author Pascal ECHEMANN
* @version 1.0.0, 17/08/2009 16:26
* @see http://www.flashapi.org/
*/

package org.flashapi.swing.core {
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>Version</code> class stores the current version of the SPAS 3.0
	 * 	API. You can distingate alpha, beta, RC and final releases by reading the
	 * 	three first digits, as shown below:
	 * 	<ul>
	 * 		<li>0.9.7 =&gt; alpha releases</li>
	 * 		<li>0.9.8 =&gt; beta releases</li>
	 * 		<li>0.9.9 =&gt; first RC</li>
	 * 		<li>1.0.0 =&gt; first final release</li>
	 * 	</ul>
	 * 
	 * 	<p>Alpha and beta releases use two more digits; the first digit indicates
	 * 	the alpha or beta category and the last one indicates the release number
	 * 	in the current category. Thus, if the <code>Version.toString()</code>
	 * 	outputs <code>0.9.7.5.3</code> the current version of the SPAS 3.0 API
	 * 	is the <em>third version of the fifth (<code>5.3</code>) Alpha (<code>0.9.7</code>)
	 * 	release</em>.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public final class Version {
		
		/**
		 *  @private
		 */
		public function Version() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a string representation of the current SPAS 3.0 API release.
		 * 
		 * 	@return	The current SPAS 3.0 API release.
		 */
		public static function toString():String {
			return QUOTE + "Current version: " + spas_internal::VERSION;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  Version string for this SPAS 3.0 release.
		 */
		spas_internal static const VERSION:String = "0.9.7.6.2";
		
		/**
		 * 	@private
		 */
		private static const QUOTE:String = "They did not know it was impossible, so they did it. (Attributed to Mark TWAIN, 1835-1910)\n";
	}
}