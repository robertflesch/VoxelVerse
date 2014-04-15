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

package org.flashapi.swing.containers {
	
	// -----------------------------------------------------------
	// SimpleContainerBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/04/2010 19:03
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.Iterator;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>SimpleContainerBase</code> class is the base class for SPAS 3.0
	 * 	container objects that do not use extended control capabilities, such as
	 * 	bordes, background or scroll bars.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SimpleContainerBase extends UIContainer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>SimpleContainerBase</code> instance.
		 *
		 * 	@param	width	The width of the container, in pixels. Default value is
		 * 					<code>100</code> px.
		 * 	@param	height	The height of the container, in pixels. Default value is
		 * 					<code>100</code> px.
		 */
		public function SimpleContainerBase(width:Number = 100, height:Number = 100) {
			super();
			initObj(width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var rect:Rectangle = new Rectangle(0, 0, $width, $height);
			if($autoAdjustSize) {
				var it:Iterator = spas_internal::elementsList.iterator;
				var newRect:Rectangle;
				var obj:*;
				while(it.hasNext()) {
					obj = it.next();
					newRect = obj.getRect(null);
					newRect.x = obj.x; newRect.y = obj.y; 
					rect = rect.union(newRect);
				}
				$width = rect.width; $height = rect.height;
				it.reset();
			}
			return rect;
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, $width, $height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static function showRedrawRegions(value:Boolean, color:uint = 0xFF0000):void {
			_debugOpacity = value ? .5 : 0;
			_debugColor = color;
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			with (spas_internal::uioSprite.graphics) {
				clear();
				beginFill(_debugColor, _debugOpacity);
				drawRect(0, 0, $width, $height);
				endFill();
			}
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private static properties
		//
		//--------------------------------------------------------------------------
		
		private static var _debugColor:uint = 0xFF0000;
		private static var _debugOpacity:Number = 0;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			$width = width;
			$height = height;
			$autoAdjustSize = true;
			initMinSize(0, 0); 
			spas_internal::uioSprite.addChild($content);
		}
	}
}