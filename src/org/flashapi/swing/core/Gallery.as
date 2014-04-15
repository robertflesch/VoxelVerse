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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// Gallery.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 28/06/2009 12:47
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.containers.GalleryContainer;
	import org.flashapi.swing.layout.Layout;
	
	/**
	 * 	The <code>Gallery</code> interface defines the basic set of APIs that you must
	 * 	implement to create a SPAS 3.0 interactive image gallery.
	 * 
	 * <p><strong><code>Gallery</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-color</code></td>
	 * 			<td>Sets the font color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>fontColor</code></td>
	 * 			<td><code>Properties.COLOR</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">font-size</code></td>
	 * 			<td>Sets the font size of the object.</td>
	 * 			<td>Recognized values are positive integers.</td>
	 * 			<td><code>fontSize</code></td>
	 * 			<td><code>Properties.FONT_SIZE</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">text-align</code></td>
	 * 			<td>Sets the alignment of the text displayed within this object.</td>
	 * 			<td>Valid values are <code class="css">left</code>, <code class="css">center</code>
	 * 			and <code class="css">right</code>.</td>
	 * 			<td><code>textAlign</code></td>
	 * 			<td><code>Properties.TEXT_ALIGN</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Gallery extends IUIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets or gets the vertical position of all captions within this
		 * 	<code>Gallery</code> object. Valid values are:
		 * 	<ul>
		 * 		<li><code>CaptionPosition.TOP</code></li>
		 * 		<li><code>CaptionPosition.BOTTOM</code></li>
		 * 	</ul>
		 * 
		 * 	@default CaptionPosition.BOTTOM
		 */
		function get captionPosition():String;
		function set captionPosition(value:String):void;
		
		/**
		 * 	Sets or gets the color of the text for all caption controls within this
		 * 	<code>Gallery</code> object.
		 * 
		 * 	@see org.flashapi.swing.text.ATM#fontColor
		 */
		function get fontColor():*;
		function set fontColor(value:*):void;
		
		/**
		 *  Sets or gets the point size of the text for all caption controls within 
		 * 	this <code>Gallery</code> object. The default value is defined by the
		 * 	font size of the Look and Feel text format used by the <code>GalleryContainer</code>
		 * 	instances within this <code>Gallery</code> object.
		 * 
		 * 	@see org.flashapi.swing.containers.GalleryContainer
		 * 	@see org.flashapi.swing.text.ATM#fontSize
		 */
		function get fontSize():*;
		function set fontSize(value:*):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the caption controls
		 * 	are visible (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		function get showCaptions():Boolean;
		function set showCaptions(value:Boolean):void;
		
		/**
		 * 	Sets or gets the alignment of the text for all the caption controls within 
		 * 	this <code>Gallery</code> object. Valid values are:
		 * 	<ul>
		 * 		<li>TextAlign.LEFT</li>
		 * 		<li>TextAlign.CENTER</li>
		 * 		<li>TextAlign.RIGHT</li>
		 * 	</ul>
		 * 
		 * 	@default TextAlign.LEFT
		 * 
		 * 	@see org.flashapi.swing.text.ATM#textAlign
		 */
		function get textAlign():String;
		function set textAlign(value:String):void;
		
		/**
		 * 	Sets or gets the CSS class name for all the thumbnail controls within 
		 * 	this <code>Gallery</code> object.
		 */
		function get thumbnailClassName():String;
		function set thumbnailClassName(value:String):void;
		
		/**
		 * 	Sets or gets the CSS class name for all the <code>GalleryContainer</code>
		 * 	instances within this <code>Gallery</code> object.
		 * 
		 * 	@see org.flashapi.swing.containers.GalleryContainer
		 */
		function get containerClassName():String;
		function set containerClassName(value:String):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether texts displayed
		 * 	by the caption controls are selectable (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default true
		 */
		function get selectable():Boolean;
		function set selectable(value:Boolean):void;
		
		/**
		 *  A reference to the <code>Layout</code> instance for this <code>Gallery</code>.
		 *  object The default layout is an instance of the <code>FlowLayout</code> class.
		 *
		 *  @see org.flashapi.swing.layout.Layout
		 *  @see org.flashapi.swing.layout.FlowLayout
		 */
		function get layout():Layout;
		function set layout(value:Layout):void;
		
		//--------------------------------------------------------------------------
		//
		//  Internal methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  Indicates the <code>GalleryContainer</code> instance that has been currently
		 * 	clicked within this <code>Gallery</code> object.
		 * 
		 * 	@see org.flashapi.swing.containers.GalleryContainer
		 */
		function setSelectedPicture(value:GalleryContainer):void;
	}
}