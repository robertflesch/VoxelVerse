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

package org.flashapi.swing.plaf.basic {

	// -----------------------------------------------------------
	// BasicUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 26/10/2009 13:58
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.LookAndFeel;
	
	/**
	 * 	The <code>BasicUI</code> class is the base class for the "flex-like"
	 * 	pluggable look and feel.
	 * 	
	 * 	@see org.flashapi.swing.plaf.LookAndFeel
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicUI implements LookAndFeel {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.  A Look and Feel object must not be directly instantiated.
		 * 
		 * 	@param	dto		A reference to the <code>LafDTO</code> object that
		 * 					instantiates this look and feel.
		 */
		public function BasicUI(dto:LafDTO) {
			super();
			this.dto = dto;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant integer that defines the panel color for the SPAS 3.0 "flex-like"
		 * 	look and feel.
		 */
		public static const DEFAULT_PANEL_COLOR:uint = 0xB0BDC3;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function addRaiseEffect():void {
			var s:Sprite = dto.container;
			s.scaleX = s.scaleY = 1.02;
			s.x -= 3;
			s.y -= 3;
			_startDragEffectShadow.pop();
			_startDragEffectShadow.push(new DropShadowFilter(8, 45, 0, .5, 15, 15));
			s.filters = _startDragEffectShadow;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function clearEmphasizedState():void {
			dto.container.filters = [];
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function drawBackFace():void { }
		
		/**
		 *  @inheritDoc 
		 */
		public function drawEmphasizedState():void {
			if (!isNaN(dto.focusColor)) _focusGlowFilter.color = dto.focusColor;
			var f:Array = [_focusGlowFilter];
			dto.container.filters = f;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getGlowFilter():GlowFilter {
			return _glowFilter;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getFocusFilter():GlowFilter {
			return _focusGlowFilter;
		}
			
		/**
		 *  @inheritDoc 
		 */
		public function getShadowFilter():DropShadowFilter {
			return _dropShadowFilter;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function onChange():void {
			_startDragEffectShadow = [];
			_startDragEffectShadow = null;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function removeRaiseEffect():void {
			var s:Sprite = dto.container;
			s.scaleX = s.scaleY = 1;
			s.x += 3;
			s.y += 3;
			_startDragEffectShadow.pop();
			s.filters = _startDragEffectShadow;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected var dto:LafDTO;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _dropShadowFilter:DropShadowFilter = new DropShadowFilter(2.5, 90, 0, .4, 6, 6);
		private var _glowFilter:GlowFilter = new GlowFilter(0x0066CC, .5, 10, 10);
		private var _focusGlowFilter:GlowFilter = new GlowFilter(0x0099FF, .6, 7, 7, 5);
		private var _startDragEffectShadow:Array = [];
	}
}