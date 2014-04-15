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
	// SpinButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version beta 1.1, 17/03/2010 22:08
	* @see http://www.flashapi.org/
	*/

	import flash.geom.Rectangle;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.SpinButtonEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.IconizedButton;
	import org.flashapi.swing.plaf.libs.SpinButtonUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("SpinButton.png")]
	
	//--------------------------------------
	//  Events
	//--------------------------------------

	/**
	 *  Dispatched when the the user clicks on the "up" arrow button of
	 * 	this <code>SpinButton</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.SpinButtonEvent
	 */
	[Event(name = "clickUp", type = "org.flashapi.swing.event.SpinButtonEvent")]
	
	/**
	 *  Dispatched when the the user clicks on the "down" arrow button of
	 * 	this <code>SpinButton</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.SpinButtonEvent
	 */
	[Event(name = "clickDown", type = "org.flashapi.swing.event.SpinButtonEvent")]
	
	/**
	 * 	<img src="SpinButton.png" alt="SpinButton" width="18" height="18"/>
	 * 
	 * 	A <code>SpinButton</code> object is composed of two buttons that display
	 * 	"up" and "down" arrows. You tipacally used <code>SpinButton</code> instances
	 * 	to create a custom spinner-like behavior for any kind of objects.
	 * 
	 * 	@see org.flashapi.swing.Spinner
	 * 	@see org.flashapi.swing.NumericStepper
	 * 
	 *  @includeExample SpinButtonExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SpinButton extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>SpinButton</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>SpinButton</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>SpinButton</code> instance, in
		 * 					pixels.
		 */
		public function SpinButton(width:Number = 20, height:Number = 20) {
			super();
			initObj(width, height);
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
		
		private var _downBtn:IconizedButton;
		/**
		 *  Returns a reference to the <code>IconizedButton</code> instance that
		 * 	displays the "down" arrow within this <code>SpinButton</code> instance.
		 * 
		 * 	@see #upButton
		 */
		public function get downButton():IconizedButton {
			return _downBtn;
		}
		
		private var _upBtn:IconizedButton;
		/**
		 *  Returns a reference to the <code>IconizedButton</code> instance that
		 * 	displays the "up" arrow within this <code>SpinButton</code> instance.
		 * 
		 * 	@see #downButton
		 */
		public function get upButton():IconizedButton {
			return _upBtn;
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			_upBtn.width = _downBtn.width = $width = value;
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void {
			$height = value;
			fixButtonsHeight();
			fixPositions();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function get color():* {
			return _upBtn.color;
		}
		override public function set color(value:*):void {
			_downBtn.color = _upBtn.color = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function finalize():void {
			_upBtn.finalize();
			_downBtn.finalize();
			_upBtn = null;
			_downBtn = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			_upBtn.lockLaf(lookAndFeel.getButtonLaf(), true);
			_downBtn.lockLaf(lookAndFeel.getButtonLaf(), true);
			setIcons();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			initSize(width, height);
			createObjects();
			initLaf(SpinButtonUIRef);
			spas_internal::setSelector(Selectors.SPIN_BUTTON);
			spas_internal::isInitialized(1);
		}
		
		private function fixPositions():void {
			var r:Rectangle = _upBtn.getBounds(null);
			_downBtn.y = r.height;
		}
		
		private function fixButtonsHeight():void {
			var h:Number = $height / 2;
			_upBtn.height = _downBtn.height = h;
			var buttonSizeCorrection:Number =
				_upBtn.spas_internal::uioSprite.getBounds(null).height - _upBtn.height;
			_upBtn.height = _downBtn.height = h - buttonSizeCorrection;
		}
		
		private function createObjects():void {
			_upBtn = new IconizedButton();
			_downBtn = new IconizedButton();
			_upBtn.width = _downBtn.width = $width;
			_upBtn.spas_internal::setSelector(Selectors.SPIN_BUTTON_CONTROL);
			_downBtn.spas_internal::setSelector(Selectors.SPIN_BUTTON_CONTROL);
			_upBtn.cornerRadius = _downBtn.cornerRadius = 0;
			_upBtn.target = _downBtn.target = spas_internal::uioSprite;
			$evtColl.addEvent(_upBtn, UIMouseEvent.CLICK, clickUp);
			$evtColl.addEvent(_downBtn, UIMouseEvent.CLICK, clickDown);
			_upBtn.display();
			_downBtn.display();
			fixButtonsHeight();
			fixPositions();
		}
		
		private function clickUp(e:UIMouseEvent):void {
			dispatchEvt(SpinButtonEvent.CLICK_UP);
		}
		
		private function clickDown(e:UIMouseEvent):void {
			dispatchEvt(SpinButtonEvent.CLICK_DOWN);
		}
		
		private function dispatchEvt(type:String):void {
			dispatchEvent(new SpinButtonEvent(type));
		}
		
		private function setIcons():void {
			_upBtn.drawIcon(lookAndFeel.getUpArrowBrush(), getIconBounds(_upBtn));
			_downBtn.drawIcon(lookAndFeel.getDownArrowBrush(), getIconBounds(_upBtn));
		}
		
		private function getIconBounds(btn:IconizedButton):Rectangle {
			var b:Rectangle = btn.getBounds(null);
			var to:Number = btn.lookAndFeel.getTopOffset();
			var lo:Number = btn.lookAndFeel.getLeftOffset();
			var rect:Rectangle =
				new Rectangle(	lo - btn.lookAndFeel.getIconDelay(),
								to,
								b.width - btn.lookAndFeel.getRightOffset() - lo,
								b.height - to - btn.lookAndFeel.getBottomOffset());
			return rect;
		}
	}
}