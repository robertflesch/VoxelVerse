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
	// Border.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 21/12/2008 17:39
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	
	/**
	 * 	The <code>Border</code> interface describes objects capable of rendering
	 * 	a border and a complex background.
	 * 
	 * <p><strong><code>Border</code> objects support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-style</code></td>
	 * 			<td>Sets the style of border applied to the object.</td>
	 * 			<td>One of the following string value: <code class="css">none</code>,
	 * 			<code class="css">dashed</code>, <code class="css">dotted</code>,
	 * 			<code class="css">double</code>, <code class="css">solid</code>,
	 * 			<code class="css">outset</code>, <code class="css">inset</code>,
	 * 			<code class="css">ridge</code>, <code class="css">groove</code>,
	 * 			<code class="css">frame</code>.</td>
	 * 			<td><code>borderStyle</code></td>
	 * 			<td>Properties.BORDER_STYLE</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-opacity</code></td>
	 * 			<td>Sets the border opacity for this object.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>borderAlpha</code></td>
	 * 			<td>Properties.BORDER_OPACITY</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-width</code></td>
	 * 			<td>Sets the border width for this object.</td>
	 * 			<td>Possible values are positive integers.</td>
	 * 			<td><code>borderWidth</code></td>
	 * 			<td>Properties.BORDER_WIDTH</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-radius</code></td>
	 * 			<td>Affects all four border corners of an element.</td>
	 * 			<td>Possible values are positive integers.</td>
	 * 			<td><code>UIObject.cornerRadius</code></td>
	 * 			<td>Properties.BORDER_RADIUS</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-top-left-radius</code></td>
	 * 			<td>Affects the top-left border corner of an element.</td>
	 * 			<td>Possible values are positive integers.</td>
	 * 			<td><code>topLeftCorner</code></td>
	 * 			<td>Properties.BORDER_TOP_LEFT_RADIUS</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-top-right-radius</code></td>
	 * 			<td>Affects the top-right border corner of an element.</td>
	 * 			<td>Possible values are positive integers.</td>
	 * 			<td><code>topRightCorner</code></td>
	 * 			<td>Properties.BORDER_TOP_RIGHT_RADIUS</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-bottom-left-radius</code></td>
	 * 			<td>Affects the bottom-left border corner of an element.</td>
	 * 			<td>Possible values are positive integers.</td>
	 * 			<td><code>bottomLeftCorner</code></td>
	 * 			<td>Properties.BORDER_BOTTOM_LEFT_RADIUS</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-bottom-right-radius</code></td>
	 * 			<td>Affects the bottom-right border corner of an element.</td>
	 * 			<td>Possible values are positive integers.</td>
	 * 			<td><code>bottomRightCorner</code></td>
	 * 			<td>Properties.BORDER_BOTTOM_RIGHT_RADIUS</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-highlight-color</code></td>
	 * 			<td>Sets the border highlight color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>borderHighlightColor</code></td>
	 * 			<td><code>Properties.BORDER_HIGHLIGHT_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-shadow-color</code></td>
	 * 			<td>Sets the border shadox color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>borderShadowColor</code></td>
	 * 			<td><code>Properties.BORDER_SHADOW_COLOR</code></td>
	 * 		</tr>
	 * 
	 * 	</table> 
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Border {
		
		/**
		 * 	A reference to the sprite container used to render the background.
		 */
		function get backgroundContainer():Sprite;
		
		/**
		 *  Returns the background width specified for this object.
		 */
		function get backgroundWidth():Number;
		
		/**
		 *  Returns the background height specified for this object.
		 */
		function get backgroundHeight():Number;
		
		/**
		 * 	A reference to the sprite container used to render the borders.
		 */
		function get bordersContainer():Sprite;
		
		/**
		 * 	Sets or gets the alpha value of the border (<code>0.0</code> to <code>1.0</code>).
		 * 
		 * 	@default NaN
		 */
		function get borderAlpha():Number;
		function set borderAlpha(value:Number):void;
		
		/**
		 *  A value from the <code>BorderStyle</code> class that specifies the border line style
		 * 	specified for this object. Valid values are:
		 *  <ul>
		 * 		<li><code>BorderStyle.NONE</code>,</li>
		 * 		<li><code>BorderStyle.DASHED</code>,</li>
		 * 		<li><code>BorderStyle.DOTTED</code>,</li>
		 * 		<li><code>BorderStyle.DOUBLE</code>,</li>
		 * 		<li><code>BorderStyle.SOLID</code>,</li>
		 * 		<li><code>BorderStyle.OUTSET</code>,</li>
		 * 		<li><code>BorderStyle.INSET</code>,</li>
		 * 		<li><code>BorderStyle.DOUBLE</code>,</li>
		 * 		<li><code>BorderStyle.RIDGE</code>,</li>
		 * 		<li><code>BorderStyle.GROOVE</code>.</li>
		 * 	</ul>
		 * 	For more information abaout using border styles, see
		 * 	<a href='../../../../appendixes/box_class.html'>The <code>Box</code> class model</a> in the
		 * 	'Appendixes section'.
		 * 
		 * 	@see org.flashapi.swing.constants.BorderStyle
		 * 
		 * 	@default BorderStyle.NONE
		 */
		function get borderStyle():String;
		function set borderStyle(value:String):void;
		
		/**
		 * 	Sets or gets the border width specified for this object, in pixels.
		 * 	<p><strong>Note:</strong> border values are always rounded to the nearest integer
		 * 	value for all <code>Border</code> object instances.</p>
		 * 
		 * 	@default NaN
		 */
		function get borderWidth():Number;
		function set borderWidth(value:Number):void;
		
		/**
		 *  Sets or gets the top left corner radius value specified for this object.
		 * 	If set to <code>NaN</code>, the value used to set the <code>UIObject</code> 
		 * 	top left corner radius is the value returned by the <code>cornerRadius</code>
		 * 	property.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#cornerRadius
		 * 
		 * 	@see #topRightCorner
		 * 	@see #bottomRightCorner
		 * 	@see #bottomLeftCorner
		 */
		function get topLeftCorner():Number;
		function set topLeftCorner(value:Number):void;
		
		/**
		 *  Sets or gets the top right corner radius value specified for this object.
		 * 	If set to <code>NaN</code>, the value used to set the <code>UIObject</code> 
		 * 	top right corner radius is the value returned by the <code>cornerRadius</code>
		 * 	property.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#cornerRadius
		 * 
		 * 	@see #topLeftCorner
		 * 	@see #bottomRightCorner
		 * 	@see #bottomLeftCorner
		 */
		function get topRightCorner():Number;
		function set topRightCorner(value:Number):void;
		
		/**
		 *  Sets or gets the bottom right corner radius value specified for this object.
		 * 	If set to <code>NaN</code>, the value used to set the <code>UIObject</code> 
		 * 	bottom right corner radius is the value returned by the <code>cornerRadius</code>
		 * 	property.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#cornerRadius
		 * 
		 * 	@see #topLeftCorner
		 * 	@see #topRightCorner
		 * 	@see #bottomLeftCorner
		 */
		function get bottomRightCorner():Number;
		function set bottomRightCorner(value:Number):void;
		
		/**
		 *  Sets or gets the bottom left corner radius value specified for this object.
		 * 	If set to <code>NaN</code>, the value used to set the <code>UIObject</code> 
		 * 	bottom left corner radius is the value returned by the <code>cornerRadius</code>
		 * 	property.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#cornerRadius
		 * 
		 * 	@see #topLeftCorner
		 * 	@see #topRightCorner
		 * 	@see #bottomRightCorner
		 */
		function get bottomLeftCorner():Number;
		function set bottomLeftCorner(value:Number):void;
		
		/**
		 *  Sets or gets the top border color value specified for this object. If set to
		 * 	<code>NaN</code>, the value used to set the <code>UIObject</code> top border
		 * 	color is the value returned by the <code>borderColor</code> property.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderColor
		 * 
		 * 	@see #borderRightColor
		 * 	@see #borderBottomColor
		 * 	@see #borderLeftColor
		 */
		function get borderTopColor():*;
		function set borderTopColor(value:*):void;
		
		/**
		 *  Sets or gets the right border color value specified for this object. If set to
		 * 	<code>NaN</code>, the value used to set the <code>UIObject</code> right border
		 * 	color is the value returned by the <code>borderColor</code> property.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderColor
		 * 
		 * 	@see #borderTopColor
		 * 	@see #borderBottomColor
		 * 	@see #borderLeftColor
		 */
		function get borderRightColor():*;
		function set borderRightColor(value:*):void;
		
		/**
		 *  Sets or gets the bottom border color value specified for this object. If set to
		 * 	<code>NaN</code>, the value used to set the <code>UIObject</code> bottom border
		 * 	color is the value returned by the <code>borderColor</code> property.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderColor
		 * 
		 * 	@see #borderTopColor
		 * 	@see #borderRightColor
		 * 	@see #borderLeftColor
		 */
		function get borderBottomColor():*;
		function set borderBottomColor(value:*):void;
		
		/**
		 *  Sets or gets the left border color value specified for this object. If set to
		 * 	<code>NaN</code>, the value used to set the <code>UIObject</code> left border
		 * 	color is the value returned by the <code>borderColor</code> property.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderColor
		 * 
		 * 	@see #borderTopColor
		 * 	@see #borderRightColor
		 * 	@see #borderBottomColor
		 */
		function get borderLeftColor():*;
		function set borderLeftColor(value:*):void;
		
		/**
		 *  Sets or gets the border shadow color value specified for this object. If set
		 * 	to <code>NaN</code>, the value used to set the <code>UIObject</code> border shadow
		 * 	color is <code>0xFFFFFF</code>.
		 * 
		 * 	@default NaN
		 */
		function get borderShadowColor():*;
		function set borderShadowColor(value:*):void;
		
		/**
		 *  Sets or gets the border highlight color value specified for this object. If set
		 * 	to <code>NaN</code>, the value used to set the <code>UIObject</code> border highlight
		 * 	color is <code>0x333333</code>.
		 * 
		 * 	@default NaN
		 */
		function get borderHighlightColor():*;
		function set borderHighlightColor(value:*):void;
		
		/**
		 *  Sets or gets the top border alpha value specified for this object. If set
		 * 	to <code>NaN</code>, the value used to set the <code>UIObject</code> top border
		 * 	alpha is the value returned by the <code>borderAlpha</code> property.
		 *
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderAlpha
		 * 
		 * 	@see #borderRightOpacity
		 * 	@see #borderBottomOpacity
		 * 	@see #borderLeftOpacity
		 */
		function get borderTopOpacity():Number;
		function set borderTopOpacity(value:Number):void;
		
		/**
		 *  Sets or gets the rigth border alpha value specified for this object. If set
		 * 	to <code>NaN</code>, the value used to set the <code>UIObject</code> rigth border
		 * 	alpha is the value returned by the <code>borderAlpha</code> property.
		 *
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderAlpha
		 * 
		 * 	@see #borderTopOpacity
		 * 	@see #borderBottomOpacity
		 * 	@see #borderLeftOpacity
		 */
		function get borderRightOpacity():Number;
		function set borderRightOpacity(value:Number):void;
		
		/**
		 *  Sets or gets the bottom border alpha value specified for this object. If set
		 * 	to <code>NaN</code>, the value used to set the <code>UIObject</code> bottom border
		 * 	alpha is the value returned by the <code>borderAlpha</code> property.
		 *
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderAlpha
		 * 
		 * 	@see #borderTopOpacity
		 * 	@see #borderRightOpacity
		 * 	@see #borderLeftOpacity
		 */
		function get borderBottomOpacity():Number;
		function set borderBottomOpacity(value:Number):void;
		
		/**
		 *  Sets or gets the left border alpha value specified for this object. If set
		 * 	to <code>NaN</code>, the value used to set the <code>UIObject</code> left border
		 * 	alpha is the value returned by the <code>borderAlpha</code> property.
		 *
		 * 	@default NaN
		 * 
		 * 	@see org.flashapi.swing.core.UIObject#borderAlpha
		 * 
		 * 	@see #borderTopOpacity
		 * 	@see #borderRightOpacity
		 * 	@see #borderBottomOpacity
		 */
		function get borderLeftOpacity():Number;
		function set borderLeftOpacity(value:Number):void;
		
		/**
		 *  Sets or gets the border shadow alpha value specified for this object.
		 * 
		 * 	@default 1
		 */
		function get borderShadowOpacity():Number;
		function set borderShadowOpacity(value:Number):void;
		
		/**
		 *  Sets or gets the border highlight alpha value specified for this object.
		 * 	@default 1
		 */
		function get borderHighlightOpacity():Number;
		function set borderHighlightOpacity(value:Number):void;
	}
}