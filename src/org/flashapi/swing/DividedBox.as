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
	// DividedBox.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version beta 4.1, 22/02/2010 23:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.button.core.DividedBoxButton;
	import org.flashapi.swing.constants.DividedBoxOrientation;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.ContainerEvent;
	import org.flashapi.swing.layout.Layout;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DividedBox.png")]
	
	/**
	 * 	<img src="DividedBox.png" alt="DividedBox" width="18" height="18"/>
	 * 
	 * 	<code>DividedBox</code> is used to divide two or more graphic objects.
	 * 	By dragging the divider that appears between the graphic objects, the
	 * 	user can specify how much of the split box total area goes to each object.
	 * 	When the user is resizing the objects the minimum size of the objects
	 * 	is used to determine the maximum/minimum position the objects can be
	 * 	set to.
	 * 
	 * 	<p><strong><code>DividedBox</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">orientation</code></td>
	 * 			<td>Sets the object orientation.</td>
	 * 			<td>Valid values are <code class="css">horizontal</code> or
	 * 			<code class="css">vertical</code></td>
	 * 			<td><code>orientation</code></td>
	 * 			<td>Properties.ORIENTATION</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 *  @includeExample DividedBoxExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DividedBox extends Box implements Observer, Border, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DividedBox</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	width 	The width of the <code>DividedBox</code>, in pixels.
		 * 	@param	height	The height of the <code>DividedBox</code>, in pixels.
		 * 	@param	borderStyle The type of border for this the <code>DividedBox</code>
		 * 						instance, defined by the <code>BorderStyle</code> class.
		 * 						Default value is <code>BorderStyle.NONE</code>.
		 * 	@param	orientation		The orientation of the <code>BorderStyle</code>
		 * 							instance. Valid values are <code>DividedBoxOrientation.VERTICAL</code>
		 * 							or <code>DividedBoxOrientation.HORIZONTAL</code>.
		 * 							Default value is <code>DividedBoxOrientation.HORIZONTAL</code>.
		 */
		public function DividedBox(width:Number = 100, height:Number = 100, borderStyle:String = "none", orientation:String = "horizontal") {
			super(width, height, borderStyle);
			initObj(orientation);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function set layout(value:Layout):void { }
		
		private var _dividerThickness:Number = 10;
		/**
		 * 	Sets or gets the thickness of the divider buttons used within this
		 * 	<code>DividedBox</code> instance.
		 * 
		 * 	@default 10
		 * 
		 * 	@see org.flashapi.swing.button.core.DividedBoxButton
		 */
		public function get dividerThickness():Number {
			return _dividerThickness;
		}
		public function set dividerThickness(value:Number):void {
			_dividerThickness = value;
		}
		
		private var _resizeToContent:Boolean = false;
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	A <code>Boolean</code> value that indicates whether this <code>DividedBox</code>
		 * 	instance automatically resizes to the size of its content (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get resizeToContent():Boolean {
			return _resizeToContent;
		}
		public function set resizeToContent(value:Boolean):void { 
			_resizeToContent = value;
			//TODO: use autosize
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>orientation</code> property.
		 * 
		 * 	@see #orientation
		 */
		protected var $orientation:String = DividedBoxOrientation.HORIZONTAL;
		/**
		 * 	Sets or gets the orientation of the <code>DividedBox</code> instance.
		 * 	Valid values are <code>DividedBoxOrientation.VERTICAL</code> or
		 * 	<code>DividedBoxOrientation.HORIZONTAL</code>.
		 * 
		 * 	@default <code>DividedBoxOrientation.HORIZONTAL</code>
		 */
		public function get orientation():String {
			return $orientation;
		}
		public function set orientation(value:String):void {
			$orientation = value;
			setLayoutOrientation();
			spas_internal::updateDividers();
		}
		
		private var _useMinSize:Boolean = true;
		/**
		 * 	[Not implemented yet.]
		 * 	
		 * 	<p class="hide">If set to <code>true</code>, the minimum size of the graphic objects is
		 * 	used to determine the maximum/minimum position the graphic objects can be set to.</p>
		 * 
		 * 	@default false
		 */
		public function get useMinSize():Boolean {
			return _useMinSize;
		}
		public function set useMinSize(value:Boolean):void {
			_useMinSize = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			finalizeDividers();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  The reference to the <code>Sprite</code> object that contains dividing
		 * 	controls.
		 */
		protected var $dividersContainer:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  The reference to the <code>Sprite</code> object where <code>DividedBoxButton</code>
		 * 	instances are displayed.
		 */
		protected var $dividers:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  The reference to the <code>Sprite</code> used to draw separation lines 
		 * 	when a resizing operation is performed.
		 */
		protected var $separator:Sprite;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *  An internal <code>Array</code> object used to store references to all
		 * 	<code>DividedBoxButton</code> instances.
		 */
		protected var $dividersStack:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		protected function setLayoutOrientation():void {
			switch($orientation) {
				case DividedBoxOrientation.HORIZONTAL: 
					$layout.orientation = LayoutOrientation.HORIZONTAL;
					break;
				case DividedBoxOrientation.VERTICAL: 
					$layout.orientation = LayoutOrientation.VERTICAL;
					break;
			}
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			$borderDecorator.drawBackground();
			$borderDecorator.drawBorders();
			super.drawMask();
			spas_internal::updateDividers();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		spas_internal function updateDividers(e:ContainerEvent = null):void {
			var nc:int = $content.numChildren;
			var btn:DividedBoxButton;
			if (nc <= 1) {
				finalizeDividers();
				return;
			} else {
				var obj1:Object;
				var obj2:Object;
				var i:int = 0;
				do {
					if ($dividersStack[i] != null) btn = $dividersStack[i];
					else {
						btn = new DividedBoxButton(this, $dividers, $separator);
						$dividersStack.push(btn);
					}
					btn.spas_internal::orientation = $orientation;
					obj1 = this.getObjectAt(i);
					obj2 = this.getObjectAt(i + 1);
					btn.spas_internal::setObjects(obj1, obj2);
					!btn.displayed ? btn.display() : btn.redraw();
					i ++;
				} while (nc-1 > i);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(orientation:String):void {
			$orientation = orientation;
			$horizontalGap = $verticalGap = 10;
			createDividerCont();
			setLayoutOrientation();
			$evtColl.addEvent(this, ContainerEvent.ELEMENT_ADDED, spas_internal::updateDividers);
			spas_internal::setSelector(Selectors.DIVIDED_BOX);
			spas_internal::isInitialized(2);
		}
		
		private function finalizeDividers():void {
			if($dividersStack.length == 0) return;
			do { $dividersStack.pop().finalize(); }
			while ($dividersStack.length > 0);
		}
		
		private function createDividerCont():void {
			$dividersStack = [];
			//var depth:int = spas_internal::CONTAINER.getChildIndex(_contentMask);
			$dividersContainer = new Sprite();
			$dividers = new Sprite();
			$separator = new Sprite();
			$dividersContainer.addChild($separator);
			$dividersContainer.addChild($dividers);
			spas_internal::uioSprite.addChildAt($dividersContainer, 3);
		}
	}
}