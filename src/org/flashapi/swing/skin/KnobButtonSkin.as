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
	// KnobButtonSkin.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/04/2010 11:21
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.utils.describeType;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.plaf.spas.SpasUI;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>KnobButtonSkin</code> class defines the skin class for <code>KnobButton</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.KnobButton
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class KnobButtonSkin extends Skin implements Skinable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>KnobButtonSkin</code> object with the
		 * 	specified name.
		 * 
		 * 	@param name	The instance name for this <code>KnobButtonSkin</code> object.
		 */
		public function KnobButtonSkin(name:String = "") {
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
		 * 	Sets or get the bitmap used by the skin to render the track of the 
		 * 	<code>KnobButton</code> instance.
		 */
		public function get track():* {
			return _bgSkinData;
		}
		public function set track(value:*):void {
			_bgSkinData = value;
			setSkinObj(value, "_bgSkin");
		}
		
		private var _btnSkin:BitmapData = null;
		private var _btnSkinData:*;
		/**
		 * 	Sets or get the bitmap used by the skin to render the face of the 
		 * 	<code>KnobButton</code> instance.
		 */
		public function get button():* {
			return _btnSkinData;
		}
		public function set button(value:*):void {
			_btnSkinData = value;
			setSkinObj(value, "_btnSkin");
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scale9Grid():Rectangle {
			return null;
		}
		public function set scale9Grid(value:Rectangle):void  { }
		
		/**
		 * @private
		 */
		override public function set smoothing(value:Boolean):void {
			super.smoothing = value;
			updateSmoothing();
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
			var ps:KnobButtonSkin = new KnobButtonSkin();
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
		 * 	@return	The default color of the skin.
		 */
		public function getColor():uint {
			return SpasUI.DEFAULT_COLOR;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Render the track of the <code>KnobButton</code> instance.
		 */
		public function drawTrack():void {
			if (_bgSkin != null) _trackBmc.bitmapData = _bgSkin;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Render the face of the <code>KnobButton</code> instance.
		 */
		public function drawButton():void {
			if (_buttonBmc != null) _buttonBmc.bitmapData = _btnSkin;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function getTrackBitmap():Bitmap {
			return _trackBmc;
		}
		
		/**
		 * @private
		 */
		spas_internal function getButtonBitmap():Bitmap {
			return _buttonBmc;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _trackBmc:Bitmap;
		private var _buttonBmc:Bitmap;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_trackBmc = new Bitmap();
			_buttonBmc = new Bitmap();
			updateSmoothing();
		}
		
		private function setSkinObj(value:*, target:String):void {
			if(value!=null) {
				var bmp:BitmapData;
				if (value is BitmapData) {
					this[target] = value.clone();
					$bmpColl.add(this[target]);
				} else if (value is DisplayObject) {
					bmp = new BitmapData(value.width, value.height, true, 0);
					bmp.draw(value);
					this[target] = bmp.clone();
					$bmpColl.add(this[target]);
					bmp.dispose(); bmp = null;
				} /*else {
					var loader:Loader = new Loader();
					loader.load(value);
					eventCollector.addOneShotEvent(loader, Event.COMPLETE, completeEvent);
				}*/
			}
			/*function completeEvent(e:Event):void {
				var c:DisplayObject = e.target.content;
				bmp = new BitmapData(c.width, c.height, false, 0);
				bmp.draw(c);
				this[target] = bmp.clone();
				bmpCollector.add(this[target]);
				bmp.dispose(); bmp = null;
			}*/
		}
		
		private function updateSmoothing():void {
			_trackBmc.smoothing = _buttonBmc.smoothing = $smoothing;
		}
	}
}