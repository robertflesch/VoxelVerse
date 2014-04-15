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

package org.flashapi.swing.renderer {
	
	// -----------------------------------------------------------
	// DataGridHeaderRenderer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 18/06/2009 16:05
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.state.ColorState;
	
	/**
	 * 	The <code>DataGridHeaderRenderer</code> interface defines the basic 
	 * 	set of APIs that you must implement to create <code>DataGridHeader</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.table.DataGridHeader
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DataGridHeaderRenderer extends TextItemRenderer {
		
		/**
		 *  Sets or gets the color of the sorting icon displayed by this 
		 * 	<code>DataGridHeaderRenderer</code> object.
		 * 	The sorting icon color is applied only if the icon uses a reference
		 * 	to a programatic <code>Brush</code> to be rendered.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 *  
		 *  @see org.flashapi.swing.color.SVGCK
		 *  @see org.flashapi.swing.Icon
		 *  @see org.flashapi.swing.brushes.Brush
		 * 
		 *  @see #colors
		 */
		function get iconColor():*;
		function set iconColor(value:*):void;
		
		/**
		 * 	A <code>ColorState</code> object that sets and gets the color of this
		 * 	<code>DataGridHeaderRenderer</code> for each state. <code>ColorState</code>
		 * 	instances define five different states:
		 * <ul>
		 * 		<li><code>ColorState.disabled</code>,</li>
		 * 		<li><code>ColorState.down</code>,</li>
		 * 		<li><code>ColorState.over</code>,</li>
		 *  	<li><code>ColorState.up</code>.</li>
		 * 	</ul>
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are
		 * 	are the same as the values used for for the <code>UIObject.color</code>
		 * 	property.vThe default value for each state is <code>StateObjectValue.NONE</code>.
		 * 	To unset a color state value, use the <code>StateObjectValue.NONE</code>
		 * 	constant.</p>
		 *  
		 *  @see org.flashapi.swing.core.UIObject#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 *  @see #iconColors
		 */
		function get colors():ColorState;
		function set colors(value:ColorState):void;
		
		/**
		 * 	A <code>ColorState</code> object that sets and gets the color of the
		 * 	sorting icon for each state of the header. <code>ColorState</code>
		 * 	instances define five different states:
		 * 	
		 * <ul>
		 * 		<li><code>ColorState.disabled</code>,</li>
		 * 		<li><code>ColorState.down</code>,</li>
		 * 		<li><code>ColorState.over</code>,</li>
		 *  	<li><code>ColorState.up</code>.</li>
		 * 	</ul>
		 * 
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are
		 * 	the same as the values used for for the <code>color</code> property.
		 * 	The default value for each state is <code>StateObjectValue.NONE</code>.
		 * 	To unset a color state value, use the <code>StateObjectValue.NONE</code>
		 * 	constant.</p>
		 *  
		 *  @see org.flashapi.swing.core.UIObject#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		function get iconColors():ColorState;
		function set iconColors(value:ColorState):void;
	}
}