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
	// ModalObject.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 04/06/2009 01:03
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.geom.Geometry;
	
	[IconFile("ModalObject.png")]
	
	/**
	 * 	<img src="ModalObject.png" alt="ModalObject" width="18" height="18"/>
	 * 
	 * 	The <code>ModalObject</code> class lets you set a window-like "modal"
	 * 	behavior to any display object, which means the display object will retain
	 * 	focus until the <code>ModalObject</code> instance is removed.
	 * 	<code>ModalObject</code> instances behave like modal wrappers for display
	 * 	objects.
	 * 
	 *  @includeExample ModalObjectExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ModalObject extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>ModalObject</code> instance with the
		 * 					specified parameter.
		 * 
		 *	@param	object	A display object to be displayed when you call
		 * 					<code>ModalObject.display()</code> the method.
		 * 					The <code>object</code> parameter can be a
		 * 					<code>DisplayObject</code> or a <code>UIObject</code>
		 * 					instance.
		 */
		public function ModalObject(object:*) {
			super();
			initObj(object);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _colorMatrixFilter:ColorMatrixFilter;
		/**
		 * 	Sets or gets the <code>ColorMatrixFilter</code> object used by this 
		 * 	<code>ModalObject</code> instance to tint the interface when the
		 * 	<code>colorMode</code> property is <code>true</code>.
		 * 
		 * 	<p> The default value is a color matrix with the following properties:<br />
		 * 	<img src = "../../../doc-images/modal_object_matrix.gif"
		 * 	alt="ModalObject default matrix." /></p>
		 * 
		 * 	@see #colorMode
		 */
		public function get colorMatrixFilter():ColorMatrixFilter {
			return _colorMatrixFilter;
		}
		public function set colorMatrixFilter(value:ColorMatrixFilter):void {
			_colorMatrixFilter = value;
		}
		
		private var _colorMode:Boolean = true;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>ModalObject</code>
		 * 	instance uses a <code>ColorMatrixFilter</code> object to tint the interface
		 * 	when displayed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 * 
		 * 	@see #colorMatrixFilter
		 */
		public function get colorMode():Boolean {
			return _colorMode;
		}
		public function set colorMode(value:Boolean):void {
			_colorMode = value;
		}
		
		private var _displayed:Boolean = false;
		/**
		 *  Returns a <code>Boolean</code> value that indicates the whether <code>ModalObject</code>
		 * 	instance is currently displayed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get displayed():Boolean {
			return _displayed;
		}
		
		private var _object:* = null;
		/**
 		 * 	Sets or gets the display object to be used as a modal popup object.
		 * 
		 * 	@default null
		 */
		public function get object():* {
			return _object;
		}
		public function set object(value:*):void {
			_object = value;
		}
		
		private static var _preventSandboxViolations:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>ModalObject</code>
		 * 	instance prevent sandbox violations when rendering the modal background
		 * 	(<code>true</code>), or not (<code>false</code>). Must be <code>true</code>
		 * 	if you use <code>StageVideo</code> instances within SPAS 3.0 applications.
		 * 
		 * 	<p>If <code>true</code>, no blur effect is applyed to the modal background.</p>
		 * 
		 * 	@default false
		 */
		public static function get preventSandboxViolations():Boolean {
			return _preventSandboxViolations;
		}
		public static function set preventSandboxViolations(value:Boolean):void {
			_preventSandboxViolations = value;
		}
		
		/**
		 *  The <code>paddingTop</code> property sets the top padding of the
		 * 	"frozen area".  
		 *
		 *  @default 0
		 * 
		 * 	@see #paddingRight
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 */
		public function get paddingTop():Number {
			return _paddTop;
		}
		public function set paddingTop(value:Number):void {
			_paddTop = value;
			_destPoint.y = - value;
			refresh();
		}
		
		/**
		 *  The <code>paddingLeft</code> property sets the left padding of the
		 * 	"frozen area".  
		 *
		 *  @default 0
		 * 
		 * 	@see #paddingRight
		 * 	@see #paddingBottom
		 * 	@see #paddingTop
		 */
		public function get paddingLeft():Number {
			return _paddLeft;
		}
		public function set paddingLeft(value:Number):void {
			_paddLeft = value;
			_destPoint.x = - value;
			refresh();
		}
		
		/**
		 *  The <code>paddingBottom</code> property sets the bottom padding of the
		 * 	"frozen area".  
		 *
		 *  @default 0
		 * 
		 * 	@see #paddingRight
		 * 	@see #paddingLeft
		 * 	@see #paddingTop
		 */
		public function get paddingBottom():Number {
			return _paddBottom;
		}
		public function set paddingBottom(value:Number):void {
			_paddBottom = value;
			refresh();
		}
		
		/**
		 *  The <code>paddingRight</code> property sets the right padding of the
		 * 	"frozen area".  
		 *
		 *  @default 0
		 * 
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 * 	@see #paddingTop
		 */
		public function get paddingRight():Number {
			return _paddRight;
		}
		public function set paddingRight(value:Number):void {
			_paddRight = value;
			refresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Displays the <code>ModalObject</code> instance at the specified (x,y)
		 * 	coordinates relative to the stage coordinates.
		 * 	<p>If coordinate parameters are not set, the <code>ModalObject</code> is
		 * 	displayed at the center of the stage.</p>
		 * 
		 * 	@param	x Indicates the x coordinate of the <code>ModalObject</code>, in
		 * 			pixels. Default value is <code>undefined</code>.
		 * 	@param	y Indicates the y coordinate of the <code>ModalObject</code>, in
		 * 			pixels. Default value is <code>undefined</code>.
		 * 
		 * 	@see displayed
		 * 	@see remove()
		 */
		public function display(x:Number = undefined, y:Number = undefined):void {
			if(!_displayed) {
				createUIObject(x, y);
				_displayed = true;
				_evtColl.addEvent(_stage, Event.RESIZE, refresh);
			}
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			remove();
			if(_mainBitmap != null) _mainBitmap.bitmapData.dispose();
			_evtColl.finalize();
			_evtColl = null;
			_object = null;
			_colorMatrixFilter = null;
			_destPoint = null;
			_origin = null;
		}
		
		/**
		 *  Removes the <code>ModalObject</code> instance from the stage.
		 * 
		 * 	@see display()
		 */
		public function remove():void {
			if(_displayed) {
				_frozenArea.removeChildAt(0);
				_stage.removeChild(_frozenArea);
				if (_object is IUIObject) _object.remove()
				else _stage.removeChild(_object);
				_evtColl.removeEvent(_stage, Event.RESIZE, refresh);
			}
			if (_documentBitmap != null) _documentBitmap.dispose();
			_documentBitmap = null;
			_displayed = false;
		}
		
		/**
		 * Redraws the <code>ModalObject</code> instance. 
		 */
		public function redraw():void {
			refresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		protected function createUIObject(x:Number = NaN, y:Number = NaN):void {
			createModalBackground();
			if (_object is IUIObject) {
				_object.target = _stage;
				_object.display();
			} else _stage.addChild(_object);
			_x = x;
			_y = y;
			setObjPosition();
		}
		
		/**
		 *  @private
		 */
		protected function refresh(e:Event = null):void {
			if(_documentBitmap == null) return;
			_documentBitmap.dispose();
			refreshModalBackground();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _mainBitmap:Bitmap;
		private var _documentBitmap:BitmapData;
		private var _frozenArea:Sprite;
		private var _bounds:Rectangle;
		private var _blur:BlurFilter;
		private var _stage:Stage;
		private var _evtColl:EventCollector;
		private var _paddTop:Number;
		private var _paddRight:Number;
		private var _paddBottom:Number;
		private var _paddLeft:Number;
		private var _destPoint:Point;
		private var _origin:Point;
		private var _x:Number;
		private var _y:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(object:*):void {
			_stage = UIDescriptor.getUIManager().stage;
			_object = object;
			_paddTop = _paddRight = _paddBottom = _paddLeft = 0;
			_destPoint = new Point();
			_origin = Geometry.ORIGIN;
			_frozenArea = new Sprite();
			_frozenArea.cacheAsBitmap = true;
			_blur = new BlurFilter(3, 3, 3);
			_evtColl = new EventCollector();
			_colorMatrixFilter =
				new ColorMatrixFilter(	[1, 0, 0, 0.1, 0, 0, 1, 0, 0.1, 0,
										0, 0, 1, 0.1, 0, 0, 0, 0, 1, 0]);
		}
		
		private function setObjPosition():void {
			var r:Rectangle = _object.getBounds(_stage);
			var xPos:Number = isNaN(_x) ? (_stage.stageWidth - r.width - r.x) / 2 : _x;
			var yPos:Number = isNaN(_y) ? (_stage.stageHeight - r.height - r.y) / 2 : _y;
			_object.x = xPos;
			_object.y = yPos;
		}
		
		private function createModalBackground():void {
			_mainBitmap = new Bitmap();
			if (_frozenArea.numChildren == 0) _frozenArea.addChild(_mainBitmap);
			_stage.addChild(_frozenArea);
			refreshModalBackground();
		}
		
		private function refreshModalBackground():void {
			setVisibility(false);
			var sh:Number = _stage.stageHeight;
			var sw:Number = _stage.stageWidth;
			_bounds = new Rectangle(0, 0, sw - _paddRight, sh - _paddBottom);
			if (_preventSandboxViolations) {
				_documentBitmap = new BitmapData(sw - _paddLeft - _paddRight, sh - _paddBottom - _paddTop, true, 0x66FFFFFF);
			} else {
				_documentBitmap = new BitmapData(sw - _paddLeft - _paddRight, sh - _paddBottom - _paddTop, true, 0x00FFFFFF);
				var buffer:BitmapData = new BitmapData(sw, sh, true, 0x00FFFFFF);
				buffer.draw(_stage);
				_documentBitmap.applyFilter(buffer, _bounds, _destPoint, _blur);
				buffer.dispose();
				buffer = null;
			}
			if (_colorMode) _documentBitmap.applyFilter(_documentBitmap, _bounds, _origin, _colorMatrixFilter);
			
			_mainBitmap.bitmapData = _documentBitmap;
			_mainBitmap.x = _paddLeft;
			_mainBitmap.y = _paddTop;
			setObjPosition();
			setVisibility(true);
		}
		
		private function setVisibility(value:Boolean):void {
			_frozenArea.visible = _object.visible = value;
		}
	}
}