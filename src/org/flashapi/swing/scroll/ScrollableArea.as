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

package org.flashapi.swing.scroll {
	
	// -----------------------------------------------------------
	// ScrollableArea.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 17/03/2010 21:31
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.flashapi.swing.constants.ScrollableOrientation;
	import org.flashapi.swing.constants.ScrollPolicy;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.event.ScrollEvent;
	import org.flashapi.swing.plaf.libs.ScrollableAreaUIRef;
	import org.flashapi.swing.ScrollBar;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>ScrollableArea</code> creates a <code>UIObject</code> that can be
	 * 	extended or decorated to create <code>UIObject</code> instances that allow
	 * 	users to scroll another object within a SPAS 3.0 application.
	 * 
	 * 	<p> <code>ScrollableArea</code> objects consist in both, vertical and horizontal
	 * 	scroll bars, which can independently be visible or hidden. These scroll bars
	 * 	are used to move a <code>DisplayObject</code> specified by the 
	 * 	<code>targetPath</code> property.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ScrollableArea extends UIObject implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor.	Creates a new <code>ScrollableArea</code> object with the
		 * 					specified parameters.
		 * 
		 * 	@param	targetPath	The <code>DisplayObject</code> for which scrolling must 
		 * 					be managed by this <code>ScrollableArea</code> object.
		 * 	@param	width	The width of the <code>ScrollableArea</code> object, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>ScrollableArea</code> object, in
		 * 					pixels.
		 */
		public function ScrollableArea(targetPath:DisplayObject, width:Number = 150, height:Number = 80) { 
			super();
			initObj(targetPath, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the vertical
		 * 	scroll bar is visible (<code>true</code>), or hidden (<code>false</code>).
		 * 	The value of the <code>isVScrollBarActive</code> property depends on the
		 * 	<code>scrollPolicy</code> for this <code>ScrollableArea</code> object.
		 * 
		 * 	@default true
		 * 
		 * 	@see #isHScrollBarActive
		 * 	@see #scrollPolicy
		 */
		public function get isVScrollBarActive():Boolean {
			return _isVScrollBarActive;
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the horizontal
		 * 	scroll bar is visible (<code>true</code>), or hidden (<code>false</code>).
		 * 	The value of the <code>isHScrollBarActive</code> property depends on the
		 * 	<code>scrollPolicy</code> for this <code>ScrollableArea</code> object.
		 * 
		 * 	@default true
		 * 
		 * 	@see #isVScrollBarActive
		 * 	@see #scrollPolicy
		 */
		public function get isHScrollBarActive():Boolean {
			return _isHScrollBarActive;
		}
		
		/**
		 * 	The <code>DisplayObject</code> for which scrolling must be managed by
		 * 	this <code>ScrollableArea</code> object.
		 */
		public function get targetPath():DisplayObject {
			return _targetPath;
		}
		public function set targetPath(value:DisplayObject):void {
			_targetPath = spas_internal::HScrollBar.targetPath =
			spas_internal::VScrollBar.targetPath = value;
			if(displayed) redraw();
		}
		
		private var _scrollPolicy:String = ScrollPolicy.BOTH;
		/**
		 * 	Sets or gets the scroll policy for this <code>ScrollableArea</code> object.
		 * 	Possible values are:
		 * 	<ul>
		 * 		<li><code>ScrollPolicy.AUTO</code>: configures the scrollable area to 
		 * 		include scroll bars only when necessary,</li>
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
		 * 	@default ScrollPolicy.BOTH
		 */
		public function get scrollPolicy():String {
			return _scrollPolicy;
		}
		public function set scrollPolicy(value:String):void {
			_scrollPolicy = value;
			switch(_scrollPolicy) {
				case ScrollPolicy.BOTH :
					_isVScrollBarActive = _isHScrollBarActive = true;
					spas_internal::VScrollBar.display();
					spas_internal::HScrollBar.display();
					break;
				case ScrollPolicy.NONE :
					_isVScrollBarActive = _isHScrollBarActive = false;
					spas_internal::VScrollBar.remove();
					spas_internal::HScrollBar.remove();
					break;
				case ScrollPolicy.VERTICAL :
					if (_isHScrollBarActive) {
						_isHScrollBarActive = false;
						spas_internal::HScrollBar.remove();
					}
					if (!_isVScrollBarActive) {
						_isVScrollBarActive = true;
						spas_internal::VScrollBar.display();
					}
					break;
				case ScrollPolicy.HORIZONTAL :
					if (_isVScrollBarActive) {
						_isVScrollBarActive = false;
						spas_internal::VScrollBar.remove();
					}
					if (!_isHScrollBarActive) {
						_isHScrollBarActive = true;
						spas_internal::HScrollBar.display();
					}
					break;
				case ScrollPolicy.AUTO :
					break; //TODO : place the MainContainer algorithm here.
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Deactivated getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function get shadow():Boolean {
			return false;
		}
		override public function set shadow(value:Boolean):void { }
		
		/**
		 * 	@private
		 */
		override public function get glow():Boolean {
			return false;
		}
		override public function set glow(value:Boolean):void {}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			$evtColl.removeEvent(spas_internal::VScrollBar, ScrollEvent.THICKNESS_CHANGED, thicknessChangedHandler);
			$evtColl.removeEvent(spas_internal::HScrollBar, ScrollEvent.THICKNESS_CHANGED, thicknessChangedHandler);
			_targetPath = null;
			spas_internal::VScrollBar.finalize();
			spas_internal::HScrollBar.finalize();
			spas_internal::VScrollBar = null;
			spas_internal::HScrollBar = null;
			super.finalize();
		}
		
		/**
		 * 	@private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if(!$displayed) {
				$parent.addChild(_scrollArea);
				move(x, y);
				if(_isVScrollBarActive) spas_internal::VScrollBar.display();
				if(_isHScrollBarActive) spas_internal::HScrollBar.display();
				refresh();
				doStartEffect();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			if ($displayed) {
				if (spas_internal::VScrollBar != null) spas_internal::VScrollBar.remove();
				if (spas_internal::HScrollBar != null) spas_internal::HScrollBar.remove();
				unload();
			} 
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal var VScrollBar:ScrollBar;
		
		/**
		 * 	@private
		 */
		spas_internal var HScrollBar:ScrollBar;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			var vsw:Number = spas_internal::VScrollBar.width;
			var hsw:Number = spas_internal::HScrollBar.width;
			var hLengthAdjustment:Number = _isVScrollBarActive && spas_internal::VScrollBar.visible ? vsw : 0;
			var vLengthAdjustment:Number = _isHScrollBarActive && spas_internal::HScrollBar.visible ? hsw : 0;
			spas_internal::VScrollBar.y = $padT;
			spas_internal::VScrollBar.x = $width - vsw;
			spas_internal::HScrollBar.y = $height-hsw;
			spas_internal::VScrollBar.length = height - vLengthAdjustment - $padT - $padB;
			spas_internal::HScrollBar.length = width-hLengthAdjustment;
			if(_isVScrollBarActive && _isHScrollBarActive) spas_internal::VScrollBar.showBottomRightCorner = true;
			_scrollArea.x = spas_internal::uioSprite.x;
			_scrollArea.y = spas_internal::uioSprite.y;
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			initScrollBarLAF();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _isVScrollBarActive:Boolean;
		private var _isHScrollBarActive:Boolean;
		private var _scrollArea:Sprite;
		private var _targetPath:DisplayObject;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(targetPath:DisplayObject, width:Number, height:Number):void {
			$width = width;
			$height = height;
			_targetPath = targetPath;
			_isVScrollBarActive = _isHScrollBarActive = true;
			_scrollArea = new Sprite();
			$padL = $padR = $padT = $padB = 0;
			spas_internal::VScrollBar = new ScrollBar(_targetPath, height);
			spas_internal::HScrollBar = new ScrollBar(_targetPath, width, ScrollableOrientation.HORIZONTAL);
			initLaf(ScrollableAreaUIRef);
			$evtColl.addEventCollection(
				[spas_internal::HScrollBar, spas_internal::VScrollBar], ScrollEvent.THICKNESS_CHANGED, thicknessChangedHandler);
			spas_internal::HScrollBar.target = spas_internal::VScrollBar.target = _scrollArea;
		}
		
		private function initScrollBarLAF():void {
			var c:Class = lookAndFeel.getScrollBarLaf();
			spas_internal::VScrollBar.lockLaf(c, true);
			spas_internal::HScrollBar.lockLaf(c, true);
		}
		
		private function thicknessChangedHandler(e:ScrollEvent):void {
			refresh();
		}
	}
}