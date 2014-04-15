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
	// ButtonSkin.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 28/12/2008 13:39
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.utils.describeType;
	import org.flashapi.swing.BitmapClip;
	import org.flashapi.swing.button.core.ABM;
	import org.flashapi.swing.constants.WebFonts;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.text.FontFormat;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>ButtonSkin</code> class defines the skin class for <code>Button</code>
	 * 	objects.
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ButtonSkin extends Skin implements Skinable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ButtonSkin</code> object with the
		 * 	specified name.
		 * 
		 * 	@param name	The instance name for this <code>ButtonSkin</code> object.
		 */
		public function ButtonSkin(name:String = "") {
			super(name);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The grey tint color applied to the button text when the <code>Button.greyTint</code>
		 * 	property is <code>true</code>.
		 * 
		 * 	@default 0xACA899
		 */
		public var grayTintColor:uint = 0xACA899;
		
		/**
		 * 	The gap between the icon and the text displayed on the button face.
		 * 			
		 * 	@default 2
		 */
		public var iconDelay:Number = 2;
		
		/**
		 * 	The button top offset distance.
		 * 
		 * 	@default 2
		 */
		public var topOffset:Number = 2;
		
		/**
		 * 	The button left offset distance.
		 * 
		 * 	@default 2
		 */
		public var leftOffset:Number = 2;
		
		/**
		 * 	The button right offset distance.
		 * 
		 * 	@default 2
		 */
		public var rightOffset:Number = 2;
		
		/**
		 * 	The button bottom offset distance.
		 * 
		 * 	@default 2
		 */
		public var bottomOffset:Number = 2 ;
		
		/**
		 * 	The color transformation to apply to the button icon when the 
		 * 	<code>UIObject.active</code> property is set to <code>false</code>.
		 * 	Default value is a <code>ColorTransform</code> object with the following
		 * 	properties:
		 * 	<ul>
		 * 		<li><code>redMultiplier = .2</code></li>
		 * 		<li><code>greenMultiplier = .2</code></li>
		 * 		<li><code>blueMultiplier = .2</code></li>
		 * 		<li><code>alphaMultiplier = .2</code></li>
		 * 	</ul>
		 */
		public var inactiveIconColor:ColorTransform;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _overSkin:BitmapData = null;
		private var _overSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the button face when
		 * 	the mouse is over it.
		 */
		public function get overSkin():* {
			return _overSkinData;
		}
		public function set overSkin(value:*):void {
			_overSkinData = value;
			setSkinObj(value, "_overSkin");
		}
		
		private var _downSkin:BitmapData = null;
		private var _downSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the button face when
		 * 	the mouse is over it and the mouse button is pressed.
		 */
		public function get downSkin():* {
			return _downSkinData;
		}
		public function set downSkin(value:*):void {
			_downSkinData = value;
			setSkinObj(value, "_downSkin");
		}
		
		private var _upSkin:BitmapData = null;
		private var _upSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the button face when
		 * 	the mouse is not over it.
		 */
		public function get upSkin():* {
			return _upSkinData;
		}
		public function set upSkin(value:*):void {
			_upSkinData = value;
			setSkinObj(value, "_upSkin");
		}
		
		private var _selectedSkin:BitmapData = null;
		private var _selectedSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the button face when
		 * 	the <code>Button.selected</code> property is set to <code>true</code>.
		 */
		public function get selectedSkin():* {
			return _selectedSkinData;
		}
		public function set selectedSkin(value:*):void {
			_selectedSkinData = value;
			setSkinObj(value, "_selectedSkin");
		}
		
		private var _inactiveSkin:BitmapData = null;
		private var _inactiveSkinData:*;
		/**
		 * 	Sets or gets the bitmap used by the skin to render the button face when
		 * 	the <code>UIObject.active</code> property is set to <code>false</code>.
		 */
		public function get inactiveSkin():* {
			return _inactiveSkinData;
		}
		public function set inactiveSkin(value:*):void {
			_inactiveSkinData = value;
			setSkinObj(value, "_inactiveSkin");
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get scale9Grid():Rectangle {
			return _btnBmc.scale9Grid;
		}
		public function set scale9Grid(value:Rectangle):void  {
			_btnBmc.scale9Grid = value;
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
			var b:ButtonSkin = new ButtonSkin();
			var descp:XML = describeType(this);
			assignProp(b, descp..variable);
			assignProp(b, descp..accessor);
			return b as Skinable;
		}
		
		//--------------------------------------------------------------------------
		//
		//  ButtonUI API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	This method is used by the skin to render the button face when the mouse
		 * 	is not over it.
		 */
		public function drawOutState():void {
			getSkinBitmap(_upSkin);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	This method is used by the skin to render the button face when the mouse
		 * 	is over it.
		 */
		public function drawOverState():void {
			getSkinBitmap(_overSkin);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	This method is used by the skin to render the button button face
		 * 	when the <code>Button.selected</code> property is set to <code>true</code>.
		 */
		public function drawSelectedState():void {
			getSkinBitmap(_selectedSkin);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	This method is used by the skin to render the button face when the
		 * 	mouse is over it and the mouse left button is clicked.
		 */
		public function drawPressedState():void {
			getSkinBitmap(_downSkin);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	This method is used by the skin to render the button face when the
		 * 	<code>UIObject.active</code> property is set to <code>false</code>.
		 */
		public function drawInactiveState():void {
			getSkinBitmap(_inactiveSkin);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a reference to the <code>FontFormat</code> used by the skin
		 * 	when the mouse is not over the button.
		 * 
		 * 	@return	The "up" state <code>FontFormat</code> used by the skin.
		 */
		public function getUpFontFormat():FontFormat {
			return _upFontFormat;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a reference to the <code>FontFormat</code> used by the skin
		 * 	when the mouse is over the button.
		 * 
		 * 	@return	The "over" state <code>FontFormat</code> used by the skin.
		 */
		public function getOverFontFormat():FontFormat {
			return _upFontFormat;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a reference to the <code>FontFormat</code> used by the skin
		 * 	when the mouse is over the button and the mouse left button is clicked.
		 * 
		 * 	@return	The "down" state <code>FontFormat</code> used by the skin.
		 */
		public function getDownFontFormat():FontFormat {
			return _upFontFormat;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a reference to the <code>FontFormat</code> used by the skin
		 * 	when the button <code>selected</code> property is set to <code>true</code>.
		 * 
		 * 	@return	The "selected" state <code>FontFormat</code> used by the skin.
		 */
		public function getSelectedFontFormat():FontFormat {
			return _upFontFormat;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a reference to the <code>FontFormat</code> used by the skin
		 * 	when the the button is disabled.
		 * 
		 * 	@return	The "disabled" state <code>FontFormat</code> used by the skin.
		 */
		public function getDisabledFontFormat():FontFormat {
			return _upFontFormat;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns an integer that represents the grey tint color applied to 
		 * 	the button text when the <code>Button.greyTint</code> property
		 * 	is set to <code>true</code>.
		 * 	
		 * 	@return  The value for the button grey tint color.
		 */
		public function getGrayTintColor():uint {
			return this.grayTintColor;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Returns a number that represents the gap between the icon and the
		 * 	text displayed on the button face.
		 * 
		 *	@return The gap between the icon and the text displayed on the
		 * 			button face.
		 */
		public function getIconDelay():Number {
			return this.iconDelay;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *	Returns the button top offset distance.<br />
		 *  The top offset distance defines the distance between the top edge of the
		 * 	button and the group composed by the text and the icon.
		 * 
		 *	@return The button top offset distance.
		 */
		public function getTopOffset():Number {
			return this.topOffset;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *	Returns the button left offset distance.<br />
		 *  The left offset distance defines the distance between the left edge of the
		 * 	button and the group composed by the text and the icon.
		 * 
		 *	@return The button left offset distance.
		 */
		public function getLeftOffset():Number {
			return this.leftOffset;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *	Returns the button right offset distance.<br />
		 *  The right offset distance defines the distance between the right edge of the
		 * 	button and the group composed by the text and the icon.
		 * 
		 *	@return The button right offset distance.
		 */
		public function getRightOffset():Number {
			return this.rightOffset;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 *	Returns the button bottom offset distance.<br />
		 *  The bottom offset distance defines the distance between the bottom edge of the
		 * 	button and the group composed by the text and the icon.
		 * 
		 *	@return The button bottom offset distance.
		 */
		public function getBottomOffset():Number {
			return this.bottomOffset;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	This method is used by the skin to draw the button face when the
		 *  <code>UIObject.active</code> property is set to <code>false</code>.
		 */
		public function drawInactiveIcon():void {
			drawiconColor(this.inactiveIconColor);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	This method is used by the skin to draw the button face when the
		 * 	<code>UIObject.active</code> property is set to <code>true</code>.
		 */
		public function drawActiveIcon():void {
			drawiconColor(_nullColorTransform);
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	This method is used by the skin to draw the button face when the
		 *  <code>Button.dotted</code> property is set to <code>true</code>.
		 */
		public function drawDottedLine():void {
			/*var dashedLine:DashedLine = new DashedLine(target, 1, 2);
			dashedLine.lineStyle(0, 0x777777, 1, true);
			dashedLine.drawRectangle(new Point(2, 2), new Point(uio.width-2, uio.height-2));
			dashedLine.endFill();*/
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal function getBitmapClip():BitmapClip {
			return _btnBmc;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _btnBmc:BitmapClip;
		private var _nullColorTransform:ColorTransform ;
		private var _upFontFormat:FontFormat;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			this.inactiveIconColor = new ColorTransform(.2, .2, .2, .2);
			_upFontFormat = new FontFormat(WebFonts.VERDANA, 12, 0x0B333C, true);
			_btnBmc = new BitmapClip();
			_nullColorTransform = new ColorTransform(1, 1, 1, 1);
		}
		
		private function getSkinBitmap(bmp:BitmapData):void {
			if (bmp != null) {
				_btnBmc.bitmapData = bmp;
				_btnBmc.resize(uio.width, uio.height);
			}
		}
		
		private function setSkinObj(value:*, target:String):void {
			if(value!=null) {
				if (value is BitmapData) {
					this[target] = value.clone();
					$bmpColl.add(this[target]);
				}
				/*else {
					var loader:Loader = new Loader();
					loader.load(value);
					eventCollector.addOneShotEvent(loader, Event.COMPLETE, completeEvent);
				}*/
			}
			/*function completeEvent(e:Event):void {
				var c:DisplayObject = e.target.content;
				var bmp:BitmapData = new BitmapData(c.width, c.height, false, 0);
				bmp.draw(c);
				this[target] = bmp.clone();
				bmpCollector.add(this[target]);
				bmp.dispose();
			}*/
		}
		
		private function drawiconColor(ct:ColorTransform):void {
			var it:Transform = (uio as ABM).icon.transform;
            it.colorTransform = ct;
		}
	}
}