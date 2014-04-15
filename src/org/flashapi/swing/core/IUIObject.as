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
	// IUIObject.as
	// -----------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.text.TextField;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.crypto.GUID;
	import org.flashapi.swing.effect.Effect;
	import org.flashapi.swing.framework.Debugger;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.skin.Skinable;
	import org.flashapi.swing.state.ColorState;
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 16/01/2011 12:41
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>IUIObject</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 visual <code>UIObject</code>.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface IUIObject extends Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Indicates the alpha transparency value of the <code>UIOBject</code>.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque). <code>UIObjects</code> with <code>alpha</code> set to
		 * 	<code>0</code> are active, even though they are invisible.
		 * 
		 *  @default 1
		 * 
		 *  @see #backgroundAlpha
		 */
		function get alpha():Number;
		function set alpha(value:Number):void;
		
		/**
		 * 	Sets or retrieves the amount of time, in milliseconds, before showing the
		 * 	boxhelp for displaying the <code>alt</code> property.
		 * 	If set to <code>null</code> the boxhelp wont be displayed.
		 * 
		 * 	@default 500
		 */
		function get altDelay():uint;
		function set altDelay(value:uint):void;
		
		/**
		 *  Indicates whether a <code>Uiobjects</code> is currently active (<code>true</code>)
		 * 	or not (<code>false</code>).
		 * 
		 *  @default true
		 */
		function get active():Boolean;
		function set active(value:Boolean):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether a <code>Uiobjects</code> defines
		 * 	it focus state itself (<code>true</code>) or not (<code>false</code>).
		 * 	The way the auto focus state is applied depends on the specified
		 *  <code>Uiobjects</code>.
		 * 
		 *  @default false
		 */
		function get autoFocus():Boolean;
		function set autoFocus(value:Boolean):void;
		
		/**
		 * 	If <code>autoHeight</code> is set to <code>true</code>, the <code>IUIObject</code>
		 * 	automatically adjusts its height.
		 * 	<p>If <code>autoHeight</code> and <code>autoWidth</code> are set to
		 * 	<code>true</code> the <code>autoSize</code> property is automatically
		 * 	set to <code>true</code>.</p>
		 * 
		 * 	@see #autoWidth
		 * 	@see #autoSize
		 */
		function get autoHeight():Boolean;
		function set autoHeight(value:Boolean):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether a <code>IUIObject</code>
		 * 	creates a simulated three-dimensional effect (<code>true</code>) or not
		 * 	(<code>false</code>). The effect rendered by the <code>autoRaise</code>
		 *  property is similar to the effect rendered by the <code>raise</code> property.
		 *  The way the auto raise state is rendered depends on the specified
		 * 	<code>IUIObject</code>.
		 *  
		 *  @default false
		 * 
		 *  @see #raise
		 */
		function get autoRaise():Boolean;
		function set autoRaise(value:Boolean):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether a <code>IUIObject</code>
		 * 	sets it size itself (<code>true</code>) or not(<code>false</code>).
		 * 	The way the <code>autoSize</code> is applyed depends on the specified
		 * 	<code>IUIObject</code>.
		 *  
		 *  @default false
		 *  @see #width
		 *  @see #height
		 *  @see #resize()
		 */
		function get autoSize():Boolean;
		function set autoSize(value:Boolean):void;
		
		/**
		 * 	If <code>autoWidth</code> is set to <code>true</code>, the <code>IUIObject</code>
		 * 	automatically adjusts its width.
		 * 	<p>If <code>autoHeight</code> and <code>autoWidth</code> are set to
		 * 	<code>true</code> the <code>autoSize</code> property is automatically
		 * 	set to <code>true</code>.</p>
		 * 
		 * 	@see #autoWidth
		 * 	@see #autoSize
		 */
		function get autoWidth():Boolean;
		function set autoWidth(value:Boolean):void;
		
		/**
		 *  Sets or gets the alpha transparency of the background.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code> (fully opaque).
		 *  The Look and Feel class of a specified <code>IUIObject</code> specifies if this object
		 * 	has a visual background and / or if the background alpha transparency can be set.
		 * 
		 *  @default 1
		 * 
		 *  @see #alpha
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function get backgroundAlpha():Number;
		function set backgroundAlpha(value:Number):void;
		
		/**
		 *  Sets or gets the background color for this <code>IUIObject</code>.
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
		 *  <p>The following code shows different ways to render uiobjects with the same color:
		 * 		<listing version="3.0">
		 * 			var myWin1:Window = new Window();
		 * 			myWin1.color = "violet";
		 * 			myWin1.display();<br />
		 * 			var myWin2:Window = new Window();
		 * 			myWin2.color = 0xEE82EE;
		 * 			myWin2.display(50, 50);<br />
		 * 			var myWin3:Window = new Window();
		 * 			myWin3.color = 15631086;
		 * 			myWin3.display(100, 100);
		 * 		</listing>
		 * 	</p>
		 *  <p>Most of the time, the default value is returned by the
		 * 	<code>lookAndFeel.getBackgroundColor()</code> property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 *  @see #borderColor
		 *  @see #colors
		 *  @see #alpha
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function get backgroundColor():*;
		function set backgroundColor(value:*):void;
		
		/**
		 * 	Not implemented yet.
		 * 
		 *  @default null
		 */
		function get backface():Sprite;
		
		/**
		 * 	Not implemented yet.
		 * 
		 *  @see #backface
		 *  @see org.flashapi.swing.managers.TextureManager
		 * 	@default null
		 */
		function get backfaceTextureManager():TextureManager;
		
		/**
		 *  A <code>Boolean</code> that indicates whether the gradient mode of the 
		 * 	the background <code>TextureManager</code> is activated (<code>true</code>)
		 * 	or not (<code>false</code>).
		 * 
		 * 	<p>If the <code>backgroundGradientMode</code> property is set to <code>true</code>
		 * 	the <code>texture</code> property of the background <code>TextureManager</code> is
		 * 	automatically set to <code>null</code>.</p>
		 *  
		 *  @default false
		 * 
		 *  @see #backgroundGradientProperties
		 *  @see #backgroundTexture
		 *  @see #backgroundTextureManager
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		function get backgroundGradientMode():Boolean;
		function set backgroundGradientMode(value:Boolean):void;
		
		/**
		 *  A reference to the object returned by the <code>gradientProperties</code> of the
		 * 	background texture manager.
		 *  This object defines values that are used by the background texture manager to create
		 * 	gradient textures instead of plain colors for the <code>IUIObject</code> background.
		 * 
		 * 	<p>The Look and Feel class of a specified <code>IUIObject</code> determines 
		 * 	if this object is able to render a gradient background.</p>
		 * 
		 *  <p>Properties for the background gradient properties object are:
		 *  	<ul>
		 * 		<li><code>type:String</code>,</li>
		 * 		<li><code>colors:Array</code>,</li>
		 * 		<li><code>ratios:Array</code>,</li>
		 * 		<li><code>matrix:Matrix</code>,</li>
		 * 		<li><code>spreadMethod:String</code>,</li>
		 * 		<li><code>interpolationMethod:String</code>,</li>
		 * 		<li><code>focalPointRatio:Number</code>.</li>
		 * 		</ul>
		 * 	</p>
		 *
		 *  @see #backgroundGradientMode
		 *  @see #backgroundTexture
		 *  @see #backgroundTextureManager
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		function get backgroundGradientProperties():Object;
		function set backgroundGradientProperties(value:Object):void;
		
		/**
		 *  A reference to the <code>texture</code> property specified by the background
		 * 	<code>TextureManager</code> instance.
		 *
		 *  @see #backgroundGradientMode
		 *  @see #backgroundTextureManager
		 *  @see #backgroundGradientProperties
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		function get backgroundTexture():*;
		function set backgroundTexture(value:*):void;
		
		/**
		 *  Returns a reference to the background <code>TextureManager</code> instance for
		 * 	this <code>IUIObject</code>.
		 *
		 *  @see #backgroundGradientMode
		 *  @see #backgroundTexture
		 *  @see #backgroundGradientProperties
		 *  @see org.flashapi.swing.managers.TextureManager
		 * 
		 * 	@default null
		 */
		function get backgroundTextureManager():TextureManager;
		
		/**
		 * 	A value from the <code>BlendMode</code> class that specifies which blend mode to
		 * 	use with this <code>IUIObject</code> instance. See the <code>blendMode</code>
		 * 	property of the <code>DisplayObject</code> class for more information on how
		 * 	to use blend mode within Flash Player.
		 * 
		 * 	@default BlendMode.NORMAL
		 */
		function get blendMode():String;
		function set blendMode(value:String):void;
		
		/**
		 * 	Not yet implemented.
		 */
		function get bindedObject():*;
		
		/**
		 * 	@copy org.flashapi.swing.border.Border#borderAlpha
		 */
		function get borderAlpha():Number;
		function set borderAlpha(value:Number):void;
		
		/**
		 *  Sets or gets the border color for this <code>IUIObject</code>.
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
		 *  <p>The following code shows different ways to render uiobjects with the same color:
		 * 		<listing version="3.0">
		 * 			var myWin1:Window = new Window();
		 * 			myWin1.color = "violet";
		 * 			myWin1.display();<br />
		 * 			var myWin2:Window = new Window();
		 * 			myWin2.color = 0xEE82EE;
		 * 			myWin2.display(50, 50);<br />
		 * 			var myWin3:Window = new Window();
		 * 			myWin3.color = 15631086;
		 * 			myWin3.display(100, 100);
		 * 		</listing>
		 * 	</p>
		 *  <p>Most of the time, the default value is returned by the
		 * 	<code>lookAndFeel.getBorderColor()</code> property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 *  @see #color
		 *  @see #colors
		 *  @see #alpha
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function get borderColor():*;
		function set borderColor(value:*):void;
		
		/**
		 * 	A <code>ColorState</code> object. The <code>borderColors</code> property sets and gets
		 * 	the border color of the <code>IUIObject</code> for each state of the object.
		 * 	<code>ColorState</code> instances define five different states:
		 * 	<ul>
		 * 		<li><code>ColorState.disabled</code>,</li>
		 * 		<li><code>ColorState.down</code>,</li>
		 * 		<li><code>ColorState.over</code>,</li>
		 *  	<li><code>ColorState.up</code>.</li>
		 * 	</ul>
		 * 	<p>Valid values for each state are the same as valid values used to define
		 * 	the <code>color</code> property. The default value for each state is The
		 *  <code>StateObjectValue.NONE</code> constant. To unset a color state value, use the 
		 * 	<code>StateObjectValue.NONE</code> constant.</p>
		 * 
		 * 	@default null
		 *  
		 *  @see #color
		 *  @see #borderColor
		 * 	@see org.flashapi.swing.state.ColorState
		 * 	@see org.flashapi.swing.constants.StateObjectValue
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	
		 */
		function get borderColors():ColorState;
		function set borderColors(value:ColorState):void;
		
		/**
		 *	@copy org.flashapi.swing.border.Border#borderWidth
		 */
		function get borderWidth():Number;
		function set borderWidth(value:Number):void;
		
		/**
		 *	@copy org.flashapi.swing.border.Border#bottomRightCorner
		 */
		function get bottomRightCorner():Number;
		function set bottomRightCorner(value:Number):void;
		
		/**
		 *	@copy org.flashapi.swing.border.Border#bottomLeftCorner
		 */
		function get bottomLeftCorner():Number;
		function set bottomLeftCorner(value:Number):void;
		
		/**
		 *  Returns a <code>Rectangle</code> instance that defines the <code>IUIObject</code>
		 * 	real boundaries. <code>IUIObject</code> real boundaries include the area filled by
		 * 	the glow or shadow effects.
		 * 
		 * 	<p><strong>This property is still under development.</strong></p>
		 * 
		 * 	@see #glow
		 * 	@see #shadow
		 */
		function get boundaries():Rectangle;
		
		/**
		 * 	Specifies the button mode of this <code>IUIObject</code>. If <code>true</code>, this
		 * 	<code>IUIObject</code> behaves as a button, which means that it triggers the display
		 *  of the hand cursor when the mouse passes over the <code>IUIObject</code> and can
		 * 	receive a click event if the enter or space keys are pressed when the
		 * 	<code>IUIObject</code> has focus.
		 */
		function get buttonMode():Boolean;
		function set buttonMode(value:Boolean):void;
		
		/**
		 *  If <code>true</code>, Flash Player caches an internal bitmap representation of the
		 * 	<code>IUIObject</code>.
		 * 
		 *  @default false
		 */
		function get cacheAsBitmap():Boolean;
		function set cacheAsBitmap(value:Boolean):void;
		
		/**
		 *  The <code>className</code> property sets or returns the CSS class attribute of a
		 * 	<code>IUIObject</code>.
		 * 
		 * 	<p><strong>Note that class names are not case-sensitive.</strong></p>
		 * 
		 *  @default ""
		 */
		function get className():String;
		function set className(value:String):void;
		
		/**
		 *  The <code>ColorState</code> object for this <code>IUIObject</code>. Some
		 * 	<code>IUIObject</code>, such as <code>Button</code> instances, use a 
		 *  <code>ColorState</code> object to define a new color for each state:
		 *  <ul>
		 * 		<li><code>ColorState.disabled,</code></li>
		 * 		<li><code>ColorState.down,</code></li>
		 * 		<li><code>ColorState.over,</code></li>
		 *  	<li><code>ColorState.up.</code></li>
		 * 	</ul>
		 * 
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are the
		 * 	same as valid values used to define the <code>color</code> property.
		 * 	The default value for each  state is the <code>StateObjectValue.NONE</code> constant.
		 * 	To unset a color state value, use the <code>StateObjectValue.NONE</code> constant.</p>
		 *  
		 *  @see #color
		 *  @see #borderColor
		 *  @see #glowColor
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		function get colors():ColorState;
		function set colors(value:ColorState):void;
		
		/**
		 *  The <code>IUIObject</code> color. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 *  <p>The following code shows different ways to render a <code>IUIObject</code> with the same color:
		 * 		<listing version="3.0">
		 * 			var myWin1:Window = new Window();
		 * 			myWin1.color = "violet";
		 * 			myWin1.display();<br />
		 * 			var myWin2:Window = new Window();
		 * 			myWin2.color = 0xEE82EE;
		 * 			myWin2.display(50, 50);<br />
		 * 			var myWin3:Window = new Window();
		 * 			myWin3.color = 15631086;
		 * 			myWin3.display(100, 100);
		 * 		</listing>
		 * 	</p>
		 *  <p>Most of the time, the default value is returned by the <code>lookAndFeel.getColor()</code>
		 * 	property.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 *  @see #borderColor
		 *  @see #colors
		 *  @see #alpha
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function get color():*;
		function set color(value:*):void;
		
		/**
		 * 	Sets or gets the <code>constraints</code> object for this <code>IUIObject</code>. 
		 * 	The <code>constraints</code> object is used by some layout classes to express
		 * 	layout contraints for this <code>IUIObject</code>.
		 */
		function get constraints():Object;
		function set constraints(value:Object):void;
		
		/**
		 *  Returns a reference to the sprite container that displays the
		 * 	<code>IUIObject</code> instance.
		 */
		function get container():Sprite;
		
		/**
		 *  Returns a reference to the content sprite for the <code>IUIObject</code> instance.
		 * 	If the <code>IUIObject</code> instance does not heritate from the <code>IUIContainer</code>
		 * 	class, the value is <code>null</code>.
		 * 
		 * 	@default null
		 * 
		 *  @see org.flashapi.swing.core.IUIContainer
		 */
		function get content():Sprite;
		
		/**
		 *  Indicates the radius of <code>UIObjects</code> corners.
		 *  The default value depends on the class and the <code>IUIObject</code> Look and Feel;
		 *  if not overriden for the class, the default value is <code>NaN</code>.
		 * 
		 * 	<p>When you set the <code>cornerRadius</code> property, <code>topLeftCorder</code>,
		 * 	<code>topRightCorder</code>, <code>bottomLeftCorder</code> and <code>bottomRightCorder</code>
		 * 	properties are automatically set to <code>NaN</code>.</p>
		 * 
		 *  @see #topLeftCorner
		 *  @see #bottomLeftCorner
		 *  @see #topRightCorner
		 *  @see #bottomRightCorner
		 *  @see #setCornerRadiuses()
		 */
		function get cornerRadius():Number;
		function set cornerRadius(value:Number):void;
		
		/**
		 *  The <code>data</code> property lets you pass a value to the
		 * 	<code>IUIObject</code> instance.
		 * 
		 * 	@default null
		 */
		function get data():*;
		function set data(value:*):void;
		
		/**
		 * 	@private
		 * 
		 * 	Specifies whether the <code>IUIObject</code> receives doubleClick events.
		 * 	The default value is <code>false</code>, which means that by default an
		 * 	<code>IUIObject</code> instance does not receive <code>doubleClick</code> events.
		 * 
		 *  <p>The <code>mouseEnabled</code> property must also be set to <code>true</code>, 
		 *  its default value, for the <code>IUIObject</code> to receive <code>doubleClick</code>
		 * 	events.</p>
		 * 	
		 * 	@default false
		 */
		function get doubleClickEnabled():Boolean;
		function set doubleClickEnabled(value:Boolean):void;
		
		/**
		 * 	Returns the default minimum width of the <code>IUIObject</code>.
		 * 
		 * 	@default 0
		 * 
		 *  @see #defaultMinHeight
		 */
		function get defaultMinWidth():Number;
		
		/**
		 * 	Returns the default minimum height of the <code>IUIObject</code>.
		 * 
		 * 	@default 0
		 * 
		 *  @see #defaultMinWidth
		 */
		function get defaultMinHeight():Number;
		
		/**
		 *  A value from the <code>DragConstraint</code> class that specifies which drag
		 * 	constraint to use. 
		 *  <p>If the specified <code>IUIObject</code> is allows to perform drag operations,
		 * 	you can use the <code>dragConstraint</code> property to define its behaviour
		 * 	when dragging:</p>
		 *  <ul>
		 * 		<li>if set to <code>DragConstraint.STAGE</code>, it is not possible to drag
		 * 			the <code>IUIObject</code> out of the visible area of the SWF,</li>
		 * 		<li>if set to <code>DragConstraint.FREE</code>, you can drag the <code>IUIObject</code>
		 * 		without any restriction.</li>
		 *  </ul>
		 *  <p>The following code shows the difference between the <code>DragConstraint.STAGE</code>
		 * 	and the <code>DragConstraint.FREE</code> settings:
		 * 		<listing version="3.0">
		 * 			var myWin1:Window = new Window();
		 * 			myWin1.dragConstraint = DragConstraint.STAGE;
		 * 			myWin1.display();<br />
		 * 			var myWin2:Window = new Window();
		 * 			// default value is DragConstraint.FREE;
		 * 			myWin2.display(50, 50);
		 * 		</listing>
		 * 	</p>
		 * 
		 * 	@default DragConstraint.FREE
		 * 
		 * 	@see org.flashapi.swing.constants.DragConstraint
		 */
		function get dragConstraint():String;
		function set dragConstraint(value:String):void;
		
		/**
		 *  The <code>draggable</code> property defines whether the <code>IUIObject</code>
		 * 	can be moved (<code>true</code>) or not (<code>false</code>).
		 *  
		 * 	@default false
		 * 
		 *  @see #startDrag()
		 *  @see #stopDrag()
		 */
		function get draggable():Boolean;
		function set draggable(value:Boolean):void;
		
		/**
		 *  Forces the <code>IUIObject</code> to be redrawn even if it is not currently
		 * 	displayed. By default, <code>UIObjects</code> are not redrawn while they
		 * 	are not displayed.
		 * 
		 * 	@default false
		 */
		function get forceRefresh():Boolean;
		function set forceRefresh(value:Boolean):void;
		
		/**
		 *  A <code>Boolean</code> value that specifies whether a <code>IUIObject</code> is enabled
		 * 	(<code>true</code>), or not (<code>false</code>).
		 *  When a <code>IUIObject</code> is disabled (the <code>enabled</code> property is set to
		 * 	<code>false</code>), it is still visible but cannot be clicked.
		 *  This property is useful if you want to disable parts of your navigation;
		 *  for example, you might want to disable a button in the currently displayed page so that
		 *  it can't be clicked and the page cannot be reloaded.
		 * 
		 * 	<p><strong>This property is not implemented yet by all <code>UIObjects</code>.</strong></p>
		 *  
		 *  @default true
		 */
		function get enabled():Boolean;
		function set enabled(value:Boolean):void;
		
		/**
		 *  Defines the effect played when the <code>remove()</code> method is called
		 *  and the <code>hasRemoveEffect</code> property is <code>true</code>.
		 *  <p>If the <code>hasRemoveEffect</code> property is <code>true</code> and you
		 * 	have not defined the <code>removeEffectRef</code> property,
		 *  the default effect used by the object is the "fade out" effect.</p>
		 *  
		 *  @default org.flashapi.swing.effect.FadeOut
		 * 
		 *  @see #displayEffectRef
		 *  @see #hasDisplayEffect
		 *  @see #hasRemoveEffect
		 *  @see org.flashapi.swing.effect.FadeOut
		 */
		function get removeEffectRef():Class;
		function set removeEffectRef(value:Class):void;
		
		/**
		 * 	Sets or gets the duration of the effect used by the <code>IUIObject</code>
		 * 	if the <code>hasRemoveEffect</code> property is set to <code>true</code>.
		 * 	If set to <code>NaN</code>, the effect duration is defined by the default
		 * 	duration of the current remove effect class.
		 * 
		 * 	@see #hasRemoveEffect
		 * 	@see #displayEffectDuration
		 * 
		 * 	@default NaN
		 */
		function get removeEffectDuration():Number;
		function set removeEffectDuration(value:Number):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether the <code>IUIObject</code>
		 * 	remove effect is rendering (<code>true</code>) or not(<code>false</code>).
		 *  
		 *  @default false
		 * 
		 *  @see #removeEffectRef
		 *  @see #hasRemoveEffect
		 */
		function get removeEffectIsRendering():Boolean;
		
		/**
		 *  Returns the <code>EventCollector</code> instance accessible
		 * 	through this <code>IUIObject</code>.
		 *  
		 *  @see org.flashapi.swing.event.EventCollector
		 */
		function get eventCollector():EventCollector;
		
		/**
		 *  If <code>true</code>, the height of the <code>IUIObject</code> take the same value as its
		 * 	parent container height, or layout-height if its parent is a <code>UIContainer</code>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #fixToParentWidth
		 */
		function get fixToParentHeight():Boolean;
		function set fixToParentHeight(value:Boolean):void;
		
		/**
		 *  If <code>true</code>, the width of the <code>IUIObject</code> take the same value as its
		 * 	parent container width, or layout-width if its parent is a <code>UIContainer</code>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #fixToParentHeight
		 */
		function get fixToParentWidth():Boolean;
		function set fixToParentWidth(value:Boolean):void;
		
		/**
		 *  Indicates the emphasized color value when the <code>IUIObject</code> has the focus.
		 *  Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 * 
		 * 	@default NaN
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		function get focusColor():*;
		function set focusColor(value:*):void;
		
		/**
		 *  A reference to the object returned by the <code>gradientProperties</code> of the
		 * 	texture manager.
		 *  This object defines values that are used by the texture manager to create
		 * 	gradient textures instead of plain colors for the <code>IUIObject</code>.
		 * 
		 * 	<p>The Look and Feel class of a specified <code>IUIObject</code> determines 
		 * 	if this object is able to render a gradient shape.</p>
		 * 
		 *  <p>Properties for the gradient properties object are:
		 *  	<ul>
		 * 		<li><code>type:String</code>,</li>
		 * 		<li><code>colors:Array</code>,</li>
		 * 		<li><code>ratios:Array</code>,</li>
		 * 		<li><code>matrix:Matrix</code>,</li>
		 * 		<li><code>spreadMethod:String</code>,</li>
		 * 		<li><code>interpolationMethod:String</code>,</li>
		 * 		<li><code>focalPointRatio:Number</code></li>
		 * 		</ul>
		 * 	</p>
		 *
		 *  @see #gradientMode
		 *  @see #texture
		 *  @see #textureManager
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		function get gradientProperties():Object;
		function set gradientProperties(value:Object):void;
		
		/**
		 *  Indicates wether the <code>IUIObject</code> glow effect is active (<code>true</code>)
		 * 	or not (<code>false</code>). The glow effect lets you apply a visual glow effect
		 * 	to a <code>IUIObject</code>.
		 *	
		 * <p>The glow effect uses the Flash <code>GlowFilter</code> class as part of its
		 * 	implementation. If you apply a glow effect to a <code>IUIObject</code>, you cannot
		 *  apply a <code>GlowFilter</code> or another glow effect to it.</p>
		 *
		 *  @default false
		 * 
		 *  @see #glowColor
		 *  @see #shadow
		 *  @see flash.filters.GlowFilter
		 */
		function get glow():Boolean;
		function set glow(value:Boolean):void;
		
		/**
		 *  The color of the glow effect applied to the <code>IUIObject</code>. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 */
		function get glowColor():*;
		function set glowColor(value:*):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether the gradient mode of the 
		 * 	the <code>TextureManager</code> is activated (<code>true</code>)
		 * 	or not (<code>false</code>).
		 * 
		 * 	<p>If the <code>gradientMode</code> property is set to <code>true</code>
		 * 	the <code>texture</code> property of the <code>TextureManager</code> is
		 * 	automatically set to <code>null</code>.</p>
		 *  
		 *  @default false
		 * 
		 *  @see #gradientProperties
		 *  @see #texture
		 *  @see #textureManager
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		function get gradientMode():Boolean;
		function set gradientMode(value:Boolean):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether the <code>IUIObject</code> has an effect
		 * 	when the <code>display()</code> is called (<code>true</code>), or not(<code>false</code>).
		 *  
		 *  @default false
		 * 
		 *  @see #removeEffectRef
		 *  @see #displayEffectRef
		 *  @see #hasRemovaEffect
		 *  @see org.flashapi.swing.effect.FadeIn
		 */
		function get hasDisplayEffect():Boolean;
		function set hasDisplayEffect(value:Boolean):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether the <code>IUIObject</code> has an effect
		 * 	when the <code>remove()</code> is called (<code>true</code>), or not(<code>false</code>).
		 *  
		 *  @default false
		 * 
		 *  @see #removeEffectRef
		 *  @see #displayEffectRef
		 *  @see #hasRemoveEffect
		 *  @see org.flashapi.swing.effect.FadeOut
		 */
		function get hasRemoveEffect():Boolean;
		function set hasRemoveEffect(value:Boolean):void;
		
		/**
		 *  Indicates the height of the <code>IUIObject</code>, in pixels.
		 * 
		 *  @see #width
		 */
		function get height():Number;
		function set height(value:Number):void;
		
		/**
		 *  The horizontal base line for objects that define this property.
		 * 
		 * 	<p><strong>This property is not implemented yet.</strong></p>
		 * 
		 *  @default 0
		 * 
		 *  @see #verticalBaseLine
		 */
		function get horizontalBaseLine():Number;
		
		/**
		 *  The <code>IUIObject</code> horizontal gap.
		 * 
		 *  @default 0
		 * 
		 *  @see #verticalGap
		 */
		function get horizontalGap():Number;
		function set horizontalGap(value:Number):void;
		
		/**
		 * 	Gets or sets the <code>IUIObject</code> identifier. The ID must be unique in a document,
		 * 	and is often used to retrieve a <code>IUIObject</code> by using the
		 * 	<code>UIManager.document.getElementByID()</code> method.
		 * 
		 * 	<p><strong>Note: </strong>identifiers are cas insensitive. If you create an object with
		 * 	<code>"myId"</code> as identifier and another with <code>"myID"</code> as identifier,
		 * 	an exception will be thrown.</p>
		 * 
		 * 	<p>To dedelete the <code>IUIObject</code> unique ID, you must set the <code>id</code>
		 * 	property to <code>null</code>.</p>
		 * 
		 *  @default null
		 * 
		 * 	@see #guid
		 * 
		 *  @throws org.flashapi.swing.exceptions.AlreadyBoundException A <code>AlreadyBoundException</code> 
		 * 			if the ID already exist.
		 */
		function get id():String;
		function set id(value:String):void;
		
		/**
		 * 	Returns an object that represents the Genuine Unique IDentifier of
		 * 	the <code>IUIObject</code>. Contrary to the <code>id</code> property,
		 * 	<code>GUIDs</code> cannot be set by users or developers.
		 * 
		 * 	<p>This property is unique and is automatically generated by the SPAS 3.0
		 * 	framework, each time a new <code>IUIObject</code> instance is created.</p>
		 * 
		 * 	@see #id
		 * 	@see org.flashapi.swing.crypto.GUID
		 */
		function get guid():GUID;
		
		/**
		 * 	Returns the current index of the <code>IUIObject</code>. The index is often
		 * 	used by <code>Listable</code> objects to return the <code>IUIObject</code> position
		 * 	into the list.
		 * 
		 * 	@see org.flashapi.swing.list.Listable
		 * 
		 *  @default -1
		 */
		function get index():int;
		
		/**
		 * 	Indicates whether the <code>IUIObject</code> can be redrawn (<code>false</code>) or not
		 * 	(<code>true</code>) when the SPAS 3.0 framework performs a visual update to this
		 * 	component.
		 * 
		 *  @default false
		 */
		function get invalidateRefresh():Boolean;
		function set invalidateRefresh(value:Boolean):void;
		
		/**
		 * 	The <code>layoutPosition</code> property indicates wether a <code>IUIObject</code>
		 * 	has a <code>static</code> or <code>absolute</code> position in the current layout flow of its parent container.
		 * <ul>
		 * 		<li>A <code>IUIObject</code> with a <code>static</code> positioning always has
		 * 		the position which is defined by its parent container. (A static <code>IUIObject</code>
		 * 		ignores <code>x</code>, <code>y</code> or <code>move()</code> declarations).</li>
		 * 		<li>A <code>IUIObject</code> with an <code>absolute</code> positioning is placed at
		 * 		the coordinates relative to its containing block. That means the position is specified by the
		 * 		<code>x</code> and <code>y</code> properties, or the <code>move()</code> method.</li>
		 * 	</ul>
		 * 
		 * 	<p><strong>This property is not implemented yet.</strong></p>
		 * 
		 *  @default LayoutPosition.STATIC
		 * 
		 * 	@see org.flashapi.swing.constants.LayoutPosition
		 */
		function get layoutPosition():String;
		function set layoutPosition(value:String):void;
		
		/**
		 *  The <code>margin</code> shorthand property sets all the margin properties
		 * 	in one declaration.
		 * 
		 *  @default NaN
		 * 
		 *  @see #marginLeft
		 *  @see #marginTop
		 * 	@see #marginRight
		 * 	@see #marginBottom
		 */
		function get margin():Number;
		function set margin(value:Number):void;
		
		/**
		 *  The <code>marginLeft</code> property sets the left margin of a <code>IUIObject</code>.  
		 *
		 *  @default 0
		 * 
		 *  @see #marginTop
		 * 	@see #marginRight
		 * 	@see #marginBottom
		 */
		function get marginLeft():Number;
		function set marginLeft(value:Number):void;
		
		/**
		 *  The <code>marginTop</code> property sets the top margin of a <code>IUIObject</code>.    
		 *
		 *  @default 0
		 * 
		 * 	@see #marginLeft
		 * 	@see #marginRight
		 * 	@see #marginBottom
		 */
		function get marginTop():Number;
		function set marginTop(value:Number):void;
		
		/**
		 *  The <code>marginRight</code> property sets the right margin of a <code>IUIObject</code>.    
		 *
		 *  @default 0
		 * 
		 *  @see #marginTop
		 * 	@see #marginLeft
		 * 	@see #marginBottom
		 */
		function get marginRight():Number;
		function set marginRight(value:Number):void;
		
		/**
		 *  The <code>marginBottom</code> property sets the right margin of a <code>IUIObject</code>.    
		 *
		 *  @default 0
		 * 
		 *  @see #marginTop
		 * 	@see #marginLeft
		 * 	@see #marginRight
		 */
		function get marginBottom():Number;
		function set marginBottom(value:Number):void;
		
		/**
		 *  A <code>IUIObject</code> can be masked by the specified mask object.
		 *  To ensure that masking works when the <code>Stage</code> is scaled, the mask
		 *  display object must be in an active part of the display list.
		 *  <p>The mask object itself is not drawn. Set the <code>mask</code> to <code>null</code>
		 * 	to remove the mask object.</p>
		 */
		function get mask():DisplayObject;
		function set mask(value:DisplayObject):void;
		
		/**
		 * 	A <code>Number</code> that specifies the minimum width of the <code>IUIObject</code>, in pixels.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see #minHeight
		 * 
		 *  @throws org.flashapi.swing.exceptions.IllegalArgumentException An <code>IllegalArgumentException</code>
		 * 			if the value of the <code>width</code> property is smaller than the default minimum width.
		 */
		function get minWidth():Number;
		function set minWidth(value:Number):void;
		
		/**
		 * 	A <code>Number</code> that specifies the minimum height of the <code>IUIObject</code>, in pixels.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see #minWidth
		 * 
		 *  @throws org.flashapi.swing.exceptions.IllegalArgumentException An <code>IllegalArgumentException</code> 
		 * 			if the value of the <code>height</code> property is smaller than the default minimum height.
		 */
		function get minHeight():Number;
		function set minHeight(value:Number):void;
		
		/**
		 *  Indicates the instance name of the <code>IUIObject</code>.
		 */
		function get name():String;
		function set name(value:String):void;
		
		/**
		 *  The <code>padding</code> shorthand property sets all padding properties
		 * 	in one declaration. 
		 * 
		 *  @default NaN
		 * 
		 *  @see #setPadding()
		 *  @see #paddingBottom
		 *  @see #paddingTop
		 * 	@see #paddingRight
		 * 	@see #paddingLeft
		 */
		function get padding():Number;
		function set padding(value:Number):void;
		
		/**
		 *  The <code>paddingBottom</code> property sets the bottom padding of a <code>IUIObject</code>.
		 *
		 *  @default NaN
		 * 
		 *  @see #setPadding()
		 *  @see #paddingTop
		 * 	@see #paddingRight
		 * 	@see #paddingLeft
		 */
		function get paddingBottom():Number;
		function set paddingBottom(value:Number):void;
		
		/**
		 *  The <code>paddingLeft</code> property sets the left padding of a <code>IUIObject</code>.
		 *
		 *  @default NaN
		 * 
		 *  @see #setPadding()
		 *  @see #paddingTop
		 * 	@see #paddingRight
		 * 	@see #paddingBottom
		 */
		function get paddingLeft():Number;
		function set paddingLeft(value:Number):void;
		
		/**
		 *  The <code>paddingRight</code> property sets the right padding of a <code>IUIObject</code>.  
		 *
		 *  @default NaN
		 * 
		 *  @see #setPadding()
		 *  @see #paddingTop
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 */
		function get paddingRight():Number;
		function set paddingRight(value:Number):void;
		
		/**
		 *  The <code>paddingTop</code> property sets the top padding of a <code>IUIObject</code>.  
		 *
		 *  @default NaN
		 * 
		 *  @see #setPadding()
		 * 	@see #paddingRight
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 */
		function get paddingTop():Number;
		function set paddingTop(value:Number):void;
		
		/**
		 *  Returns a reference to the <code>DisplayObjectContainer</code> that contains
		 * 	the <code>IUIObject</code>. To set a new parent <code>DisplayObjectContainer</code>
		 *  use the <code>target</code> property.
		 *  <p>You can use parent to move up multiple levels in the <code>IUIObject</code>
		 * 	display list.</p>
		 * 
		 *  @see #target
		 */
		function get parent():DisplayObjectContainer;
		
		/**
		 * 	A <code>Number</code> that specifies the height of a <code>IUIObject</code> as a percentage
		 * 	of its parent container size.
		 * 	Allowed values are <code>0</code> (no height) to <code>100</code> (full height).
		 * 	<p>Setting the <code>height</code> or <code>fixToParentHeight</code> properties
		 * 	resets this property to <code>NaN</code>.</p>
		 * 
		 * 	@default NaN
		 * 
		 *  @see #percentWidth
		 */
		function get percentHeight():Number;
		function set percentHeight(value:Number):void;
		
		/**
		 * 	A <code>Number</code> that specifies the width of a <code>IUIObject</code> as a percentage
		 * 	of its parent container size.
		 * 	Allowed values are <code>0</code> (no width) to <code>100</code> (full width).
		 * 	<p>Setting the <code>width</code> or <code>percentWidth</code> properties
		 * 	resets this property to <code>NaN</code>.</p>
		 * 
		 * 	@default NaN
		 * 
		 *  @see #percentHeight
		 */
		function get percentWidth():Number;
		function set percentWidth(value:Number):void;
		
		/**
		 *  Returns a <code>Point</code> that indicates the (x,y) coordinates of
		 * 	the <code>IUIObject</code> relative to the local coordinates of its parent
		 * 	<code>DisplayObjectContainer</code>. 
		 * 
		 *  @see #x
		 *  @see #y
		 *  @see #globalPosition
		 */
		function get position():Point;
		
		/**
		 *  Returns a <code>Point</code> that indicates the (x,y) coordinates
		 * 	of the <code>IUIObject</code> relative to its parent container (local)
		 * 	converted to the <code>Stage</code> coordinates (global). 
		 * 
		 *  @see #x
		 *  @see #y
		 *  @see #position
		 */
		function get globalPosition():Point;
		
		/**
		 *  A value from the <code>Quality</code> class that specifies
		 * 	the level of quality to use to render the <code>IUIObject</code>.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li><code>Quality.BEST</code>,</li>
		 * 		<li><code>Quality.HIGH</code>,</li>
		 * 		<li><code>Quality.MEDIUM</code>,</li>
		 * 		<li><code>Quality.LOW</code>.</li>
		 * 	</ul>
		 * 
		 * 	<p>This property is only implemented by the <code>Window</code> class
		 * 	at the moment.</p>
		 * 
		 * 	@default Quality.HIGH
		 * 
		 *  @see org.flashapi.swing.constants.Quality
		 * 	@see org.flashapi.swing.Window
		 */
		function get quality():String;
		function set quality(value:String):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether the <code>IUIObject</code> has a
		 * 	simulated three-dimensional effect (<code>true</code>) or not (<code>false</code>).
		 * 	The effect rendered by the <code>raise</code> property is similar to the effect 
		 *  rendered by the <code>autoRaise</code> property. The way the raise effect is
		 *  rendered depends on the specified <code>IUIObject</code>.
		 *  
		 *  @default false
		 * 
		 *  @see #autoRaise
		 */
		function get raise():Boolean;
		function set raise(value:Boolean):void;
		
		/**
		 *  Indicates if the reflection effect is active (<code>true</code>) or not (<code>false</code>);
		 *  The reflection effect lets you apply a visual reflect effect to a <code>IUIObject</code>.
		 *	
		 * <p>The reflection effect uses the <code>DistortFX</code> class as part of its implementation.
		 *  For more information, see the <code>org.flashapi.swing.fx.basicfx.DistortFX</code> class.
		 *  If you apply a <code>DistortFX</code> effect to a <code>IUIObject</code>, you cannot apply a
		 *  <code>DistortFX</code> or a second reflection effect to it.</p>
		 * 
		 * 	<p>The <code>Distortion</code> class is a port of the "Sandy 3D" <code>DistortImage</code> class.
		 *  Sandy is an intuitive and user-friendly 3D open-source library developed 
		 *  by Thomas Pfeiffer.
		 *  <br />
		 *  For more information see the <a href="http://www.flashsandy.org/">Sandy Web site</a>.</p>
		 *
		 *  @default false
		 * 
		 *  @see #reflectProperties
		 *  @see org.flashapi.swing.fx.basicfx.Reflection
		 *  @see org.flashapi.swing.fx.basicfx.DistortFX
		 *  @see org.flashapi.swing.geom.distort.Distortion
		 *  @see http://www.flashsandy.org/
		 */
		function get reflection():Boolean;
		function set reflection(value:Boolean):void;
		
		/**
		 *  Indicates the rotation of the <code>IUIObject</code> instance, in degrees, from its
		 * 	original orientation. Values from <code>0</code> to <code>180</code> represent
		 * 	clockwise rotation; values from <code>0</code> to <code>-180</code> represent
		 *  counterclockwise rotation. Values outside this range are added to or subtracted
		 *  from <code>360</code> to obtain a value within the range.
		 * 
		 *  @default 0
		 */
		function get rotation():Number;
		function set rotation(value:Number):void;
		
		/**
		 *  Indicates the horizontal scale (percentage) of the <code>IUIObject</code> as applied
		 * 	from the registration point. The default registration point is <code>(0,0)</code>.
		 * 	<code>1.0</code> equals 100% scale. 
		 *  <p>Scaling the local coordinate system affects the <code>x</code> and <code>y</code>
		 * 	properties settings, which are defined in whole pixels.</p>
		 *
		 *  @default 1.0
		 */
		function get scaleX():Number;
		function set scaleX(value:Number):void;
		
		/**
		 *  Indicates the vertical scale (percentage) of the <code>IUIObject</code> as applied
		 * 	from the registration point. The default registration point is <code>(0,0)</code>. 
		 * 	<code>1.0</code> equals 100% scale. 
		 *  <p>Scaling the local coordinate system affects the <code>x</code> and <code>y</code>
		 * 	properties settings, which are defined in whole pixels.</p>
		 *
		 *  @default 1.0
		 */
		function get scaleY():Number;
		function set scaleY(value:Number):void;
		
		/**
		 *  Indicates wether the <code>IUIObject</code> shadow effect is active (<code>true</code>),
		 * 	or not (<code>false</code>). The shadow effect lets you apply a visual shadow effect
		 * 	to a <code>IUIObject</code> instance.
		 *	
		 * <p>The glow effect uses the Flash <code>DropShadowFilter</code> class as part of its
		 * 	implementation. If you apply a shadow effect to a <code>IUIObject</code>, you cannot
		 *  apply a <code>DropShadowFilter</code> or another shadow effect to it.</p>
		 *
		 *  @default false
		 * 
		 *  @see #glow
		 *  @see flash.filters.DropShadowFilter
		 */
		function get shadow():Boolean;
		function set shadow(value:Boolean):void;
		
		/**
		 *  This property is used to check whether the <code>IUIObject</code> has been added to the 
		 *  SPAS 3.0 display list (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		function get displayed():Boolean;
		
		/**
		 *  Define the effect played when the <code>display()</code> method is called
		 *  and the <code>hasDisplayEffect</code> property is <code>true</code>.
		 *  <p>If <code>hasDisplayEffect</code> property is <code>true</code> and the
		 * 	<code>displayEffectRef</code> property is not defined, the default effect
		 * 	used by the <code>IUIObject</code> is the "fade in" effect.</p>
		 *  
		 *  @default org.flashapi.swing.effect.FadeIn
		 * 
		 *  @see #removeEffectRef
		 *  @see #hasRemoveEffect
		 *  @see #hasDisplayEffect
		 *  @see org.flashapi.swing.effect.FadeIn
		 */
		function get displayEffectRef():Class;
		function set displayEffectRef(value:Class):void;
		
		/**
		 * 	Sets or gets the duration of the effect used by the <code>IUIObject</code>
		 * 	when the <code>hasDisplayEffect</code> property is set to <code>true</code>.
		 * 	If set to <code>NaN</code>, the effect duration is defined by the default
		 * 	duration of the current display effect class.
		 * 
		 * 	@see #hasDisplayEffect
		 * 	@see #removeEffectDuration
		 */
		function get displayEffectDuration():Number;
		function set displayEffectDuration(value:Number):void;
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the <code>IUIObject</code> display
		 * 	effect is rendering (<code>true</code>) or not(<code>false</code>).
		 *  
		 *  @default false
		 * 
		 *  @see #displayEffect
		 *  @see #hasDisplayEffect
		 */
		function get displayEffectIsRendering():Boolean;
		
		/**
		 * 	Returns a reference to the <code>Effect</code> instance used by the
		 * 	<code>IUIObject</code> display effect mechanism.
		 * 
		 * 	@default A <code>FadeIn</code> effect instance.
		 * 
		 * 	@see org.flashapi.swing.effect.FadeIn
		 * 	@see #removeEffect
		 */
		function get displayEffect():Effect;
		
		/**
		 * 	Returns a reference to the <code>Effect</code> instance used by the
		 * 	<code>IUIObject</code> remove effect mechanism.
		 * 
		 * 	@default A <code>FadeOut</code> effect instance.
		 * 
		 * 	@see org.flashapi.swing.effect.FadeOut
		 * 	@see #displayEffect
		 */
		function get removeEffect():Effect;
		
		/**
		 * 	Returns the CSS selector value of the <code>IUIObject</code>.
		 * 
		 * 	@default Selectors.UIOBJECT
		 */
		function get selector():String;
		
		/**
		 *  A reference to the object that contains the specified <code>IUIObject</code>.
		 *  <p>The <code>target</code> property can either be a <code>DisplayObjectContainer</code> or
		 *  a <code>UIContainer</code> subclass.</p>
		 * 
		 *  @see #parent
		 */
		function get target():*
		function set target(value:*):void
		
		/**
		 *  Several <code>UIObjects</code>, such as buttons, windows, etc., use a <code>Textfield</code>
		 *  instance todisplay the plain text specified by the <code>label</code> or <code>text</code>
		 * 	properties. The <code>textField</code> returns a reference to this <code>Textfield</code>
		 * 	instance when it exists.
		 *
		 *  @default null
		 */
		function get textField():TextField;
		
		/**
		 *  The <code>textTransform</code> property controls the letters displayed
		 * 	within a <code>IUIObject</code>.
		 * 	<p>Possible values are constants defined by the <code>TextTransformType</code> class:
		 * 	<br />
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>Value</th>
		 * 			<th>Description</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td><code>TextTransformType.NONE</code></td>
		 * 			<td>Default. Defines normal text, with lower case letters and capital letters</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>TextTransformType.CAPITALIZE</code></td>
		 * 			<td>Each word in a text starts with a capital letter</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>TextTransformType.UPPERCASE</code></td>
		 * 			<td>Defines only capital letters</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>TextTransformType.LOWERCASE</code></td>
		 * 			<td>Defines no capital letters, only lower case letters</td>
		 * 		</tr>
		 * 	</table> 
		 * 	</p>
		 * 
		 * 	@default TextTransformType.NONE
		 * 
		 * 	@see org.flashapi.swing.constants.TextTransformType
		 */
		function get textTransform():String;
		function set textTransform(value:String):void;
		
		/**
		 *  A reference to the <code>texture</code> property of the <code>TextureManager</code>
		 * 	instance.
		 *
		 *  @see #gradientMode
		 *  @see #textureManager
		 *  @see #gradientProperties
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		function get texture():*;
		function set texture(value:*):void;
		
		/**
		 *  A reference to the <code>TextureManager</code> instance for this <code>IUIObject</code>.
		 *
		 *  @see #gradientMode
		 *  @see #texture
		 *  @see #gradientProperties
		 *  @see org.flashapi.swing.managers.TextureManager
		 * 
		 * 	@default null
		 */
		function get textureManager():TextureManager;
		
		/**
		 *	@copy org.flashapi.swing.border.Border#topLeftCorner
		 */
		function get topLeftCorner():Number;
		function set topLeftCorner(value:Number):void;
		
		/**
		 *	@copy org.flashapi.swing.border.Border#topRightCorner
		 */
		function get topRightCorner():Number;
		function set topRightCorner(value:Number):void;
		
		/**
		 *  Sets or gets the <code>Transform</code> object with properties pertaining to a
		 * 	<code>IUIObject</code> matrix, color transform, and pixel bounds.
		 *  The specific properties — <code>matrix</code>, <code>colorTransform</code>,
		 * 	and three read-only properties (<code>concatenatedMatrix</code>, <code>concatenatedColorTransform</code>,
		 * 	and <code>pixelBounds</code>) — are described in the entry for the <code>flash.geom.Transform</code>
		 * 	class.
		 *  <p>Each of the transform <code>IUIObject</code> properties is itself an object.
		 * 	This concept is important because the only way to set new values for the
		 * 	<code>matrix</code> or <code>colorTransform</code> objects is to create a new object
		 * 	and copy that object into the <code>transform.matrix</code> or <code>transform.colorTransform</code>
		 * 	properties.</p>
		 */
		function get transform():Transform;
		function set transform(value:Transform):void;
		
		/**
		 * 	Returns the type of the calling form element for this <code>IUIObject</code> 
		 * 	when it is used as a <code>Form</code> element.
		 * 	<p>Possible values are <code>FormItemType</code> class constants.</p>
		 * 
		 *  @default null
		 * 
		 * 	@see org.flashapi.swing.Form
		 * 	@see org.flashapi.swing.constants.FormItemType
		 */
		function get type():String;
		
		/**
		 *  The vertical base line for objects that define this property.
		 * 
		 * 	<p><strong>This property is not implemented yet.</strong></p>
		 * 
		 *  @default 0
		 * 
		 *  @see #horizontalBaseLine
		 */
		function get verticalBaseLine():Number;
		
		/**
		 *  The <code>IUIObject</code> vertical gap.
		 * 
		 *  @default 0
		 * 
		 *  @see #horizontalGap
		 */
		function get verticalGap():Number;
		function set verticalGap(value:Number):void;
		
		/**
		 *  A <code>Boolean</code> that indicates whether or not the <code>IUIObject</code> is visible.
		 * 	<code>IUIObject</code> that are not visible are disabled. For example, if
		 * 	<code>visible = false</code> for a <code>Button</code> instance, it cannot be clicked.
		 */
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		/**
		 *  Indicates the width of the <code>IUIObject</code>, in pixels.
		 * 
		 *  @see #height
		 */
		function get width():Number;
		function set width(value:Number):void;
		
		/**
		 *  Indicates the x coordinate of the <code>IUIObject</code> relative to the local
		 * 	coordinates of the parent <code>DisplayObjectContainer</code>.
		 *
		 *  @default 0
		 */
		function get x():Number;
		function set x(value:Number):void;
		
		/**
		 *  Indicates the y coordinate of the <code>IUIObject</code> relative to the local
		 * 	coordinates of the parent <code>DisplayObjectContainer</code>. 
		 * 
		 * 	@default 0
		 */
		function get y():Number;
		function set y(value:Number):void;
		
		//--------------------------------------------------------------------------
		//
		//  methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  <strong>[Deprecated]</strong> Creates an internal visual representation of the
		 * 	<code>IUIObject</code>.
		 */
		function cacheUIObject():void
		
		/**
		 *  Displays the <code>IUIObject</code> at the specified (x,y) coordinates relative
		 * 	to the local coordinates of the parent <code>DisplayObjectContainer</code>.
		 * 	If the <code>hasDisplayEffect</code> property is <code>true</code>, the
		 * 	<code>IUIObject</code> is rendered through the current start effect to be displayed.
		 * 	<p>If coordinate parameters are not set, <code>IUIObject</code> uses (0,0) as
		 * 	default coordinates.</p>
		 * 
		 * 	@param	x Indicates the x coordinate of the <code>IUIObject</code>.
		 * 			Default value is <code>undefined</code>.
		 * 	@param	y Indicates the y coordinate of the <code>IUIObject</code>.
		 * 			Default value is <code>undefined</code>.
		 * 
		 * 	@see #remove()
		 * 	@see #hasDisplayEffect
		 * 	@see #displayEffectRef
		 */
		function display(x:Number = undefined, y:Number = undefined):void;
		
		/**
		 *  Draws the backface of the specified <code>IUIObject</code>.
		 * 	<p><strong>This method is not implemented yet.</strong></p>
		 * 	
		 *  @return A reference to the backface <code>Sprite</code> instance
		 * 	used to draw the uiobject <code>IUIObject</code>.
		 */
		function drawBackface():Sprite;
		
		/**
		 * 	Returns a rectangle that defines the area of the <code>IUIObject</code> relative to the
		 * 	coordinate system of the <code>targetCoordinateSpace</code> property.
		 * 	<p>The <code>getBounds()</code> method is similar to the <code>getRect()</code> method; however,
		 * 	the <code>Rectangle</code> returned by the <code>getBounds()</code> method includes any strokes
		 * 	on shapes, whereas the <code>Rectangle</code> returned by the <code>getRect()</code>
		 * 	method does not.</p>
		 * 
		 * 	@param	The display object that defines the coordinate system to use.
		 *	@return The rectangle that defines the area of the <code>IUIObject</code> relative to the
		 * 			<code>targetCoordinateSpace</code> object coordinate system.
		 * 
		 * 	@see #getRect()
		 */
		function getBounds(targetCoordinateSpace:DisplayObject):Rectangle;
		
		/**
		 * 	Returns the fully qualified class name of a <code>IUIObject</code>. 
		 * 
		 * 	@return A string containing the fully qualified class name. 
		 */
		function getQualifiedClassName():String;
		
		/**
		 * 	Returns the fully qualified class name of the base class of a <code>IUIObject</code>.
		 * 
		 * 	@return A fully qualified base class name, or null if none exists. 
		 */
		function getQualifiedSuperclassName():String;
		
		/**
		 * 	Returns a rectangle that defines the boundary of the <code>IUIObject</code>, based on the
		 * 	coordinate system defined by the <code>targetCoordinateSpace</code> parameter, excluding
		 * 	any strokes on shapes. The values that the <code>getRect()</code> method returns are the
		 * 	same or smaller than those returned by the <code>getBounds()</code> method.
		 * 
		 * 	@param	The display object that defines the coordinate system to use.
		 * 	@return The rectangle that defines the area of the <code>IUIObject</code> relative to the
		 * 			<code>targetCoordinateSpace</code> object coordinate system.
		 * 
		 * 	@see #getBounds()
		 */
		function getRect(targetCoordinateSpace:DisplayObject):Rectangle;
		
		/**
		 * 	Returns the current version of the SPAS 3.0 Framework.
		 * 
		 * 	@return A string that represent the current version of the SPAS 3.0 Framework.
		 */ 
		function getVersion():String;
		
		/**
		 * 	Evaluates the display object to see if it overlaps or intersects
		 * 	with the <code>obj</code> display object (or the <code>obj</code> <code>IUIObject</code>).
		 * 
		 * @param	obj The display object or the <code>IUIObject</code> to test against.
		 * @return	<code>true</code> if the display objects (or the <code>IUIObject</code>)
		 * 			intersect; <code>false</code> if not.
		 */
		function hitTestObject(obj:DisplayObject):Boolean;
		
		/**
		 * 	Moves this <code>IUIObject</code> instance to the specified <code>x</code> 
		 * 	and <code>y</code> coordinates.
		 * 
		 *  @param 	The new x-position for this <code>IUIObject</code> instance,
		 * 			in pixels.
		 * 	@param 	The new y-position for this <code>IUIObject</code> instance,
		 * 			in pixels.
		 */
		function move(x:Number, y:Number):void;
		
		/**
		 * Redraws the <code>IUIObject</code>. 
		 */
		function redraw():void;
		
		/**
		 *  Removes the <code>IUIObject</code> from its parent <code>DisplayObjectContainer</code>.
		 * 	If the <code>hasRemoveEffect</code> property is <code>true</code>, the <code>IUIObject</code>
		 * 	plays the current end effect before being removed. 
		 * 
		 * 	@see #display()
		 * 	@see #hasRemoveEffect
		 * 	@see #removeEffectRef
		 * 	@see #finalize()
		 */
		function remove():void;
		
		/**
		 * 	Resizes the <code>IUIObject</code> with the specified <code>width</code>
		 * 	and <code>height</code>.
		 * 
		 * 	@param The new width for this object, in pixels.
		 * 	@param The new height for this object, in pixels.
		 */
		function resize(width:Number, height:Number):void;
		
		/**
		 *  The <code>setPadding()</code> method defines the space between the <code>IUIObject</code>
		 * 	bounds and the element content. It is similar that separately using <code>paddingTop</code>,
		 * 	<code>paddingRight</code>, <code>paddingBottom</code> and <code>paddingLeft</code> properties.
		 * 
		 *  @param	Sets the <code>paddingTop</code> property of the <code>IUIObject</code>.
		 *  @param	Sets the <code>paddingRight</code> property of the <code>IUIObject</code>.
		 *  @param	Sets the <code>paddingBottom</code> property of the <code>IUIObject</code>.
		 *  @param	Sets the <code>paddingLeft</code> property of the <code>IUIObject</code>.
		 * 
		 * 	@see #padding
		 * 	@see #paddingTop
		 * 	@see #paddingRight
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 */
		function setPadding(top:Number = NaN, right:Number = NaN, bottom:Number = NaN, left:Number = NaN):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
         * 	Sets the component to the specified <code>width</code> and <code>height</code>.
		 * 	This method is implemented to allow SPAS 3.0 <code>IUIObject</code> to
		 * 	be shared as Flash components
         *
         * 	@param width The width of the component, in pixels.
         * 	@param height The height of the component, in pixels.
		 */
		function setSize(width:Number, height:Number):void;
		
		/**
		 * Displays the <code>IUIObject</code> over all of other objects into its parent container. 
		 */
		function setToTopLevel():void;
		
		/**
		 * 	Lets the user drag the specified <code>IUIObject</code>. The <code>IUIObject</code> remains
		 * 	draggable until explicitly stopped through a call to the <code>stopDrag()</code> method,
		 * 	or until another <code>IUIObject</code> is made draggable.
		 * 	Only one <code>IUIObject</code> is draggable at a time. 
		 * 
		 * 	@param	Specifies whether the draggable <code>IUIObject</code> is locked to the center
		 * 			of the mouse position (<code>true</code>), or locked to the point where the user
		 * 			first clicked the <code>IUIObject</code> (<code>false</code>).
		 * 	@param	Value relative to the coordinates of the <code>IUIObject</code> parent that specifies
		 * 			a constraint rectangle or the <code>IUIObject</code>.
		 * 
		 *	@see #draggable
		 *	@see #stopDrag()
		 */
		function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void;
		
		/**
		 * 	Ends the <code>startDrag()</code> method. A <code>IUIObject</code> that was made draggable
		 * 	with the <code>startDrag()</code> method remains draggable until a <code>stopDrag()</code>
		 * 	method is added, or until another <code>IUIObject</code> becomes draggable.
		 * 	Only one <code>IUIObject</code> is draggable at a time.
		 * 
		 *	@see #draggable
		 *	@see #startDrag()
		 */
		function stopDrag():void;
		
		/**
		 * 	Sets the <code>Radius</code> of <code>IUIObject</code> corners with different
		 * 	values.The default value for each corner radius depends on its own implementation
		 * 	and its Look and Feel;
		 *  if not overriden for the class, the default value is <code>NaN</code>.
		 * 	
		 * 	<p>When you use the <code>setCornerRadiuses</code> method, the
		 * 	<code>cornerRadius</code> property is automatically set to <code>NaN</code>.</p>
		 * 
		 * 	@param	topLeft		the radius for the top left corner.
		 * 	@param	topRight	the radius for the top right corner.
		 * 	@param	bottomRight	the radius for the bottom right corner.
		 * 	@param	bottomLeft	the radius for the bottom left corner.
		 * 
		 * 	@see #topLeftCorner
		 *  @see #bottomLeftCorner
		 *  @see #topRightCorner
		 *  @see #bottomRightCorner
		 * 	@see #cornerRadius
		 */
		function setCornerRadiuses(topLeft:Number, topRight:Number, bottomRight:Number, bottomLeft:Number):void;
		
		//--------------------------------------------------------------------------
		//
		//  Look and Feel management
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets a new Look and Feel to be used during the lifetime of the <code>IUIObject</code>,
		 * 	and updates others <code>IUIObject</code> from the same LAF class accordingly.
		 * 	<p><strong>The <code>setLaf()</code> method do not changes <code>IUIObject</code> Look and Feel
		 * 	that have been locked by using the <code>lockLaf()</code> method.</strong></p>
		 * 
		 *	<span class="hide">
		 * 
		 * 		//--> <strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 		Overriden IUIObject.setLaf methods should the follow the
		 * 		IUIObject.setLaf method algorithm to ensure proper functioning of
		 * 		the SPAS 3.0 L&amp;F support.
		 * 
		 * 		IUIObject.setLaf method algorithm:
		 * 		- Check if the value parameter is a class object that implements
		 * 		the LookAndFeel interface. (Use the LAFValidator.validate or the
		 * 		IUIObject.validateLaf methods).
		 * 		- Set the laf property of the constructor instance with the value
		 * 		parameter. (Use IUIObject.setLafRef method).
		 * 		- Calls the lookAndFeel.onChange() method. (Use the IUIObject.setNewLaf
		 * 		method).
		 * 		- Creates a new LookAndfeel instance from the constructor "laf"
		 * 		property and set it to the lookAndFeel property. Then, set the
		 * 		parameter IUIObject.isLafProtected to false. (Use the
		 * 		IUIObject.setNewLaf method).
		 * 		- (Optional) Check if the the uiobject uses the default Laf colors.
		 * 		(Use IUIObject.fixDefaultLafColors method).
		 * 		- If the IUIObject.invalidateLafUpdate property is set to false,
		 * 		change look and fell for all uiobjects registred into the constructor
		 * 		Observable object. (Use the IUIObject.notifyLafChanges method).
		 * 		- If the IUIObject.invalidateLafEvent property is set to false,
		 * 		dispatch an UIOEvent.LAF_CHANGED event for this uiobject.
		 * 		(Use the IUIObject.dispatchLafChangedEvent method).
		 * 
		 * 	</span>
		 * 	
		 * 	@param	The Look and Feel to be used to render the <code>IUIObject</code>.
		 * 
		 * 	@see #lookAndFeel
		 *  @see #getLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function setLaf(value:Object):void;
		
		/**
		 * 	Locks the <code>IUIObject</code> apparence with the specified Look and Feel.
		 * 	<p><strong>Contrary to the <code>setLaf()</code> method, the <code>lockLaf()</code> method
		 * 	only changes the Look and Feel of the specified <code>IUIObject</code>.<br />
		 * 	When you use the <code>setLaf()</code> method with others <code>UIObjects</code>,
		 * 	the L&amp;F of the locked <code>IUIObject</code> does not change.<br />
		 *  To unlock the <code>IUIObject</code> L&amp;F, use the <code>unlockLaf()</code>
		 * 	method.</strong></p>
		 * 
		 * 	@param value The L&amp;F to use to lock the <code>IUIObject</code> Look and Feel.
		 * 	@param autoUnlock A <code>Boolean</code> that indicates whether the <code>unlockLaf</code> 
		 * 					method must be called first to re-lock the <code>IUIObject</code>
		 * 					Look and Fell (<code>false</code>), or not (<code>true</code>).
		 * 
		 * 	@see #lookAndFeel
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #unlockLaf()
		 */ 
		function lockLaf(value:Object, autoUnlock:Boolean = false):void;
		
		/**
		 * 	Unlock the Look and Feel of the specified <code>IUIObject</code> and replaces it by
		 * 	the current L&amp;F class.
		 * 	<p><strong>If you had not used the <code>lockLaf()</code> before calling the
		 * 	<code>unlockLaf()</code> method, the <code>IUIObject</code> is redrawn and rendered
		 * 	using its current L&amp;F.</strong></p>
		 * 
		 * 	@see #lookAndFeel
		 *  @see #getLaf()
		 *  @see #lockLaf()
		 *  @see #setLaf()
		 */
		function unlockLaf():void;
		
		/**
		 * 	Returns a reference to the <code>IUIObject</code> Look and Feel (L&amp;F) class.
		 * 	<p><strong>When you use the <code>lockLaf()</code> method, the L&amp;F of the
		 * 	<code>IUIObject</code> instance class and the <code>IUIObject</code> L&amp;F are
		 * 	not the same.</strong></p>
		 * 
		 * 	@return The current <code>IUIObject</code> L&amp;F class reference.
		 * 
		 * 	@see #lookAndFeel
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function getLafRef():Class;
		
		/**
		 * 	Returns a reference to the <code>IUIObject</code> default Look and Feel (L&amp;F) class.
		 * 
		 * 	@return The default <code>IUIObject</code> L&amp;F class reference.
		 * 
		 * 	@see #lookAndFeel
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function getDefaultLafRef():Class;
		
		/**
		 * 	Returns a reference to the Look and Feel (L&amp;F) of the specified <code>IUIObject</code>.
		 * 
		 * 	@return The current L&amp;F of the specified uiobject.
		 * 
		 * 	@see #lookAndFeel
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function getLaf():Object;
		
		/**
		 *  Indicates whether the <code>IUIObject</code> Look and Feel (L&amp;F) can be set (<code>false</code>)
		 *  or not (<code>true</code>).
		 *  The <code>lafProtected</code> is set to 
		 * 	<ul>
		 * 	<li><code>true</code> when you call the <code>lockLaf()</code> method,</li>
		 * 	<li>is set to <code>false</code> when the <code>unlockLaf()</code> is called.</li>
		 * 	</ul>
		 * 	<p>When a <code>IUIObject</code> is <code>lafProtected</code>, the <code>setLaf()</code> method does not
		 *  interact with it.</p>
		 *  
		 *  @default false
		 * 
		 *  @see #lookAndFeel
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		function get lafProtected():Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  Skin management
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  A <code>Boolean</code> that indicates whether the <code>IUIObject</code>
		 * 	look and feel is programmatically defined (<code>false</code>),
		 * 	or is defined by a <code>Skinable</code> object (<code>true</code>).
		 *  
		 *  @default false
		 * 
		 * 	@see #skin
		 *  @see org.flashapi.swing.skin.Skinable
		 */
		function get hasSkinObject():Boolean;
		
		/**
		 * 	Sets or gets the <code>Skinable</code> object for this <code>IUIObject</code>.
		 * 
		 * 	@see #hasSkin
		 * 	@see org.flashapi.swing.skin.Skinable
		 */
		function get skin():Skinable;
		function set skin(value:Skinable):void;
		
		//--------------------------------------------------------------------------
		//
		//  Debuging API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Displays expressions, or writes to log files, while debugging. A single
		 * 	print statement can support multiple arguments. If any argument in a print
		 * 	statement includes a data type other than a <code>String</code>, the print
		 * 	function invokes the associated <code>toString()</code> method for that
		 * 	data type.
		 * 
		 * 	<p>The <code>print()</code> method is equivalent to the <code>UIManager.print()</code>
		 * 	methods.</p>
		 * 
		 * 	<p>This method is useful for developers who create their own components
		 * 	and/or complex applications by extending SPAS 3.0 native objects.</p>
		 * 
		 * 	@see org.flashapi.swing.UIManager#print()
		 * 
		 * 	@param	...arguments One or more (comma separated) expressions to evaluate.
		 * 	For multiple expressions, a space is inserted between each expression in
		 * 	the output.
		 */
		function print(...arguments):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 	Returns a reference to the <code>UIManager</code> <code>Debugger</code> object.
		 */
		function get debugger():Debugger;
	}
}