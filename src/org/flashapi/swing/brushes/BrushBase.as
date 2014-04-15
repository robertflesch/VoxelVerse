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

package org.flashapi.swing.brushes {
	
	// -----------------------------------------------------------
	// BrushBase.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/03/2008 11:19
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	/**
	 * 	The <code>BrushBase</code> class is the base class for all <code>Brush</code>
	 * 	objects.
	 * 	<code>Brush</code> objects define the color and the pattern of a rectangular
	 * 	area. They can be used to draw custom strokes or icons.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BrushBase implements Brush {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>Brush</code> object.
		 * 
		 * 	@param	target	The display object used to draw the <code>Brush</code> object.
		 * 	@param	rect	A <code>Rectangle</code> that defines the bounds of the
		 * 					<code>Brush</code> object.
		 * 					If <code>null</code> the default <code>Brush.rectangle</code>
		 * 					property is set to <code>16</code> px.
		 * 	@param	dto		A reference to the <code>LafDTO</code> instance used by
		 * 					the <code>Brush</code> object to get access to properties
		 * 					from its parent	<code>UIObject</code>.  
		 */
		public function BrushBase(target:*, rect:Rectangle = null, dto:LafDTO = null) {
			super();
			initObj(target, rect, dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var $color:Number = NaN;
		/**
		 * 	@inheritDoc
		 */
		public function get color():* {
			return $color;
		}
		public function set color(value:*):void {
			$color = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>factor</code> property.
		 * 
		 * 	@see #factor
		 */
		protected var $factor:Number = 1.0;
		/**
		 * 	@inheritDoc
		 */
		public function get factor():Number {
			return $factor;
		}
		public function set factor(value:Number):void {
			$factor = value;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>rectangle</code> property.
		 * 
		 * 	@see #rectangle
		 */
		protected var $rect:Rectangle;
		/**
		 * 	@inheritDoc
		 */
		public function get rectangle():Rectangle {
			return $rect;
		}
		public function set rectangle(value:Rectangle):void {
			$rect = value;
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
		 * 	@inheritDoc
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
		 * 	Stores the internal value for the <code>dto</code> property.
		 * 
		 * 	@see #dto
		 */
		protected var $dto:LafDTO;
		/**
		 * 	@inheritDoc
		 */
		public function get dto():LafDTO {
			return $dto;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function paint():void {}
		
		/**
		 * 	@inheritDoc
		 */
		public function clear():void {}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			$graphics = null;
			$target = null;
			$rect = null;
			$dto = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A reference to the <code>Graphics</code> object for this <code>Brush</code>
		 * 	instance.
		 */
		protected var $graphics:Graphics;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A <code>Boolean</code> value that indicates whether the icon is currently
		 * 	painted (<code>true</code>), or not(<code>false</code>).
		 */
		protected var $isPainted:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:*, rect:Rectangle, dto:LafDTO):void {
			$target = target;
			if ($target is Sprite || $target is Shape || $target is MovieClip) $graphics = target.graphics;
			//else ;
			$rect = (rect == null) ? new Rectangle(0, 0, 16, 16) : rect;
			$dto = dto;
		}
	}
}