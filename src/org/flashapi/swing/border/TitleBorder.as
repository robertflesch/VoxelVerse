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

package org.flashapi.swing.border {
	
	// -----------------------------------------------------------
	// TitleBorder.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/12/2008 15:50
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	Interface describing an object capable of rendering a border around
	 * 	the edges of a SPAS 3.0 <code>UIObject</code>, with a title and a
	 * 	complex background.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface TitleBorder extends Border {
		
		/**
		 * 	The text description displayed in the border.
		 * 	If set to <code>null</code>, no text is displayed.
		 * 
		 *  @default null
		 */
		function get title():String;
		function set title(value:String):void;
		
		/**
		 * 	Sets or gets the horizontal position of the text displayed in the border.
		 * 	Valid values are:
		 * 	<ul>
		 * 		<li><code>HorizontalAlignment.LEFT</code>,</li>
		 * 		<li><code>HorizontalAlignment.CENTER</code>,</li>
		 * 		<li><code>HorizontalAlignment.RIGHT</code>.</li>
		 * 	</ul>
		 * 
		 *  @default HorizontalAlignment.LEFT
		 */
		function get titleAlignment():String;
		function set titleAlignment(value:String):void;
		
		/**
		 * 	Sets or gets the vertical position of the text displayed in the border.
		 * 	Valid values are:
		 * 	<ul>
		 * 		<li><code>BorderPosition.ABOVE_TOP</code>,</li>
		 * 		<li><code>BorderPosition.TOP</code>,</li>
		 * 		<li><code>BorderPosition.BELOW_TOP</code>,</li>
		 * 		<li><code>BorderPosition.ABOVE_BOTTOM</code>,</li>
		 * 		<li><code>BorderPosition.BOTTOM</code>,</li>
		 * 		<li><code>BorderPosition.BELOW_BOTTOM</code>.</li>
		 * 	</ul>
		 * 
		 *  @default BorderPosition.TOP
		 */
		function get titlePosition():String;
		function set titlePosition(value:String):void;
	}
}