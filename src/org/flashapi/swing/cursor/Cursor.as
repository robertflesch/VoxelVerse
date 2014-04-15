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

package org.flashapi.swing.cursor {
	
	// -----------------------------------------------------------
	// Cursor.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 14/03/2010 18:39
	* @see http://www.flashapi.org/
	*/
	
	import flash.ui.Mouse;
	import org.flashapi.swing.constants.CursorType;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.exceptions.SingletonException;
	import org.flashapi.swing.managers.DepthManager;
	import org.flashapi.swing.plaf.libs.CursorUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>Cursor</code> class creates a singleton object used by SPAS 3.0
	 * 	applications to display cursor controls.
	 * 
	 * 	@see org.flashapi.swing.managers.CursorManager
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Cursor extends UIObject implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Cursor</code> singleton.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException
		 * 			A <code>SingletonException</code> if you try create a new
		 * 			<code>Cursor</code> instance.
		 */
		public function Cursor() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function set name(value:String):void {}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
            if(!displayed) {
				move(x, y);
				Mouse.hide();
				spas_internal::uioSprite.visible = true;
				doStartEffect();
				refresh();
				//DepthManager.setOverAll(this);
			}
		}
		
		
		/**
		 * @private
		 */
		override public function remove():void {
			if(displayed) unload();
			Mouse.show();
		}
		
		/**
		 * 	Sets the type of cursor that must be displayed within the current SPAS 3.0
		 * 	application. Possible values are constants of the <code>CursorType</code>
		 * 	class.
		 * 
		 * 	@see org.flashapi.swing.constants.CursorType
		 */
		public function set type(value:String):void {
			$type = value;
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static function getInstance():Cursor {
			_constructorAccess = false;
			return new Cursor();
		}
		
		/**
		 * 	@private
		 */
		override protected function refresh():void {
			switch($type) {
				case CursorType.DEFAULT_CURSOR:
					lookAndFeel.drawDefaultCursor();
					break;
				//case BUSY_CURSOR: lookAndFeel.drawBusyCursor(); break;
				case CursorType.SW_RESIZE_CURSOR:
					lookAndFeel.drawSWResizeCursor();
					break;
				case CursorType.SE_RESIZE_CURSOR:
					lookAndFeel.drawSEResizeCursor();
					break;
				case CursorType.NW_RESIZE_CURSOR:
					lookAndFeel.drawNWResizeCursor();
					break;
				case CursorType.NE_RESIZE_CURSOR:
					lookAndFeel.drawNEResizeCursor();
					break;
				case CursorType.N_RESIZE_CURSOR:
					lookAndFeel.drawNResizeCursor();
					break;
				case CursorType.S_RESIZE_CURSOR:
					lookAndFeel.drawSResizeCursor();
					break;
				case CursorType.W_RESIZE_CURSOR:
					lookAndFeel.drawWResizeCursor();
					break;
				case CursorType.E_RESIZE_CURSOR:
					lookAndFeel.drawEResizeCursor();
					break;
				case CursorType.H_DIVIDER_CURSOR:
					lookAndFeel.drawHDividerCursor();
					break;
			}
			setPosition();
			setEffects();
			DepthManager.setOverAll(this);
		}
		
		/**
		 * 	@private
		 */
		spas_internal function mouseMoveHandler():void {
			setPosition();
        }
		
		/**
		 * 	@private
		 */
		spas_internal function mouseEnterHandler():void {
			if(!spas_internal::uioSprite.visible) spas_internal::uioSprite.visible = true;
			setPosition();
        }
		
		/**
		 * 	@private
		 */
		spas_internal function mouseLeaveHandler():void {
			spas_internal::uioSprite.visible = false;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _xOffset:Number;
		private var _yOffset:Number;
		private static var _instanciable:Boolean = true;
		private static var _constructorAccess:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if(!_instanciable || _constructorAccess) throw new SingletonException(this.toString());
			$type = CursorType.DEFAULT_CURSOR;
			initLaf(CursorUIRef);
			_instanciable = false;
			_constructorAccess = true;
			$parent = $stage;
			_xOffset = _yOffset = 0;
			spas_internal::uioSprite.visible = false;
			createContainer();
			spas_internal::uioSprite.name = "Cursor";
		}
		
		private function setPosition():void {
			spas_internal::uioSprite.x = $parent.mouseX + _xOffset;
			spas_internal::uioSprite.y = $parent.mouseY + _yOffset;
		}
		
		private function createContainer():void {
			$parent.addChild(spas_internal::uioSprite);
			spas_internal::uioSprite.cacheAsBitmap = true;
			spas_internal::lafDTO.setOffsetX =
				function(value:Number):void {
					_xOffset = value;
				}
			spas_internal::lafDTO.setOffsetY =
				function(value:Number):void {
					_yOffset = value;
				}
			/*var cusorArea:Sprite = new Sprite;
			var ca:Figure = Figure.setFigure(cusorArea);
			ca.beginFill(0, 0);
			ca.drawRectangle(0, 0, 10, 10);
			ca.endFill();
			spas_internal::CONTAINER.addChild(cusorArea);*/
		}
	}
}