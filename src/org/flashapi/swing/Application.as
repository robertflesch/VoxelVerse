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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// Application.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 10/05/2010 14:16
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.containers.MainContainer;
	import org.flashapi.swing.containers.PseudoMainContainer;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.crypto.GUID;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.core.Version;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.ApplicationEvent;
	import org.flashapi.swing.exceptions.AlreadyBoundException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.layout.Layout;
	import org.flashapi.swing.managers.CSSManager;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.text.CssString;
	
	use namespace spas_internal;
	
	[IconFile("Application.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when an external CSS has been succesfully loaded by the application.
	 *
	 *  @eventType org.flashapi.swing.event.ApplicationEvent.STYLE_LOADED
	 */
	[Event(name = "styleLoaded", type = "org.flashapi.swing.event.ApplicationEvent")]
	
	/**
	 *  Dispatched each time the application is resized.
	 *
	 *  @eventType org.flashapi.swing.event.ApplicationEvent.RESIZED
	 */
	[Event(name = "resized", type = "org.flashapi.swing.event.ApplicationEvent")]
	
	/**
	 * 	<img src="Application.png" alt="Application" width="18" height="18"/>
	 * 
	 *  SPAS 3.0 defines a default, or <code>Application</code>, container that
	 * 	lets you start adding content to your application without explicitly
	 * 	defining another container.
	 * 
	 * 	<p>To create SPAS 3.0 apllications, you can use both, Flex SDK and the the
	 * 	Flash IDE.</p>
	 * 
	 *  <p>There are two different ways for creating <code>Application</code> containers
	 * 	from the Flash IDE:</p>
	 * 	<ul>
	 * 		<li>by creating a <code>Document</code> class that subclasses the 
	 * 		<code>Application</code> class,</li>
	 * 		<li>by using SPAS 3.0 directly from the main timeline; in that case,
	 * 		you must use the <code>UIManager.initialize()</code> method.</li>
	 * 	</ul>
	 * 
	 * 	<p><strong>You can use the same <code>Document</code> class for building SPAS 3.0 
	 * 	from the free Flex SDK and the Flash IDE.</strong></p>
	 * 
	 * 	<p>when you use SPAS 3.0 from the main timeline, you cannot access to methods
	 * 	and properties defined for the <code>Application</code> class even if SPAS 3.0
	 * 	internal mechanisms do.</p>
	 * 
	 * 	<p>The following codes shows both ways to initialize the SPAS 3.0 API:
	 * 		<listing version="3.0">
	 * 			//SPAS 3.0 Document-class-based application.
	 * 			package {
	 * 
	 * 				import org.flashapi.swing.*;
	 * 
	 * 				public class MyApplication extends Application {
	 * 
	 * 					public function MyApplication():void {
	 * 						super(entryPoint);
	 * 					}
	 * 					
	 * 					private function entryPoint():void {
	 * 						// Entry point...
	 * 					}
	 * 				}
	 * 			}
	 * 		</listing>
	 * 		<listing version="3.0">
	 * 			//SPAS 3.0 main-timeline-based application.
	 * 			import org.flashapi.swing.*;
	 * 
	 * 			//Use the this keyword to declare the main timeline as your application.
	 * 			UIManager.initialize(this)
	 * 		</listing>
	 * 	</p>
	 * 
	 *	<p><strong>The <code>Application</code> instance can be accessed through the
	 * 	<code>UIManager.document</code> property.</strong></p>
	 * 
	 * 	<p>Because SPAS 3.0 is designed to provide high-level graphical support for all
	 * 	kind of works, the background of an application is not visible by default. Set
	 * 	the <code>bodyVisibility</code> property to <code>true</code> to show it.</p>
	 * 
	 * 	<p>You cannot create more than one <code>Application</code> object into the same
	 * 	compiled swf file; but you can add as many swf compiled applications as you want,
	 * 	by loading external <code>Application</code> compiled within their own swf files.</p>
	 *
	 * 	<p><strong>Note:</strong> when you load external <code>Application</code> files
	 * 	into your main application, some functionalities, such as the <code>gadientProperties</code>
	 * 	property, can no longer be modified for the loaded application.</p>
	 *
	 * 	<p><strong>The <code>Application</code> class supports the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">align</code></td>
	 * 			<td>Sets the vertical and horizontal alignments for this object.</td>
	 * 			<td>Recognized values are <code class="css">top</code>, <code class="css">middle</code>,
	 * 			<code class="css">bottom</code>, <code class="css">left</code>, <code class="css">center</code>
	 * 			and <code class="css">right</code></td>
	 * 			<td><code>horizontalAlignment</code> or <code>verticalAlignment</code></td>
	 * 			<td><code>Properties.ALIGN</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">color</code></td>
	 * 			<td>Sets the background color of the application.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td>color</td>
	 * 			<td><code>Properties.COLOR</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">gradient</code></td>
	 * 			<td>Indicates whether the application background has plain or gradient colors.</td>
	 * 			<td>Recognized values are <code class="css">true</code> or <code class="css">false</code>.</td>
	 * 			<td>gradientBackground</td>
	 * 			<td><code>Properties.GRADIENT</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">gradient-colors</code></td>
	 * 			<td>Sets the gradient colors of the application background.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).
	 * 			Colors must be separated by a "white space" delimiter.</td>
	 * 			<td>gradientProperties.colors</td>
	 * 			<td><code>Properties.GRADIENT-COLORS</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">horizontal-align</code></td>
	 * 			<td>Specifies the horizontal alignment of this object.</td>
	 * 			<td>Possible values are <code class="css">left</code>, <code class="css">center</code>
	 * 			and <code class="css">right</code>.</td>
	 * 			<td>horizontalAlignment</td>
	 * 			<td><code>Properties.HORIZONTAL_ALIGN</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">horizontal-gap</code></td>
	 * 			<td>Sets the horizontal gap value for this object.</td>
	 * 			<td>Possible values are valid numbers.</td>
	 * 			<td><code>horizontalGap</code></td>
	 * 			<td><code>Properties.HORIZONTAL_GAP</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">scroll-policy</code></td>
	 * 			<td>Sets the scroll policy for this object.</td>
	 * 			<td>Valid values are <code class="css">both</code>, <code class="css">none</code>,
	 * 			<code class="css">vertical</code>, <code class="css">horizontal</code>,
	 * 			<code class="css">auto</code>.</td>
	 * 			<td><code>scrollPolicy</code></td>
	 * 			<td><code>Properties.SCROLL_POLICY</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">visibility</code></td>
	 * 			<td>Sets the visibility of the object.</td>
	 * 			<td>Valid values are <code class="css">hidden</code> or
	 * 			<code class="css">visible</code>.</td>
	 * 			<td><code>bodyVisibility</code></td>
	 * 			<td><code>Properties.VISIBILITY</code></td>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">vertical-align</code></td>
	 * 			<td>Specifies the vertical alignment of this object.</td>
	 * 			<td>Possible values are <code class="css">top</code>, <code class="css">middle</code>
	 * 			and <code class="css">bottom</code>.</td>
	 * 			<td><code>verticalAlignment</code></td>
	 * 			<td><code>Properties.VERTICAL_ALIGN</code></td>
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
	 *  @includeExample ApplicationExample.as
	 * 
	 *  @see org.flashapi.swing.UIManager
	 *  @see org.flashapi.swing.containers.MainContainer
	 * 	@see org.flashapi.swing.ApplicationLoader
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public dynamic class Application extends MovieClip implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. Creates a new <code>Application</code> instance with the
		 * 	specified entry point function.
		 * 
		 * 	@param	entryPoint	A <code>Function</code> that will be called after
		 * 						this <code>Application</code> instance will be initialized.
		 * 						Considering SPAS 3.0 best practices, this function
		 * 						always should specify the entry point of your applications.
		 */
		public function Application(entryPoint:Function = null) {
			super();
			initObj(entryPoint);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Debuging API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	[Debuging API] 
		 * 	Displays expressions, or writes to log files, while debugging. A single
		 * 	print statement can support multiple arguments. If any argument in a print
		 * 	statement includes a data type other than a <code>String</code>, the print
		 * 	function invokes the associated <code>toString()</code> method for that
		 * 	data type.
		 * 
		 * 	<p>The <code>print()</code> method is equivalent to the <code>UIManager.print()</code>
		 * 	methods.</p>
		 * 
		 * 	@see org.flashapi.swing.UIManager#print()
		 * 
		 * 	@param	...arguments One or more (comma separated) expressions to evaluate.
		 * 	For multiple expressions, a space is inserted between each expression into
		 * 	the output.
		 */
		public function print(...arguments):void {
			UIManager.print(arguments);
		}
		
		/**
		 * 	Returns the current version of the SPAS 3.0 Framework.
		 * 
		 * 	@return A string that represent the current version of the SPAS 3.0 Framework.
		 */
		public function getVersion():String {
			return Version.toString();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the main container
		 * 	automatically adjusts its height (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 	
		 * 	<p>If both, <code>autoHeight</code> and <code>autoWidth</code> are 
		 * 	<code>true</code>, the <code>autoSize</code> property is automatically 
		 * 	set to <code>true</code>.</p>
		 * 
		 * 	@default true
		 * 
		 * 	@see #autoSize
		 * 	@see #autoWidth
		 */
		public function get autoHeight():Boolean {
			return _targetContainer.autoHeight;
		}
		public function set autoHeight(value:Boolean):void {
			_targetContainer.autoHeight = value;
		}
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the main container 
		 * 	sets its size itself (<code>true</code>), or not(<code>false</code>).
		 * 
		 * 	<p>If both, <code>autoHeight</code> and <code>autoWidth</code> are 
		 * 	<code>true</code>, the <code>autoSize</code> property is automatically 
		 * 	set to <code>true</code>.</p>
		 *  
		 *  @default true
		 * 
		 * 	@see #autoHeight
		 * 	@see #autoWidth
		 */
		public function get autoSize():Boolean {
			return _targetContainer.autoSize;
		}
		public function set autoSize(value:Boolean):void {
			_targetContainer.autoSize = value;
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the main container
		 * 	automatically adjusts its width (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 	
		 * 	<p>If both, <code>autoHeight</code> and <code>autoWidth</code> are 
		 * 	<code>true</code>, the <code>autoSize</code> property is automatically 
		 * 	set to <code>true</code>.</p>
		 * 
		 * 	@default true
		 * 
		 * 	@see #autoSize
		 * 	@see #autoHeight
		 */
		public function get autoWidth():Boolean {
			return _targetContainer.autoWidth;
		}
		public function set autoWidth(value:Boolean):void {
			_targetContainer.autoWidth = value;
		}
		
		/**
		 * 	Returns a reference to the <code>Canvas</code> instance which is used as
		 * 	intermediate background container for this <code>Application</code> instance.
		 * 	The following image illustrates the organization of SPAS 3.0 <code>Application</code>
		 * 	containers and the position of the <code>background</code> container in the
		 * 	vertical hierarchy:
		 * 	<p><img src = "../../../doc-images/application.jpg" alt="SPAS 3.0 Application
		 * 	organization." /></p>
		 * 
		 * 	@see #backgroundPosition
		 * 	@see #content
		 */
		public function get background():Canvas {
			return spas_internal::appContainer.spas_internal::backgroundCanvas;
		}
		
		/**
		 * 	Sets or gets the position of the <code>background</code> <code>Canvas</code>.
		 * 	If <code>null</code>, the position of the <code>background</code> <code>Canvas</code>
		 * 	is the same as the <code>content</code> container position.
		 * 	
		 * 	<p><strong>Note:</strong> when you change the <code>backgroundPosition</code> property,
		 * 	the main container is automatically redrawn.</p>
		 * 
		 * 	@default null
		 * 
		 * 	@see #background
		 * 	@see #content
		 */
		public function get backgroundPosition():Point {
			return spas_internal::appContainer.spas_internal::backgroundPosition;
		}
		public function set backgroundPosition(value:Point):void {
			spas_internal::appContainer.spas_internal::backgroundPosition = value;
			spas_internal::appContainer.redraw();
		}
		
		/**
		 * 	Indicates whether the application body is visible (<code>true</code>), or not
		 * 	(<code>false</code>). Because SPAS 3.0 is designed for being easilly used by
		 * 	Flash developers and Flash designers, the default value is <code>false</code>;
		 * 	this allows to use backgrounds designed with Flash authoring tools.
		 * 
		 * 	@default false
		 * 
		 * 	@see #color
		 */
		public function get bodyVisibility():Boolean {
			return spas_internal::appContainer.spas_internal::body.visible;
		}
		public function set bodyVisibility(value:Boolean):void {
			spas_internal::appContainer.spas_internal::body.visible = value;
		}
		
		/**
		 *  Sets or gets the body color of the application. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> 
		 *  recommendation to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> 
		 *  section of the document to get valid SVG color keyword names.</p>
		 * 
		 *  <p>The default value is <code>0x93A9B4</code>.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #bodyVisibility
		 */
		public function get color():* {
			return _targetContainer.color;
		}
		public function set color(value:*):void {
			_targetContainer.color = value;
			_targetContainer.redraw();
		}
		
		private var _content:Sprite;
		/**
		 * 	Returns a reference to the <code>Sprite</code> container that holds
		 * 	all <code>UIObjects</code> displayed within this application.
		 * 	The following image illustrates the organization of SPAS 3.0 <code>Application</code>
		 * 	containers and the position of the <code>content</code> container in the
		 * 	vertical hierarchy:
		 * 	<p><img src = "../../../doc-images/application.jpg" alt="SPAS 3.0 Application
		 * 	organization." /></p>
		 * 
		 * 	@see #background
		 */
		public function get content():Sprite {
			return _content;
		}
		
		/**
		 * 	Returns a <code>Rectangle</code> object that represents the bounds defined 
		 * 	by all elements added into the main container of this <code>Application</code>
		 * 	instance.
		 */
		public function get contentMetrics():Rectangle {
			return _targetContainer is MainContainer ?
				(_targetContainer as MainContainer).spas_internal::getContentMetrics() :
				_targetContainer.getBounds(null);
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>Application</code>
		 * 	has been added to the Flash Player display list (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get displayed():Boolean {
			return _displayed;
		}
		
		private var _entryPoint:Function = null;
		/**
		 * 	A <code>Function</code> that will be called after this <code>Application</code>
		 * 	instance will be initialized. Considering SPAS 3.0 best practices, this function
		 * 	always should specify the entry point of your applications.
		 * 
		 * 	@default null
		 * 
		 * 	@throws org.flashapi.swing.exceptions.AlreadyBoundException An
		 * 	<code>AlreadyBoundException</code> if an <code>entryPoint</code> function
		 * 	has already been set.
		 */
		public function get entryPoint():Function {
			return _entryPoint;
		}
		public function set entryPoint(value:Function):void {
			if (_entryPoint != null) {
				throw new AlreadyBoundException(Locale.spas_internal::ERRORS.ENTRY_POINT_ERROR);
			}
			_entryPoint = value;
			if (_isAddedToStage) _entryPoint();
			else $evtColl.addEvent(this, Event.ADDED_TO_STAGE, callEntryPoint);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The <code>EventCollector</code> instance for this <code>Application</code>
		 * 	instance.
		 */
		protected var $evtColl:EventCollector = new EventCollector();
		/**
		 *  A reference to the internal <code>EventCollector</code> instance for this
		 * 	<code>Application</code> instance. As the returned <code>EventCollector</code>
		 * 	instance allows direct access to the internal event gesture of SPAS 3.0 
		 * 	applications, you never should try to access this property.
		 *  
		 *  <p><strong>Calling the <code>EventCollector.removeAllEvents()</code> method
		 *  for the <code>eventCollector</code> property will definitely destroy the internal
		 * 	event handling mechanism of this <code>Application</code> instance.</strong></p>
		 *  
		 *  @see org.flashapi.swing.event.EventCollector
		 */
		public function get eventCollector():EventCollector {
			return $evtColl;
		}
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the application is currently
		 * 	displayed in full-screen mode (<code>true</code>), or in normal window mode
		 * 	<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see org.flashapi.swing.UIManager#setFullScreen()
		 * 	@see org.flashapi.swing.UIManager#getFullScreen()
		 */
		public function get fullScreen():Boolean {
			return UIManager.getFullScreen(); }
		public function set fullScreen(value:Boolean):void {
			UIManager.setFullScreen(value);
		}
		
		/**
		 *  A reference to the <code>gadientProperties</code> object defined by the <code>TextureManager</code>
		 * 	instance for the application main container.
		 *  The <code>gadientProperties</code> object defines the values to use for creating gradient
		 * 	textures instead of plain color for the body of the main container.
		 * 
		 * 	<p>If <code>gradientMode</code> property is <code>true</code>, gradient properties defined by
		 * 	the <code>gadientProperties</code> object are used to create the new gradient texture.</p>
		 * 
		 *  <p>Properties for the body gradient properties object are:
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
		 *  @see #texture
		 *  @see #gradientBackground
		 *  @see #gradientMode
		 * 	@see #setGradientProperties()
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		public function get gradientProperties():Object {
			return _targetContainer.gradientProperties;
		}
		public function set gradientProperties(value:Object):void {
			_targetContainer.gradientProperties = value;
		}
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the application <code>TextureManager</code>
		 * 	creates a new gradient texture with the body of the main container (<code>true</code>),
		 * 	or not <code>false</code>).
		 *  
		 * 	@default false
		 * 
		 *  @see #texture
		 *  @see #gradientProperties
		 *  @see #gradientMode
		 * 	@see #setGradientProperties()
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		public function get gradientBackground():Boolean {
			return _targetContainer.gradientMode;
		}
		public function set gradientBackground(value:Boolean):void {
			_targetContainer.gradientMode = value;
			_targetContainer.redraw();
		}
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the application <code>TextureManager</code>
		 * 	creates a new gradient texture with the body of the main container (<code>true</code>),
		 * 	or not <code>false</code>).
		 *  
		 * 	<p>The <code>gradientMode</code> property is similar to the <code>gradientBackground</code> 
		 * 	property. It is only implemented for CSS compatibility.</p>
		 * 
		 * 	@default false
		 * 
		 *  @see #texture
		 *  @see #gradientProperties
		 *  @see #gradientBackground
		 * 	@see #setGradientProperties()
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		public function get gradientMode():Boolean {
			return _targetContainer.gradientMode;
		}
		public function set gradientMode(value:Boolean):void {
			this.gradientBackground = value;
		}
		
		/**
		 * 	Returns an object that represents the Genuine Unique IDentifier of this
		 * 	<code>Application</code> instance.
		 * 
		 * 	<p>This property is unique and is automatically generated by the SPAS 3.0
		 * 	Framework, each time a new <code>Application</code> instance is created.</p>
		 * 
		 * 	@see org.flashapi.swing.crypto.GUID
		 */
		public function get guid():GUID {
			return _targetContainer.guid;
		}
		
		private var _hAlign:String = HorizontalAlignment.CENTER;
		/**
		 * 	The <code>horizontalAlignment</code> property specifies or retrieves a <code>Boolean</code>
		 * 	value that indicates the horizontal placement of the main container.
		 * 	<p>Valid values are:
		 * 		<ul>
		 * 			<li><code>HorizontalAlignment.LEFT</code>,</li>
		 * 			<li><code>HorizontalAlignment.CENTER</code>,</li>
		 * 			<li><code>HorizontalAlignment.RIGHT</code>.</li>
		 * 		</ul>
		 * 	</p>
		 * 	
		 * 	@default HorizontalAlignment.CENTER
		 * 	
		 * 	@see #verticalAlignment
		 */
		public function get horizontalAlignment():String {
			return _hAlign;
		}
		public function set horizontalAlignment(value:String):void {
			_hAlign = value;
			_targetContainer.redraw();
		}
		
		/**
		 *  Sets or gets the horizontal gap of the main container for this 
		 * 	<code>Application</code> instance.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #verticalGap
		 */
		public function get horizontalGap():Number {
			return _targetContainer.horizontalGap;
		}
		public function set horizontalGap(value:Number):void {
			_targetContainer.horizontalGap = value;
			_targetContainer.redraw();
		}
		
		/**
		 *  The <code>Layout</code> instance which is defined to laid out display
		 * 	objects within the main container of this <code>Application</code> instance.
		 * 
		 * 	@default FlowLayout
		 * 
		 * 	@see org.flashapi.swing.layout.Layout
		 * 	@see org.flashapi.swing.layout.FlowLayout
		 */
		public function get layout():Layout {
			return _targetContainer.layout;
		}
		public function set layout(value:Layout):void {
			_targetContainer.layout = value;
			_targetContainer.redraw();
		}
		
		/**
		 *  The <code>marginLeft</code> property defines the left-hand margin of the
		 * 	application main container. 
		 *
		 *  @default 0
		 * 
		 *  @see #marginTop
		 * 	@see #marginRight
		 * 	@see #marginBottom
		 */
		public function get marginLeft():Number {
			return _targetContainer.marginLeft;
		}
		public function set marginLeft(value:Number):void {
			_targetContainer.marginLeft = value;
		}
		
		/**
		 *  The <code>marginTop</code> property defines the top margin of the
		 * 	application main container. 
		 *
		 *  @default 0
		 * 
		 * 	@see #marginLeft
		 * 	@see #marginRight
		 * 	@see #marginBottom
		 */
		public function get marginTop():Number {
			return _targetContainer.marginTop;
		}
		public function set marginTop(value:Number):void {
			_targetContainer.marginTop = value;
		}
		
		/**
		 *  The <code>marginRight</code> property defines the right-hand margin of the
		 * 	application main container. 
		 *
		 *  @default 0
		 * 
		 *  @see #marginTop
		 * 	@see #marginLeft
		 * 	@see #marginBottom
		 */
		public function get marginRight():Number {
			return _targetContainer.marginRight;
		}
		public function set marginRight(value:Number):void {
			_targetContainer.marginRight = value;
		}
		
		/**
		 *  The <code>marginBottom</code> property defines the bottom margin of the
		 * 	application main container. 
		 *
		 *  @default 0
		 * 
		 *  @see #marginTop
		 * 	@see #marginLeft
		 * 	@see #marginRight
		 */
		public function get marginBottom():Number {
			return _targetContainer.marginBottom;
		}
		public function set marginBottom(value:Number):void {
			_targetContainer.marginBottom = value;
		}
		
		/**
		 *  The <code>paddingBottom</code> property defines the bottom padding of the
		 * 	application main container. 
		 *
		 *  @default 0
		 * 
		 *  @see #setPadding()
		 *  @see #paddingTop
		 * 	@see #paddingRight
		 * 	@see #paddingLeft
		 */
		public function get paddingBottom():Number {
			return _targetContainer.paddingBottom;
		}
		public function set paddingBottom(value:Number):void {
			_targetContainer.paddingBottom = value;
		}
		
		/**
		 *  The <code>paddingLeft</code> property defines the left-hand padding of the
		 * 	application main container. 
		 *
		 *  @default 0
		 * 
		 *  @see #setPadding()
		 *  @see #paddingTop
		 * 	@see #paddingRight
		 * 	@see #paddingBottom
		 */
		public function get paddingLeft():Number {
			return _targetContainer.paddingLeft;
		}
		public function set paddingLeft(value:Number):void {
			_targetContainer.paddingLeft = value;
		}
		
		/**
		 *  The <code>paddingRight</code> property defines the right-hand padding of the
		 * 	application main container.  
		 *
		 *  @default 0
		 * 
		 *  @see #setPadding()
		 *  @see #paddingTop
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 */
		public function get paddingRight():Number {
			return _targetContainer.paddingRight;
		}
		public function set paddingRight(value:Number):void {
			_targetContainer.paddingRight = value;
		}
		
		/**
		 *  The <code>paddingTop</code> property defines the top padding of the
		 * 	application main container.    
		 *
		 *  @default 0
		 * 
		 *  @see #setPadding()
		 * 	@see #paddingRight
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 */
		public function get paddingTop():Number {
			return _targetContainer.paddingTop;
		}
		public function set paddingTop(value:Number):void {
			_targetContainer.paddingTop = value;
		}
		
		/**
		 *  A reference to the <code>texture</code> property of the application
		 * 	<code>TextureManager</code> instance.
		 * 
		 *  @see #gradientMode
		 *  @see #textureManager
		 *  @see #gradientProperties
		 *  @see org.flashapi.swing.managers.TextureManager
		 */
		public function get texture():* {
			return _targetContainer.texture;
		}
		public function set texture(value:*):void {
			_targetContainer.texture = value;
			_targetContainer.redraw();
		}
		
		/**
		 *  A reference to the <code>TextureManager</code> instance for this
		 * 	<code>Application</code> instance.
		 *
		 *  @see #gradientMode
		 *  @see #texture
		 *  @see #gradientProperties
		 *  @see org.flashapi.swing.managers.TextureManager
		 * 
		 * 	@default null
		 */
		public function get textureManager():TextureManager {
			return _targetContainer.textureManager;
		}
		
		/**
		 * 	The CSS selector value for all <code>Application</code> instances;
		 * 	always returns the value specified by the <code>Selectors.BODY</code>
		 * 	constant.
		 */
		public function get selector():String {
			return Selectors.BODY;
		}
		
		/**
		 * 	Sets the style of this <code>Application</code> instance. When a style is
		 * 	added to an <code>Application</code> instance, all elements displayed within
		 * 	the application can be affected by the new style. Possible values for the
		 * 	<code>styleSheet</code> property can be:
		 * 	<ul>
		 * 		<li>URLs to valid CSS files,</li>
		 * 		<li>Instances of the <code>CssString</code> class,</li>
		 * 		<li>Valid <code>StyleSheet</code> objects.</li>
		 * 	</ul>
		 * 
		 * 	<p>The SPAS 3.0 style API behaves like the HTML CSS implementation, which
		 * 	means that each time a new style is added, it will only override styles
		 * 	that define the same CSS rules.</p>
		 * 
		 * 	@see org.flashapi.swing.text.CssString
		 * 	@see #waitForStyleInit()
		 */
		public function set styleSheet(value:*):void {
			_addingStylesNum++;
			switch(true) {
				case value is String :
					var r:URLRequest = new URLRequest(value);  
					var l:URLLoader = new URLLoader();
					$evtColl.addEvent(l, Event.COMPLETE, styleSheetCompleteHandler);  
					//l.addEventListener(Event.COMPLETE, styleSheetCompleteHandler);   
					l.load(r);
					break;
				case value is CssString :
					_addingStylesNum--;
					spas_internal::applyNewStyle(value.getStyles());
					dispatchAppEvent(ApplicationEvent.STYLE_LOADED);
					break;
				case value is StyleSheet :	
				default :
					_addingStylesNum--;
					spas_internal::applyNewStyle(value);
					dispatchAppEvent(ApplicationEvent.STYLE_LOADED);
			}
		}
		
		/**
		 *  A reference to the object that contains this <code>Application</code>
		 * 	instance.
		 */
		public function get target():* {
			return _targetContainer.target;
		}
		
		private var _vAlign:String = VerticalAlignment.MIDDLE;
		/**
		 * 	The <code>verticalAlignment</code> property specifies or retrieves a <code>Boolean</code>
		 * 	value that indicates the vertical placement of the application main container.
		 * 	<p>Valid values are:
		 * 		<ul>
		 * 			<li><code>VerticalAlignment.TOP</code>,</li>
		 * 			<li><code>VerticalAlignment.MIDDLE</code>,</li>
		 * 			<li><code>VerticalAlignment.BOTTOM</code>.</li>
		 * 		</ul>
		 * 	</p>
		 * 	
		 * 	@default VerticalAlignment.MIDDLE
		 * 	
		 * 	@see #horizontalAlignment
		 * 	@see #setPosition()
		 */
		public function get verticalAlignment():String {
			return _vAlign;
		}
		public function set verticalAlignment(value:String):void {
			_vAlign = value;
			_targetContainer.redraw();
		}
		
		/**
		 *  Sets or gets the vertical gap of the main container for this 
		 * 	<code>Application</code> instance.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #horizontalGap
		 */
		public function get verticalGap():Number {
			return _targetContainer.verticalGap;
		}
		public function set verticalGap(value:Number):void {
			_targetContainer.verticalGap = value;
			_targetContainer.redraw();
		}
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the application 
		 * 	<code>Application</code> instance is visible (<code>true</code>), or not
		 * 	<code>false</code>). An application which is not visible is automatically
		 * 	disabled.
		 * 
		 * 	@default true
		 */
		override public function get visible():Boolean {
			return _targetContainer.visible;
		}
		override public function set visible(value:Boolean):void {
			_targetContainer.visible = value;
		}
		
		/**
		 * 	Sets or gets the width of the main container, in pixels.
		 * 
		 * 	@see #height
		 */
		override public function get width():Number {
			return _targetContainer.width;
		}
		override public function set width(value:Number):void {
			//_targetContainer.autoWidth = isNaN(value);
			if(isNaN(value)) {
				_targetContainer.autoWidth = true;
				_targetContainer.width = 0;
			} else {
				_targetContainer.autoWidth = false;
				_targetContainer.width = value;
			}
		}
		
		/**
		 * 	Sets or gets the height of the main container, in pixels.
		 * 
		 * 	@see #width
		 */
		override public function get height():Number {
			return _targetContainer.height; 
		}
		override public function set height(value:Number):void { 
			//_targetContainer.autoHeight = !isNaN(value);
			if(isNaN(value)) {
				_targetContainer.autoHeight = true;
				_targetContainer.height = 0;
			} else {
				_targetContainer.autoHeight = false;
				_targetContainer.height = value; 
			}
		}
		
		/**
		 * 	Returns the value of the <code>x</code> coordinate of the main container,
		 * 	in pixels, relative to the <code>Stage</code> instance.
		 * 
		 * 	@see #y
		 */
		override public function get x():Number {
			return _targetContainer.content.x;
		}
		
		/**
		 * 	Returns the value of the <code>y</code> coordinate of the main container,
		 * 	in pixels, relative to the <code>Stage</code> instance.
		 * 
		 * 	@see #x
		 */
		override public function get y():Number {
			return _targetContainer.content.y;
		}
		
		/**
		 *  If <code>true</code>, the height of the <code>Application</code> instance take the
		 * 	same value as the height of the <code>Stage</code> object, or its parent
		 * 	<code>UIContainer</code> instance.
		 * 
		 * 	@default true
		 * 
		 * 	@see #fixToParentWidth
		 */
		public function get fixToParentHeight():Boolean {
			return _targetContainer.fixToParentHeight;
		}
		public function set fixToParentHeight(value:Boolean):void {
			_targetContainer.fixToParentHeight = value;
		}
		
		/**
		 *  If <code>true</code>, the width of the <code>Application</code> instance take the
		 * 	same value as the width of the <code>Stage</code> object, or its parent
		 * 	<code>UIContainer</code> instance.
		 * 
		 * 	@default true
		 * 
		 * 	@see #fixToParentHeight
		 */
		public function get fixToParentWidth():Boolean {
			return _targetContainer.fixToParentWidth;
		}
		public function set fixToParentWidth(value:Boolean):void {
			_targetContainer.fixToParentWidth = value;
		}
		
		/**
		 * 	[Under development.]
		 * 
		 * 	@see #scrollPaddingRight
		 * 	@see #scrollPaddingBottom
		 * 	@see #scrollPaddingLeft
		 */
		public function get scrollPaddingTop():Number {
			return spas_internal::appContainer.scrollPaddingTop;
		}
		public function set scrollPaddingTop(value:Number):void {
			spas_internal::appContainer.scrollPaddingTop = value;
		}
		
		/**
		 * 	[Under development.]
		 * 
		 * 	@see #scrollPaddingTop
		 * 	@see #scrollPaddingBottom
		 * 	@see #scrollPaddingLeft
		 */
		public function get scrollPaddingRight():Number {
			return spas_internal::appContainer.scrollPaddingRight;
		}
		public function set scrollPaddingRight(value:Number):void {
			spas_internal::appContainer.scrollPaddingRight = value;
		}
		
		/**
		 * 	[Under development.]
		 * 
		 * 	@see #scrollPaddingRight
		 * 	@see #scrollPaddingTop
		 * 	@see #scrollPaddingLeft
		 */
		public function get scrollPaddingBottom():Number {
			return spas_internal::appContainer.scrollPaddingBottom;
		}
		public function set scrollPaddingBottom(value:Number):void {
			spas_internal::appContainer.scrollPaddingBottom = value;
		}
		
		/**
		 * 	[Under development.]
		 * 
		 * 	@see #scrollPaddingRight
		 * 	@see #scrollPaddingBottom
		 * 	@see #scrollPaddingTop
		 */
		public function get scrollPaddingLeft():Number {
			return spas_internal::appContainer.scrollPaddingLeft;
		}
		public function set scrollPaddingLeft(value:Number):void {
			spas_internal::appContainer.scrollPaddingLeft = value;
		}
		
		/**
		 * 	The <code>scrollPolicy</code> property controls the display of scroll bars.
		 * 	Possible values are:
		 * 	<ul>
		 * 		<li><code>ScrollPolicy.AUTO</code>: configures the application to include
		 * 		scroll bars only when necessary,</li>
		 * 		<li><code>ScrollPolicy.BOTH</code>: displays both, vertical and
		 * 		horizontal scroll bars,</li>
		 * 		<li><code>ScrollPolicy.VERTICAL</code>: displays only the vertical
		 * 		scroll bars,</li>
		 * 		<li><code>ScrollPolicy.HORIZONTAL</code>: displays only the horizontal
		 * 		scroll bars,</li>
		 * 		<li><code>ScrollPolicy.NONE</code>: deactivates both, vertical and
		 * 		horizontal scroll bars.</li>
		 * 	</ul>
		 * 	
		 * 	@default ScrollPolicy.AUTO
		 */
		public function get scrollPolicy():String {
			return spas_internal::appContainer.scrollPolicy;
		}
		public function set scrollPolicy(value:String):void {
			spas_internal::appContainer.scrollPolicy = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//public function addControlBar():Element {}
		
		/**
		 * 	@copy org.flashapi.swing.UIManager#addCursor()
		 */
		public static function addCursor(value:String = "default"):void {
			UIManager.addCursor(value);
		}
		
		/**
		 * 	@copy org.flashapi.swing.UIManager#removeCursor()
		 */
		public static function removeCursor():void {
			UIManager.removeCursor();
		}
		
		/**
		 * 	Adds an object to the list of elements to be displayed within the document
		 * 	application.
		 * 	<p>Elements can be added:
		 * 		<ul>
		 * 			<li>from URIs (pictures, swf files, text files...),</li>
		 * 			<li>from the SWF library of the Flash Player,</li>
		 * 			<li>by creating a new ActionScript 3.0 object (e.g. <code>Sprite</code>,
		 * 			<code>TextField</code>...),</li>
		 * 			<li>by creating a new SPAS 3.0 <code>UIObject</code> (e.g. <code>Button</code>,
		 * 			<code>Panel</code>...).</li>
		 * 		</ul>
		 * 	</p>
		 * 
		 * 	@param	value	The object to add as a child element of this <code>Application</code>
		 * 					instance. 
		 * 	@param	type	A <code>DataFormat</code> constant that indicates the type of data
		 * 					the object you pass in the <code>value</code> parameter is.
		 * 					Default value is <code>DataFormat.GRAPHIC</code>.
		 * 
		 * 	@return			An <code>Element</code> object; a reference to the object that
		 * 					you pass in the <code>value</code> parameter.
		 * 
		 * 	@see #addElementAt()
		 * 	@see #addGraphicElements()
		 */
		public function addElement(value:*, type:String = "graphic"):Element {
			var elm:Element = _targetContainer.addElement(value, type);
			_elements.push(value);
			setRefresh();
			return elm;
		}
		
		/**
		 * 	[Not available yet.]
		 * 	Adds an object to the list of elements to be displayed within the document
		 * 	application, at the specified index.
		 * 
		 * 	@param	value	The object to add as a child element of this <code>Application</code>
		 * 					instance. 
		 * 	@param	index	The index at which to add the child element specified by the
		 * 					the <code>value</code> parameter.
		 * 	@param	type	A <code>DataFormat</code> constant that indicates the type of data
		 * 					the object you pass in the <code>value</code> parameter is.
		 * 					Default value is <code>DataFormat.GRAPHIC</code>.
		 * 
		 * 	@return			An <code>Element</code> object; a reference to the object that
		 * 					you pass in the <code>value</code> parameter.
		 * 
		 * 	@see #addElement()
		 * 	@see #addGraphicElements()
		 */
		public function addElementAt(value:*, index:uint, type:String = "graphic"):Element {
			var elm:Element = _targetContainer.addElementAt(value, index, type);
			_elements.push(value);
			setRefresh();
			return elm;
		}
		
		/**
		 * 	Adds a collection of graphic objects to the list of elements to be displayed
		 * 	within the document application.
		 * 	<p>Elements can be added:
		 * 		<ul>
		 * 			<li>from URIs (pictures, swf files, text files...),</li>
		 * 			<li>from the SWF library of the Flash Player,</li>
		 * 			<li>by creating a new ActionScript 3.0 object (e.g. <code>Sprite</code>,
		 * 			<code>TextField</code>...),</li>
		 * 			<li>by creating a new SPAS 3.0 <code>UIObject</code> (e.g. <code>Button</code>,
		 * 			<code>Panel</code>...).</li>
		 * 		</ul>
		 * 	</p>
		 * 
		 * 	<p>The following codes illustrate the difference between <code>addGraphicElements()</code>
		 * 	and <code>addElement()</code> methods. Both codes do exactly the same:
		 * 	<listing version="3.0">
		 * 		var label1:Label = new Label("A button:");
		 * 		var button1:Button = new Button;
		 * 
		 * 		var label2:Label = new Label("Another button:");
		 * 		var button2:Button = new Button;
		 * 		
		 * 		UIManager.document.layout = new FlowLayout();
		 * 
		 * 		UIManager.document.addElement(label1);
		 * 		UIManager.document.addElement(button1);
		 * 		UIManager.document.addElement(label2);
		 * 		UIManager.document.addElement(button2);
		 * 	</listing>
			<listing version="3.0">
		 * 		var label1:Label = new Label("A button:");
		 * 		var button1:Button = new Button;
		 * 
		 * 		var label2:Label = new Label("Another button:");
		 * 		var button2:Button = new Button;
		 * 		
		 * 		UIManager.document.layout = new FlowLayout();
		 * 
		 * 		UIManager.document.addGraphicsElement(label1, button1, label2, button2);
		 * 	</listing>
		 * </p>
		 * 
		 * 	@param	... rest	A collection or a series of graphical child elements to add 
		 * 						to this <code>Application</code> instance.
		 * 
		 * 	@see #addElement()
		 * 	@see #addElementAt()
		 */
		public function addGraphicElements(... rest):void {
			var l:uint = rest.length;
			for(var i:uint = 0; i < l; i++) {
				_targetContainer.addElement(rest[i]);
				_elements.push(rest[i]);
			}
			setRefresh();
		}
		
		/**
		 * 	Removes and finalizes all elements that are contained within this
		 * 	<code>Application</code> instance.
		 * 	The parent property of removed child elements are set to <code>null</code>,
		 * 	and the object are garbage collected if no other references to them exist.
		 * 
		 * 	@see #removeElement()
		 * 	@see #removeElements()
		 * 	@see #removeElementAt()
		 */
		public function finalizeElements():void {
			_targetContainer.finalizeElements();
		}
		
		/**
		 * 	Returns an <code>Array</code> of all elements contained within this
		 * 	<code>Application</code> instance.
		 * 	
		 * 	@return All elements contained within this <code>Application</code> instance.
		 */
		public function getElements():Array {
			return _elements;
		}
		
		/**
		 * 	Returns the element for which the ID is specified. The <code>getElementByID()</code>
		 * 	provides an important gateway to pass <code>UIObject</code> references from a
		 * 	SPAS 3.0 document application to another.
		 * 
		 * 	@param	value A string representing the unique ID of the element being sought. 
		 * 
		 *  @return The element for which the ID is specified.
		 * 
		 * 	@see #getElementsByClassName()
		 * 	@see #getElementsByName()
		 * 	@see #getElementsBySelector()
		 */
		public function getElementByID(value:String):* {
			return spas_internal::IDStack[value.toLowerCase()];
		}
		
		/**
		 * 	This method returns an <code>Array</code> that represents a collection
		 * 	of elements with the given CSS class name.
		 * 
		 * 	@param	value 	A string representing the CSS class name to search child 
		 * 					elements within the application.
		 * 
		 *  @return An <code>Array</code> object that contains all elements, with the
		 * 			specified CSS class name, added to the document application.
		 * 
		 * 	@see #getElementByID()
		 * 	@see #getElementsByName()
		 * 	@see #getElementsBySelector()
		 */
		public function getElementsByClassName(value:String):Array {
			var tempArray:Array = [];
			for each (var item:* in _elements) {
				if (item.hasOwnProperty("className")) {
					if (item.className.toLowerCase() == value) tempArray.push(item);
				}
			}
			return tempArray;
		}
		
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	@see #getElementsByClassName()
		 * 	@see #getElementByID()
		 * 	@see #getElementsBySelector()
		 */
		public function getElementsByName(... rest):Array {
			/*var tempArray:Array = new Array();
			for each (var item in elements) if(getQualifiedClassName(item)==getQualifiedClassName(value)) tempArray.push(item);
			return tempArray;*/
			return [];
		}
		
		/**
		 * 	This method returns an <code>Array</code> that represents a collection
		 * 	of elements with the given CSS selector name.
		 * 
		 * 	@param	value 	A string representing the CSS selector name to search  
		 * 					child elements within the application.
		 * 
		 *  @return An <code>Array</code> object that contains all elements, with the
		 * 			specified CSS selector name, added to the document application.
		 * 
		 * 	@see #getElementsByClassName()
		 * 	@see #getElementsByName()
		 * 	@see #getElementByID()
		 */
		public function getElementsBySelector(value:String):Array {
			var tempArray:Array = [];
			for each (var item:* in _elements) {
				if (item.hasOwnProperty("selector")) {
					if (item.selector.toLowerCase() == value) tempArray.push(item);
				}
			}
			return tempArray;
		}
		
		/**
		 *  Redraws the main container of this <code>Application</code> instance.
		 */
		public function redraw():void {
			if (spas_internal::isDrawable) spas_internal::appContainer.redraw();
		}
		
		/**
		 * 	Removes all elements that are contained within this <code>Application</code>
		 * 	instance.
		 * 
		 * 	@see #removeElement()
		 * 	@see #finalizeElements()
		 * 	@see #removeElementAt()
		 */
		public function removeElements():void {
			_targetContainer.removeElements();
			_elements = [];
		}
		
		/**
		 * 	Removes the specified child element instance from the child element list of
		 * 	the <code>Application</code> instance. If the child element to remove is a 
		 * 	<code>DisplayObject</code>, the parent property of the removed child element 
		 *	is set to <code>null</code>, and the object is garbage collected if no other
		 * 	references to the child element exist. The index positions of any objects
		 * 	above the child element in the <code>Application</code> are decreased by
		 * 	<code>1</code>. 
		 * 
		 * 	@param	value	The child <code>Element</code> instance to remove.
		 * 
		 * 	@return			The child <code>Element</code> instance that was removed.
		 * 
		 * 	@see #finalizeElements()
		 * 	@see #removeElements()
		 * 	@see #removeElementAt()
		 */
		public function removeElement(value:*):Element {
			return _targetContainer.removeElement(value);
		}
		
		/**
		 * 	Removes a child element from the specified index position in the child list
		 * 	of the <code>Application</code>. If the child element to remove is a 
		 * 	<code>DisplayObject</code>, the parent property of the removed child element 
		 *	is set to <code>null</code>, and the object is garbage collected if no other
		 * 	references to the child element exist. The index positions of any objects
		 * 	above the child element in the <code>Application</code> are decreased by
		 * 	<code>1</code>. 
		 * 
		 * 	@param	index	The child index of the <code>Element</code> to remove.
		 * 
		 * 	@return			The child <code>Element</code> instance that was removed.
		 * 
		 * 	@see #removeElement()
		 * 	@see #removeElements()
		 * 	@see #finalizeElements()
		 */
		public function removeElementAt(index:int):Element {
			return _targetContainer.removeElementAt(index);
		}
		
		/**
		 * 	Defines the gradient properties for the body area of the application main
		 * 	container.
		 * 
		 *	@param	colors 	An array of RGB hexadecimal color values to be used in the gradient;
		 * 					You can specify up to 15 colors. For each color, be sure you specify
		 * 					a corresponding value in the <code>ratios</code> parameter. 
		 * 	@param	ratios 	An array of color distribution ratios; valid values are <code>0</code>
		 * 					to <code>255</code>. This value defines the percentage of the width
		 * 					where the color is sampled at 100%. <code>0</code> represents the
		 * 					left-hand position in the gradient box and <code>255</code> represents
		 * 					the right-hand position in the gradient box. The values in the array
		 * 					must increase sequentially; for example, <code>[0, 63, 127, 190, 255]</code>. 
		 * 	@param	type 	A value from the <code>GradientType</code> class that specifies which
		 * 					gradient type to use: <code>GradientType.LINEAR</code> or
		 * 					<code>GradientType.RADIAL</code>.
		 * 	@param	matrix 	A transformation matrix as defined by the <code>flash.geom.Matrix</code>
		 * 					class.
		 * 	@param	spreadMethod 	A value from the <code>SpreadMethod</code> class that specifies
		 * 					which spread method to use, either: <code>SpreadMethod.PAD</code>,
		 * 					<code>SpreadMethod.REFLECT</code> or <code>SpreadMethod.REPEAT</code>.
		 * 	@param	interpolationMethod 	A value from the <code>InterpolationMethod</code> class
		 * 					that specifies which value to use: <code>InterpolationMethod.linearRGB</code>
		 * 					or <code>InterpolationMethod.RGB</code>.
		 * 	@param	focalPointRatio  A number that controls the location of the focal point of the
		 * 					gradient. <code>0</code> means that the focal point is in the center.
		 * 					<code>1</code> means that the focal point is at one border of the gradient
		 * 					circle. <code>-1</code> means that the focal point is at the other border
		 * 					of the gradient circle. A value less than <code>-1</code> or greater than
		 * 					<code>1</code> is rounded to <code>-1</code> or <code>1</code>.
		 * 
		 * 	@see #gradientBackground
		 * 	@see #gradientProperties
		 * 	@see #gradientMode
		 */
		public function setGradientProperties(	colors:Array, ratios:Array, type:String = "linear",
												matrix:Matrix = null, spreadMethod:String = "pad",
												interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void {
			var o:Object = {
				type:type, colors:colors, ratios:ratios, matrix:matrix, spreadMethod:spreadMethod,
				interpolationMethod:interpolationMethod, focalPointRatio:focalPointRatio
			};
			_targetContainer.textureManager.gradientProperties = o;
		}
		
		/**
		 * 	Sets the <code>horizontalAlignment</code> and <code>verticalAlignment</code> properties
		 * 	for the application main container.
		 * 
		 * 	@param	horizontalAlignment The horizontal placement of the main container defines by
		 * 								the <code>HorizontalAlignment</code> class. Valid values are:
		 * 								<ul>
		 * 									<li><code>HorizontalAlignment.LEFT</code>,</li>
		 * 									<li><code>HorizontalAlignment.CENTER</code>,</li>
		 * 									<li><code>HorizontalAlignment.RIGHT</code>.</li>
		 * 								</ul>
		 * 	@param	verticalAlignment 	The vertical placement of the main container defines by the
		 * 								<code>VerticalAlignment</code> class. Valid values are:
		 * 								<ul>
		 * 									<li><code>VerticalAlignment.TOP</code>,</li>
		 * 									<li><code>VerticalAlignment.MIDDLE</code>,</li>
		 * 									<li><code>VerticalAlignment.BOTTOM</code>.</li>
		 * 								</ul>
		 * 
		 * 	@see #horizontalAlignment
		 * 	@see #verticalAlignment
		 */
		public function setPosition(horizontalAlignment:String, verticalAlignment:String):void {
			_vAlign = verticalAlignment;
			_hAlign = horizontalAlignment;
			_targetContainer.redraw();
		}
		
		/**
		 * 	The <code>waitForStyleInit</code> method adds a new style to this <code>Application</code>
		 * 	instance and calls functions specified by the <code>callback</code> parameter once
		 * 	the new style has been added. By setting the application entry point as a function
		 * 	for the <code>callback</code> parameter, this method ensures that no object will
		 * 	be created until an external CSS file, specified by the <code>style</code> parameter,
		 * 	is fully loaded.
		 * 
		 * 	@param	style	A valid style to add to this <code>Application</code> instance.
		 * 	@param	callback	A collection of callback function to be called after the
		 * 						style ahs been added to the application.
		 * 
		 * 	@see #styleSheet
		 */
		public function waitForStyleInit(style:*, ...callback):void {
			_waitForStyleInitFunctions = callback;
			$evtColl.addEvent(this, ApplicationEvent.STYLE_LOADED, fireWaitForStyleInitFunctions);
			styleSheet = style;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			if (!(_targetContainer is MainContainer)) {
				_entryPoint = null;
				_waitForStyleInitFunctions = [];
				_waitForStyleInitFunctions = null;
				var item:*;
				var __id:String;
				for each (item in _elements) { 
					_elements.splice(_elements.indexOf(item), 1);
					__id = item.id ? item.id.toLowerCase() : null;
					if (__id != null) {
						spas_internal::IDStack[__id] = null;
						delete spas_internal::IDStack[__id];
					}
					item = null;
				}
				_elements = null;
				spas_internal::IDStack = null;
				_content = null;
				_targetContainer.target = null;
				_targetContainer.finalize();
				_targetContainer = null;
				spas_internal::appContainer = null;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Internal reference to the <code>Stage</code> instance.
		 */
		protected var $stage:Stage
		
		/**
		 * 	@private
		 */
		spas_internal var enableMainContainerAcces:Boolean = false;
		
		/**
		 * 	@private
		 */
		spas_internal var isDrawable:Boolean = false;
		
		/**
		 * 	@private
		 */
		spas_internal var IDStack:Dictionary;
		
		/**
		 * 	@private
		 */
		spas_internal var appContainer:MainContainer;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/*spas_internal function hasMainContainer(uio:UIObject):void {
			var item:*;
			for each (item in _elements)  {
				if (item == uio && !uio.displayed) {
					uio.parent.addChild(uio.spas_internal::uioSprite);
					break;
				}
			}
		}*/
		
		/**
		 * 	@private
		 */
		spas_internal function destroy(uio:UIObject):void {
			var item:*;
			for each (item in _elements) {
				if (item == uio) {
					_elements.splice(_elements.indexOf(item), 1);
					break;
				}
			}
			var __id:String = uio.id ? uio.id.toLowerCase() : null;
			if (__id != null) {
				spas_internal::IDStack[__id] = null;
				delete spas_internal::IDStack[__id];
			}
			uio = null;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function resizeEventHandler():void {
			if (_targetContainer.fixToParentWidth || _targetContainer.fixToParentHeight)
				_targetContainer.spas_internal::updateLayout();
			_targetContainer.redraw();
			dispatchAppEvent(ApplicationEvent.RESIZED);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function appendChild(value:*, type:String = "graphic"):void {
			_elements.push(value);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function deleteChild(value:*):void {
			_elements.splice(_elements.indexOf(value), 1);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function applyNewStyle(value:*):void {
			var cssm:CSSManager = UIManager.cssManager;
			cssm.spas_internal::addStyle(value);
			if (_addingStylesNum == 0) cssm.spas_internal::updateRules();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _elements:Array;
		private var _displayed:Boolean = false;
		private var _addingStylesNum:uint = 0;
		private var _targetContainer:UIContainer;
		private var _waitForStyleInitFunctions:Array;
		private var _isAddedToStage:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(entryPoint:Function):void {
			if (entryPoint != null) this.entryPoint = entryPoint;
			else init(this);
		}
		
		private function fireWaitForStyleInitFunctions(e:ApplicationEvent):void {
			$evtColl.removeEvent(this, ApplicationEvent.STYLE_LOADED, fireWaitForStyleInitFunctions);
			var l:int = _waitForStyleInitFunctions.length - 1;
			var i:uint = 0;
			for (; i <= l; i++) _waitForStyleInitFunctions[i]();
			_waitForStyleInitFunctions = [];
		}
		
		private function init(target:DisplayObject):void {
			spas_internal::IDStack = new Dictionary(true);
			_waitForStyleInitFunctions = [];
			_elements = [];
			if (!UIManager.spas_internal::isInitialized()) {
				UIManager.spas_internal::init(target, false);
				//FSEnabled = UIManager.stage.hasOwnProperty("displayState");
				spas_internal::enableMainContainerAcces = true;
				spas_internal::appContainer = new MainContainer();
				_content = spas_internal::appContainer.content;
				_targetContainer = spas_internal::appContainer;
				spas_internal::appContainer.display();
				spas_internal::isDrawable = _displayed = true;
				setRefresh();
			} else if(UIManager.document != null) {
				spas_internal::appContainer = UIManager.document.spas_internal::appContainer;
				_targetContainer = new PseudoMainContainer();
				_content = _targetContainer.content;
				_targetContainer.target = this;
				(_targetContainer as UIObject).display();
			}
			_isAddedToStage = true;
			$stage = UIManager.stage;
		}
		
		private function setRefresh():void {
			spas_internal::appContainer.redraw();
		}
		
		private function styleSheetCompleteHandler(e:Event):void {
			$evtColl.removeEvent(e.target, Event.COMPLETE, styleSheetCompleteHandler);  
			_addingStylesNum--;
			//TODO: intervertir ces deux lignes:
			dispatchAppEvent(ApplicationEvent.STYLE_LOADED);
			spas_internal::applyNewStyle(e.target.data);
		}
		
		private function callEntryPoint(e:Event):void {
			$evtColl.removeEvent(this, Event.ADDED_TO_STAGE, callEntryPoint);
			init(this);
			if(_entryPoint != null) _entryPoint();
		}
		
		private function dispatchAppEvent(type:String):void {
			this.dispatchEvent(new ApplicationEvent(type));
		}
	}
}