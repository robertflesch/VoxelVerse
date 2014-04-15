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

package org.flashapi.swing.skin {
	
	// -----------------------------------------------------------
	// PanelSkin.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 25/06/2009 10:09
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.utils.describeType;
	import org.flashapi.swing.BitmapClip;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.plaf.spas.SpasUI;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>PanelSkin</code> class defines the skin class for <code>Panel</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.Panel
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class PanelSkin extends Skin implements Skinable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>PanelSkin</code> object with the
		 * 	specified name.
		 * 
		 * 	@param name	The instance name for this <code>PanelSkin</code> object.
		 */
		public function PanelSkin(name:String = "") {
			super(name);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _bgSkin:BitmapData = null;
		private var _bgSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the <code>Panel</code>
		 * 	object.
		 */
		public function get skin():* {
			return _bgSkinData;
		}
		public function set skin(value:*):void {
			_bgSkinData = value;
			setSkinObj(value);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scale9Grid():Rectangle {
			return _panelBmc.scale9Grid;
		}
		public function set scale9Grid(value:Rectangle):void  {
			_panelBmc.scale9Grid = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function clone():Skinable {
			var ps:PanelSkin = new PanelSkin();
			var descp:XML = describeType(this);
			assignProp(ps, descp..variable);
			assignProp(ps, descp..accessor);
			return ps as Skinable;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns the default color of the skin.
		 * 
		 * 	@return	The default color of this skin.
		 */
		public function getColor():uint {
			return SpasUI.DEFAULT_BACKGROUND_COLOR;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Renders the background of the <code>Panel</code> instance.
		 */
		public function drawPanel():void {
			getSkinBitmap();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function getBitmapClip():BitmapClip {
			return _panelBmc;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _panelBmc:BitmapClip;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_panelBmc = new BitmapClip();
		}
		
		private function getSkinBitmap():void {
			if (_bgSkin != null) {
				_panelBmc.bitmapData = _bgSkin;
				_panelBmc.resize(uio.width, uio.height);
			}
		}
		
		private function setSkinObj(value:*):void {
			var bmp:BitmapData;
			if(value!=null) {
				if (value is BitmapData) {
					_bgSkin = value.clone();
					$bmpColl.add(_bgSkin);
				} else if (value is DisplayObject) {
					bmp = new BitmapData(value.width, value.height, true, 0);
					bmp.draw(value);
					_bgSkin = bmp.clone();
					$bmpColl.add(_bgSkin);
					bmp.dispose(); bmp = null;
				} /*else {
					var loader:Loader = new Loader();
					eventCollector.addEvent(loader, Event.COMPLETE, completeEvent);
					loader.load(new URLRequest(value));	
				}*/
			}
			/*function completeEvent(e:Event):void {
				eventCollector.removeEvent(loader, Event.COMPLETE, completeEvent);
				var c:DisplayObject = e.target.content;
				bmp = new BitmapData(c.width, c.height, false, 0);
				bmp.draw(c);
				_bgSkin = bmp.clone();
				bmpCollector.add(_bgSkin);
				bmp.dispose();
				bmp = null;
				loader = null;
				dispatchEvent(new SkinEvent(SkinEvent.SKIN_CHANGED));
			}*/
		}
	}
}