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
	// IconTextFieldLayout.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/01/2008 23:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LayoutOrientation;
	import org.flashapi.swing.constants.VerticalAlignment;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>IconTextFieldLayout</code> class is an utility class to help
	 * 	developers easily manage the layouting between icon images and text fields.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class IconTextFieldLayout {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>IconTextFieldLayout</code> instance.
		 */
		public function IconTextFieldLayout() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function finalize():void {
			_origin = null;
			_bounds = null;
			_uio1 = null;
			_uio2 = null;
			_r1 = null;
			_r2 = null;
		}
		
		/**
		 * @private
		 */
		spas_internal function setLayoutProperties(box:Rectangle, vAlign:String = "middle", hAlign:String = "center", vSpace:Number = 10, hSpace:Number = 10):void {
			_origin = box.topLeft;
			_bounds = box.bottomRight;
			_vAlign = vAlign;
			_hAlign = hAlign;
			_vSpace = vSpace;
			_hSpace = hSpace;
		}
		
		/**
		 * @private
		 */
		spas_internal function setLayout(UIObject1:DisplayObject , UIObject2:DisplayObject, layout:String = "vertical"):void {
			_uio1 = UIObject1;
			_uio2 = UIObject2;
			_r1 = UIObject1.getBounds(UIObject1);
			_r2 = UIObject2.getBounds(UIObject2);
			_layout = layout;
			var uio1X:Number;
			var uio1Y:Number;
			var uio2X:Number;
			var uio2Y:Number;
			if (_layout == LayoutOrientation.VERTICAL) {
				switch(_hAlign) {
					case HorizontalAlignment.LEFT :
						uio1X = uio2X = _origin.x;
						break;
					case HorizontalAlignment.CENTER :
						uio1X = _origin.x + (_bounds.x - _r1.width) / 2;
						uio2X = _origin.x + (_bounds.x - _r2.width) / 2;
						break;
					case HorizontalAlignment.RIGHT :
						uio1X = _bounds.x - _r1.width;
						uio2X = _bounds.x - _r2.width;
						break;
				}
				switch(_vAlign) {
					case VerticalAlignment.TOP :
						uio1Y = _origin.y;
						uio2Y = uio1Y + _uio1.height + _vSpace;
						break;
					case VerticalAlignment.MIDDLE :
						uio1Y = (_bounds.y + _origin.y - _r1.height - _r2.height - _vSpace) / 2;
						uio2Y = uio1Y + _r1.height + _vSpace;
						break;
					case VerticalAlignment.BOTTOM :
						uio2Y = _bounds.y - _r2.height;
						uio1Y = uio2Y - _r1.height - _vSpace;
						break;
				}	
			} else if (_layout == LayoutOrientation.HORIZONTAL) {
				switch(_vAlign) {
					case VerticalAlignment.TOP :
						uio1Y = uio2Y = _origin.y;
						break;
					case VerticalAlignment.MIDDLE :
						uio1Y = (_bounds.y + _origin.y - _r1.height) / 2;
						uio2Y = (_bounds.y + _origin.y - _r2.height) / 2;
						break;
					case VerticalAlignment.BOTTOM :
						uio1Y = _bounds.y - _r1.height;
						uio2Y = _bounds.y - _r2.height;
						break;
				}
				switch(_hAlign) {
					case HorizontalAlignment.LEFT :
						uio1X = _origin.x;
						uio2X = uio1X + _uio1.width + _hSpace;
						break;
					case HorizontalAlignment.CENTER :
						uio1X = (_bounds.x + _origin.x - _r1.width - _r2.width - _hSpace) / 2;
						uio2X = uio1X + _r1.width + _hSpace;
						break;
					case HorizontalAlignment.RIGHT :
						uio2X = _bounds.x - _r2.width;
						uio1X = _bounds.x - _r2.width - _r1.width - _hSpace;
						break;
				}
			}
			_uio1.x = uio1X;
			_uio1.y = uio1Y;
			_uio2.x = uio2X;
			_uio2.y = uio2Y;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _hSpace:Number;
		private var _vSpace:Number;
		private var _origin:Point;
		private var _bounds:Point;
		private var _uio1:DisplayObject;
		private var _uio2:DisplayObject;
		private var _r1:Rectangle;
		private var _r2:Rectangle;
		private var _vAlign:String;
		private var _hAlign:String;
		private var _layout:String;
	}
}