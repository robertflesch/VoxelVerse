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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// MeasureUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 08/10/2008 10:53
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.core.SizeAdjuster;
	
	/**
	 * 	The <code>MeasureUtil</code> class is a utility class that defines all-static
	 * 	methods for working with <code>UIObjects</code> metrics issues. Because
	 * 	<code>UIObject</code> instances cannot deal with real bounds before having
	 * 	changed their size, the <code>MeasureUtil</code> provides convenient methods
	 * 	to anticipate differences between size values and the real metrics of
	 * 	<code>UIObject</code> instances.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class MeasureUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				MeasureUtil instance.
		 */
		public function MeasureUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a <code>Number</code> that represent the difference between
		 * 	the left edge of the <code>DisplayObject</code> instance, specified
		 * 	by the <code>x</code> value, and the real metrics.
		 * 	
		 * 	@param	obj	The <code>DisplayObject</code> for which to fix metrics
		 * 				issues.
		 * 
		 * 	@return The difference between the left edge and the real metrics 
		 * 			of a <code>DisplayObject</code> instance.
		 * 
		 * 	@see #getRightRatio()
		 */
		public static function getLeftRatio(obj:DisplayObject):Number {
			var r:Rectangle = obj.getBounds(null);
			return r.x;
		}
		
		/**
		 * 	Returns a <code>Number</code> that represent the difference between
		 * 	the right edge of the <code>DisplayObject</code> instance, specified
		 * 	by the <code>width</code> property, and the real metrics.
		 * 	
		 * 	@param	obj	The <code>DisplayObject</code> for which to fix metrics
		 * 				issues.
		 * 
		 * 	@return The difference between the right edge and the real metrics 
		 * 			of a <code>DisplayObject</code> instance.
		 * 
		 * 	@see #getLeftRatio()
		 */
		public static function getRightRatio(obj:DisplayObject):Number {
			var r:Rectangle = obj.getBounds(null);
			return r.width - getEffectiveWidth(obj) + r.x;
		}
		
		/**
		 * 	Returns a <code>Number</code> that represent the difference between
		 * 	the bottom edge of the <code>DisplayObject</code> instance, specified
		 * 	by the <code>height</code> property, and the real metrics.
		 * 	
		 * 	@param	obj	The <code>DisplayObject</code> for which to fix metrics
		 * 				issues.
		 * 
		 * 	@return The difference between the bottom edge and the real metrics 
		 * 			of a <code>DisplayObject</code> instance.
		 * 
		 * 	@see #getTopRatio()
		 */
		public static function getBottomRatio(obj:DisplayObject):Number {
			var r:Rectangle = obj.getBounds(null);
			return r.height - getEffectiveHeight(obj) + r.y;
		}
		
		/**
		 * 	Returns a <code>Number</code> that represent the difference between
		 * 	the top edge of the <code>DisplayObject</code> instance, specified
		 * 	by the <code>y</code> value, and the real metrics.
		 * 	
		 * 	@param	obj	The <code>DisplayObject</code> for which to fix metrics
		 * 				issues.
		 * 
		 * 	@return The difference between the top edge and the real metrics 
		 * 			of a <code>DisplayObject</code> instance.
		 * 
		 * 	@see #getBottomRatio()
		 */
		public static function getTopRatio(obj:DisplayObject):Number {
			var r:Rectangle = obj.getBounds(null);
			return r.y;
		}
		
		/**
		 * 	Returns a <code>Number</code> that represent the difference between
		 * 	height and the real metrics of a <code>DisplayObject</code> instance.
		 * 	
		 * 	@param	obj	The <code>DisplayObject</code> for which to fix metrics
		 * 				issues.
		 * 
		 * 	@return The difference between height and the real metrics of a
		 * 			<code>DisplayObject</code> instance.
		 * 
		 * 	@see #getWidthRatio()
		 */
		public static function getHeightRatio(obj:DisplayObject):Number {
			var r:Rectangle = obj.getBounds(null);
			return r.height - getEffectiveHeight(obj);
		}
		
		/**
		 * 	Returns a <code>Number</code> that represent the difference between
		 * 	width and the real metrics of a <code>DisplayObject</code> instance.
		 * 	
		 * 	@param	obj	The <code>DisplayObject</code> for which to fix metrics
		 * 				issues.
		 * 
		 * 	@return The difference between width and the real metrics of a
		 * 			<code>DisplayObject</code> instance.
		 * 
		 * 	@see #getHeightRatio()
		 */
		public static function getWidthRatio(obj:DisplayObject):Number {
			var r:Rectangle = obj.getBounds(null);
			return r.width - getEffectiveWidth(obj);
		}
		
		/*public static function getLayoutBounds(uio:UIObject):Rectangle {
			var l:Number = isNaN(uio.paddingLeft) ? 0 : uio.paddingLeft;
			var r:Number = isNaN(uio.paddingRight) ? 0 : uio.paddingRight;
			var t:Number = isNaN(uio.paddingTop) ? 0 : uio.paddingTop;
			var b:Number = isNaN(uio.paddingBottom) ? 0 : uio.paddingBottom;
			return new Rectangle(l, t, uio.width - r, uio.height - b);
		}*/
		
		/*public static  function getPercentWidth(uio:UIObject, hGapSize:Number = 0):Number {
			if (isNaN(uio.percentWidth)) return NaN;
			var bounds:Number = getLayoutBounds(uio.target).width;
			var newWidth:Number = (bounds - getWidthRatio(uio as DisplayObject) - uio.marginLeft - uio.marginRight - hGapSize) * uio.percentWidth / 100;
			var minWidth:Number = isNaN(uio.minWidth) ? 0 : uio.minWidth;
			return (newWidth > minWidth) ? newWidth : NaN;
		}*/
		
		/*public static function getPercentHeight(uio:UIObject, vGapSize:Number = 0):Number {
			if (isNaN(uio.percentHeight)) return NaN;
			var bounds:Number = getLayoutBounds(uio.target).height;
			var newHeight:Number = (bounds - getHeightRatio(uio as DisplayObject) - uio.marginTop - uio.marginBottom - vGapSize) * uio.percentHeight / 100;
			var minHeight:Number = isNaN(uio.minHeight) ? 0 : uio.minHeight;
			return (newHeight > minHeight) ? newHeight : NaN;
		}*/
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private static function getEffectiveWidth(obj:*):Number {
			var s:Number;
			if (obj is SizeAdjuster) s = obj.getRealWidth();
			else if (isNaN(obj.width)) s = 0;
			else s = obj.width;
			return s;
		}
		
		private static function getEffectiveHeight(obj:*):Number {
			var s:Number;
			if (obj is SizeAdjuster) s = obj.getRealHeight();
			else if (isNaN(obj.height)) s = 0;
			else s = obj.height;
			return s;
		}
	}
}