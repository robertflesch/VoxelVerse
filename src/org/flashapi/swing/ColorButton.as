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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// ColorButton.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 14/03/2010 20:48
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.flashapi.swing.color.ColorPicker;
	import org.flashapi.swing.color.ColorPickerCreator;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.effect.ScaleIn;
	import org.flashapi.swing.event.ColorPickerEvent;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.geom.Geometry;
	import org.flashapi.swing.plaf.libs.ColorButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("ColorButton.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the value of the color selected with the <code>ColorButton</code> 
	 * 	instance changes due to user action.
	 *
	 *  @eventType org.flashapi.swing.event.ColorPickerEvent.COLOR_CHANGED
	 */
	[Event(name = "colorChanged", type = "org.flashapi.swing.event.ColorPickerEvent")]
	
	/**
	 * 	<img src="ColorButton.png" alt="ColorButton" width="18" height="18"/>
	 * 
	 * 	The <code>ColorButton</code> class provides a way for a user to choose a
	 * 	color from the specified <code>ColorPicker</code> object. It shows a
	 *  single swatch in a square button. When the user clicks the swatch button,
	 * 	the <code>ColorPicker</code> instance appears and displays the entire
	 * 	swatch color list.
	 * 
	 * 	<p>You can use any <code>ColorPicker</code> instances that you want to
	 * 	display swatch color list. Developers can create their own <code>ColorPicker</code>
	 * 	objects and use them with any <code>ColorButton</code> instance.</p>
	 * 
	 *  @includeExample ColorButtonExample.as
	 * 
	 * 	@see org.flashapi.swing.color.ColorPicker
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ColorButton extends UIObject implements ColorPickerCreator, Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ColorButton</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	colorPicker A <code>ColorPicker</code> instance used to display
		 * 						a swatch color list when the user clicks on this
		 * 						<code>ColorButton</code> instance.
		 * 	@param	width	The width of the <code>ColorButton</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>ColorButton</code> instance, in
		 * 					pixels.
		 */
		public function ColorButton(colorPicker:ColorPicker = null, width:Number = 22, height:Number = 22) {
			super();
			initObj(colorPicker, width, height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _colorPicker:ColorPicker;
		/**
		 * 	@inheritDoc
		 */
		public function get colorPicker():ColorPicker {
			return _colorPicker;
		}
		public function set colorPicker(value:ColorPicker):void {
			setColorPicker(value);
		}
		
		private var _colorPickerDelay:Number = 5;
		/**
		 * 	Sets or gets the time delay, in milliseconds, between the moment the user  
		 * 	clicks on the color button and the color picker object is displayed.
		 * 
		 * 	@default 5
		 */
		public function get colorPickerDelay():Number {
			return _colorPickerDelay;
		}
		public function set colorPickerDelay(value:Number):void {
			_colorPickerDelay = value;
		}
		
		private var _selectedColor:uint = 0x000000;
		/**
		 * 	@inheritDoc
		 */
		public function get selectedColor():uint {
			return _selectedColor;
		}
		public function set selectedColor(value:uint):void {
			setColor(value);
			setDefaultColor();
			lookAndFeel.drawOutState();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if (!$displayed) {
				createUIObject(x, y);
				createEvents();
				doStartEffect();
			}
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			//if (_colorPicker != null) _colorPicker.finalize();
			if (_colorPicker != null) _colorPicker = null;
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function remove():void {
			if ($displayed) {
				unload();
				$evtColl.removeAllEvents();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			lookAndFeel.drawOutState();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function initObj(colorPicker:ColorPicker, width:Number, height:Number):void {
			initSize(width, height);
			initMinSize(5, 5);
			createColorsObj();
			spas_internal::lafDTO.selectedColor = _selectedColor;
			/**
			 * _iconColors = new ColorState(this);
			 */
			initLaf(ColorButtonUIRef);
			spas_internal::uioSprite.buttonMode = true;
			setColorPicker(colorPicker);
			spas_internal::setSelector(Selectors.COLOR_BUTTON);
			spas_internal::isInitialized(1);
		}
		
		private function createEvents():void {
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OVER, mouseOverHandler);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OUT, mouseOutHandler);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_DOWN, mouseDownHandler);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			lookAndFeel.drawOverState();
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			lookAndFeel.drawOutState();
		}
		
		private function mouseDownHandler(e:MouseEvent):void {
			lookAndFeel.drawPressedState();
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			lookAndFeel.drawOverState();
			if (_colorPicker != null) {
				if ((_colorPicker as IUIObject).displayed) {
					_colorPicker.remove();
					_colorPicker.creator = null;
				}
				else {
					var pt:Point = spas_internal::uioSprite.localToGlobal(Geometry.ORIGIN);
					setDefaultColor();
					_colorPicker.creator = this;
					$evtColl.addEvent(_colorPicker, UIOEvent.DISPLAYED, fixCursorDepth);
					$evtColl.addEvent(_colorPicker, UIOEvent.REMOVED, fixColorPickerCreator);
					//TODO: check for stage size
					_colorPicker.display(Math.ceil(pt.x), Math.ceil(pt.y + height + _colorPickerDelay));
				}
			}
		}
		
		private function fixColorPickerCreator(e:UIOEvent):void {
			_colorPicker.creator = null;
		}
		
		private function fixCursorDepth(e:UIOEvent):void {
			e.target.setToTopLevel();
			$evtColl.removeEvent(_colorPicker, UIOEvent.DISPLAYED, fixCursorDepth);
		}
		
		private function setColorPicker(cp:ColorPicker):void {
			if (_colorPicker != null) {
				uio.eventCollector.removeEvent(_colorPicker, ColorPickerEvent.COLOR_CHANGED, colorPickerChanged);
				_colorPicker.finalize();
			}
			_colorPicker = cp;
			if(cp != null) {
				var uio:IUIObject = _colorPicker as IUIObject;
				uio.shadow = uio.hasDisplayEffect = true;
				uio.displayEffectRef = ScaleIn;
				uio.target = $stage;
				uio.eventCollector.addEvent(_colorPicker, ColorPickerEvent.COLOR_CHANGED, colorPickerChanged);
			}
		}
		
		private function colorPickerChanged(e:ColorPickerEvent):void {
			if (_colorPicker.creator != this) return;
			setColor(e.color);
			lookAndFeel.drawOutState();
			_colorPicker.remove();
			this.dispatchEvent(new ColorPickerEvent(ColorPickerEvent.COLOR_CHANGED, _selectedColor));
		}
		
		private function setDefaultColor():void {
			if (_colorPicker != null) {
				var uio:IUIObject = _colorPicker as IUIObject;
				uio.color = _selectedColor;
			}
		}
		
		private function setColor(c:uint):void {
			spas_internal::lafDTO.selectedColor = _selectedColor = c;
		}
	}
}