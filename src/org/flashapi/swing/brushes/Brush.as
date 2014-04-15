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

package org.flashapi.swing.brushes {
	
	// -----------------------------------------------------------
	// Brush.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/03/2008 14:50
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>Brush</code> interface describes the attributes of brush objects.
	 * 	<code>Brush</code> objects define the color and the pattern of a rectangular
	 * 	area. They can be used to draw custom strokes or icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Brush {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all internal process
		 * 	of an object are killed before you delete it. Typically, the <code>finalize</code>
		 * 	action should remove all events associated with this objects, and destroy
		 * 	somme objects such like <code>BitmapData</code> or <code>NetConnection</code>
		 * 	instances.
		 * 	<p><strong>After calling this function you must set the object to <code>null</code>
		 * 	to definitely kill it.</strong></p>
		 */
		function finalize():void;
		
		/**
		 * 	The <code>paint</code> method performs custom graphics on the display 
		 * 	object, within the specified bounds.
		 */
		function paint():void;
		
		/**
		 *  Clears all graphics that have been drawn on the display object.
		 */
		function clear():void;
		
		/**
		 *  The <code>Brush</code> object color. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 * 
		 * 	@see org.flashapi.swing.color.SVGCK
		 */
		function get color():*;
		function set color(value:*):void;
		
		/**
		 *  Sets or gets the sprite, shape or movie clip used to draw the <code>Brush</code> object.
		 */
		function get target():*;
		function set target(value:*):void;
		
		/**
		 * 	The rectangle bounds of the <code>Brush</code> object. In most cases,
		 * 	the brush object is automatically scaled to the size defined by the rectangle.
		 * 
		 * 	@default null
		 */
		function get rectangle():Rectangle;
		function set rectangle(value:Rectangle):void;
		
		/**
		 * 	Returns the <code>LafDTO</code> instance assigned to this <code>Brush</code> object.
		 * 
		 * 	@default null
		 */
		function get dto():LafDTO;
		
		/**
		 * 	Sets or gets the factor value used to draw the <code>Brush</code> object.
		 * 	The way this property is implemented depends on each <code>Brush</code> object.
		 * 	Most of them do not use this property.
		 */
		function get factor():Number;
		function set factor(value:Number):void;
	}
}