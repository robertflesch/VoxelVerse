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

package org.flashapi.swing.css {
	
	// -----------------------------------------------------------
	// Properties.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 11/04/2011 02:05
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>Properties</code> class is an enumeration of constant values that
	 * 	specify the predefined CSS properties that can be used to define how SPAS 3.0
	 * 	elements should be displayed.
	 * 
	 * 	@see org.flashapi.swing.css.Selectors
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Properties {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				Properties instance.
		 */
		public function Properties() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code class="css">align</code> css property for the <code class="css">body</code>
		 * 	selector. Recognized values are <code class="css">top</code>,
		 * 	<code class="css">middle</code>, <code class="css">bottom</code>,
		 * 	<code class="css">left</code>, <code class="css">center</code> and <code class="css">right</code>.
		 * 
		 * 	<p>To set the css <code class="css">align</code> property you can independently specify:</p>
		 * 	<ul>
		 * 		<li>the horizontal alignment only (e.g. <code class="css">align:left;</code>),</li>
		 * 		<li>the vertical alignment only (e.g. <code class="css">align:top;</code>),</li>
		 * 		<li>both, horizontal and vertical alignments (e.g. <code class="css">align:top left;</code>).</li>
		 * 	</ul>
		 */
		public static const ALIGN:String = "align";
		
		/**
		 * 	The <code class="css">background-color</code> css property. Posible values are:
		 * 	<ul>
		 * 		<li>a valid color keyword (e.g. <code class="css">background-color:red;</code>),</li>
		 * 		<li>a CSS color (e.g. <code class="css">background-color:#ff0000;</code>),</li>
		 * 		<li>an integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">background-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const BACKGROUND_COLOR:String = "backgroundColor";
		
		/**
		 * 	The <code class="css">gradient-background-colors</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">gradient-background-colors:black white;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">gradient-background-colors:#000000 #ffffff;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">gradient-background-colors:0x000000 0xffffff;</code>).</li>
		 * 	</ul>
		 */
		public static const GRADIENT_BACKGROUND_COLORS:String = "gradientBackgroundColors";
		
		/**
		 * 	The <code class="css">background-opacity</code> css property. Posible values
		 * 	are numbers from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public static const BACKGROUND_OPACITY:String = "backgroundOpacity";
		
		/**
		 * 	The <code class="css">border-style</code> css property. Posible values are:
		 * 	<ul>
		 * 		<li><code class="css">none</code>,</li>
		 * 		<li><code class="css">dashed</code>,</li>
		 * 		<li><code class="css">double</code>,</li>
		 * 		<li><code class="css">solid</code>,</li>
		 * 		<li><code class="css">outset</code>,</li>
		 * 		<li><code class="css">inset</code>,</li>
		 * 		<li><code class="css">ridge</code>,</li>
		 * 		<li><code class="css">groove</code>,</li>
		 * 		<li><code class="css">frame</code>.</li>
		 * 	</ul>
		 */
		public static const BORDER_STYLE:String = "borderStyle";
		
		/**
		 * 	The <code class="css">border-opacity</code> css property. Posible values
		 * 	are numbers from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public static const BORDER_OPACITY:String = "borderOpacity";
		
		/**
		 * 	The <code class="css">border-color</code> css property. Possible values
		 * 	are valid color keywords (e.g. <code class="css">red</code>), CSS hexadecimal
		 * 	color values (e.g. <code class="css">#ff6699</code>), or hexadecimal
		 * 	integer values (e.g. <code class="css">0xff6699</code>).
		 */
		public static const BORDER_COLOR:String = "borderColor";
		
		/**
		 * 	The <code class="css">border-width</code> css property. Possible values
		 * 	are positive integers.
		 */
		public static const BORDER_WIDTH:String = "borderWidth";
		
		/**
		 * 	The <code class="css">border-radius</code> css property. Possible values
		 * 	are positive integers.
		 */
		public static const BORDER_RADIUS:String = "borderRadius";
		
		/**
		 * 	The <code class="css">border-top-left-radius</code> css property. Possible values
		 * 	are positive integers.
		 */
		public static const BORDER_TOP_LEFT_RADIUS:String = "borderTopLeftRadius";
		
		/**
		 * 	The <code class="css">border-top-right-radius</code> css property. Possible values
		 * 	are positive integers.
		 */
		public static const BORDER_TOP_RIGHT_RADIUS:String = "borderTopRightRadius";
		
		/**
		 * 	The <code class="css">border-bottom-left-radius</code> css property. Possible values
		 * 	are positive integers.
		 */
		public static const BORDER_BOTTOM_LEFT_RADIUS:String = "borderBottomLeftRadius";
		
		/**
		 * 	The <code class="css">border-bottom-right-radius</code> css property. Possible values
		 * 	are positive integers.
		 */
		public static const BORDER_BOTTOM_RIGHT_RADIUS:String = "borderBottomRightRadius";
		
		/**
		 * 	The <code class="css">border-highlight-color</code> css property. Possible values
		 * 	are valid color keywords (e.g. <code class="css">red</code>), CSS hexadecimal
		 * 	color values (e.g. <code class="css">#ff6699</code>), or hexadecimal
		 * 	integer values (e.g. <code class="css">0xff6699</code>).
		 */
		public static const BORDER_HIGHLIGHT_COLOR:String = "borderHighlightColor";
		
		/**
		 * 	The <code class="css">border-shadow-color</code> css property. Possible values
		 * 	are valid color keywords (e.g. <code class="css">red</code>), CSS hexadecimal
		 * 	color values (e.g. <code class="css">#ff6699</code>), or hexadecimal
		 * 	integer values (e.g. <code class="css">0xff6699</code>).
		 */
		public static const BORDER_SHADOW_COLOR:String = "borderShadowColor";
		
		/**
		 * 	The <code class="css">color</code> css property. Possible values
		 * 	are valid color keywords (e.g. <code class="css">red</code>), CSS hexadecimal
		 * 	color values (e.g. <code class="css">#ff6699</code>), or hexadecimal
		 * 	integer values (e.g. <code class="css">0xff6699</code>).
		 */
		public static const COLOR:String = "color";
		
		/**
		 * 	The <code class="css">content-style</code> css property. Not implemented yet.
		 */
		public static const CONTENT_STYLE:String = "contentStyle";
		
		/**
		 * 	The <code class="css">font-color</code> css property. Possible values
		 * 	are valid color keywords (e.g. <code class="css">red</code>), CSS hexadecimal
		 * 	color values (e.g. <code class="css">#ff6699</code>), or hexadecimal
		 * 	integer values (e.g. <code class="css">0xff6699</code>).
		 */
		public static const FONT_COLOR:String = "fontColor";
		
		/**
		 * 	The <code class="css">font-size</code> css property. Recognized values
		 * 	are positive integers.
		 */
		public static const FONT_SIZE:String = "fontSize";
		
		/**
		 * 	The <code class="css">font-style</code> css property. Recognized values are:
		 * 	<ul>
		 * 		<li><code class="css">normal</code>,</li>
		 * 		<li><code class="css">italic</code>.</li>
		 * 	</ul>
		 */
		public static const FONT_STYLE:String = "fontStyle";
		
		/**
		 * 	The <code class="css">font-weight</code> css property. Recognized values are:
		 * 	<ul>
		 * 		<li><code class="css">normal</code>,</li>
		 * 		<li><code class="css">bold</code>.</li>
		 * 	</ul>
		 */
		public static const FONT_WEIGHT:String = "fontWeight";
		
		/**
		 * 	The <code class="css">gap</code> css property. Possible values are
		 * 	positive numbers.
		 */
		public static const GAP:String = "gap";
		
		/**
		 * 	The <code class="css">glow</code> css property. Recognized values are 
		 * 	<code class="css">true</code> or <code class="css">false</code>.
		 */
		public static const GLOW:String = "glow";
		
		/**
		 * 	The <code class="css">glow-color</code> css property. Possible values
		 * 	are valid color keywords (e.g. <code class="css">red</code>), CSS hexadecimal
		 * 	color values (e.g. <code class="css">#ff6699</code>), or hexadecimal
		 * 	integer values (e.g. <code class="css">0xff6699</code>).
		 */
		public static const GLOW_COLOR:String = "glowColor";
		
		/**
		 * 	The <code class="css">gradient</code> css property. Recognized values are 
		 * 	<code class="css">true</code> or <code class="css">false</code>.
		 */
		public static const GRADIENT:String = "gradient";
		
		/**
		 * 	The <code class="css">gradient-background</code> css property. Recognized values are 
		 * 	<code class="css">true</code> or <code class="css">false</code>.
		 */
		public static const GRADIENT_BACKGROUND:String = "gradientBackground";
		
		/**
		 * 	The <code class="css">gradient-colors</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">gradient-colors:black white;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">gradient-colors:#000000 #ffffff;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">gradient-colors:0x000000 0xffffff;</code>).</li>
		 * 	</ul>
		 */
		public static const GRADIENT_COLORS:String = "gradientColors";
		
		/**
		 * 	The <code class="css">height</code> css property. Recognized values are:
		 * 	<ul>
		 * 		<li>positive numbers,</li>
		 * 		<li>a percentage (e.g. <code class="css">height:90%;</code>),</li>
		 * 		<li><code class="css">auto</code>,</li>
		 * 		<li><code class="css">none</code>,</li>
		 * 		<li><code class="css">parent</code>.</li>
		 * 	</ul>
		 */
		public static const HEIGHT:String = "height";
		
		/**
		 * 	The <code class="css">html</code> css property. Recognized values are 
		 * 	<code class="css">true</code> or <code class="css">false</code>.
		 */
		public static const HTML:String = "html";
		
		/**
		 * 	The <code class="css">horizontal-align</code> css property. Possible values are:
		 * 	<ul>
		 * 		<li><code class="css">left</code>,</li>
		 * 		<li><code class="css">center</code>,</li>
		 * 		<li><code class="css">right</code>.</li>
		 * 	</ul>
		 */
		public static const HORIZONTAL_ALIGN:String = "horizontalAlign";
		
		/**
		 * 	The <code class="css">horizontal-gap</code> css property.
		 * 	Possible values are valid numbers.
		 */
		public static const HORIZONTAL_GAP:String = "horizontalGap";
		
		/**
		 * 	The <code class="css">highlight-opacity</code> css property. Posible values
		 * 	are numbers from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public static const HIGHLIGHT_OPACITY:String = "highlightOpacity";
		
		/**
		 * 	The <code class="css">icon</code> css property. Must be a valid URI to
		 * 	an image or a SWF file.
		 */
		public static const ICON:String = "icon";
		
		/**
		 * 	The <code class="css">icon-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">icon-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">icon-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">icon-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const ICON_COLOR:String = "iconColor";
		
		/**
		 * 	The <code class="css"> inner-panel</code> css property. Recognized values are 
		 * 	<code class="css">true</code> or <code class="css">false</code>.
		 */
		public static const INNER_PANEL:String = "innerPanel";
		
		/**
		 * 	The <code class="css">inner-panel-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">inner-panel-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">inner-panel-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">inner-panel-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const INNER_PANEL_COLOR:String = "innerPanelColor";
		
		/**
		 * 	The <code class="css">window-opacity</code> css property. Posible values
		 * 	are numbers from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public static const WINDOW_OPACITY:String = "windowOpacity";
		
		/**
		 * 	The <code class="css">layout</code> css property.
		 * 	This property is experimental.
		 */
		public static const LAYOUT:String = "layout";
		
		/**
		 * 	The <code class="css">layout-alignment</code> css property. Recognized values
		 * 	are <code class="css">top</code>, <code class="css">middle</code>, <code class="css">bottom</code>,
		 * 	<code class="css">left</code>, <code class="css">center</code> and <code class="css">right</code>.
		 * 
		 * 	<p>To set the css <code class="css">layout-alignment</code> property you can independently
		 * 	specify:</p>
		 * 	<ul>
		 * 		<li>the horizontal alignment only (e.g. <code class="css">layout-alignment:left;</code>),</li>
		 * 		<li>the vertical alignment only (e.g. <code class="css">layout-alignment:top;</code>),</li>
		 * 		<li>both, horizontal and vertical alignments
		 * 		(e.g. <code class="css">layout-alignment:top left;</code>).</li>
		 * 	</ul>
		 */
		public static const LAYOUT_ALIGNMENT:String = "layoutAlignment";
		
		/*
		 * 	The <code class="css">layout-orientation</code> css property. Valid values are
		 * 	<code class="css">horizontal</code> and <code class="css">vertical</code>.
		 */
		public static const LAYOUT_ORIENTATION:String = "layoutOrientation";
		
		/**
		 * 	@private
		 * 	The <code class="css">laf-class</code> css property.
		 */
		public static const LAF_CLASS:String = "lafClass";
			
		/**
		 * 	The <code class="css">margin</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const MARGIN:String = "margin";
		
		/**
		 * 	The <code class="css">margin-bottom</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const MARGIN_BOTTOM:String = "marginBottom";
		
		/**
		 * 	The <code class="css">margin-left</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const MARGIN_LEFT:String = "marginLeft";
		
		/**
		 * 	The <code class="css">margin-right</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const MARGIN_RIGHT:String = "marginRight";
		
		/**
		 * 	The <code class="css">margin-top</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const MARGIN_TOP:String = "marginTop";
		
		/**
		 * 	The <code class="css">opacity</code> css property. Posible values
		 * 	are numbers from <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 */
		public static const OPACITY:String = "opacity";
		
		/**
		 * 	The <code class="css">orientation</code> css property. Valid values are
		 * 	<code class="css">horizontal</code> and <code class="css">vertical</code>.
		 */
		public static const ORIENTATION:String = "orientation";
		
		/**
		 * 	The <code class="css">padding</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const PADDING:String = "padding";
		
		/**
		 * 	The <code class="css">padding-bottom</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const PADDING_BOTTOM:String = "paddingBottom";
		
		/**
		 * 	The <code class="css">padding-left</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const PADDING_LEFT:String = "paddingLeft";
		
		/**
		 * 	The <code class="css">padding-right</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const PADDING_RIGHT:String = "paddingRight";
		
		/**
		 * 	The <code class="css">padding-top</code> css property. Valid values are
		 * 	positive and negative numbers.
		 */
		public static const PADDING_TOP:String = "paddingTop";
		
		/**
		 * 	The <code class="css">reflect</code> css property. Recognized values are 
		 * 	<code class="css">true</code> or <code class="css">false</code>.
		 */
		public static const REFLECTION:String = "reflect";
		
		/**
		 * 	The <code class="css">shadow</code> css property. Recognized values are 
		 * 	<code class="css">true</code> or <code class="css">false</code>.
		 */
		public static const SHADOW:String = "shadow";
		
		/**
		 * 	The <code class="css">size</code> css property. Recognized values are
		 * 	<code class="css">auto</code> or <code class="css">none</code>.
		 */
		public static const SIZE:String = "size";
		
		/**
		 * 	The <code class="css">scroll-policy</code> css property. Valid values
		 * 	are:
		 * 	<ul>
		 * 		<li><code class="css">both</code>,</li>
		 * 		<li><code class="css">none</code>,</li>
		 * 		<li><code class="css">vertical</code>,</li>
		 * 		<li><code class="css">horizontal</code>,</li>
		 * 		<li><code class="css">auto</code>.</li>
		 * 	</ul>
		 */
		public static const SCROLL_POLICY:String = "scrollPolicy";
		
		/**
		 * 	The <code class="css">scrollbar-arrow-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-arrow-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-arrow-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-arrow-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_ARROW_COLOR:String = "scrollbarArrowColor";
		
		/**
		 * 	The <code class="css">scrollbar-base-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-base-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-base-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-base-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_BASE_COLOR:String = "scrollbarBaseColor";
		
		/**
		 * 	The <code class="css">scrollbar-face-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-face-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-face-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-face-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_FACE_COLOR:String = "scrollbarFaceColor";
		
		/**
		 * 	The <code class="css">scrollbar-highligh-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-highligh-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-highligh-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-highligh-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_HIGHLIGH_COLOR:String = "scrollbarHighlightColor";
		
		/**
		 * 	The <code class="css">scrollbar-shadow-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-shadow-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-shadow-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-shadow-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_SHADOW_COLOR:String = "scrollbarShadowColor";
		
		/**
		 * 	The <code class="css">scrollbar-track-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-track-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-track-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-track-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_TRACK_COLOR:String = "scrollbarTrackColor";
		
		/**
		 * 	The <code class="css">scrollbar-join-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-join-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-join-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-join-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_JOIN_COLOR:String = "scrollbarJoinColor";
		
		/**
		 * 	The <code class="css">scrollbar-inactive-join-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-inactive-join-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-inactive-join-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-inactive-join-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_INACTIVE_JOIN_COLOR:String = "scrollbarInactiveJoinColor";
		
		/**
		 * 	The <code class="css">scrollbar-inactive-track-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">scrollbar-inactive-join-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">scrollbar-inactive-join-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">scrollbar-inactive-join-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const SCROLLBAR_INACTIVE_TRACK_COLOR:String = "scrollbarInactiveTrackColor";
		
		/**
		 * 	The <code class="css">texture</code> css property. Must be a valid URI to
		 * 	an image file, or <code class="css">none</code>.
		 */
		public static const TEXTURE:String = "texture";
		
		/**
		 * 	The <code class="css">text-align</code> css property. Valid values are:
		 * 	<ul>
		 * 		<li><code class="css">left</code>,</li>
		 * 		<li><code class="css">center</code>,</li>
		 * 		<li><code class="css">right</code>.</li>
		 * 	</ul>
		 */
		public static const TEXT_ALIGN:String = "textAlign";
		
		/**
		 * 	The <code class="css">text-decoration</code> css property. Valid values are:
		 * 	<ul>
		 * 		<li><code class="css">none</code>,</li>
		 * 		<li><code class="css">underline</code>.</li>
		 * 	</ul>
		 */
		public static const TEXT_DECORATION:String = "textDecoration";
		
		/**
		 * 	The <code class="css">text-transform</code> css property. Valid values are:
		 * 	<ul>
		 * 		<li><code class="css">none</code>,</li>
		 * 		<li><code class="css">capitalize</code>,</li>
		 * 		<li><code class="css">uppercase</code>,</li>
		 * 		<li><code class="css">lowercase</code>.</li>
		 * 	</ul>
		 */
		public static const TEXT_TRANSFORM:String = "textTransform";
		
		/**
		 * 	The <code class="css">vertical-align</code> css property. Possible values are:
		 * 	<ul>
		 * 		<li><code class="css">top</code>,</li>
		 * 		<li><code class="css">middle</code>,</li>
		 * 		<li><code class="css">bottom</code>.</li>
		 * 	</ul>
		 */
		public static const VERTICAL_ALIGN:String = "verticalAlign";
		
		/**
		 * 	The <code class="css">vertical-gap</code> css property.
		 * 	Possible values are valid numbers.
		 */
		public static const VERTICAL_GAP:String = "verticalGap";
		
		/**
		 * 	The <code class="css">visibility-decoration</code> css property. Valid values are:
		 * 	<ul>
		 * 		<li><code class="css">visible</code>,</li>
		 * 		<li><code class="css">hidden</code>.</li>
		 * 	</ul>
		 */
		public static const VISIBILITY:String = "visibility";
		
		/**
		 * 	The <code class="css">width</code> css property. Recognized values are:
		 * 	<ul>
		 * 		<li>positive numbers,</li>
		 * 		<li>a percentage (e.g. <code class="css">width:90%;</code>),</li>
		 * 		<li><code class="css">auto</code>,</li>
		 * 		<li><code class="css">none</code>,</li>
		 * 		<li><code class="css">parent</code>.</li>
		 * 	</ul>
		 */
		public static const WIDTH:String = "width";
		
		/**
		 * 	The <code class="css">windows-workspace-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">windows-workspace-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">windows-workspace-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">windows-workspace-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const WINDOWS_WORKSPACE_COLOR:String = "windowsWorkspaceColor";
		
		/**
		 * 	The <code class="css">footer-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">footer-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">footer-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">footer-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const FOOTER_COLOR:String = "footerColor";
		
		/**
		 * 	The <code class="css">header-color</code> css property.
		 * 	Posible values are:
		 * 	<ul>
		 * 		<li>any valid color keyword
		 * 		(e.g. <code class="css">header-color:red;</code>),</li>
		 * 		<li>any CSS color
		 * 		(e.g. <code class="css">header-color:#ff0000;</code>),</li>
		 * 		<li>any integer that represents a hexadecimal color (e.g.
		 * 		<code class="css">header-color:0xff0000;</code>).</li>
		 * 	</ul>
		 */
		public static const HEADER_COLOR:String = "headerColor";
	}
}