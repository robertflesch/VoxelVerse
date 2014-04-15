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

package org.flashapi.swing.text {
	
	// -----------------------------------------------------------
	// UITextField.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/05/2009 17:39
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextField;
	import org.flashapi.swing.color.ColorUtil;
	import org.flashapi.swing.core.Finalizable;
	
	/**
	 * 	The <code>UITextField</code> class is a subclass of the <code>TextField</code>
	 * 	class which share the following methods and properties with the
	 * 	<code>IUIObject</code> interface:
	 * 	<ul>
	 * 		<li><code>fontColor</code>,</li>
	 * 		<li><code>fixToParentHeight</code>,</li>
	 * 		<li><code>fixToParentWidth</code>,</li>
	 * 		<li><code>minWidth</code>,</li>
	 * 		<li><code>minHeight</code>,</li>
	 * 		<li><code>data</code>,</li>
	 * 		<li><code>target</code>.</li>
	 * 	</ul>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class UITextField extends TextField implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>UITextField</code> instance.
		 */
		public function UITextField() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var $fontColor:* = NaN;
		/**
		 *  The text color of this <code>UITextField</code> object. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a>
		 * 	recommendation to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a>
		 * 	section  of the document to get valid SVG color keyword names.</p>
		 *  <p>The following code shows different ways to render <code>UITextField</code>
		 * 	object with the same color:
		 * 		<listing version="3.0">
		 * 			var myTxt1:UITextField = new UITextField();
		 * 			myTxt1.color = "violet";<br />
		 * 			var myTxt2:UITextField = new UITextField();
		 * 			myTxt2.color = 0xEE82EE;<br />
		 * 			var myTxt3:UITextField = new UITextField();
		 * 			myTxt3.color = 15631086;
		 * 		</listing>
		 * 	</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		public function get fontColor():* {
			$fontColor = super.textColor;
			return $fontColor;
		}
		public function set fontColor(value:*):void {
			$fontColor = super.textColor = getColor(value);
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
		 *  If <code>true</code>, the height of the <code>UITextField</code> take the
		 * 	same value as its parent container height, or layout-height if
		 * 	its parent is a <code>UIContainer</code>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #fixToParentWidth
		 */
		public function get fixToParentHeight():Boolean {
			return $fixToParentHeight;
		}
		public function set fixToParentHeight(value:Boolean):void {
			$fixToParentHeight = value;
			fixParentContainer();
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
		 *  If <code>true</code>, the width of the <code>UITextField</code> take
		 * 	the same value as its parent container width, or layout-width if
		 * 	its parent is a <code>UIContainer</code>.
		 * 
		 * 	@default false
		 * 
		 * 	@see #fixToParentHeight
		 */
		public function get fixToParentWidth():Boolean {
			return $fixToParentWidth;
		}
		public function set fixToParentWidth(value:Boolean):void {
			$fixToParentWidth = value;
			fixParentContainer();
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
		 * 	A <code>Number</code> that specifies the minimum width of the
		 * 	<code>UITextField</code>, in pixels.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see #minHeight
		 */
		public function get minWidth():Number {
			return $minWidth;
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
		 * 	A <code>Number</code> that specifies the minimum height of the
		 * 	<code>UITextField</code>, in pixels.
		 * 
		 * 	@default NaN
		 * 
		 * 	@see #minWidth
		 */
		public function get minHeight():Number {
			return $minHeight;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>data</code> property.
		 * 
		 * 	@see #data
		 */
		protected var $data:* = null;
		/**
		 *  The <code>data</code> property lets you pass a value to the
		 * 	<code>UITextField</code> instance.
		 * 
		 * 	@default null
		 */
		public function get data():* {
			return $data;
		}
		public function set data(value:*):void {
			$data = value;
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
		 *  A reference to the object that contains the specified <code>UITextField</code>.
		 *  <p>The <code>target</code> property can either be a <code>DisplayObjectContainer</code> 
		 *  or a <code>UIContainer</code> subclass.</p>
		 */
		public function get target():* {
			return $target;
		}
		public function set target(value:*):void {
			$target = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>label</code> property.
		 * 
		 * 	@see #label
		 */
		protected var $label:String;
		/**
		 * 	Sets or gets the plain text displayed by this <code>UITextField</code>
		 * 	object.
		 */
		public function get label():String {
			return $label;
		}
		public function set label(value:String):void {
			$label = text = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		public function finalize():void {
			$target = null;
			$data = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function getColor(value:*):uint {
			return ColorUtil.getColor(value);
		}
		
		private function fixParentContainer():void {}
	}
}