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
	//  UIObject.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.5.1, 17/03/2011 03:09
	 *  @see http://www.flashapi.org/
	 */
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import flash.utils.Timer;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.color.ColorUtil;
	import org.flashapi.swing.constants.DragConstraint;
	import org.flashapi.swing.constants.LayoutPosition;
	import org.flashapi.swing.constants.Quality;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.TextTransformType;
	import org.flashapi.swing.containers.IMainContainer;
	import org.flashapi.swing.containers.IUIContainer;
	import org.flashapi.swing.core.crypto.GUID;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.dnd.DnDFormat;
	import org.flashapi.swing.dnd.DragAndDrop;
	import org.flashapi.swing.effect.Effect;
	import org.flashapi.swing.effect.FadeIn;
	import org.flashapi.swing.effect.FadeOut;
	import org.flashapi.swing.Element;
	import org.flashapi.swing.event.EffectEvent;
	import org.flashapi.swing.event.SpasEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.exceptions.AlreadyBoundException;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.framework.Debugger;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.fx.basicfx.Reflection;
	import org.flashapi.swing.fx.ReflecProperties;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.skin.Skinable;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.ui.analytics.AnalitycsInteractiveObject;
	import org.flashapi.swing.ui.analytics.Analytics;
	import org.flashapi.swing.ui.analytics.AnalyticsObject;
	import org.flashapi.swing.util.Observable;
	import org.flashapi.swing.util.RangeChecker;
	
	use namespace spas_internal;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when a new value is set to the <code>data</code> property of
	 * 	this <code>UIObject</code>.
	 * 
	 * 	<p>The <code>dataChanged</code> event is not dispatched until after the
	 * 	property changes.</p>
	 *
	 *  @eventType org.flashapi.swing.event.SpasEvent.DATA_CHANGED
	 */
	[Event(name = "dataChanged", type = "org.flashapi.swing.event.SpasEvent")]
	
	/**
	 * 	<b>Deprecated</b>.
	 *  <p>Dispatched by a <code>UIObject</code> only when the the <code>resize()</code>
	 * 	method, is called.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.RESIZED
	 */
	[Event(name = "resized", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched when the <code>startDrag()</code> method is called on this
	 * 	<code>UIObject</code>.
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.DRAG_START
	 */
	[Event(name = "dragStart", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched when the <code>stopDrag()</code> method is called on this
	 * 	<code>UIObject</code>.
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.DRAG_STOP
	 */
	[Event(name = "dragStop", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched when the <code>UIObject</code> has finished its construction and
	 * 	has all initialization properties set.
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.INITIALIZED
	 */
	[Event(name = "initialized", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched each time a new Look and Feel is set to this <code>UIObject</code>
	 * 	instance. To set a new Look and Feel use the <code>setLaf()</code>, 
	 * 	<code>lockLaf()</code> and	<code>unlockLaf()</code> methods.
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.LAF_CHANGED
	 */
	[Event(name = "lafChanged", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched when the <code>UIObject</code> is removed from a container
	 * 	as a content element by using the <code>removeElement()</code>,
	 * 	<code>removeElementAt()</code>, <code>removeAllElements()</code>,
	 * 	<code>finalizeElement()</code>, or <code>finalizeAllElements()</code> methods;
	 * 	it is also dispatched when calling the <code>remove()</code> method 
	 * 	of the <code>UIObject</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.REMOVED
	 */
	[Event(name = "removed", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched when the <code>UIObject</code> is displayed within the
	 * 	Flash Player display list as a container content element by using
	 * 	the <code>addElement()</code>, <code>addElementAt()</code>,
	 * 	<code>addGraphicElements()</code> methods; it is also dispatched when
	 * 	calling the <code>display()</code> method of the <code>UIObject</code>
	 * 	instance.
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.DISPLAYED
	 */
	[Event(name = "displayed", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched each time a <code>UIObject</code> is redrawn due to
	 * 	modifications of its properties. You can force a <code>UIObject</code>
	 * 	to be redrawn by calling the <code>draw()</code> method.
	 * 
	 * 	<p>The <code>changed</code> event is not dispatched if the
	 * 	<code>UIObject</code> is not displayed within the Flash Player
	 * 	display list.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIOEvent.CHANGED
	 */
	[Event(name = "changed", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched each time the <code>UIObject</code> gets the focus.
	 *
	 *  @eventType org.flashapi.swing.event.FocusEvent.FOCUS_IN
	 */
	[Event(name = "focusIn", type = "org.flashapi.swing.event.FocusEvent")]
	
	/**
	 *  Dispatched each time the <code>UIObject</code> looses the focus.
	 *
	 *  @eventType org.flashapi.swing.event.FocusEvent.FOCUS_OUT
	 */
	[Event(name = "focusOut", type = "org.flashapi.swing.event.FocusEvent")]
	
	/**
	 *  Dispatched each time this <code>UIObject</code> is resized.
	 * 
	 * 	<p>You can resize the <code>UIObject</code> by setting the <code>width</code> or
	 * 	<code>height</code> property, by calling the <code>resize()</code> method,
	 * 	or by setting one of the following properties either on the <code>UIObject</code>
	 * 	or on other objects such that a nested <code>Layout</code> instance needs 
	 *  to change the <code>width</code> or <code>height</code> properties of
	 * 	this object: </p>
	 * 
	 * 	<ul>
	 * 		<li>minWidth</li>
	 * 		<li>minHeight</li>
	 * 		<li>percentWidth</li>
	 * 		<li>percentHeight</li>
	 * 		<li>fixToParentWidth</li>
	 * 		<li>fixToParentHeight</li>
	 * 	</ul>
	 * 
	 * 	<p>The <code>metricsChanged</code> event is not dispatched until after the
	 * 	property changes.</p>
	 *
	 * 	<p>The <code>metricsChanged</code> is not dispatched when the
	 * 	<code>invalidateMetricsChanges</code> property is set to <code>true</code>.</p>
	 * 
	 *  @eventType org.flashapi.swing.event.UIObjectEvent.METRICS_CHANGED
	 */
	[Event(name = "metricsChanged", type = "org.flashapi.swing.event.UIOEvent")]
	
	/**
	 *  Dispatched when the user clicks the <code>UIObject</code> instance.
	 * 
	 * 	<p>This event will only be dispatched when there are one or more relevant
	 * 	listeners attached to the dispatching object.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIMouseEvent.CLICK
	 */
	[Event(name = "click", type = "org.flashapi.swing.event.UIMouseEvent")]
	
	/**
	 *  Dispatched when the user double clicks the <code>UIObject</code> instance.
	 * 
	 * 	<p>This event will only be dispatched when there are one or more relevant
	 * 	listeners attached to the dispatching object.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIMouseEvent.DOUBLE_CLICK
	 */
	[Event(name = "doubleClick", type = "org.flashapi.swing.event.UIMouseEvent")]
	
	/**
	 *  Dispatched when the user presses outside the bounds of the <code>UIObject</code>
	 * 	instance.
	 * 
	 * 	<p>This event will only be dispatched when there are one or more relevant
	 * 	listeners attached to the dispatching object.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIMouseEvent.PRESS_OUTSIDE
	 */
	[Event(name = "pressOutside", type = "org.flashapi.swing.event.UIMouseEvent")]
	
	/**
	 *  Dispatched when the user presses the <code>UIObject</code> instance.
	 * 
	 * 	<p>This event will only be dispatched when there are one or more relevant
	 * 	listeners attached to the dispatching object.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIMouseEvent.PRESS
	 */
	[Event(name = "press", type = "org.flashapi.swing.event.UIMouseEvent")]
	
	/**
	 *  Dispatched when the user presses the <code>UIObject</code> instance and
	 * 	releases the mouse button outside the bounds of the object.
	 * 
	 * 	<p>This event will only be dispatched when there are one or more relevant
	 * 	listeners attached to the dispatching object.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIMouseEvent.RELEASE_OUTSIDE
	 */
	[Event(name = "releaseOutside", type = "org.flashapi.swing.event.UIMouseEvent")]
	
	/**
	 *  Dispatched when the user rolls over the <code>UIObject</code> instance.
	 * 
	 * 	<p>This event will only be dispatched when there are one or more relevant
	 * 	listeners attached to the dispatching object.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIMouseEvent.ROLL_OVER
	 */
	[Event(name = "rollOver", type = "org.flashapi.swing.event.UIMouseEvent")]
	
	/**
	 *  Dispatched when the user rolls out of the <code>UIObject</code> instance.
	 * 
	 * 	<p>This event will only be dispatched when there are one or more relevant
	 * 	listeners attached to the dispatching object.</p>
	 *
	 *  @eventType org.flashapi.swing.event.UIMouseEvent.ROLL_OUT
	 */
	[Event(name = "rollOut", type = "org.flashapi.swing.event.UIMouseEvent")]
	
	/**
	 *  The <code>UIObject</code> class is the base class for all SPAS&#xA0;3.0
	 * 	visual objects. This class should be considered as an abstract class, so
	 * 	it means that you should not create new <code>UIObject</code> instance.
	 *  
	 *  <p>To use the methods and properties defined by the <code>UIObject</code>
	 * 	class, you call them directly from whichever SPAS&#xA0;3.0 visual classes
	 * 	you are using. For example, to call the <code>UIObject.move()</code> method
	 * 	from the <code>Window</code> class, you would write the following code:</p>
	 * 
	 *  <listing version="3.0">
	 * 		var myWindow:Window = new Window();
	 *  	myWindow.display(10, 50);
	 * 		myWindow.move(130, 130);
	 *  </listing>
	 * 
	 * <p><strong><code>UIObject</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">alpha</code></td>
	 * 			<td>Sets the alpha transparency value of the object.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>alpha</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">background-color</code></td>
	 * 			<td>Sets the color of the object background.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>backgroundColor</code></td>
	 * 			<td><code>Properties.BACKGROUND_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">gradient-background-colors</code></td>
	 * 			<td>Sets the gradient colors of the object background.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).
	 * 			Colors must be separated by a "white space" delimiter.</td>
	 * 			<td><code>backgroundGradientProperties.colors</code></td>
	 * 			<td><code>Properties.GRADIENT_BACKGROUND_COLORS</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">background-opacity</code></td>
	 * 			<td>Sets the opacity of the object background.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>backgroundAlpha</code></td>
	 * 			<td><code>Properties.BACKGROUND_OPACITY</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">border-color</code></td>
	 * 			<td>Sets the border color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>borderColor</code></td>
	 * 			<td><code>Properties.BORDER_COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">color</code></td>
	 * 			<td>Sets the color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>color</code></td>
	 * 			<td><code>Properties.COLOR</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">glow</code></td>
	 * 			<td>Indicates whether the glow effect of the object is activated, or not.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td><code>glow</code></td>
	 * 			<td><code>Properties.GLOW</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">glow-color</code></td>
	 * 			<td>Sets the glow effect color for this object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>glowColor</code></td>
	 * 			<td><code>Properties.GLOW_COLOR</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">gradient</code></td>
	 * 			<td>Indicates whether the object has plain or gradient colors.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td><code>gradientMode</code></td>
	 * 			<td><code>Properties.GRADIENT</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">gradient-background</code></td>
	 * 			<td>Indicates whether the object background has plain or gradient colors.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td><code>backgroundGradientMode</code></td>
	 * 			<td><code>Properties.GRADIENT_BACKGROUND</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">gradient-colors</code></td>
	 * 			<td>Sets the gradient colors of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).
	 * 			Colors must be separated by a "white space" delimiter.</td>
	 * 			<td><code>gradientProperties.colors</code></td>
	 * 			<td><code>Properties.GRADIENT_COLORS</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">height</code></td>
	 * 			<td>Sets the height of the object.</td>
	 * 			<td>Recognized values are : positive numbers, percentages
	 * 			(e.g. <code class="css">90%</code>), <code class="css">auto</code>,
	 * 			<code class="css">none</code> and <code class="css">parent</code>.</td>
	 * 			<td><code>height</code></td>
	 * 			<td><code>Properties.HEIGHT</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">horizontal-gap</code></td>
	 * 			<td>Sets the horizontal gap value for this object.</td>
	 * 			<td>Possible values are valid numbers.</td>
	 * 			<td><code>horizontalGap</code></td>
	 * 			<td><code>Properties.HORIZONTAL_GAP</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">margin</code></td>
	 * 			<td>Sets the margin value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>margin</code></td>
	 * 			<td><code>Properties.MARGIN</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">margin-left</code></td>
	 * 			<td>Sets the left margin value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>marginLeft</code></td>
	 * 			<td><code>Properties.MARGIN_LEFT</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">margin-right</code></td>
	 * 			<td>Sets the right margin value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>marginRight</code></td>
	 * 			<td><code>Properties.MARGIN_RIGHT</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">margin-top</code></td>
	 * 			<td>Sets the top margin value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>marginTop</code></td>
	 * 			<td><code>Properties.MARGIN_TOP</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">margin-bottom</code></td>
	 * 			<td>Sets the bottom margin value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>marginBottom</code></td>
	 * 			<td><code>Properties.MARGIN_BOTTOM</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">opacity</code></td>
	 * 			<td>Sets the alpha transparency value of the object.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>alpha</code></td>
	 * 			<td><code>Properties.OPACITY</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">padding</code></td>
	 * 			<td>Sets the padding value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>padding</code></td>
	 * 			<td><code>Properties.PADDING</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">padding-left</code></td>
	 * 			<td>Sets the left padding value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>paddingLeft</code></td>
	 * 			<td><code>Properties.PADDING_LEFT</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">padding-right</code></td>
	 * 			<td>Sets the right padding value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>paddingRight</code></td>
	 * 			<td><code>Properties.PADDING_RIGHT</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">padding-top</code></td>
	 * 			<td>Sets the top padding value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>paddingTop</code></td>
	 * 			<td><code>Properties.PADDING_TOP</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">padding-bottom</code></td>
	 * 			<td>Sets the padding value for this object.</td>
	 * 			<td>Valid values are positive and negative numbers.</td>
	 * 			<td><code>paddingBottom</code></td>
	 * 			<td><code>Properties.PADDING_BOTTOM</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">reflect</code></td>
	 * 			<td>Indicates whether the reflection effect of the object is activated, or not.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td><code>reflection</code></td>
	 * 			<td><code>Properties.REFLECTION</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">shadow</code></td>
	 * 			<td>Indicates whether the shadow effect of the object is activated, or not.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td><code>shadow</code></td>
	 * 			<td><code>Properties.SHADOW</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">size</code></td>
	 * 			<td>Indicates whether the object manages its size itself, or not.</td>
	 * 			<td>Recognized values are <code class="css">auto</code> or <code class="css">none</code>.</td>
	 * 			<td><code>autoSize</code></td>
	 * 			<td><code>Properties.SIZE</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">width</code></td>
	 * 			<td>Sets the width of the object.</td>
	 * 			<td>Recognized values are : positive numbers, percentages
	 * 			(e.g. <code class="css">90%</code>), <code class="css">auto</code>,
	 * 			<code class="css">none</code> and <code class="css">parent</code>.</td>
	 * 			<td><code>width</code></td>
	 * 			<td><code>Properties.WIDTH</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">texture</code></td>
	 * 			<td>Sets a texture for this object.</td>
	 * 			<td>Must be a valid URI to an image file, or <code class="css">none</code>.</td>
	 * 			<td><code>texture</code> method.</td>
	 * 			<td><code>Properties.TEXTURE</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">text-transform</code></td>
	 * 			<td>Sets the text transformation of the object.</td>
	 * 			<td>Valid values are <code class="css">none</code>, <code class="css">capitalize</code>,
	 * 			<code class="css">uppercase</code> and <code class="css">lowercase</code>.</td>
	 * 			<td><code>textTransform</code></td>
	 * 			<td><code>Properties.TEXT_TRANSFORM</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">visibility</code></td>
	 * 			<td>Sets the visibility of the object.</td>
	 * 			<td>Valid values are <code class="css">hidden</code> or
	 * 			<code class="css">visible</code>.</td>
	 * 			<td><code>visible</code></td>
	 * 			<td><code>Properties.VISIBILITY</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">vertical-gap</code></td>
	 * 			<td>Sets the vertical gap value for this object.</td>
	 * 			<td>Possible values are valid numbers.</td>
	 * 			<td><code>verticalGap</code></td>
	 * 			<td><code>Properties.VERTICAL_GAP</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UIObject extends Sprite implements IUIObject, DragAndDrop, AnalitycsInteractiveObject {
		
		//--> TODO: create the alt property (alternante text) for all uiobjects.
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  Constructor. Creates a new <code>UIObject</code> instance.
		 */
		public function UIObject() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The object that represents the settings of the reflect effect.
		 *  Default values for <code>ReflecProperties</code> instance are:
		 *  <ul>
		 * 		<li><code>alpha:Number = 0.5</code>,</li>
		 * 		<li><code>ratio:Number = 127</code>,</li>
		 * 		<li><code>gap:Number = 2</code>,</li>
		 * 		<li><code>interval:Number = -1</code>.</li>
		 * 	</ul>
		 *  
		 *  @see #reflect
		 *  @see org.flashapi.swing.fx.basicfx.Reflection
		 *  @see org.flashapi.swing.fx.ReflecProperties
		 */
		public var reflectProperties:ReflecProperties;
		
		/**
		 * 	@private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The <code>deactivateMetricsChanges</code> property is used by <code>Layout</code>
		 * 	objects to deactivate temporarily the <code>mectricsChanged</code> event 
		 * 	dispatched by this <code>UIObject</code>.
		 */
		spas_internal var deactivateMetricsChanges:Boolean = false;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	If <code>true</code>, the <code>UIObject</code> does not dispatch metrics event
		 * 	defined by the <code>UIOEvent.METRICS_CHANGED</code> event type.
		 */
		public var invalidateMetricsChanges:Boolean = false;
		
		/**
		 * 	Invalidate all buit-in effects for this <code>UIOBject</code>.
		 * 	<code>UIOBject</code> "start" and "end" effects are automatically
		 * 	cancelled by this method.
		 */
		public var invalidateEffects:Boolean = false;
		
		/**
		 * 	Indicates whether the CSS properties can be applied when a CSS unique
		 * 	Identifier is defined (<code>true</code>), or not (<code>false</code>).
		 * 	If set to <code>false</code>, all CSS properties are ignored,
		 * 	except those defined for the corresponding CSS Identifier, specified by
		 * 	the <code>id</code> property.
		 * 
		 * 	@default false
		 * 
		 *  @see #id
		 */
		public var cssOverridesIDProps:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override public function get alpha():Number {
			return spas_internal::uioSprite.alpha;
		}
		override public function set alpha(value:Number):void {
			spas_internal::uioSprite.alpha = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>altDelay</code> property.
		 * 
		 * 	@see #altDelay
		 */
		protected var $altDelay:uint = 500;
		/**
		 *  @inheritDoc
		 */
		public function get altDelay():uint {
			return $altDelay;
		}
		public function set altDelay(value:uint):void {
			$altDelay = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>active</code> property.
		 * 
		 * 	@see #active
		 */
		protected var $active:Boolean = true;
		/**
		 *  @inheritDoc
		 */
		public function get active():Boolean {
			return $active;
		}
		public function set active(value:Boolean):void {
			spas_internal::lafDTO.active = $active = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoFocus</code> property.
		 * 
		 * 	@see #autoFocus
		 */
		protected var $autoFocus:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get autoFocus():Boolean {
			return $autoFocus;
		}
		public function set autoFocus(value:Boolean):void {
			$autoFocus = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoHeight</code> property.
		 * 
		 * 	@see #autoHeight
		 */
		protected var $autoHeight:Boolean;
		/**
		 *  @inheritDoc
		 */
		public function get autoHeight():Boolean {
			return $autoHeight;
		}
		public function set autoHeight(value:Boolean):void {
			$autoHeight = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoRaise</code> property.
		 * 
		 * 	@see #autoRaise
		 */
		protected var $autoRaise:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get autoRaise():Boolean {
			return $autoRaise;
		}
		public function set autoRaise(value:Boolean):void {
			$autoRaise = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoSize</code> property.
		 * 
		 * 	@see #autoSize
		 */
		protected var $autoSize:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get autoSize():Boolean {
			return $autoSize;
		}
		public function set autoSize(value:Boolean):void {
			$autoSize = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>autoWidth</code> property.
		 * 
		 * 	@see #autoWidth
		 */
		protected var $autoWidth:Boolean;
		/**
		 *  @inheritDoc
		 */
		public function get autoWidth():Boolean {
			return $autoWidth;
		}
		public function set autoWidth(value:Boolean):void {
			$autoWidth = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>backgroundAlpha</code> property.
		 * 
		 * 	@see #backgroundAlpha
		 */
		protected var $backgroundAlpha:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get backgroundAlpha():Number {
			return $backgroundAlpha;
		}
		public function set backgroundAlpha(value:Number):void {
			spas_internal::lafDTO.backgroundAlpha = $backgroundAlpha = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>backgroundColor</code> property.
		 * 
		 * 	@see #backgroundColor
		 */
		protected var $backgroundColor:* = NaN;
		[Inspectable(defaultValue="#999999", name="backgroundColor", type="Color")]
		/**
		 *  @inheritDoc
		 */
		public function get backgroundColor():* {
			return $backgroundColor;
		}
		public function set backgroundColor(value:*):void {
			if (value == Color.DEFAULT) {
				spas_internal::useDefaultLafBackgroundColor = true;
				fixDefaultLafBackgroundColor();
			} else {
				spas_internal::lafDTO.backgroundColor = $backgroundColor = getColor(value);
				spas_internal::useDefaultLafBackgroundColor = false;
			}
			if (hasBackgroundTextureManager()) $backgroundTextureManager.color = $backgroundColor;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Not implemented yet.
		 * 	Stores the internal value for the <code>backface</code> property.
		 * 
		 * 	@see #backface
		 */
		protected var $backface:Sprite = null;
		/**
		 *  @inheritDoc
		 */
		public function get backface():Sprite {
			return $backface;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Not implemented yet.
		 * 	Stores the internal value for the <code>backfaceTextureManager</code> property.
		 * 
		 * 	@see #backfaceTextureManager
		 */
		protected var $backfaceTextureManager:TextureManager = null;
		/**
		 *  @inheritDoc
		 */
		public function get backfaceTextureManager():TextureManager {
			return $backfaceTextureManager;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>backgroundGradientMode</code> property.
		 * 
		 * 	@see #backgroundGradientMode
		 */
		protected var $backgroundGradientMode:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get backgroundGradientMode():Boolean {
			return $backgroundGradientMode;
		}
		public function set backgroundGradientMode(value:Boolean):void {
			if(hasBackgroundTextureManager() && value) $backgroundTextureManager.texture = null;
			$backgroundGradientMode = value;
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundGradientProperties():Object {
			return $backgroundTextureManager.gradientProperties;
		}
		public function set backgroundGradientProperties(value:Object):void {
			if (hasBackgroundTextureManager())
				$backgroundTextureManager.gradientProperties = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundTexture():* {
			return $backgroundTextureManager.texture;
		}
		public function set backgroundTexture(value:*):void { 
			if (!isNull(value)) $backgroundGradientMode = false; 
			$backgroundTextureManager.texture = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>backgroundTextureManager</code> property.
		 * 
		 * 	@see #backgroundTextureManager
		 */
		protected var $backgroundTextureManager:TextureManager = null;
		/**
		 *  @inheritDoc
		 */
		public function get backgroundTextureManager():TextureManager {
			return $backgroundTextureManager;
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get blendMode():String {
			return spas_internal::uioSprite.blendMode;
		}
		override public function set blendMode(value:String):void {
			spas_internal::uioSprite.blendMode = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var bindedObj:*;
		/**
		 *  @inheritDoc
		 */
		public function get bindedObject():* {
			return bindedObj;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderAlpha</code> property.
		 * 
		 * 	@see #borderAlpha
		 */
		protected var $borderAlpha:Number = NaN;
		[Inspectable(defaultValue="NaN", name="borderAlpha", type="Number")]
		/**
		 *  @inheritDoc
		 */
		public function get borderAlpha():Number {
			return $borderAlpha;
		}
		public function set borderAlpha(value:Number):void {
			spas_internal::lafDTO.borderAlpha = $borderAlpha = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderColor</code> property.
		 * 
		 * 	@see #borderColor
		 */
		protected var $borderColor:* = NaN;
		[Inspectable(defaultValue="#B6B9BB", name="borderColor", type="Color")]
		/**
		 *  @inheritDoc
		 */
		public function get borderColor():* {
			return $borderColor;
		}
		public function set borderColor(value:*):void {
			if (value == Color.DEFAULT) {
				spas_internal::useDefaultLafBorderColor = true;
				fixDefaultLafBorderColor();
				fixBorderColorState(StateObjectValue.NONE);
			} else {
				spas_internal::lafDTO.borderColor = $borderColor = getColor(value);
				spas_internal::useDefaultLafBorderColor = false;
				fixBorderColorState(value);
			}
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderColors</code> property.
		 * 
		 * 	@see #borderColors
		 */
		protected var $borderColors:ColorState;
		/**
		 *  @inheritDoc
		 */
		public function get borderColors():ColorState {
			return $borderColors;
		}
		public function set borderColors(value:ColorState):void {
			spas_internal::lafDTO.borderColors = $borderColors = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderWidth</code> property.
		 * 
		 * 	@see #borderWidth
		 */
		protected var $borderWidth:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderWidth():Number {
			return $borderWidth;
		}
		public function set borderWidth(value:Number):void {
			spas_internal::lafDTO.borderWidth = $borderWidth = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>bottomRightCorner</code> property.
		 * 
		 * 	@see #bottomRightCorner
		 */
		protected var $brc:Number =  NaN;
		/**
		 *  @inheritDoc
		 */
		public function get bottomRightCorner():Number {
			return $brc;
		}
		public function set bottomRightCorner(value:Number):void {
			spas_internal::lafDTO.bottomRightCorner = $brc = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>bottomLeftCorner</code> property.
		 * 
		 * 	@see #bottomLeftCorner
		 */
		protected var $blc:Number =  NaN;
		/**
		 *  @inheritDoc
		 */
		public function get bottomLeftCorner():Number {
			return $blc;
		}
		public function set bottomLeftCorner(value:Number):void {
			spas_internal::lafDTO.bottomLeftCorner = $blc = value;
			setRefresh();
		}
		
		/**
		 *  Returns a <code>Rectangle</code> instance that defines the <code>UIObject</code>
		 * 	real boundaries. <code>UIObject</code> real boundaries include the area filled by
		 * 	the glow or shadow effects.
		 * 
		 * 	<p><strong>This property is still under development.</strong></p>
		 * 
		 * 	@see #glow
		 * 	@see #shadow
		 */
		public function get boundaries():Rectangle {
			var filter:BitmapFilter;
			if($dropShadow) filter = SHADOW[0];
			else if($glowFilter) filter = GLOW[0];
			else return spas_internal::uioSprite.getBounds(spas_internal::uioSprite);
			if(!isNull(filter)) {
				var b:Rectangle = getBounds(null);
				var bmpData:BitmapData = new BitmapData(b.width + Math.abs(b.x), b.height + Math.abs(b.y));
				bmpData.draw(spas_internal::uioSprite);
				var r:Rectangle = bmpData.generateFilterRect(b, filter);
				bmpData.dispose();
				bmpData = null;
			}
			return r;
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get buttonMode():Boolean {
			return spas_internal::uioSprite.buttonMode;
		}
		override public function set buttonMode(value:Boolean):void {
			spas_internal::uioSprite.buttonMode = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get cacheAsBitmap():Boolean {
			return spas_internal::uioSprite.cacheAsBitmap;
		}
		override public function set cacheAsBitmap(value:Boolean):void {
			spas_internal::uioSprite.cacheAsBitmap = value;
		}
		
		private var _className:String = "";
		/**
		 *  @inheritDoc
		 */
		public function get className():String {
			return _className;
		}
		public function set className(value:String):void {
			_className = value.toLowerCase();
			//if(_displayed) $uiManager.cssManager.spas_internal::setCSS(this);
			$uiManager.cssManager.spas_internal::setCSS(this);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>colors</code> property.
		 * 
		 * 	@see #colors
		 */
		protected var $colors:ColorState;
		/**
		 *  @inheritDoc
		 */
		public function get colors():ColorState {
			return $colors;
		}
		public function set colors(value:ColorState):void {
			spas_internal::lafDTO.colors = $colors = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>color</code> property.
		 * 
		 * 	@see #color
		 */
		protected var $color:* = NaN;
		[Inspectable(defaultValue="#EAEAEA", name="color", type="Color")]
		/**
		 *  @inheritDoc
		 */
		public function get color():* {
			return $color;
		}
		public function set color(value:*):void {
			if (value == Color.DEFAULT) {
				spas_internal::useDefaultLafColor = true;
				fixDefaultLafColor();
				fixColorState(StateObjectValue.NONE);
			} else {
				spas_internal::lafDTO.color = $color = getColor(value);
				spas_internal::useDefaultLafColor = false;
				fixColorState($color);
			}
			if(hasTextureManager()) $textureManager.color = $color;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>constraints</code> property.
		 * 
		 * 	@see #constraints
		 */
		protected var $constraints:Object;
		/**
		 *  @inheritDoc
		 */
		public function get constraints():Object {
			return $constraints;
		}
		public function set constraints(value:Object):void {
			$constraints = value;
		}
		
		/**
		 *  @private
		 */
		spas_internal var uioSprite:UIOSprite;
		/**
		 *  @inheritDoc
		 */
		public function get container():Sprite {
			return Sprite(spas_internal::uioSprite);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>content</code> property.
		 * 
		 * 	@see #content
		 */
		protected var $content:Sprite = null;
		/**
		 *  @inheritDoc
		 */
		public function get content():Sprite {
			return $content as Sprite;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>cornerRadius</code> property.
		 * 
		 * 	@see #cornerRadius
		 */
		protected var $cornerRadius:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get cornerRadius():Number {
			return $cornerRadius;
		}
		public function set cornerRadius(value:Number):void {
			spas_internal::lafDTO.cornerRadius = $cornerRadius = value;
			spas_internal::lafDTO.topLeftCorner = spas_internal::lafDTO.topRightCorner =
			spas_internal::lafDTO.bottomLeftCorner = spas_internal::lafDTO.bottomRightCorner = 
			$tlc = $trc = $blc = $brc = NaN;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>data</code> property.
		 * 
		 * 	@see #data
		 */
		protected var $data:*;
		/**
		 *  @inheritDoc
		 */
		public function get data():* {
			return $data;
		}
		public function set data(value:*):void {
			$data = value;
			this.dispatchEvent(new SpasEvent(SpasEvent.DATA_CHANGED));
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>displayed</code> property.
		 * 
		 * 	@see #displayed
		 */
		protected var $displayed:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get displayed():Boolean {
			return $displayed;
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get doubleClickEnabled():Boolean {
			return super.doubleClickEnabled;
			}
		override public function set doubleClickEnabled(value:Boolean):void {
			super.doubleClickEnabled = spas_internal::uioSprite.doubleClickEnabled = value;
			fixChildrenDoubleClickEnabled(spas_internal::uioSprite, value);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>defaultMinWidth</code> property.
		 * 
		 * 	@see #defaultMinWidth
		 */
		protected var $defaultMinWidth:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get defaultMinWidth():Number {
			return $defaultMinWidth;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>defaultMinHeight</code> property.
		 * 
		 * 	@see #defaultMinHeight
		 */
		protected var $defaultMinHeight:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get defaultMinHeight():Number {
			return $defaultMinHeight;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>dragConstraint</code> property.
		 * 
		 * 	@see #dragConstraint
		 */
		protected var $dragConstraint:String = DragConstraint.FREE;
		/**
		 *  @inheritDoc
		 */
		public function get dragConstraint():String {
			return $dragConstraint;
		}
		public function set dragConstraint(value:String):void {
			$dragConstraint = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>draggable</code> property.
		 * 
		 * 	@see #draggable
		 */
		protected var $draggable:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get draggable():Boolean {
			return $draggable;
		}
		public function set draggable(value:Boolean):void {
			$draggable = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>forceRefresh</code> property.
		 * 
		 * 	@see #forceRefresh
		 */
		protected var $forceRefresh:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get forceRefresh():Boolean {
			return $forceRefresh;
		}
		public function set forceRefresh(value:Boolean):void {
			$forceRefresh = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>enabled</code> property.
		 * 
		 * 	@see #enabled
		 */
		protected var $enabled:Boolean = true;
		/**
		 *  @inheritDoc
		 */
		public function get enabled():Boolean {
			return $enabled;
		}
		public function set enabled(value:Boolean):void {
			$enabled = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>removeEffectRef</code> property.
		 * 
		 * 	@see #removeEffectRef
		 */
		protected var $removeEffectRef:Class = null;
		/**
		 *  @inheritDoc
		 */
		public function get removeEffectRef():Class {
			return $removeEffectRef;
		}
		public function set removeEffectRef(value:Class):void {
			if (value == null) return;
			if ($removeEffectIsRendering) return;
			$evtColl.removeEvent($removeEffect, EffectEvent.FINISH, effectFinish);
			deleteRemoveEffect();
			var effect:Class = value as Class;
			$removeEffect = new effect(this) as Effect;
			setEffectDuration($removeEffect, $removeEffectDuration);
			$evtColl.addEvent($removeEffect, EffectEvent.FINISH, effectFinish);
			$removeEffectRef = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>removeEffectDuration</code> property.
		 * 
		 * 	@see #removeEffectDuration
		 */
		protected var $removeEffectDuration:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get removeEffectDuration():Number {
			return $removeEffectDuration;
		}
		public function set removeEffectDuration(value:Number):void {
			$removeEffectDuration = value;
			setEffectDuration($removeEffect, value);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>removeEffectIsRendering</code> property.
		 * 
		 * 	@see #removeEffectIsRendering
		 */
		protected var $removeEffectIsRendering:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get removeEffectIsRendering():Boolean {
			return $removeEffectIsRendering;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>eventCollector</code> property.
		 * 
		 * 	@see #eventCollector
		 */
		protected var $publicEventCollector:EventCollector = null;
		/**
		 *  @inheritDoc
		 */
		public function get eventCollector():EventCollector {
			if (isNull($publicEventCollector)) $publicEventCollector = new EventCollector();
			return $publicEventCollector;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fixToParentHeight</code> property.
		 * 
		 * 	@see #fixToParentHeight
		 */
		protected var $fixToParentHeight:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get fixToParentHeight():Boolean {
			return $fixToParentHeight;
		}
		public function set fixToParentHeight(value:Boolean):void {
			$fixToParentHeight = value;
			$percentHeight = NaN;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>fixToParentWidth</code> property.
		 * 
		 * 	@see #fixToParentWidth
		 */
		protected var $fixToParentWidth:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get fixToParentWidth():Boolean {
			return $fixToParentWidth;
		}
		public function set fixToParentWidth(value:Boolean):void {
			$fixToParentWidth = value;
			$percentWidth = NaN;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>focusColor</code> property.
		 * 
		 * 	@see #focusColor
		 */
		protected var $focusColor:* = NaN;
		[Inspectable(defaultValue="#0099FF", name="focusColor", type="Color")]
		/**
		 *  @inheritDoc
		 */
		public function get focusColor():* {
			return isNaN($focusColor) ? lookAndFeel.getFocusFilter().color : $focusColor;
		}
		public function set focusColor(value:*):void {
			spas_internal::lafDTO.focusColor = $focusColor = getColor(value);
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get gradientProperties():Object {
			return $textureManager.gradientProperties;
		}
		public function set gradientProperties(value:Object):void {
			if (hasTextureManager()) $textureManager.gradientProperties = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>glow</code> property.
		 * 
		 * 	@see #glow
		 */
		protected var $glowFilter:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get glow():Boolean {
			return $glowFilter;
		}
		public function set glow(value:Boolean):void {
			spas_internal::lafDTO.glow = $glowFilter = value;
			if(!value) removeGlowFilter();
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>glowColor</code> property.
		 * 
		 * 	@see #glowColor
		 */
		protected var $glowColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get glowColor():* {
			return $glowColor;
		}
		public function set glowColor(value:*):void {
			spas_internal::lafDTO.glowColor = $glowColor = getColor(value);
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>gradientMode</code> property.
		 * 
		 * 	@see #gradientMode
		 */
		protected var $gradientMode:Boolean = false;
		//[Inspectable(defaultValue="false", name="gradientMode")]
		/**
		 *  @inheritDoc
		 */
		public function get gradientMode():Boolean {
			return $gradientMode;
		}
		public function set gradientMode(value:Boolean):void {
			if(hasTextureManager() && value) $textureManager.texture = null;
			$gradientMode = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>hasDisplayEffect</code> property.
		 * 
		 * 	@see #hasDisplayEffect
		 */
		protected var $hasDisplayEffect:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get hasDisplayEffect():Boolean {
			return $hasDisplayEffect;
		}
		public function set hasDisplayEffect(value:Boolean):void {
			$hasDisplayEffect = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>hasRemoveEffect</code> property.
		 * 
		 * 	@see #hasRemoveEffect
		 */
		protected var $hasRemoveEffect:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get hasRemoveEffect():Boolean {
			return $hasRemoveEffect;
		}
		public function set hasRemoveEffect(value:Boolean):void {
			$hasRemoveEffect = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>height</code> property.
		 * 
		 * 	@see #height
		 */
		protected var $height:Number;
		/**
		 *   @inheritDoc
		 */
		override public function get height():Number {
			return $height;
		}
		override public function set height(value:Number):void {
			if (spas_internal::isComponent) super.height = value;
			spas_internal::lafDTO.height = $height = value;
			//_percentHeight = NaN;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>horizontalBaseLine</code> property.
		 * 
		 * 	@see #horizontalBaseLine
		 */
		protected var $horizontalBaseLine:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get horizontalBaseLine():Number {
			return $horizontalBaseLine;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>horizontalGap</code> property.
		 * 
		 * 	@see #horizontalGap
		 */
		protected var $horizontalGap:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get horizontalGap():Number {
			return $horizontalGap;
		}
		public function set horizontalGap(value:Number):void {
			$horizontalGap = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		private var _id:String = null;
		/**
		 *  @inheritDoc
		 */
		public function get id():String {
			return _id;
		}
		public function set id(value:String):void {
			var app:* = $uiManager.document;
			if (isNull(value)) {
				if (isNull(_id)) return;
				app.spas_internal::IDStack[_id] = null;
				delete app.spas_internal::IDStack[_id];
				_id = null;
				return;
			}
			if(value.toLowerCase() == _id) return;
			else if (!isNull(app.spas_internal::IDStack[value]))
				throw new AlreadyBoundException(Locale.spas_internal::ERRORS.UNIQUE_ID_ERROR + value);
			_id = value.toLowerCase();
			app.spas_internal::IDStack[value.toLowerCase()] = this;
			$uiManager.cssManager.spas_internal::setCSS(this);
			$analitycsObj.id = _id;
		}
		
		private var _guid:GUID;
		/**
		 *  @inheritDoc
		 */
		public function get guid():GUID {
			return _guid;
		}
		
		private  var _index:int = -1;
		/**
		 * 	@private
		 */
		spas_internal function setIndex(index:int):void {
			_index = index;
		}
		/**
		 *  @inheritDoc
		 */
		public function get index():int {
			return _index;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>invalidateRefresh</code> property.
		 * 
		 * 	@see #invalidateRefresh
		 */
		protected var $invalidateRefresh:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get invalidateRefresh():Boolean {
			return $invalidateRefresh;
		}
		public function set invalidateRefresh(value:Boolean):void {
			$invalidateRefresh = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>layoutPosition</code> property.
		 * 
		 * 	@see #layoutPosition
		 */
		protected var $layoutPosition:String = LayoutPosition.STATIC;
		/**
		 *  @inheritDoc
		 */
		public function get layoutPosition():String {
			return $layoutPosition;
		}
		public function set layoutPosition(value:String):void {
			$layoutPosition = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>margin</code> property.
		 * 
		 * 	@see #margin
		 */
		protected var $margin:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get margin():Number {
			return $margin;
		}
		public function set margin(value:Number):void {
			$margin = value;
			spas_internal::metricsChanged = true;
			if (!isNaN(value)) {
				$mrgB = $mrgL = $mrgR = $mrgT = value;
				setRefresh();
			}
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>marginLeft</code> property.
		 * 
		 * 	@see #marginLeft
		 */
		protected var $mrgL:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get marginLeft():Number {
			return $mrgL;
		}
		public function set marginLeft(value:Number):void {
			$mrgL = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>marginTop</code> property.
		 * 
		 * 	@see #marginTop
		 */
		protected var $mrgT:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get marginTop():Number {
			return $mrgT;
		}
		public function set marginTop(value:Number):void {
			$mrgT = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>marginRight</code> property.
		 * 
		 * 	@see #marginRight
		 */
		protected var $mrgR:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get marginRight():Number {
			return $mrgR;
		}
		public function set marginRight(value:Number):void {
			$mrgR = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>marginBottom</code> property.
		 * 
		 * 	@see #marginBottom
		 */
		protected var $mrgB:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get marginBottom():Number {
			return $mrgB;
		}
		public function set marginBottom(value:Number):void {
			$mrgB = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get mask():DisplayObject {
			return spas_internal::uioSprite.mask;
		}
		override public function set mask(value:DisplayObject):void  {
			spas_internal::uioSprite.mask = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>minWidth</code> property.
		 * 
		 * 	@see #minWidth
		 */
		protected var $minWidth:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get minWidth():Number {
			return $minWidth;
		}
		public function set minWidth(value:Number):void {
			if (value < $defaultMinWidth)
				throw new IllegalArgumentException(Locale.spas_internal::ERRORS.MIN_WIDTH_ERROR);
			else $minWidth = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>minHeight</code> property.
		 * 
		 * 	@see #minHeight
		 */
		protected var $minHeight:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get minHeight():Number {
			return $minHeight;
		}
		public function set minHeight(value:Number):void {
			if ($minHeight < $defaultMinHeight)
				throw new IllegalArgumentException(Locale.spas_internal::ERRORS.MIN_HEIGHT_ERROR);
			else $minHeight = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get name():String {
			return spas_internal::uioSprite.name;
		}
		override public function set name(value:String):void {
			spas_internal::uioSprite.name = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>padding</code> property.
		 * 
		 * 	@see #padding
		 */
		protected var $padding:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get padding():Number {
			return $padding;
		}
		public function set padding(value:Number):void {
			$padding = value;
			spas_internal::metricsChanged = true;
			if (!isNaN(value)) {
				$padB = $padL = $padR = $padT = value;
				setRefresh();
			}
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>paddingBottom</code> property.
		 * 
		 * 	@see #paddingBottom
		 */
		protected var $padB:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get paddingBottom():Number {
			return $padB;
		}
		public function set paddingBottom(value:Number):void {
			$padB = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>paddingLeft</code> property.
		 * 
		 * 	@see #paddingLeft
		 */
		protected var $padL:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get paddingLeft():Number {
			return $padL;
		}
		public function set paddingLeft(value:Number):void {
			$padL = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>paddingRight</code> property.
		 * 
		 * 	@see #paddingRight
		 */
		protected var $padR:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get paddingRight():Number {
			return $padR;
		}
		public function set paddingRight(value:Number):void {
			$padR = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>paddingTop</code> property.
		 * 
		 * 	@see #paddingTop
		 */
		protected var $padT:Number = NaN;
		 /**
		 *  @inheritDoc
		 */
		public function get paddingTop():Number {
			return $padT;
		}
		public function set paddingTop(value:Number):void {
			$padT = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>parent</code> property.
		 * 
		 * 	@see #parent
		 */
		protected var $parent:DisplayObjectContainer;
		/**
		 *  @inheritDoc
		 */
		override public function get parent():DisplayObjectContainer {
			return $parent;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>percentHeight</code> property.
		 * 
		 * 	@see #percentHeight
		 */
		protected var $percentHeight:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get percentHeight():Number {
			return $percentHeight;
		}
		public function set percentHeight(value:Number):void {
			//if (spas_internal::isComponent) super.height = value;trace(_height)
			if (!isNaN(value)) RangeChecker.checkNum(value, 100, 0);
			$percentHeight = value;
			//_height = MeasureUtil.getPercentHeight(this);
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>percentWidth</code> property.
		 * 
		 * 	@see #percentWidth
		 */
		protected var $percentWidth:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get percentWidth():Number {
			return $percentWidth;
		}
		public function set percentWidth(value:Number):void {
			//if (spas_internal::isComponent) super.width = value;
			if (!isNaN(value)) RangeChecker.checkNum(value, 100, 0);
			$percentWidth = value;
			//_width = MeasureUtil.getPercentWidth(this);
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get position():Point {
			return new Point(spas_internal::uioSprite.x, spas_internal::uioSprite.y);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get globalPosition():Point {
			return spas_internal::uioSprite.parent.localToGlobal(this.position);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>quality</code> property.
		 * 
		 * 	@see #quality
		 */
		protected var $quality:String = Quality.HIGH;
		/**
		 *  @inheritDoc
		 */
		public function get quality():String {
			return $quality;
		}
		public function set quality(value:String):void {
			$quality = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>raise</code> property.
		 * 
		 * 	@see #raise
		 */
		protected var $raise:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get raise():Boolean {
			return $raise;
		}
		public function set raise(value:Boolean):void {
			$raise = value;
			switch($raise) {
				case true :
					spas_internal::deactivateShadow();
					spas_internal::deactivateGlow();
					lookAndFeel.addRaiseEffect();
					break;
				case false :
					lookAndFeel.removeRaiseEffect();
					spas_internal::reactivateShadow();
					spas_internal::reactivateGlow();
					break;
			}
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>reflection</code> property.
		 * 
		 * 	@see #reflection
		 */
		protected var $reflection:Boolean;
		/**
		 *  @inheritDoc
		 */
		public function get reflection():Boolean {
			return $reflection;
		}
		public function set reflection(value:Boolean):void {
			$reflection = value;
			if (!$reflect && value) initReflect();
			else if(reflectProperties.hasChanged) initReflect();
			value ? doReflection() : $reflect.remove();
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get rotation():Number {
			return spas_internal::uioSprite.rotation;
		}
		override public function set rotation(value:Number):void {
			spas_internal::uioSprite.rotation = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get scaleX():Number {
			return spas_internal::uioSprite.scaleX;
		}
		override public function set scaleX(value:Number):void {
			spas_internal::uioSprite.scaleX = value;
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get scaleY():Number {
			return spas_internal::uioSprite.scaleY;
		}
		override public function set scaleY(value:Number):void {
			spas_internal::uioSprite.scaleY = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>shadow</code> property.
		 * 
		 * 	@see #shadow
		 */
		protected var $dropShadow:Boolean;
		[Inspectable(defaultValue = "false", name = "shadow")]
		/**
		 *  @inheritDoc
		 */
		public function get shadow():Boolean {
			return $dropShadow;
		}
		public function set shadow(value:Boolean):void {
			spas_internal::lafDTO.shadow = $dropShadow = value;
			if(!value) removeShadow();
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>displayEffectRef</code> property.
		 * 
		 * 	@see #displayEffectRef
		 */
		protected var $displayEffectRef:Class = FadeIn;
		/**
		 *  @inheritDoc
		 */
		public function get displayEffectRef():Class {
			return $displayEffectRef;
		}
		public function set displayEffectRef(value:Class):void {
			if (value == null) return;
			if ($displayEffectIsRendering) return;
			$evtColl.removeEvent($displayEffect, EffectEvent.FINISH, displayEffectFinish);
			deleteDisplayEffect();
			var effect:Class = value as Class;
			$displayEffect = new effect(this) as Effect;
			setEffectDuration($displayEffect, $displayEffectDuration);
			$evtColl.addEvent($displayEffect, EffectEvent.FINISH, displayEffectFinish);
			$displayEffectRef = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>displayEffectDuration</code> property.
		 * 
		 * 	@see #displayEffectDuration
		 */
		protected var $displayEffectDuration:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get displayEffectDuration():Number {
			return $displayEffectDuration;
		}
		public function set displayEffectDuration(value:Number):void {
			$displayEffectDuration = value;
			setEffectDuration($displayEffect, value);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>displayEffectIsRendering</code> property.
		 * 
		 * 	@see #displayEffectIsRendering
		 */
		protected var $displayEffectIsRendering:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get displayEffectIsRendering():Boolean {
			return $displayEffectIsRendering;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>displayEffect</code> property.
		 * 
		 * 	@see #displayEffect
		 */
		protected var $displayEffect:Effect;
		/**
		 *  @inheritDoc
		 */
		public function get displayEffect():Effect {
			return $displayEffect;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>removeEffect</code> property.
		 * 
		 * 	@see #removeEffect
		 */
		protected var $removeEffect:Effect;
		/**
		 *  @inheritDoc
		 */
		public function get removeEffect():Effect {
			return $removeEffect;
		}
		
		private var _selector:String = Selectors.UIOBJECT;
		/**
		 *  @inheritDoc
		 */
		public function get selector():String {
			return _selector;
		}
		/**
		 *  @private
		 */
		spas_internal function setSelector(value:String):void {
			_selector = value;
			$uiManager.cssManager.spas_internal::setCSS(this);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>target</code> property.
		 * 
		 * 	@see #target
		 */
		protected var $target:*;
		/**
		 *  @inheritDoc
		 */
		public function get target():* {
			return $target;
		}
		public function set target(value:*):void {
			$target = value;
			switch(value is IUIContainer) {
				case true :
					$parent = value.content;
					break;
				case false :
					$parent = value;
					break;
			}
			// TODO voir pour supprimer tous les listener sur _parent et sur _target
		}
		
		/**
		 * 	@private
		 */
		spas_internal var textRef:TextField = null;
		/**
		 *  @inheritDoc
		 */
		public function get textField():TextField {
			return spas_internal::textRef;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>textTransform</code> property.
		 * 
		 * 	@see #textTransform
		 */
		protected var $textTransform:String = TextTransformType.NONE;
		/**
		 *  @inheritDoc
		 */
		public function get textTransform():String {
			return $textTransform;
		}
		public function set textTransform(value:String):void {
			$textTransform = value;
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get texture():* {
			return $textureManager.texture;
		}
		public function set texture(value:*):void {
			if (!isNull(value)) $gradientMode = false;
			$textureManager.texture = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>textureManager</code> property.
		 * 
		 * 	@see #textureManager
		 */
		protected var $textureManager:TextureManager = null;
		/**
		 *  @inheritDoc
		 */
		public function get textureManager():TextureManager {
			return $textureManager;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>topLeftCorner</code> property.
		 * 
		 * 	@see #topLeftCorner
		 */
		protected var $tlc:Number =  NaN;
		/**
		 *  @inheritDoc
		 */
		public function get topLeftCorner():Number {
			return $tlc;
		}
		public function set topLeftCorner(value:Number):void {
			spas_internal::lafDTO.topLeftCorner = $tlc = value;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>topRightCorner</code> property.
		 * 
		 * 	@see #topRightCorner
		 */
		protected  var $trc:Number =  NaN;
		/**
		 *  @inheritDoc
		 */
		public function get topRightCorner():Number {
			return $trc;
		}
		public function set topRightCorner(value:Number):void {
			spas_internal::lafDTO.topRightCorner = $trc = value;
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get transform():Transform {
			return spas_internal::uioSprite.transform;
		}
		override public function set transform(value:Transform):void {
			spas_internal::uioSprite.transform = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>type</code> property.
		 * 
		 * 	@see #type
		 */
		protected var $type:String = null;
		/**
		 *  @private
		 */
		spas_internal function setType(value:String):void {
			$type = value;
		}
		/**
		 *  @inheritDoc
		 */
		public function get type():String {
			return $type;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>verticalBaseLine</code> property.
		 * 
		 * 	@see #verticalBaseLine
		 */
		protected var $verticalBaseLine:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get verticalBaseLine():Number {
			return $verticalBaseLine;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>verticalGap</code> property.
		 * 
		 * 	@see #verticalGap
		 */
		protected var $verticalGap:Number = 0;
		/**
		 *  @inheritDoc
		 */
		public function get verticalGap():Number {
			return $verticalGap;
		}
		public function set verticalGap(value:Number):void {
			$verticalGap = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function get visible():Boolean {
			return spas_internal::uioSprite.visible;
		}
		override public function set visible(value:Boolean):void {
			spas_internal::uioSprite.visible = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>width</code> property.
		 * 
		 * 	@see #width
		 */
		protected var $width:Number;
		/**
		 *  @inheritDoc
		 */
		override public function get width():Number {
			return $width;
		}
		override public function set width(value:Number):void {
			if (spas_internal::isComponent) super.width = value;
			spas_internal::lafDTO.width = $width = value;
			// _percentWidth = NaN;
			setRefresh();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>x</code> property.
		 * 
		 * 	@see #x
		 */
		protected var $x:Number = 0;
		/**
		 *  @inheritDoc
		 */
		override public function get x():Number {
			return $x;
		}
		override public function set x(value:Number):void {
			spas_internal::uioSprite.x = $x = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>y</code> property.
		 * 
		 * 	@see #y
		 */
		protected var $y:Number = 0;
		/**
		 * @inheritDoc
		 */
		override public function get y():Number {
			return $y;
		}
		override public function set y(value:Number):void {
			spas_internal::uioSprite.y = $y = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				createUIObject(x, y);
				doStartEffect();
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function remove():void {
			if ($displayed) unload();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function cacheUIObject():void {
			createUIObject();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function drawBackface():Sprite {
			if(isNull($backface)) $backface = new Sprite();
			if(isNull($backfaceTextureManager)) $backfaceTextureManager = new TextureManager($backface);
			lookAndFeel.drawBackFace($backface);
			return $backface;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function finalize():void {
			var f:UIObject = $uiManager.focusManager.getFocus();
			if (!isNull(f)) {
				if (f == this) $uiManager.focusManager.setFocus(null);
			}
			if ($displayed) {
				//_isFinalizing = true;
				this.remove();
			} //else destroyUIObject();
			destroyUIObject();
		}
		
		private var _isFinalizing:Boolean;
		private function destroyUIObject():void {
			if (!isNull($evtColl)) {
				$evtColl.finalize();
				$evtColl = null;
			}
			_guid = null;
			if (this is LafRenderer) {
				//--> Sometimes the lookAndFeel property can be undefined (e.g. MenuBuilder class):
				if (!isNull(lookAndFeel)) {
					lookAndFeel.onChange();
					lookAndFeel = null;
				}
				$uiRef.lafList.deleteObserver(this);
				if ($uiRef.lafList.countObservers() == 0) $uiRef.lafList = null;
			}
			spas_internal::lafDTO.spas_internal::finalize();
			spas_internal::lafDTO = null;
			if (!isNull($content)) $content = null;
			if (!isNull($textureManager)) {
				$textureManager.finalize();
				$textureManager = null;
			}
			if (!isNull($backgroundTextureManager)) {
				$backgroundTextureManager.finalize();
				$backgroundTextureManager = null;
			}
			if (!isNull($backfaceTextureManager)) {
				$backfaceTextureManager.finalize();
				$backfaceTextureManager = null;
			}
			if (!isNull($publicEventCollector)) {
				$publicEventCollector.finalize();
				$publicEventCollector = null;
			}
			deleteRemoveEffect();
			deleteDisplayEffect();
			finalizeSkinObject();
			if (!isNull($colors)) {
				$colors.finalize();
				$colors = null;
			}
			reflectProperties.finalize();
			reflectProperties = null;
			$storedSize.finalize();
			$storedSize = null;
			if (!isNull($hitArea)) {
				//spas_internal::CONTAINER.removeChild($hitArea);
				$hitArea = null;
			}
			if (!isNull(spas_internal::background)) {
				//spas_internal::CONTAINER.removeChild(spas_internal::background);
				spas_internal::background = null;
			}
			if (!isNull(spas_internal::borders)) {
				//spas_internal::CONTAINER.removeChild(spas_internal::borders);
				spas_internal::borders = null;
			}
			$analitycsObj.finalize();
			$analitycsObj = null;
			spas_internal::uioSprite.finalize();
			spas_internal::uioSprite = null;
			$target = null;
			$parent = null;
			$data = null;
			$stage = null;
			$uiManager.document.spas_internal::destroy(this);
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle;
			if(this is IUIContainer) {
				var _scaleX:Number = $content.scaleX;
				var _scaleY:Number = $content.scaleY;
				$content.scaleX = $content.scaleY = 0;
				r = spas_internal::uioSprite.getBounds(spas_internal::getCoordinateSpace(targetCoordinateSpace));
				$content.scaleX = _scaleX, $content.scaleY = _scaleY;
				
			} else r = spas_internal::uioSprite.getBounds(spas_internal::getCoordinateSpace(targetCoordinateSpace));
			return r;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getQualifiedClassName():String {
			return flash.utils.getQualifiedClassName(this);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getQualifiedSuperclassName():String {
			return flash.utils.getQualifiedSuperclassName(this);
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle;
			if(this is IUIContainer) {
				var _scaleX:Number = $content.scaleX;
				var _scaleY:Number = $content.scaleY;
				$content.scaleX = $content.scaleY = 0;
				r = spas_internal::uioSprite.getRect(spas_internal::getCoordinateSpace(targetCoordinateSpace));
				$content.scaleX = _scaleX;
				$content.scaleY = _scaleY;
			} else r = spas_internal::uioSprite.getRect(spas_internal::getCoordinateSpace(targetCoordinateSpace));
			return r;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getVersion():String {
			return Version.toString();
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function hitTestObject(obj:DisplayObject):Boolean {
			var target:DisplayObject = (obj is UIObject) ? (obj as UIObject).container : obj;
			return spas_internal::uioSprite.hitTestObject(target);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function move(x:Number, y:Number):void {
			this.x = (isNaN(x)) ? this.$x : x;
			this.y = (isNaN(y)) ? this.$y : y;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function redraw():void {
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function resize(width:Number, height:Number):void { 
			spas_internal::lafDTO.width = $width = width;
			spas_internal::lafDTO.height = $height = height;
			setRefresh();
			dispatchUIOEvent(UIOEvent.RESIZED);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function setPadding(top:Number = NaN, right:Number = NaN, bottom:Number = NaN, left:Number = NaN):void {
			$padT = top;
			$padR = right;
			$padB = bottom;
			$padL = left;
			setRefresh();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function setSize(width:Number, height:Number):void { 
			this.resize(width, height);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function setToTopLevel():void {
			$uiManager.setToTopLevel(this);
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void {
			if ($draggable) {
				dispatchUIOEvent(UIOEvent.DRAG_START);
				($dragConstraint == DragConstraint.FREE) ?
					spas_internal::uioSprite.startDrag(lockCenter, bounds) :
					spas_internal::uioSprite.startDrag(false, new Rectangle(0, 0, $stage.stageWidth-$width, $stage.stageHeight-$height));
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function stopDrag():void { 
			spas_internal::uioSprite.stopDrag();
			$x = spas_internal::uioSprite.x;
			$y = spas_internal::uioSprite.y;
			dispatchUIOEvent(UIOEvent.DRAG_STOP);
		}
		
		/**
		 *  @private
		 */
		override public function toString():String {
			var clsName:String = flash.utils.getQualifiedClassName(this);
			clsName = clsName.substring(clsName.lastIndexOf(":")+1, clsName.length);
			return "[uiobject " + clsName + "]";
		}
		
		/**
		 *  @inheritDoc
		 */
		public function setCornerRadiuses(topLeft:Number, topRight:Number, bottomRight:Number, bottomLeft:Number):void {
			spas_internal::lafDTO.cornerRadius = $cornerRadius = NaN;
			spas_internal::lafDTO.topLeftCorner = $tlc = topLeft;
			spas_internal::lafDTO.topRightCorner = $trc = topRight;
			spas_internal::lafDTO.bottomLeftCorner = $blc = bottomLeft;
			spas_internal::lafDTO.bottomRightCorner = $brc = bottomRight;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */	
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			switch(type) {
				case UIOEvent.INITIALIZED :
					if (_isInitialized = true) dispatchUIOEvent(UIOEvent.INITIALIZED);
					break;
				case UIMouseEvent.CLICK :
					$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.CLICK, onClick);
					break;
				case UIMouseEvent.DOUBLE_CLICK :
					$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.DOUBLE_CLICK, onDoubleClick);
					break;
				case UIMouseEvent.PRESS_OUTSIDE :
					$evtColl.addEvent($stage, MouseEvent.MOUSE_DOWN, onPressOutsideEvent);
					break;
				case UIMouseEvent.PRESS :
					$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_DOWN, onPressEvent);
					break;
				case UIMouseEvent.RELEASE :
					$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_UP, onReleaseEvent);
					break;
				case UIMouseEvent.RELEASE_OUTSIDE :
					$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, onReleaseOutsideEvent);
					break;
				case UIMouseEvent.ROLL_OVER :
					$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OVER, onRollOverEvent);
					break;
				case UIMouseEvent.ROLL_OUT :
					$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OUT, onRollOutEvent);
					break;
			}
		}
		
		/**
		 * 	@private
		 */
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			super.removeEventListener(type, listener, useCapture);
			switch(type) {
				case UIMouseEvent.CLICK :
					$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.CLICK, onClick);
					break;
				case UIMouseEvent.PRESS_OUTSIDE :
					$evtColl.removeEvent($stage, MouseEvent.MOUSE_DOWN, onPressOutsideEvent);
					break;
				case UIMouseEvent.PRESS :
					$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.MOUSE_DOWN, onPressEvent);
					break;
				case UIMouseEvent.RELEASE :
					$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.MOUSE_UP, onReleaseEvent);
					break;
				case UIMouseEvent.RELEASE_OUTSIDE :
					$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, onReleaseOutsideEvent);
					break;
				case UIMouseEvent.ROLL_OVER :
					$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OVER, onRollOverEvent);
					break;
				case UIMouseEvent.ROLL_OUT :
					$evtColl.removeEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OUT, onRollOutEvent);
					break;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Analytics API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function get analitycsData():* {
			return $analitycsObj.data;
		}
		public function set analitycsData(value:*):void {
			$analitycsObj.data = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get analitycsType():String {
			return $analitycsObj.analyticsType;
		}
		public function set analitycsType(value:String):void {
			$analitycsObj.analyticsType = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get analitycsRef():Analytics{
			return $analitycsObj.analyticsRef;
		}
		public function set analitycsRef(value:Analytics):void {
			$analitycsObj.analyticsRef = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>analitycsObj</code> property.
		 * 
		 * 	@see #analitycsObj
		 */
		protected var $analitycsObj:AnalyticsObject;
		/**
		 * 	@inheritDoc
		 */
		public function get analitycsObj():AnalyticsObject {
			return $analitycsObj;
		}
		/*public function set analitycsObj(value:AnalyticsObject):void {
			//$analitycsObj = value;
		}*/
		
		
		//--------------------------------------------------------------------------
		//
		//  Look and Feel management
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  The object that represents the Look and Feel of the <code>UIObject</code>.
		 *  
		 *  @see #lafProtected
		 *  @see #getLaf()
		 *  @see #setLaf()
		 *  @see #lockLaf()
		 *  @see #unlockLaf()
		 */
		public var lookAndFeel:Object;
		
		/**
		 *  @inheritDoc
		 */
		public function setLaf(value:Object):void {
			validateLaf(value);
			setLafRef(value);
			notifyLafChanges();
			dispatchLafChangedEvent();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function lockLaf(value:Object, autoUnlock:Boolean = false):void {
			if ($isLafProtected && autoUnlock == false) return;
			if (value == $uiRef.laf && lookAndFeel is $uiRef.laf) {
				$isLafProtected = true;
			} else {
				validateLaf(value);
				removeOldLaf();
				setNewLockedLaf(value);
				fixDefaultLafColors();
				setSpecificLafChanges();
				dispatchLafChangedEvent();
				setRefresh();
			}
		}
		
		/**
		 *  @inheritDoc
		 */
		public function unlockLaf():void {
			$isLafProtected = false;
			removeOldLaf();
			setNewLaf();
			updateLaf();
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getLafRef():Class {
			return $uiRef.laf;
		}
		
		private var _defaultLaf:Class;
		/**
		 *  @inheritDoc
		 */
		public function getDefaultLafRef():Class {
			return _defaultLaf;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function getLaf():Object {
			return lookAndFeel.constructor;
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  An internal <code>Boolean</code> value that indicates whether the uiobject 
		 * 	Look and Feel is protected (<code>false</code>) or not (<code>true</code>).
		 * 
		 *  @default false
		 */
		protected var $isLafProtected:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get lafProtected():Boolean {
			return $isLafProtected;
		}
		
		//--> Protected L&F properties for SPAS developers:
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A reference to the old look and feel used by this uiobject.
		 */
		protected var $oldLaf:Object;
		
		//--> Protected L&F methods for SPAS developers:
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 */
		protected var $uiRef:Object;
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Initializes the look and feel for any uiobject that uses LoonAndFeel.
		 * 	This method must be used into the uiobject constructor function.
		 * 
		 * 	@param	uiReference	the class reference object used define the default look and feel
		 */
		protected function initLaf(uiReference:Class):void {
			$uiRef = Object(uiReference);
			if ($uiRef.lafList == null) $uiRef.lafList = new Observable();
			_defaultLaf = $uiRef.getDefaultUI();
			/*if (hasObservable(this["constructor"])) _constructRef = this["constructor"];
			else {
				var _ref:XML = describeType(this);
				var item:XML;
				var tpe:String;
				var classObj:Class;
				for each(item in _ref.extendsClass) {
					tpe = item.attribute("type");
					if (tpe == UI_CONTAINER || tpe == UI_OBJECT) throw new LookAndFeelException();
					else {
						classObj = getDefinitionByName(tpe) as Class;
						if (hasObservable(classObj)) {
							_constructRef = classObj;
							break;
						}
					}
				}
			}
			*/
			$uiRef.lafList.addObserver(this);
			validateLaf(_defaultLaf);
			if ($uiRef.laf == undefined) setLafRef(_defaultLaf);
			setNewLaf();
			fixDefaultLafColors();
			setSpecificLafChanges();
			$oldLaf = lookAndFeel;
		}
		
		/**
		 * 	@private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Checks if the class object passed as Look and Feel implements the LookAndFeel interface.
		 * 
		 * 	@param	value	the class object to be checked as LookAndFeel
		 */
		protected function validateLaf(value:Object):void {
			LAFValidator.validate(value);
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The routine called by the update method of the "observer" design pattern to change
		 * 	the look and feel for an object which is registred by the Observable instance
		 * 	constructor.
		 */
		protected function changeLaf():void {
			if(!$isLafProtected) {
				setNewLaf();
				fixDefaultLafColors();
				setSpecificLafChanges();
				dispatchLafChangedEvent();
			}
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Dispatches the UIOEvent.LAF_CHANGED event for this uiobject when the invalidateLafEvent
		 * 	is set to true..
		 */
		protected function dispatchLafChangedEvent():void {
			if(!$invalidateLafEvent) dispatchUIOEvent(UIOEvent.LAF_CHANGED);
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The notify method used by the "observer" design pattern to change all look and feels
		 * 	for this constructor when the invalidateLafUpdate property is set to true.
		 */
		protected function notifyLafChanges():void {
			if (!$invalidateLafUpdate) {
				var obs:Observable = $uiRef.lafList;
				if (obs.countObservers() > 0) { 
					obs.setChanged();
					obs.notifyObservers();
				}
			}
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Provides a routine to calls the "onChange" property for the LookAndFeel instance
		 * 	and set it as value for the "oldLaf" property.
		 */
		protected function removeOldLaf():void {
			if (lookAndFeel) {
				lookAndFeel.onChange();
				$oldLaf = lookAndFeel;
			}
		}
		
		/**
		 *  @private
		 */
		protected function fixDefaultLafColors():void {
			fixDefaultLafColor();
			fixDefaultLafBackgroundColor();
			fixDefaultLafBorderColor();
		}
		
		/**
		 *  @private
		 */
		spas_internal var useDefaultLafColor:Boolean = true;
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Indicates that this uiobject must use L&amp;F default colors when its color
		 * 	property is defined by the Color.DEFAULT constant..
		 */
		protected function fixDefaultLafColor():void {
			if(spas_internal::useDefaultLafColor) {
				spas_internal::lafDTO.color = $color =
				lookAndFeel.hasOwnProperty("getColor") ? lookAndFeel.getColor() : NaN;
			}
		}
		
		/**
		 *  @private
		 */
		spas_internal var useDefaultLafBackgroundColor:Boolean = true;
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Indicates that this uiobject must use L&amp;F default colors when its background
		 * 	color property is defined by the Color.DEFAULT constant.
		 */
		protected function fixDefaultLafBackgroundColor():void {
			if (spas_internal::useDefaultLafBackgroundColor) {
				spas_internal::lafDTO.backgroundColor = $backgroundColor =
				lookAndFeel.hasOwnProperty("getBackgroundColor") ? lookAndFeel.getBackgroundColor() : NaN;
			}
		}
		
		/**
		 *  @private
		 */
		spas_internal var useDefaultLafBorderColor:Boolean = true;
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Indicates that this uiobject must use L&amp;F default border color when its 
		 * 	borderColor property is defined by the Color.DEFAULT constant.
		 */
		protected function fixDefaultLafBorderColor():void {
			if (spas_internal::useDefaultLafBorderColor) {
				spas_internal::lafDTO.borderColor = $borderColor =
				lookAndFeel.hasOwnProperty("getBorderColor") ? lookAndFeel.getBorderColor() : NaN;
			}
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Sets the UI reference "laf" property.
		 * 
		 * 	@param	value	the class object to set as constructor "laf" property
		 */
		protected function setLafRef(value:Object):void {
			$uiRef.laf = value;
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Creates a new LookAndFeel instance from the constructor "laf" property and
		 * 	sets the isLafProtected property to false.
		 */
		protected function setNewLaf():void {
			removeOldLaf();
			lookAndFeel = new $uiRef.laf(spas_internal::lafDTO);
			$isLafProtected = false;
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Creates a new LookAndFeel instance only for this uiobject and sets the isLafProtected property to true.
		 * 
		 * 	@param	value	the class object to set as "lookAndfeel" property for this uiobject
		 */
		protected function setNewLockedLaf(value:Object):void {
			removeOldLaf();
			lookAndFeel = new value(spas_internal::lafDTO);
			$isLafProtected = true;
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Calls the "observer" design pattern update method for this object, to update look and feel
		 * 	for objects which are registred by the constructor Observable instance.
		 */
		protected function updateLaf():void {
			if (!$invalidateLafUpdate) this.update($uiRef.lafList, undefined);
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 */
		public function update(o:Observable, arg:*):void {
			changeLaf();
			setRefresh();
		}
		
		//--> Protected L&F properties for SPAS developers:
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A flag that prevents the update of the look and feel for objects which are
		 * 	registred by the constructor Observable instance when it set to true.
		 * 
		 * 	@default false
		 */
		protected var $invalidateLafUpdate:Boolean = false;
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A flag that prevents the UIOEvent.LAF_CHANGED event for this uiobject
		 * 	when it set to true.
		 * 
		 * 	@default false
		 */
		protected var $invalidateLafEvent:Boolean = false;
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 	
		 * 	This method is used by the L&amp;F routine to fix the look and feel of
		 * 	<code>UIObject</code> internal controls, such as button or text conntrols, etc..
		 * 
		 * 	Developers can override this method to specify paricular look and feel
		 * 	behaviours in their own control uiobjects.
		 * 
		 * 	IMPORTANT: 	This method is not called during the L&amp;F initialization,
		 * 				(<code>UIObject.initLaf()</code> method) because most of <code>UIObject</code>
		 * 				internal controls are not yet created !
		 */
		protected function setSpecificLafChanges():void { }
		
		//--------------------------------------------------------------------------
		//
		//  L&F DTO management
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 	
		 * 	The internal look and feel data transfert object.
		 */
		spas_internal var lafDTO:LafDTO;
		
		/**
		 * 	@private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 	
		 * 	Initializes the look and feel data transfert object.
		 */
		private function initLafDTO():void {
			spas_internal::lafDTO = new LafDTO(this);
			spas_internal::lafDTO.borderWidth = $borderWidth;
			spas_internal::lafDTO.borderAlpha = $borderAlpha;
			spas_internal::lafDTO.backgroundAlpha = $backgroundAlpha;
			spas_internal::lafDTO.active = $active;
			spas_internal::lafDTO.cornerRadius = $cornerRadius;
			spas_internal::lafDTO.topLeftCorner = $tlc;
			spas_internal::lafDTO.topRightCorner = $trc;
			spas_internal::lafDTO.bottomLeftCorner = $blc;
			spas_internal::lafDTO.bottomRightCorner = $brc;
			spas_internal::lafDTO.glow = $glowFilter;
			spas_internal::lafDTO.glowColor = $glowColor;
			spas_internal::lafDTO.shadow = $dropShadow;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Skin management
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Indicates whether the <code>UIObject</code> uses a skin object to be rendered
		 * 	<code>true</code>, or not <code>false</code>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #$skinObject
		 */
		protected var $hasSkin:Boolean = false;
		/**
		 *  @inheritDoc
		 */
		public function get hasSkinObject():Boolean {
			return $hasSkin;
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 */
		spas_internal var background:Sprite;
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 */
		protected function createBackground():void {
			spas_internal::background = new Sprite();
			spas_internal::uioSprite.addChild(spas_internal::background);
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 */
		spas_internal var borders:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A reference to the skin object to render the <code>UIObject</code>.
		 * 
		 * 	@default null
		 * 
		 * 	@see #$hasSkin
		 */
		protected var $skinObject:*;
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 */
		protected function getSkinObj():Object {
			return $hasSkin ? $skinObject : lookAndFeel;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get skin():Skinable {
			return $skinObject as Skinable;
		}
		public function set skin(value:Skinable):void {
			finalizeSkinObject();
			if (!isNull(value)) {
				$skinObject = value.clone();
				$skinObject.spas_internal::uio = this;
				$hasSkin = true;
				lookAndFeel.onChange();
			} else $hasSkin = false;//--> update the old laf.
		}
		
		/**
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 	Destroys the current skin object if it exists.
		 */
		protected function finalizeSkinObject():void {
			if (!isNull($skinObject)) {
				$skinObject.finalize();
				$skinObject = null;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the hit area sprite for this <code>UIObject</code>.
		 */
		protected var $hitArea:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the <code>SizeUtil</code> object for this <code>UIObject</code>.
		 */
		protected var $storedSize:SizeUtil;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>EventCollector</code> instance
		 * 	for this <code>UIObject</code>.
		 */
		protected var $evtColl:EventCollector = new EventCollector();
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>Stage</code> instance
		 * 	for this <code>UIObject</code>.
		 */
		protected var $stage:Stage;
		
		/**
		 *  @private
		 */
		protected var $childrenToRender:uint = 0;
		
		/**
		 *  @private
		 */
		spas_internal var useReflectionTextFix:Boolean = true;
		
		/**
		 * 	@private
		 */
		spas_internal var isComponent:Boolean = false;
		
		/**
		 * 	@private
		 */
		spas_internal var invalidateChangeEvent:Boolean = false;
		
		/**
		 * 	@private
		 */
		spas_internal var metricsChanged:Boolean = false;
		
		/**
		 * 	@private
		 */
		spas_internal var invalidateLayoutUpdate:Boolean = false;
		
		/**
		 * 	@private
		 */
		spas_internal var pressedElement:String;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	Abstract draw function.
		 */
		protected function draw():void {
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		protected function createHitArea():void {
			$hitArea = new Sprite();
			$hitArea.cacheAsBitmap = true;
		}
		
		/**
		 *  @private
		 */
		protected function initMinSize(minWidth:Number = 1, minHeight:Number = 1):void {
			$defaultMinWidth = $minWidth = minWidth;
			$defaultMinHeight = $minHeight = minHeight;
		}
		
		/**
		 *  @private
		 */
		protected function initSize(width:Number, height:Number):void {
			spas_internal::lafDTO.width = $width = width;
			spas_internal::lafDTO.height = $height = height;
		}
		
		/**
		 *  @private
		 */
		protected function displayMainContainer():void {
			$parent.addChild(spas_internal::uioSprite);
		}
		
		/**
		 *  @private
		 */
		protected function refreshDisplayList():void {
			if(!$parent.contains(spas_internal::uioSprite)) displayMainContainer();
			//***********************
			// pourquoi cette methode ?
			// $uiManager.document.spas_internal::hasMainContainer(this);
			//***********************
		}
		
		/**
		 *  @private
		 */
		protected function getQuality():int {
			var q:int;
			switch($quality) {
				case Quality.BEST :
					q = 3;
					break;
				case Quality.HIGH :
					q = 2;
					break;
				case Quality.MEDIUM :
					q = 1;
					break;
				case Quality.LOW :
					q = 0;
					break;
			}
			return q;
		}
		
		/**
		 *  @private
		 */
		protected function refresh():void {
			setEffects();
		}
		
		/**
		 *  @private
		 */
		protected function unload():void {
			if (_displayEventTimer != null) deleteDisplayEvent();
			if ($displayEffectIsRendering) {
				invalidateDisplayEffect();
				removeFromTargetUIContainer();
				return;
			}
			if ($removeEffectIsRendering) return;
			if (isNull(spas_internal::uioSprite.parent)) {
				removeFromTargetUIContainer();
				return;
			}
			if ($hasRemoveEffect && getQuality() >= 1 && !invalidateEffects) {
				$removeEffectIsRendering = true;
				spas_internal::uioSprite.parent.removeChild(spas_internal::uioSprite);
				$removeEffect.play();
			} else {
				spas_internal::uioSprite.parent.removeChild(spas_internal::uioSprite);
				removeFromTargetUIContainer();
			}
		}
		
		private function createEffects():void {
			$displayEffect = new FadeIn(this);
			$evtColl.addEvent($displayEffect, EffectEvent.FINISH, displayEffectFinish);
			$evtColl.addEvent(this, UIOEvent.INVALIDATE_EFFECT, invalidateDisplayEffect);
			$removeEffect = new FadeOut(this);
			$evtColl.addEvent($removeEffect, EffectEvent.FINISH, effectFinish);
			$evtColl.addEvent(this, UIOEvent.INVALIDATE_EFFECT, invalidateRemoveEffect);
		}
		
		private function deleteDisplayEffect():void {
			$displayEffectRef = null;
			$displayEffect.finalize();
			$displayEffect = null;
		}
		
		private function deleteRemoveEffect():void {
			$removeEffectRef = null;
			$removeEffect.finalize();
			$removeEffect = null;
		}
		
		private function removeFromTargetUIContainer():void {
			$removeEffectIsRendering = false;
			if ($target is IUIContainer) {
				if ($target.spas_internal::elementsList.contains(this)) {
					Element.spas_internal::removeLayoutListener(this);
					$target.spas_internal::elementsList.remove(this);
					$target.spas_internal::uioToDisplay.remove(this);
					if ($target.content.contains(spas_internal::uioSprite)) {
						$target.content.removeChild(spas_internal::uioSprite);
					}
				}
			}
			$displayed = false;
			dispatchUIOEvent(UIOEvent.REMOVED);
			updateTargetLayout();
		}
		
		private function invalidateRemoveEffect(e:UIOEvent = null):void {
			if ($displayEffectIsRendering) return;
			/*_removeEffect.finalize();
			_removeEffect = null;*/
			$removeEffect.stop();
			//_eventCollector.removeEvent(this, UIOEvent.INVALIDATE_EFFECT, invalidateRemoveEffect);
			//_eventCollector.removeEvent(_removeEffect, EffectEvent.FINISH, effectFinish);
			removeFromTargetUIContainer();
		}
		
		private function updateTargetLayout():void {
			if ($target == $stage || $target == $uiManager.document) return;
			else if ($target is IUIContainer) {
				$target.layout.removeObject(this);
				if (!$target.spas_internal::invalidateLayoutUpdate) $target.spas_internal::updateLayout();
			}
		}
		
		/**
		 *  @private
		 */
		protected function setRefresh():void {
			if($displayed || $forceRefresh) {
				if(!$invalidateRefresh) refresh();
				dispatchChangeEvent();
				$storedSize.checkMetricsChanges();
			}
		}
		
		/**
		 *  @private
		 */
		protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			move(x, y);
			refresh();
		}
		
		/**
		 *  @private
		 */
		protected function getColor(value:*):uint {
			return ColorUtil.getColor(value);
		}
		
		/**
		 *  @private
		 */
		spas_internal function getCoordinateSpace(targetCoordinateSpace:DisplayObject):DisplayObject {
			return !isNull(targetCoordinateSpace) ? spas_internal::uioSprite : targetCoordinateSpace;
		}
		
		/**
		 *  @private
		 */
		spas_internal function addToLayoutManagerQueue(e:Object = null):void { }
		
		/**
		 *  @private
		 */
		spas_internal function setDepth(value:int):void {
			var contDepth:int = spas_internal::uioSprite.parent.getChildIndex(spas_internal::uioSprite);
			spas_internal::uioSprite.parent.swapChildrenAt(value, contDepth);
		}
		
		private var _isInitialized:Boolean = true;
		/**
		 *  @private
		 */
		spas_internal function isInitialized(initID:uint):void {
			if (!(this is Initializable)) return;// trace(this["constructor"]);
			else {
				if (this["constructor"].hasOwnProperty("spas_internal::INIT_ID")) {
					if (this["constructor"].spas_internal::INIT_ID == initID) dispatchInitEvent();
				} else dispatchInitEvent(); // We assume that in this case to object extends
											// an Initializable class without implementing the
											// Initializable internal API.
			}
		}
		
		private function dispatchInitEvent():void {
			_isInitialized = true;
			dispatchUIOEvent(UIOEvent.INITIALIZED);
		}
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _callback:Function = null;
		private var _displayEventTimer:Timer = null;
		
		//--------------------------------------------------------------------------
		//
		//  Drag and drop API:
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var dragEnbd:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get dragEnabled():Boolean {
			return spas_internal::dragEnbd;
		}
		public function set dragEnabled(value:Boolean):void {
			spas_internal::dragEnbd = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var dropEnbd:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get dropEnabled():Boolean {
			return spas_internal::dropEnbd;
		}
		public function set dropEnabled(value:Boolean):void {
			spas_internal::dropEnbd = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var dndDt:* = null;
		/**
		 * 	@inheritDoc
		 */
		public function get dndData():* {
			return spas_internal::dndDt;
		}
		public function set dndData(value:*):void {
			spas_internal::dndDt = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var dropFmt:Array = [];
		/**
		 * 	@inheritDoc
		 */
		public function get dropFormat():Array {
			return spas_internal::dropFmt;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var parentDropEnbd:Boolean = true;
		/**
		 * 	@inheritDoc
		 */
		public function get parentDropEnabled():Boolean {
			return spas_internal::parentDropEnbd;
		}
		public function set parentDropEnabled(value:Boolean):void {
			spas_internal::parentDropEnbd = value;
		}
		
		/**
		 * 	@private
		 */
		spas_internal var parentDragEnbd:Boolean = true;
		/**
		 * 	@inheritDoc
		 */
		public function get parentDragEnabled():Boolean {
			return spas_internal::parentDragEnbd;
		}
		public function set parentDragEnabled(value:Boolean):void {
			spas_internal::parentDragEnbd = value;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function addDropFormat(format:DnDFormat):void {
			spas_internal::dropFmt.push(format);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function hasDropFormat(format:DnDFormat):Boolean {
			var l:int = spas_internal::dropFmt.length -1;
			for (; l >= 0; l--) {
				if (spas_internal::dropFmt[l] == format) return true;
			}
			return false;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function removeDropFormat(format:DnDFormat):void {
			var l:int = spas_internal::dropFmt.length -1;
			for (; l >= 0; l--) {
				if (spas_internal::dropFmt[l] == format)
					spas_internal::dropFmt.splice(l, 1);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			this.focusRect = _isFinalizing = false;
			spas_internal::uioSprite = new UIOSprite()
			initTarget();
			initLafDTO();
			reflectProperties = new ReflecProperties(this, 2, .5, 127);
			$uiManager.document.spas_internal::appendChild(this);
			$storedSize = new SizeUtil(this);
			$evtColl.addEvent($storedSize, Event.CHANGE, sizeChanged);
			//_eventCollector.addEvent(this, MouseEvent.ROLL_OVER, dispatchDragEnterEvent);
			if(this is IUIContainer) $content = new Sprite();
			if (this is Focusable) createFocusEvents();
			createEffects();
			$analitycsObj = new AnalyticsObject();
		}
		
		private function initTarget():void {
			$stage = $uiManager.stage;
			spas_internal::uioSprite.spas_internal::target = this;
			if (!$uiManager.spas_internal::isInitialized() && isNull(this.stage)) 
				$uiManager.print(Locale.spas_internal::ERRORS.INIT_ERROR);// throw new Error()
			else if (!$uiManager.spas_internal::isInitialized()) $uiManager.initialize(this.stage);
			if (!isNull(this.stage)) {
				spas_internal::isComponent = true;
				$target = $parent = super;
				spas_internal::lafDTO.width = $width = super.width;
				spas_internal::lafDTO.height = $height = super.height;
				super.scaleX = super.scaleY = 1;
				if ($parent.numChildren > 0) $parent.removeChildAt(0);
			} else {
				$target = $parent = $uiManager.hasMainContainer() ?
					$uiManager.document : $stage;
			}
			_guid = new GUID();
		}
		
		private function onDisplay():void {
			_displayEventTimer = new Timer(50, 1);
			//--> Dirty hack to compensate the no multithread support in AS3:
			$evtColl.addEvent(_displayEventTimer, TimerEvent.TIMER, dispatchDisplayEvent);
			_displayEventTimer.start();
		}
		
		private function dispatchDisplayEvent(e:TimerEvent):void {
			$evtColl.removeEvent(_displayEventTimer, TimerEvent.TIMER, dispatchDisplayEvent);
			doReflection();
			dispatchUIOEvent(UIOEvent.DISPLAYED);
			if(!isNull(_callback)) _callback();
			_callback = null;
			_displayEventTimer = null;
		}
		
		private function deleteDisplayEvent():void {
			$evtColl.removeEvent(_displayEventTimer, TimerEvent.TIMER, dispatchDisplayEvent);
			_displayEventTimer.stop();
			_displayEventTimer = null;
		}
		
		private function effectFinish(e:EffectEvent):void {
			var t:Timer = new Timer(35, 1);
			//--> Dirty hack to compensate the no multithread support in AS3:
			$evtColl.addEvent(t, TimerEvent.TIMER, dispatchRemoveEvent);
			t.start();
		}
		
		private function dispatchRemoveEvent(e:TimerEvent):void {
			//updateTargetLayout();
			$evtColl.removeEvent(e.target, TimerEvent.TIMER, dispatchRemoveEvent);
			removeFromTargetUIContainer();
		}
		
		private function hasTextureManager():Boolean {
			return ( !isNull($textureManager));
		}
		
		private function hasBackgroundTextureManager():Boolean {
			return (!isNull($backgroundTextureManager));
		}
		
		private function fixChildrenDoubleClickEnabled(obj:DisplayObject, value:Boolean):void {
			/*var i:int = 0;
			var elm:InteractiveObject;
			for (;  i < obj.numChildren; i++) {
				elm = obj.getChildAt(i) as InteractiveObject;
				//trace(this, elm);
				if (elm) elm.doubleClickEnabled = value;
			}
			if (this is IUIContainer) {
				for (i=0;  i < this.numElements; i++) {
					elm = this.getElementAt(i) as InteractiveObject;
					if (elm) elm.doubleClickEnabled = value;
				}
			}*/
		}
		
		//--------------------------------------------------------------------------
		//
		//  Effect management
		//
		//--------------------------------------------------------------------------
		
		private static const SHADOW:Array = [];
		private static const GLOW:Array = [];
		
		private static var _defaultShadowFilter:DropShadowFilter = new DropShadowFilter(1.5, 90, 0, .5);
		private static var _defaultGlowFilter:GlowFilter =  new GlowFilter (0x0066CC, .5, 10, 10);
		
		/**
		 *  @private
		 */
		protected var $reflect:Reflection = null;
		
		/**
		 * 	@private
		 */
		spas_internal function deactivateShadow():void {
			removeShadow();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function reactivateShadow():void {
			if (shadow) setShadow();
		}
		
		/**
		 *  @private
		 */
		protected function setShadow():void {
			var filter:DropShadowFilter = (this is LafRenderer) ?
				lookAndFeel.getShadowFilter() : _defaultShadowFilter;
			removeShadow();
			SHADOW.push(filter);
			spas_internal::uioSprite.filters = SHADOW;
		}
		
		/**
		 *  @private
		 */
		protected function removeShadow():void {
			SHADOW.pop();
			spas_internal::uioSprite.filters = SHADOW;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function deactivateGlow():void {
			removeGlowFilter();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function reactivateGlow():void {
			if (glow) setGlow();
		}
		
		/**
		 *  @private
		 */
		protected function setGlow():void {
			var filter:GlowFilter = (this is LafRenderer) ?
				lookAndFeel.getGlowFilter() : _defaultGlowFilter;
			removeGlowFilter();
			if (!isNaN($glowColor)) filter.color = $glowColor;
			GLOW.push(lookAndFeel.getGlowFilter());
			spas_internal::uioSprite.filters = GLOW;
		}
		
		/**
		 *  @private
		 */
		protected function removeGlowFilter():void {
			GLOW.pop();
			spas_internal::uioSprite.filters = GLOW;
		}
		
		/**
		 *  @private
		 */
		protected function setEffects():void {
			if($dropShadow) setShadow();
			if($glowFilter) setGlow();
			doReflection();
		}
		
		/**
		 *  @private
		 */
		protected function doStartEffect(callback:Function = null):void {
			$displayed = true;
			if ($displayEffectIsRendering) return;
			if ($removeEffectIsRendering) invalidateRemoveEffect();
			_callback = callback;
			//$uiManager.cssManager.spas_internal::setCSS(this);
			if (this is IUIContainer) spas_internal::addToLayoutManagerQueue();
			if ($childrenToRender > 0 && !(this is IMainContainer) && $hasDisplayEffect && !invalidateEffects) {
				$displayEffectIsRendering = true;
				var t:Timer = new Timer(5, 0);
				$evtColl.addEvent(t, TimerEvent.TIMER, checkChildrenToRender);
				t.start();
			} else renderDisplayEffect();
		}
		
		private function checkChildrenToRender(e:TimerEvent):void {
			//trace(childrenToRender);
			if ($childrenToRender == 0) {
				var t:Timer = e.target as Timer;
				$evtColl.removeEvent(t, TimerEvent.TIMER, checkChildrenToRender);
				t.stop();
				t = null;
				spas_internal::addToLayoutManagerQueue();
				renderDisplayEffect();
			}
		}
		
		private function renderDisplayEffect():void {
			if ($hasDisplayEffect && getQuality() >= 1) {
				$displayEffectIsRendering = true;
				$displayEffect.play();
			} else {
				refreshDisplayList();
				onDisplay();
			}
			//$uiManager.spas_internal::refreshDocumentPage(this);
			var app:* = $uiManager.document;
			if($target == app.spas_internal::appContainer) app.redraw();
		}
		
		private function setEffectDuration(fx:Effect, duration:Number):void {
			if(!isNaN(duration)) fx.duration = duration;
		}
		
		private function displayEffectFinish(e:EffectEvent):void {
			$displayEffect.stop();
			$displayEffectIsRendering = false;
			refreshDisplayList();
			onDisplay();
		}
		
		private function invalidateDisplayEffect(e:UIOEvent = null):void {
			if ($removeEffectIsRendering) return;
			$displayEffect.stop();
			$displayEffectIsRendering = false;
		}
		
		private function initReflect():void {
			if (!isNull($reflect)) $reflect.finalize();
			$reflect = new Reflection(	spas_internal::uioSprite, reflectProperties.gap,
										reflectProperties.alpha, reflectProperties.ratio,
										reflectProperties.interval);
		}
		
		/**
		 *  @private
		 */
		protected function doReflection():void {
			if($reflection && $displayed) {
				/*if(this is IUIContainer) {
					_content.scaleX = _content.scaleY = 0;
					_reflect.hide();
					var r:Rectangle = CONTAINER.getBounds(null);
					_reflect.show();
					_content.scaleX = _content.scaleY = 1;
					_reflect.setRectangle(r);
				}
				else _reflect.render();*/
				$reflect.useReflectionTextFix = spas_internal::useReflectionTextFix;
				$reflect.render();
			}
		}
		
		private function sizeChanged(e:Event):void {
			dispatchMetricsEvent();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event management
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		protected var dispatchOnReleaseOutside:Boolean = false;
		
		/**
		 *  @private
		 */
		protected function dispatchChangeEvent():void {
			if (!spas_internal::invalidateChangeEvent) dispatchUIOEvent(UIOEvent.CHANGED);
		}
		
		/**
		 *  @private
		 */
		protected function dispatchMetricsEvent():void {
			if (!invalidateMetricsChanges && !spas_internal::deactivateMetricsChanges)
				dispatchUIOEvent(UIOEvent.METRICS_CHANGED);
		}
		
		/**
		 *  @private
		 */
		protected function dispatchButtonEvent(type:String):void { 
			dispatchEvent(new UIMouseEvent(type));
		}
		
		/**
		 *  @private
		 */
		protected function dispatchUIOEvent(type:String):void { 
			dispatchEvent(new UIOEvent(type));
		}
		
		/**
		 *  @private
		 */
		protected function onClick(e:MouseEvent):void {
			if ($active && $enabled) dispatchButtonEvent(UIMouseEvent.CLICK);
		}
		
		/**
		 *  @private
		 */
		protected function onDoubleClick(e:MouseEvent):void {
			if ($active && $enabled) dispatchButtonEvent(UIMouseEvent.DOUBLE_CLICK);
		}
		
		/**
		 *  @private
		 */
		protected function onPressEvent(e:MouseEvent):void {
			if ($active && $enabled) dispatchOnReleaseOutside = true;
			var me:UIMouseEvent = new UIMouseEvent(UIMouseEvent.PRESS, true);
			me.localX = e.localX;
			me.localY = e.localY;
			dispatchEvent(me);
		}
		
		/**
		 *  @private
		 */
		protected function onPressOutsideEvent(e:MouseEvent):void { 
			if ($active  && $enabled && !spas_internal::uioSprite.hitTestPoint($stage.mouseX, $stage.mouseY))
				dispatchButtonEvent(UIMouseEvent.PRESS_OUTSIDE);
		}
		/**
		 *  @private
		 */
		protected function onReleaseEvent(e:MouseEvent):void {
			if($active && $enabled) dispatchButtonEvent(UIMouseEvent.RELEASE);
		}
		/**
		 *  @private
		 */
		protected function onReleaseOutsideEvent(e:MouseEvent):void { 
			if ($active  && $enabled && !spas_internal::uioSprite.hitTestPoint($stage.mouseX, $stage.mouseY) && dispatchOnReleaseOutside)
				dispatchButtonEvent(UIMouseEvent.RELEASE_OUTSIDE);
				dispatchOnReleaseOutside = false;
		}
		/**
		 *  @private
		 */
		protected function onRollOverEvent(e:MouseEvent):void {
			dispatchButtonEvent(UIMouseEvent.ROLL_OVER);
		}
		/**
		 *  @private
		 */
		protected function onRollOutEvent(e:MouseEvent):void {
			dispatchButtonEvent(UIMouseEvent.ROLL_OUT);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Debuging API
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function print(...arguments):void {
			$uiManager.print(arguments);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get debugger():Debugger {
			return $uiManager.debugger;
		}
		
		/**
		 * 	Timer output object
		 *  @private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 	
		 */
		protected function printTimer(flag:String = "UIObject.getTimer(): "):void {
			var s:String =  flag + this + " at " + flash.utils.getTimer();
			$uiManager.print(s);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Focus management
		//
		//--------------------------------------------------------------------------
		
		private function createFocusEvents():void {
			$evtColl.addEvent(this, FocusEvent.FOCUS_IN, focusInHandler);
			$evtColl.addEvent(this, FocusEvent.FOCUS_OUT, focusOutHandler);
			$evtColl.addEvent(this, KeyboardEvent.KEY_DOWN, keyDownHandler);
			$evtColl.addEvent(this, KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		/**
		 *  @private
		 */
		protected function keyDownHandler(e:KeyboardEvent):void { }
		
		/**
		 *  @private
		 */
		protected function keyUpHandler(e:KeyboardEvent):void { }
		
		/**
		 *  @private
		 */
		protected function focusInHandler(e:FocusEvent):void { }
		
		/**
		 *  @private
		 */
		protected function focusOutHandler(e:FocusEvent):void { }
		
		//--------------------------------------------------------------------------
		//
		//  DTO utils
		//
		//--------------------------------------------------------------------------
		
		private function fixColorState(value:*):void {
			if ($colors != null) spas_internal::lafDTO.colors.up = $colors.up = value;
		}
		
		private function fixBorderColorState(value:*):void {
			if ($borderColors != null) spas_internal::lafDTO.borderColors.up = $borderColors.up = value;
		}
		
		/**
		 *  @private
		 */
		protected function createColorsObj():void {
			$colors = new ColorState(this);
			spas_internal::lafDTO.colors = $colors;
		}
		
		/**
		 *  @private
		 */
		protected function createBorderColorsObj():void {
			$borderColors = new ColorState(this);
			spas_internal::lafDTO.borderColors = $borderColors;
		}
		
		/**
		 *  @private
		 */
		protected function createTextureManager(target:DisplayObject):void {
			$textureManager = new TextureManager(target);
			spas_internal::lafDTO.textureManager = $textureManager;
		}
		
		/**
		 *  @private
		 */
		protected function createBackgroundTextureManager(target:DisplayObject):void {
			$backgroundTextureManager = new TextureManager(target);
			spas_internal::lafDTO.backgroundTextureManager = $backgroundTextureManager;
		}
		
		//--------------------------------------------------------------------------
		//
		//  UIDescriptor API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function setUIManager(uiManager:Class):void {
			$uiManager = uiManager;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the <code>IUIManager</code> that manages
		 * 	the current SPAS 3.0 API.
		 * 
		 * 	@see org.flashapi.swing.core.UIDescriptor
		 */
		protected static var $uiManager:*;
	}
}