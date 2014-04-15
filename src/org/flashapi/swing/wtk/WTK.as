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

package org.flashapi.swing.wtk {
	
	// -----------------------------------------------------------
	// UIWindow.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1 20/08/2009 12:31
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import org.flashapi.swing.containers.IUIContainer;
	import org.flashapi.swing.core.ClosableObject;
	import org.flashapi.swing.core.SizeAdjuster;
	
	/**
	 * 	The <code>WTK</code> (for Windowing ToolKit) interface defines the basic
	 * 	set of APIs that you must implement to create SPAS 3.0 abstract windows.
	 * 
	 * 	@see org.flashapi.swing.wtk.AWM
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public interface WTK extends IUIContainer, ClosableObject, SizeAdjuster {
		
		/**
		 * 	Sets or gets the CSS class name for all buttons displayed within the
		 * 	window title bar.
		 * 
		 * 	@default ""
		 */
		function get buttonsClassName():String;
		function set buttonsClassName(value:String):void;
		
		/**
		 * 	Returns a reference to the window closing button.
		 * 
		 * 	@see org.flashapi.swing.wtk.WindowButton
		 * 
		 * 	@see #closeButtonActive
		 * 	@see #closeButtonEnabled
		 * 	@see #showCloseButton
		 */
		function get closeButton():WTKButton;
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the window closing
		 * 	button is active (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #closeButton
		 * 	@see #closeButtonEnabled
		 * 	@see #showCloseButton
		 */
		function get closeButtonActive():Boolean;
		function set closeButtonActive(value:Boolean):void;
		
		/**
		 * 	Sets or gets the closing button alternate text value.
		 * 
		 * 	@default WTKLocaleUs.CLOSE
		 * 
		 * 	@see org.flashapi.swing.button.core.ABM#alt
		 */
		function get closeButtonAlt():String;
		function set closeButtonAlt(value:String):void;
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the window closing
		 * 	button is enabled (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #closeButton
		 * 	@see #closeButtonActive
		 * 	@see #showCloseButton
		 */
		function get closeButtonEnabled():Boolean;
		function set closeButtonEnabled(value:Boolean):void;
		
		/**
		 * 	Sets or gets the color of the label text displayed within the window
		 * 	title bar. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 *  <p>Most of the time, the default value is returned by the
		 * 	<code>lookAndFeel.getBorderColor()</code> property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		function get fontColor():*;
		function set fontColor(value:*):void;
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the window has
		 * 	an inner panel (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #innerPanelColor
		 * 	@see #innerPanelOpacity
		 */
		function get innerPanel():Boolean;
		function set innerPanel(value:Boolean):void;
		
		/**
		 * 	Sets and gets the color of the window inner panel. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 *  <p>Most of the time, the default value is returned by the
		 * 	<code>lookAndFeel.getBorderColor()</code> property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 
		 * 	@see #innerPanel
		 * 	@see #innerPanelOpacity
		 */
		function get innerPanelColor():*;
		function set innerPanelColor(value:*):void;
		
		/**
		 * 	Sets and gets the opacity of the window inner panel, from <code>0</code>
		 * 	(fully transparent) to <code>1</code> (fully opaque).
		 * 
		 * 	@default 1
		 * 
		 * 	@see #innerPanelColor
		 * 	@see #innerPanel
		 */
		function get innerPanelOpacity():Number;
		function set innerPanelOpacity(value:Number):void;
		
		/**
		 * 	Sets and gets the opacity of the window, from <code>0</code>
		 * 	(fully transparent) to <code>1</code> (fully opaque).
		 * 
		 * 	@default 1
		 */
		function get windowOpacity():Number;
		function set windowOpacity(value:Number):void;
		
		/**
		 * 	Sets or gets the color of the <code>IconMenuRenderer</code> instance
		 * 	defined by this window. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 *  <p>Most of the time, the default value is returned by the
		 * 	<code>lookAndFeel.getBorderColor()</code> property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #iconMenu
		 */
		function get iconMenuColor():*;
		function set iconMenuColor(value:*):void;
		
		/**
		 *  Returns a <code>Boolean</code> value that indicates whether the <code>state</code>
		 * 	<code>WindowState.MAXIMIZED</code> (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #minimized
		 * 	@see #state
		 */
		function get maximized():Boolean;
		
		/**
		 *  Returns a <code>Boolean</code> value that indicates whether the <code>state</code>
		 * 	<code>WindowState.MINIMIZED</code> (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #maximized
		 * 	@see #state
		 */
		function get minimized():Boolean;
		
		/**
		 * 	Returns a string value that indicates the current state of the window.
		 * 	Possible values are:
		 * 	<ul>
		 * 		<li><code>WindowState.NORMAL</code>,</li>
		 * 		<li><code>WindowState.MAXIMIZED</code>,</li>
		 * 		<li><code>WindowState.MINIMIZED</code>.</li>
		 * 	</ul>
		 * 
		 * 	@default WindowState.NORMAL
		 * 
		 * 	@see #maximized
		 * 	@see #$minimized
		 */
		function get state():String;
		
		/**
		 *  Returns the full height of the window, including:
		 * 	<ul>
		 * 		<li>both, top and bottom extended borders heights,</li>
		 * 		<li>the title bar height,</li>
		 * 		<li>the header height, if displayed,</li>
		 * 		<li>the footer height, if displayed.</li>
		 * 	</ul>
		 * 
		 *  @see #outerWidth
		 *  @see #height
		 *  @see #width
		 */
		function get outerHeight():Number;
		
		/**
		 *  Returns the full width of the window, including both, left and right
		 * 	extended borders widths.
		 * 
		 *  @see #outerHeight
		 *  @see #height
		 *  @see #width
		 */
		function get outerWidth():Number;
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the closing button is 
		 * 	visible (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #closeButton
		 * 	@see #closeButtonActive
		 * 	@see #closeButtonEnabled
		 */
		function get showCloseButton():Boolean;
		function set showCloseButton(value:Boolean):void;
		
		/**
		 * 	Returns a reference to the hitarea button used to interact with the window
		 * 	title bar.
		 */
		function get titleBarButton():Sprite;
		
		/**
		 *  The <code>label</code> property specifies the plain text displayed
		 * 	on the face of the window title bar.
		 * 
		 *  @default null
		 * 
		 * 	@see #html
		 */
		function get label():String;
		function set label(value:String):void;
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the text specified
		 * 	by the <code>label</code> property is HTML (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 *  @default false
		 * 
		 * 	@see #label
		 */
		function get html():Boolean;
		function set html(value:Boolean):void;
		
		/**
		 * 	A reference to the <code>Icon</code> instance displayed winthin the
		 * 	window title bar.
		 * 
		 * 	@see org.flashapi.swing.Icon
		 */
		function get icon():WTKIcon;
		
		//--------------------------------------------------------------------------
		//
		//  Header & footer controls API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets and gets the opacity of the window header container, from <code>0</code>
		 * 	(fully transparent) to <code>1</code> (fully opaque).
		 * 
		 * 	@default 1
		 * 
		 * 	@see #headerColor
		 * 	@see #footerColor
		 * 	@see #footerOpacity
		 */
		function get headerOpacity():Number;
		function set headerOpacity(value:Number):void;
		
		/**
		 * 	Sets and gets the opacity of the window footer container, from <code>0</code>
		 * 	(fully transparent) to <code>1</code> (fully opaque).
		 * 
		 * 	@default 1
		 * 
		 * 	@see #headerColor
		 * 	@see #footerColor
		 * 	@see #headerOpacity
		 */
		function get footerOpacity():Number;
		function set footerOpacity(value:Number):void;
		
		/**
		 * 	Sets and gets the color of the window header container. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 *  <p>Most of the time, the default value is returned by the
		 * 	<code>lookAndFeel.getBorderColor()</code> property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #footerOpacity
		 * 	@see #footerColor
		 * 	@see #headerOpacity
		 */
		function get headerColor():*;
		function set headerColor(value:*):void;
		
		/**
		 * 	Sets and gets the color of the window footer container. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 *  <p>Most of the time, the default value is returned by the
		 * 	<code>lookAndFeel.getBorderColor()</code> property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #footerOpacity
		 * 	@see #headerColor
		 * 	@see #headerOpacity
		 */
		function get footerColor():*;
		function set footerColor(value:*):void;
		
		/**
		 * 	Returns a reference of the header control for this window.
		 * 
		 * 	@see #footer
		 */
		function get header():WTKControlContainer;
		
		/**
		 * 	Returns a reference of the header control for this window.
		 * 
		 * 	@see #header
		 */
		function get footer():WTKControlContainer;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Removes an icon added with the <code>setIcon()</code> method.
		 * 
		 * 	@see org.flashapi.swing.Icon
		 * 	@see #setIcon()
		 * 	@see #icon
		 */
		function deleteIcon():void;
		
		/**
		 * 	Adds an element to be displayed as an icon within the window title bar.
		 * 	Valid elements are the same as elements that can be used for the
		 * 	<code>Icon.addElement()</code> method.
		 * 	
		 * 	@param	value The element to add as an icon.
		 * 
		 * 	@see org.flashapi.swing.Icon
		 * 	@see #removeIcon()
		 * 	@see #icon
		 */
		function setIcon(value:*):void;
		
		/**
		 * 	Removes an icon painted with the <code>drawIcon()</code> method.
		 * 
		 * 	@see org.flashapi.swing.Icon
		 * 	@see #drawIcon()
		 * 	@see #icon
		 */
		function clearIcon():void;
		
		/**
		 * 	Draws the icon displayed within the window title bar, with the specified
		 * 	<code>Brush</code> class.
		 * 
		 * 	@param	brush	The <code>Brush</code> class reference used to draw the
		 * 					icon.
		 * 
		 * 	@see org.flashapi.swing.Icon
		 * 	@see #clearIcon()
		 * 	@see #icon
		 */
		function drawIcon(brush:Class = null):void;
	}
}