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

package org.flashapi.swing.scroll {
	
	// -----------------------------------------------------------
	// ColorizableScrollbar.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 11/04/2011 01:57
	* @see http://www.flashapi.org/
	*/
	
	/**
	 *  The <code>ColorizableScrollbar</code> interface defines the API that must be
	 * 	implemented by objects to change the colors of their scroll bars.
	 * 
	 * 	<p><strong><code>ColorizableScrollbar</code> objects support the following 
	 * 	CSS properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-arrow-color</code></td>
	 * 			<td>Sets the color of the scroll bar arrow.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarArrowColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_ARROW_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-base-color</code></td>
	 * 			<td>Sets the base color of the scroll bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarBaseColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_BASE_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-face-color</code></td>
	 * 			<td>Sets the face color of the scroll bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarFaceColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_FACE_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-highligh-color</code></td>
	 * 			<td>Sets the highligh color of the scroll bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarHighlightColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_HIGHLIGH_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-shadow-color</code></td>
	 * 			<td>Sets the shadow color of the scroll bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarShadowColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_SHADOW_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-track-color</code></td>
	 * 			<td>Sets the track color of the scroll bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarTrackColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_TRACK_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-join-color</code></td>
	 * 			<td>Sets the join color of the scroll bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarJoinColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_JOIN_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-inactive-join-color</code></td>
	 * 			<td>Sets the inactive join color of the scroll bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarInactiveJoinColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_INACTIVE_JOIN_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scrollbar-inactive-track-color</code></td>
	 * 			<td>Sets the inactive track color of the scroll bar when the scroll bar is deactivated.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>scrollbarInactiveJoinColor</code></td>
	 * 			<td><code>Properties.SCROLLBAR_INACTIVE_TRACK_COLOR</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ColorizableScrollbar {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or gets the color of the arrow elements of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarArrowColor():*;
		function set scrollbarArrowColor(value:*):void;
		
		/**
		 * 	Sets or gets the color of the main elements of a scroll bar,
		 * 	which includes the scroll box, track, and scroll arrows.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarBaseColor():*;
		function set scrollbarBaseColor(value:*):void;
		
		/**
		 * Sets or gets the color of the scroll box of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarFaceColor():*;
		function set scrollbarFaceColor(value:*):void;
		
		/**
		 * 	Sets or gets the highlighted line color of the scroll box of a
		 * 	scroll bar.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarHighlightColor():*;
		function set scrollbarHighlightColor(value:*):void;
		
		/**
		 * 	Sets or gets the dark line color of the scroll box of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarShadowColor():*;
		function set scrollbarShadowColor(value:*):void;
		
		/**
		 * 	Sets or gets the color of the track element of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarTrackColor():*;
		function set scrollbarTrackColor(value:*):void;
		
		/**
		 * 	Sets or gets the color of bottom-right corner of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarJoinColor():*;
		function set scrollbarJoinColor(value:*):void;
		
		/**
		 * 	Sets or gets the color of bottom-right corner of a scroll bar
		 * 	when the scroll bar is deactivated.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarInactiveJoinColor():*;
		function set scrollbarInactiveJoinColor(value:*):void;
		
		/**
		 * 	Sets or gets the color of the track element of a scroll bar
		 * 	when the scroll bar is deactivated.
		 * 
		 * 	@default NaN
		 */
		function get scrollbarInactiveTrackColor():*;
		function set scrollbarInactiveTrackColor(value:*):void;
	}
}