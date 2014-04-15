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
	// Initializator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.4, 21/03/2011 03:47
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.utils.Timer;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.constants.InitObjectType;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.Library;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.databinding.DataProvider;
	import org.flashapi.swing.databinding.XMLQuery;
	import org.flashapi.swing.event.DataBindingEvent;
	import org.flashapi.swing.event.InitEvent;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.localization.init.InitLocaleUs;
	import org.flashapi.swing.net.DataLoader;
	import org.flashapi.swing.reflect.ObjectTranslator;
	import org.flashapi.swing.skin.PanelSkin;
	
	use namespace spas_internal;
	
	[IconFile("Initializator.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the SPAS 3.0 <code>Application</code> associated with this
	 * 	<code>Initializator</code> instance is initialized.
	 *
	 *  @eventType org.flashapi.swing.event.InitEvent.INITIALIZED
	 */
	[Event(name = "initialized", type = "org.flashapi.swing.event.InitEvent")]
	
	/**
	 * 	<img src="Initializator.png" alt="Initializator" width="18" height="18"/>
	 * 
	 * 	The <code>Initializator</code> class lets you manage the initializtion of
	 * 	a SPAS 3.0 application. This process prevents the "freeze" of your
	 * 	application, due to the no-multithread support of the flash player.
	 * 	
	 * 	<p>Its principle is based on softwares initialization, like you have
	 *  within common Operating Systems.</p>
	 * 
	 * 	<p><code>Initializator</code> instances are composed of a panel,
	 * 	a label and a progress bar. The panel object can be used to display 
	 * 	a <code>SplashScreen</code> instance to create custom background images,
	 * 	like desktop sofwares do while initializing.</p>
	 * 
	 * <p><strong><code>Initializator</code> instances support the following CSS
	 * 	properties:</strong></p>
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
	 * 		<tr>
	 * 			<td><code class="css">font-style</code></td>
	 * 			<td>Sets the font style of the object.</td>
	 * 			<td>Recognized values are <code class="css">normal</code> or
	 * 			<code class="css">italic</code>.</td>
	 * 			<td><code>italicized</code></td>
	 * 			<td><code>Properties.FONT_STYLE</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-weight</code></td>
	 * 			<td>Sets the font weight of the object.</td>
	 * 			<td>Recognized values are <code class="css">normal</code> or
	 * 			<code class="css">bold</code>.</td>
	 * 			<td><code>boldFace</code></td>
	 * 			<td><code>Properties.FONT_WEIGHT</code></td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">track-opacity</code></td>
	 * 			<td>Sets the alpha transparency value of the progress bar track.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>trackOpacity</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">bar-opacity</code></td>
	 * 			<td>Sets the alpha transparency value of the progress bar.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>barOpacity</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">track-highlight-opacity</code></td>
	 * 			<td>Sets the alpha transparency value of the highlighted track bar.</td>
	 * 			<td>A number from <code>0</code> (fully transparent) to <code>1</code>
	 * 			(fully opaque).</td>
	 * 			<td><code>trackHighlightOpacity</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">track-highlight-color</code></td>
	 * 			<td>Sets the color value of the highlighted track bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>trackHighlightColor</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">track-color</code></td>
	 * 			<td>Sets the color value of the progress bar track.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>trackColor</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">progress-color</code></td>
	 * 			<td>Sets the color value of the progress bar.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>progressColor</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">progress-bar-height</code></td>
	 * 			<td>Sets the height the progress bar, in pixels.</td>
	 * 			<td>Positive numbers.</td>
	 * 			<td><code>progressBarHeight</code></td>
	 * 			<td>Undocumented</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 *	@includeExample InitializatorExample.as
	 * 
	 *  @see org.flashapi.swing.Application
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Initializator extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Initializator</code> instance with
		 * 					the specified parameters.
		 * 
		 * 	@param	application	A reference to the <code>Application</code> instance
		 * 						for which this <code>Initializator</code> instance is
		 * 						used.
		 * 	@param	target	The <code>DisplayObject</code> or <code>UIContainer</code>
		 * 					instance where the <code>Initializator</code> instance is
		 * 					displayed. If <code>null</code>, he <code>Initializator</code>
		 * 					instance is displayed on the top of the <code>Stage</code>
		 * 					object.
		 * 	@param	applyCSS	<em>Undocumented</em>.
		 */
		public function Initializator(application:Application = null, target:* = null, applyCSS:Boolean = true) {
			super();
			initObj(application, target, applyCSS);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		public var id:String = null;
		
		/**
		 * 	The first message that appears on the face of the <code>Initializator</code>
		 * 	instance, before the initialization process starts.
		 */
		public var initialMessage:String = InitLocaleUs.INITIAL_MESSAGE;
		
		/**
		 * 	The last message that appears on the face of the <code>Initializator</code>
		 * 	instance, after the initialization process is finished.
		 */
		public var finalMessage:String = InitLocaleUs.FINAL_MESSAGE;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _className:String = "";
		/**
		 * 	@copy org.flashapi.swing.core.IUIObject#className
		 */
		public function get className():String {
			return _className;
		}
		public function set className(value:String):void {
			_className = value;
		}
		
		/**
		 * 	Returns the CSS selector value of this <code>Initializator</code>
		 * 	instance.
		 * 
		 * 	@return Selectors.INITIALIZATOR
		 */
		public function get selector():String {
			return Selectors.INITIALIZATOR;
		}
		
		/**
		 * 	Sets or gets the message currently displayed on the face of this 
		 * 	<code>Initializator</code> instance.
		 */
		public function get message():String {
			return _pgp.labelControl.text;
		}
		public function set message(value:String):void {
			_pgp.labelControl.text = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Style API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets the width of this <code>Initializator</code> instance, in pixels.
		 * 
		 * 	@see #height
		 */
		public function set width(value:Number):void {
			_pgp.width = value;
			movePanel();
		}
		
		/**
		 * 	Sets the height of this <code>Initializator</code> instance, in pixels.
		 * 
		 * 	@see #width
		 */
		public function set height(value:Number):void {
			_pgp.height = value;
			movePanel();
		}
		
		/**
		 *  Sets the <code>Initializator</code> background color. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> 
		 *  recommendation to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> 
		 *  section of the document to get valid SVG color keyword names.</p>
		 * 
		 *  <p>The default value is returned by the <code>lookAndFeel.getColor()</code>
		 * 	property.</p>
		 */
		public function set color(value:*):void {
			_pgp.panel.color = value;
		}
		
		public function set fontColor(value:*):void {
			_pgp.fontColor = value;
		}
		
		/**
		 * 	Sets or gets the size of the <code>Initializator</code> text, in pixels.
		 * 	The default value is specified by the current Look and Feel.
		 */
		public function set fontSize(value:Number):void {
			_pgp.fontSize = value;
		}
		
		/**
		 * 	A <code>Boolean</code> value that specifies whether the text font weight
		 * 	is bold (<code>true</code>), or not (<code>false</code>).
		 * 	
		 * 	@default false
		 */
		public function set boldFace(value:Boolean):void {
			_pgp.boldFace = value;
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>Initializator</code> 
		 * 	text is italic (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function set italicized(value:Boolean):void {
			_pgp.italicized = value;
		}
		
		/**
		 *  Indicates the alpha transparency value of the <code>Initializator</code>.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque). <code>Initializators</code> with <code>alpha</code> set 
		 * 	to <code>0</code> are active, even though they are invisible.
		 * 
		 *  @default 1
		 */
		public function set backgroundAlpha(value:Number):void {
			_pgp.panel.backgroundAlpha = value;
		}
		
		/**
		 *  Indicates wether the <code>Initializator</code> shadow effect is active
		 * 	(<code>true</code>), or not (<code>false</code>). The shadow effect lets
		 * 	you apply a visual shadow effect to an <code>Initializator</code> instance.
		 *
		 *  @default false
		 */
		public function set shadow(value:Boolean):void {
			_pgp.panel.shadow = value;
		}
		
		//--> ProgressBar API:
		
		/**
		 *  Sets or gets the highlighted track color of the <code>ProgressBar</code>.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		public function get progressColor():* {
			return _barControl.color;
		}
		public function set progressColor(value:*):void {
			_barControl.color = value;
		}
		
		/**
		 *  Sets or gets the alpha transparency of the <code>ProgressBar</code> track.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 * 
		 *  @default 1
		 */
		public function get trackOpacity():Number {
			return _barControl.trackOpacity ;
		}
		public function set trackOpacity(value:Number):void {
			_barControl.trackOpacity = value;
		}
		
		/**
		 *  Sets or gets the alpha transparency of the <code>ProgressBar</code> highlighted
		 * 	track.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 * 
		 *  @default 1
		 */
		public function get trackHighlightOpacity():Number {
			return _barControl.trackHighlightOpacity;
		}
		public function set trackHighlightOpacity(value:Number):void {
			_barControl.trackHighlightOpacity = value;
		}
		
		/**
		 *  Sets or gets the alpha transparency of the <code>ProgressBar</code>.
		 *  Valid values are <code>0</code> (fully transparent) to <code>1</code>
		 * 	(fully opaque).
		 * 
		 *  @default 1
		 */
		public function get barOpacity():Number {
			return _barControl.barOpacity;
		}
		public function set barOpacity(value:Number):void {
			_barControl.barOpacity = value;
		}
		
		/**
		 *  Sets or gets the highlighted track color for the <code>ProgressBar</code>.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		public function get trackHighlightColor():* {
			return _barControl.trackHighlightColor;
		}
		public function set trackHighlightColor(value:*):void {
			_barControl.trackHighlightColor = value;
		}
		
		/**
		 *  Sets or gets the track color of the <code>ProgressBar</code>.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		public function get trackColor():* {
			return _barControl.trackColor;
		}
		public function set trackColor(value:*):void {
			_barControl.trackColor = value;
		}
		
		/**
		 *  Sets or gets the height of the <code>ProgressBar</code>, in pixels.
		 * 	
		 * 	@default 4
		 */
		public function get progressBarHeight():Number {
			return _barControl.height;
		}
		public function set progressBarHeight(value:Number):void {
			_barControl.height = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _declareId:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>Initializator</code> 
		 * 	instance automatically generates Unique Identifiers for managed items
		 * 	(<code>true</code>), or not (<code>false</code>). If <code>true</code>,
		 * 	Unique Identifiers are created from the instance name of each item added
		 * 	to the <code>Initializator</code> instance.
		 * 
		 * 	@default false
		 */
		public function get autoDeclareID():Boolean {
			return _declareId;
		}
		public function set autoDeclareID(value:Boolean):void {
			_declareId = value;
		}
		
		/**
		 * 	Returns a reference to the <code>ProgressPanel</code> displayed within this
		 * 	<code>Initializator</code> instance.
		 */
		public function get progressPanel():ProgressPanel {
			return _pgp;
		}
		
		private var _deleteAfterInit:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>Initializator</code> 
		 * 	instance is automatically deleted at the end of the initialization process
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 	If <code>true</code>, the <code>Initializator</code> instance is finalized
		 * 	and the method specified by the <code>initFunction</code> property
		 * 	is not called.
		 * 
		 * 	@default false
		 * 
		 * 	@see #initFunction
		 */
		public function get deleteAfterInit():Boolean {
			return _deleteAfterInit;
		}
		public function set deleteAfterInit(value:Boolean):void {
			_deleteAfterInit = value;
		}
		
		private var _initFunc:Function = null;
		/**
		 * 	The callback function to run when the initialization process
		 * 	is finished. If the <code>deleteAfterInit</code> property is
		 * 	<code>true</code>, the <code>initFunction</code> method is not
		 * 	run.
		 * 
		 * 	@default null
		 * 
		 * 	@see #deleteAfterInit
		 */
		public function get initFunction():Function {
			return _initFunc;
		}
		public function set initFunction(value:Function):void {
			_initFunc = value;
		}
		
		/**
		 * 	Sets or gets the time delay, in miliseconds, between the 
		 * 	initialization of each object added to this <code>Initializator</code>
		 * 	instance.
		 * 
		 * 	@default 50
		 */
		public function get processDelay():uint {
			return _timer.delay;
		}
		public function set processDelay(value:uint):void {
			_timer.delay = value;
		}
		
		private var _errorStack:Array;
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns an <code>Array</code> that contains the URL of all
		 * 	external assets that have not been loaded within the SPAS
		 * 	3.0 application, due to loading errors. If no loading error
		 * 	is occured, returns an empty <code>Array</code>.
		 */
		public function get errorsList():Array {
			return _errorStack;
		}
		
		private var _target:* = null;
		/**
		 * 	Sets or gets the target for the <code>Initializator</code> instance.
		 * 	If the initializator is running, the current target is not changed
		 * 	until the <code>start()</code> method is called again.
		 * 	
		 * 	@default null
		 * 
		 * 	@see #start()
		 */
		public function get target():* {
			return _target;
		}
		public function set target(value:*):void {
			_target = value;
		}
		
		private var _splashScreen:SplashScreen = null;
		/**
		 * 	Sets or gets the <code>SplashScreen</code> object used by this
		 * 	<code>Initializator</code> instance.
		 * 	
		 * 	@default null
		 * 
		 * 	@see org.flashapi.swing.SplashScreen
		 */
		public function get splashScreen():SplashScreen {
			return _splashScreen;
		}
		public function set splashScreen(value:SplashScreen):void {
			_splashScreen = value;
			if (_splashScreen != null) {
				var ps:PanelSkin = new PanelSkin();
				ps.skin = value.skin;
				_pgp.panel.skin = ps;
				_pgp.setPadding(value.paddingTop, value.paddingRight,
								value.paddingBottom, value.paddingLeft);
				//_pgp.autoHeight = false;
				_pgp.resize(value.width, value.height);
				movePanel();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a URL reference to a Runtime Shared Library to load using this
		 * 	<code>Initializator</code> instance.
		 * 
		 * 	@param	name	A <code>String</code> that represents the name property
		 * 					for the RSL to load, as defined within the <code>Application</code>
		 * 					object.
		 * 	@param	uri		The URL reference to the Runtime Shared Library to load.
		 * 	@param	info	The message to display while loading the RSL.
		 */
		public function loadLibrary(name:String, uri:String, info:String = ""):void {
			var o:Object = { uri:uri, info:info, name:name, type:DataFormat.CACHED_GRAPHIC };
			_rslStack.push(o);
		}
		
		/**
		 * 	Adds a URL reference to a data file to load using this <code>Initializator</code>
		 * 	instance.
		 * 
		 * 	@param	name	A <code>String</code> that represents the name property
		 * 					for the data object to load, as defined within the 
		 * 					<code>Application</code> object.
		 * 	@param	uri		The URL reference to the data file to load.
		 * 	@param	type	The type of data file to load. Possible values are constants
		 * 					defined by the <code>DataFormat</code> class.
		 * 	@param	info	The message to display while loading the data file.
		 */
		public function loadData(name:String, uri:String, type:String, info:String = ""):void {
			var o:Object = { uri:uri, info:info, name:name, type:type };
			_assetsStack.push(o);
		}
		
		/**
		 * 	Adds a URL reference to a data font to load using this <code>Initializator</code>
		 * 	instance.
		 * 
		 * 	@param	uri		The URL reference to the font file to load.
		 * 	@param	info	The message to display while loading the font file.
		 */
		public function loadFont(uri:String, info:String = ""):void {
			var o:Object = { uri:uri, info:info, type:DataFormat.FONT };
			_assetsStack.push(o);
		}
		
		/**
		 * 	Adds a URL reference to a CSS file to load using this <code>Initializator</code>
		 * 	instance, or a reference to a <code>StyleSheet</code> object.
		 * 
		 * 	@param	css		A URL reference to the CSS file or a <code>StyleSheet</code>
		 * 					object.
		 * 	@param	info	The message to display while setting or loading the new style.
		 */
		public function addStyleSheet(css:*, info:String = ""):void {
			var o:Object = { value:css, info:info };
			_styleStack.push(o);
		}
		
		/**
		 * 	Creates a new <code>XMLQuery</code> instance from the <code>xml</code> parameter
		 * 	and set it as <code>xmlQuery</code> property for the <code>Listable</code> object
		 * 	specified by the <code>listable</code> parameter.
		 * 
		 * 	@param	listable	The <code>Listable</code> object to be populated
		 * 						by the new <code>XMLQuery</code> instance.
		 * 	@param	xml		An URL to a valid XML file, an ActionScript <code>XML</code>
		 * 					instance or an <code>xmlQuery</code> object used to
		 * 					populate the <code>Listable</code> object.
		 * 	@param	info	The message to display while initializing the
		 * 					specified object with the <code>XMLQuery</code>
		 * 					instance.
		 * 
		 * 	@see #initDataProvider()
		 * 	@see org.flashapi.swing.list.Listable
		 * 
		 * 	@throws org.flashapi.swing.exceptions.InvalidArgumentException An
		 * 			<code>InvalidArgumentException</code> error is thrown during  
		 * 			the initialization sequence if the <code>xml</code> parameter
		 * 			specified to populate the <code>Listable</code> object is not
		 * 			valid.
		 */
		public function initXmlQuery(listable:*, xml:*, info:String = ""):void {
			var o:Object = { obj:listable, query:xml, info:info };
			_xmlStack.push(o);
		}
		
		/**
		 * 	Uses the <code>DataProvider</code> instance specified by the 
		 * 	<code>dataProvider</code> parameter to set it as <code>dataProvider</code>
		 * 	property for the <code>Listable</code> object specified by the
		 * 	<code>listable</code> parameter.
		 * 
		 * 	@param	listable	The <code>Listable</code> object to be populated
		 * 						by the <code>DataProvider</code> instance.
		 * 	@param	dataProvider	A <code>DataProvider</code> instance to be
		 * 							used to populate the <code>Listable</code>
		 * 							object specified by the <code>listable</code>
		 * 							parameter.
		 * 	@param	info	The message to display while initializing the
		 * 					specified object with the <code>DataProvider</code>
		 * 					instance.
		 * 
		 * 	@see #initXmlQuery()
		 * 	@see org.flashapi.swing.list.Listable
		 */
		public function initDataProvider(listable:*, dataProvider:DataProvider, info:String = ""):void {
			var o:Object = { obj:listable, dataProvider:dataProvider, info:info };
			_dpStack.push(o);
		}
		
		/**
		 * 	Adds an collection of objects to be initialized by this 
		 * 	<code>Initializator</code> instance. Each object of the collection is
		 * 	specified by an ordered <code>Array</code> composed of the following
		 * 	elements:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>Property</th>
		 * 			<th>Type</th>
		 * 			<th>Description</th>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>name</code></td>
		 * 			<td><code>String</code></td>
		 * 			<td>The name property for the object to initialize, as
		 * 			defined within the <code>Application</code> instance.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>type</code></td>
		 * 			<td><code>Class</code></td>
		 * 			<td>The type of the object to initialize, as defined within  
		 * 			the <code>Application</code> instance.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>properties</code></td>
		 * 			<td><code>Object</code></td>
		 * 			<td>An object containing properties with which to populate
		 * 			the newly created object specified by the <code>name</code>
		 * 			and <code>type</code> parameters.If <code>null</code>, this
		 * 			property is ignored.</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td><code>info</code></td>
		 * 			<td><code>String</code></td>
		 * 			<td>The message to display while initializing the object.</td>
		 * 		</tr>
		 * 	</table>
		 * 
		 * 	<p>All <code>Array</code> instances of the collection are comma separated.</p>
		 * 	<p>The following example shows how to add twon button to an <code>Initializator</code>
		 * 	instance:</p>
		 * 	<listing version="3.0">
		 * 			myInitializator.addAll(
		 * 				["myButton1", Button, { label:"Label 1" }, "Creating first button"],
		 * 				["myButton2", Button, { label:"Label 2" }, "Creating second button"]
		 * 			);
		 * 	</listing>
		 * 
		 * 	@param	... arg	A collection of ordered <code>Array</code> instances
		 * 					that represent objects to add to this <code>Initializator</code>
		 * 					instance.
		 * 
		 * 	@see #add()
		 */
		public function addAll(... arg:*):void {
			var i:int = arg.length - 1;
			for (; i >= 0; i--) _stack.push(arg[i]);
		}
		
		/**
		 * 	Adds an object to be initialized by this <code>Initializator</code>
		 * 	instance.
		 * 
		 * 	@param	name	A <code>String</code> that represents the name property
		 * 					for the object to initialize, as defined within the 
		 * 					<code>Application</code> instance.
		 * 	@param	type	The type of the object to initialize, as defined within the 
		 * 					<code>Application</code> instance.
		 * 	@param	properties	An object containing properties with which to populate
		 * 						the newly created object specified by the <code>name</code>
		 * 						and <code>type</code> parameters. If <code>null</code>,
		 * 						this parameter is ignored.
		 * 	@param	info	The message to display while initializing the object.
		 * 
		 * 	@see #addAll()
		 */
		public function add(name:String, type:Class, properties:Object = null, info:String = ""):void {
			var arr:Array = [name, type, properties, info];
			_stack.push(arr);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_evtColl.finalize();
			_evtColl = null;
			_splashScreen = null;
			_initFunc = null;
			_target = null;
			_timer.stop();
			_barControl = null;
			_pgp.finalize();
			_pgp = null;
			_application = null;
			_stack = null;
			_dpStack = null;
			_xmlStack = null;
			_styleStack = null;
			_assetsStack = null;
			_rslStack = null;
			_errorStack = null;
		}
		
		/**
		 * 	Resizes the <code>Initializator</code> instance with the specified
		 * 	<code>width</code> and <code>height</code>.
		 * 
		 * 	@param 	The new width for this <code>Initializator</code> instance,
		 * 			in pixels.
		 * 	@param 	The new height for this <code>Initializator</code> instance,
		 * 			in pixels.
		 */
		public function resize(width:Number, height:Number):void {
			_pgp.resize(width, height);
			movePanel();
		}
		
		/**
		 * 	Starts the initialization process for this <code>Initializator</code>
		 * 	instance.
		 */
		public function start():void {
			initDataLength();
			setInfo();
			_timer.reset();
			_timer.start();
			_pgp.label = initialMessage;
			//--> TODO: check if _pgp.target is equal to _target. if not, remove _pgp
			// before to set the new target value.
			_pgp.target = _target == null ? UIDescriptor.getUIManager().stage : _target;
			_pgp.display();
			movePanel();
		}
		
		/**
		 * 	Moves this <code>Initializator</code> instance to the specified <code>x</code>
		 * 	and <code>y</code> coordinates.
		 * 
		 *  @param 	The new x-position for this <code>Initializator</code> instance,
		 * 			in pixels.
		 * 	@param 	The new y-position for this <code>Initializator</code> instance,
		 * 			in pixels.
		 */
		public function move(x:Number, y:Number):void {
			_x = x;
			_y = y;
			movePanel();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _x:Number = NaN;
		private var _y:Number = NaN;
		
		private var _timer:Timer;
		private var _evtColl:EventCollector;
		private var _application:Application;
		private var _stack:Array;
		private var _dpStack:Array;
		private var _xmlStack:Array;
		private var _styleStack:Array;
		private var _assetsStack:Array;
		private var _rslStack:Array;
		
		private var _pgp:ProgressPanel;
		private var _barControl:ProgressBar;
		private var _process:uint;
		
		private var _dataLength:Number;
		private var _dataPercent:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(application:Application, target:*, applyCSS:Boolean):void {
			_application = application;
			_target = target;
			_evtColl = new EventCollector();
			_process = InitObjectType.RSL;
			createStacks();
			_pgp = new ProgressPanel();
			_barControl = _pgp.barControl;
			if(applyCSS) UIDescriptor.getUIManager().cssManager.spas_internal::setCSS(this);
			_timer = new Timer(50, 1);
			_evtColl.addEvent(_timer, TimerEvent.TIMER, timerProcess);
		}
		
		private function initDataLength():void {
			_dataLength = 0;
			setDataLength(_stack);
			setDataLength(_dpStack);
			setDataLength(_xmlStack);
			setDataLength(_styleStack);
			setDataLength(_assetsStack);
			setDataLength(_rslStack);
			if (_dataLength == 0 ) return;
			_dataPercent = 100 / _dataLength;
			_dataLength = 0;
		}
		
		private function setDataLength(stack:Array):void {
			var l:int = stack.length;
			if (l > 0) _dataLength += l;
		}
		
		private function createStacks():void {
			_stack = [];
			_dpStack = [];
			_xmlStack = [];
			_styleStack = [];
			_assetsStack = [];
			_rslStack = [];
			_errorStack = [];
		}
		
		private function initObject(prop:*):void {
			var o:*;
			var obj:Object;
			switch(_process) {
				case InitObjectType.RSL:
					createDataLoader(prop);
					break;
				case InitObjectType.STYLE_SHEET: 
					switch(true) {
						case prop.value is String :
							var r:URLRequest = new URLRequest(prop.value);  
							var l:URLLoader = new URLLoader();   
							_evtColl.addEvent(l, Event.COMPLETE, styleSheetCompleteHandler);
							l.load(r);
							break;
						case prop.value is StyleSheet :
							_application.styleSheet = prop.value;
							setInfo();
							_timer.reset();
							_timer.start();
							break;
						default :
							throw new IllegalArgumentException(Locale.spas_internal::ERRORS.INITIALIZATOR_CSS_ERROR);
					}
					break;
				case InitObjectType.ASSETS:
					createDataLoader(prop);
					break;
				case InitObjectType.OBJECT:
					if (prop[2] != null) {
						obj = prop[2];
						var item:*;
						for each(item in obj) { if (item is Function) item = item(); }
						//for each(item in obj) { if (item is Function) obj.item = item(); }
						item = null;
					} else obj = { };
					o = ObjectTranslator.objectToInstance(obj, prop[1]) as prop[1];
					if (_declareId && o.hasOwnProperty("id")) o.id = prop[0];
					_application[prop[0]] = o;
					o is IUIObject ? _evtColl.addEvent(o, UIOEvent.INITIALIZED, onData) : onData();
					break;
				case InitObjectType.DATA_PROVIDER:
					o = prop.obj is String ? _application[prop.obj] : prop.obj;
					_evtColl.addEvent(o, DataBindingEvent.DATA_PROVIDER_FINISHED, onData);
					o.dataProvider = prop.dataProvider;
					break
				case InitObjectType.XML_QUERY:
					o = prop.obj is String ? _application[prop.obj] : prop.obj;
					_evtColl.addEvent(o, DataBindingEvent.XML_QUERY_FINISHED, onData);
					var request:XMLQuery = prop.xml is XMLQuery ? prop.xml : new XMLQuery();
					if(prop.xml is XML) o.xmlQuery = prop.xmlQuery;
					else if(prop.xml is String) {
						request.load(prop.xml);
						o.xmlQuery = request;
					} else {
						throw new InvalidArgumentException(
							Locale.spas_internal::ERRORS["GET_INVALID_XML_INIT_ERROR"](o.toString()));
					}
					//request.finalize(); request = null;
					break;
			}
			
			function onDataLoaded(e:LoaderEvent):void {
				removeLoaderEvents(e.target);
				//--> TODO / BUG: la gestion des erreurs de chargement n'est pas prise en charge!
				switch(prop.type) {
					case DataFormat.BITMAP : 
						o = e.uiloader.loader.content as Bitmap;
						_application[prop.name] = o;
						break;
					case DataFormat.CACHED_GRAPHIC : 
						o = new Library(e.uiloader.loader);
						_application[prop.name] = o;
						break;
					case DataFormat.CSS : 
						o = new StyleSheet();
						o.parseCSS(e.data);
						_application[prop.name] = o;
						break;
					case DataFormat.XML : 
						o = new XMLQuery();
						o.add(XML(e.data));
						_application[prop.name] = o;
						break;
					case DataFormat.FONT : break;
					default: _application[prop.name] = e.data;
				}
				e.target.finalize();
				onData();
			}
			
			function onDataError(e:LoaderEvent):void {
				_application[prop.name] = null;
				_errorStack.push(prop.uri);
				removeLoaderEvents(e.target);
				e.target.finalize();
				onData();
			}
			
			function createDataLoader(prop:*):void {
				var dl:DataLoader = new DataLoader();
				_evtColl.addEvent(dl, LoaderEvent.COMPLETE, onDataLoaded);
				_evtColl.addEvent(dl, ProgressEvent.PROGRESS, onDataProgress);
				_evtColl.addEvent(dl, LoaderEvent.IO_ERROR, onDataError);
				var tpe:String = prop.type;
				dl.load(prop.uri, tpe);
			}
			
			function removeLoaderEvents(tgt:Object):void {
				_evtColl.removeEvent(tgt, LoaderEvent.COMPLETE, onDataLoaded);
				_evtColl.removeEvent(tgt, ProgressEvent.PROGRESS, onDataProgress);
				_evtColl.removeEvent(tgt, LoaderEvent.IO_ERROR, onDataError);
			}
			
			updateProgressBar();
		}
		
		private function onDataProgress(e:ProgressEvent):void {
			_barControl.value = e.bytesTotal / e.bytesLoaded * 100;
		}
		
		private function getNextObj():void {
			_barControl.value = 0;
			switch(true) {
				case (_rslStack.length > 0) :
					_process = InitObjectType.RSL;
					initObject(_rslStack.shift());
					break;
				case (_styleStack.length > 0) :
					_process = InitObjectType.STYLE_SHEET;
					initObject(_styleStack.shift());
					break;
				case (_assetsStack.length > 0) :
					_process = InitObjectType.ASSETS;
					initObject(_assetsStack.shift());
					break;
				case (_stack.length > 0) :
					_process = InitObjectType.OBJECT;
					initObject(_stack.shift());
					break;
				case (_dpStack.length > 0) :
					_process = InitObjectType.DATA_PROVIDER;
					initObject(_dpStack.shift());
					break;
				case (_xmlStack.length > 0) :
					_process = InitObjectType.XML_QUERY;
					initObject(_xmlStack.shift());
					break;
				case (_stack.length == 0 && _xmlStack.length == 0) :
					_timer.reset();
					this.dispatchEvent(new InitEvent(InitEvent.INITIALIZED));
					if (_initFunc != null && !_deleteAfterInit) _initFunc(); 
					else if (_deleteAfterInit) finalize(); 
					break;
			}
		}
		
		private function updateProgressBar():void {
			_dataLength += _dataPercent;
			_barControl.trackHighlightValue = Math.floor(_dataLength);
		}
		
		private function onData(e:Event = null):void {
			setInfo();
			_timer.reset();
			_timer.start();
		}
		
		private function styleSheetCompleteHandler(e:Event):void {
			_evtColl.removeEvent(e.target, Event.COMPLETE, styleSheetCompleteHandler);
			_application.spas_internal::applyNewStyle(e.target.data);
			setInfo();
			_timer.reset();
			_timer.start();
		}
		
		private function timerProcess(e:TimerEvent):void {
			getNextObj();
		}
		
		private function setInfo():void {
			if (_styleStack.length > 0) _pgp.label = _styleStack[0].info;
			else if (_stack.length > 0) _pgp.label = _stack[0][3];
			else if (_dpStack.length > 0) _pgp.label = _dpStack[0].info;
			else _pgp.label = finalMessage;
		}
		
		private function movePanel():void {
			if (!isNaN(_x) && !isNaN(_y)) {
				_pgp.move(_x, _y);
				return;
			}
			var xPos:Number;
			var yPos:Number;
			if (_target == null) {
				var s:Stage = UIDescriptor.getUIManager().stage;
				xPos = (s.stageWidth - _pgp.width) / 2;
				yPos = (s.stageHeight - _pgp.height) / 2;
			} else {
				xPos = (_target.width - _pgp.width) / 2;
				yPos = (_target.height - _pgp.height) / 2;
			}
			_pgp.move(xPos, yPos);
		}
	}
}