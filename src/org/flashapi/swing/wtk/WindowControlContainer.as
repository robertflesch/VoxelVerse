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

package org.flashapi.swing.wtk {
	
	// -----------------------------------------------------------
	// WindowControlContainer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3 18/06/2009 21:15
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.plaf.core.LafDTO;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>WindowControlContainer</code> class creates <code>UIContainer</code>
	 * 	objects that are used as header and footer trays within SPAS 3.0 windows.
	 * 	Footer and footer trays uses the Look and Feel of the associated window to render
	 * 	background.
	 * 
	 * 	<p>Tipically, header trays allows to add menu controls to a window object.
	 * 	Footer trays are often used to add information about window content.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class WindowControlContainer extends UIContainer implements WTKControlContainer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>WindowControlContainer</code> instance 
		 * 	with the specified parameters.
		 * 
		 * 	@param	window	The <code>WTK</code> instance where the <code>WindowControlContainer</code>
		 * 					instance will be displayed.
		 * 	@param	dto		The Look and Feel Data Transfert Object specified by the 
		 * 					<code>WTK</code> instance.
		 * 	@param	width	The width of the <code>WindowControlContainer</code> 
		 * 					instance, in pixels.
		 * 	@param	height	The height of the <code>WindowControlContainer</code>
		 * 					instance, in pixels.
		 */
		public function WindowControlContainer(window:WTK, dto:LafDTO, width:Number, type:String) {
			super();
			initObj(window, dto, width, type);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _invalidateParentUpdate:Boolean = false;
		/**
		 * 	@inheritDoc
		 */
		public function get invalidateParentUpdate():Boolean {
			return _invalidateParentUpdate;
		}
		public function set invalidateParentUpdate(value:Boolean):void {
			_invalidateParentUpdate = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void { }
		
		/**
		 * 	@private
		 */
		override public function get height():Number {
			if ($content.numChildren > 0 && $autoHeight) $height = $content.height + $padL + $padR;
			return $height;
		}
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {
			$height = value;
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
			_window = null;
			_dto = null;
			spas_internal::drawingFunction = null;
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function redraw():void {
			super.redraw();
			if(!_invalidateParentUpdate) _window.redraw();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal var tray:Sprite;
		
		/**
		 *  @private
		 */
		spas_internal var drawingFunction:Function;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			refresh();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			spas_internal::drawingFunction();
			drawMask();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		spas_internal function setWidth(width:Number):void {
			$width = width;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _window:WTK;
		private var _dto:LafDTO;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(window:WTK, dto:LafDTO, width:Number, type:String):void {
			_window = window;
			_dto = dto;
			$type = type;
			createContainers();
			initSize(width, 25);
			$horizontalGap = $verticalGap = $padL = $padT = $padR = $padB = 5;
			spas_internal::setSelector($type);
		}
		
		private function createContainers():void {
			spas_internal::tray = new Sprite();
			spas_internal::uioSprite.addChild(spas_internal::tray);
			spas_internal::uioSprite.addChild($content);
			$contentMask = new Shape();
			spas_internal::uioSprite.addChild($contentMask);
			$content.mask = $contentMask;
		}
		
		private function drawMask():void {
			var g:Graphics = ($contentMask as Shape).graphics;
			g.clear();
			g.beginFill(0);
			g.drawRect($padL, $padT, $width - $padR, $height - $padB);
			g.endFill();
		}
	}
	
}
