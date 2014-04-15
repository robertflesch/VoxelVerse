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

package org.flashapi.swing.list {
	
	// -----------------------------------------------------------
	// DropButtonListBase.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/02/2010 14:41
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.MouseEvent;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.button.core.ABM;
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.constants.DropButtonPosition;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.Icon;
	import org.flashapi.swing.IconizedButton;
	import org.flashapi.swing.icons.core.StateIcon;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the user clicks on the firts button of the 
	 * 	<code>DropButtonListBase</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.ListEvent.UIMouseEvent.CLICK
	 */
	[Event(name = "click", type = "org.flashapi.swing.event.UIMouseEvent")]
	
	/**
	 * 	The <code>DropButtonListBase</code> class is the base class for drop-down list
	 * 	objects composed of by button controls. The first button control allows the 
	 * 	user to start a specific action according to the current selected value.
	 * 	The second button control is used to activate, or deactivate, the drop-down
	 * 	list.
	 * 
	 * 	<p>When a <code>DropButtonListBase</code> object is inactive, it only displays 
	 * 	both button controls. When activated, it displays (drops down) a list
	 * 	of values, from which the user may select one. When the user selects a new
	 * 	value, the <code>DropButtonListBase</code> object reverts to its inactive
	 * 	state.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DropButtonListBase extends DropListBase {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>DropButtonListBase</code> instance.
		 * 
		 * 	@param	label	The text displayed on the face of the first button control.
		 * 	@param	width	The width of the <code>DropButtonListBase</code> instance.
		 * 	@param	size	The number of items displayed within drop-down list object.
		 * 	@param	checkModeRef	A string that represents the reference passed as
		 * 	the <code>caller</code> parameter to the <code>checkStrictMode()</code>
		 * 	method of the associated <code>XMLQuery</code> object.
		 */
		public function DropButtonListBase(label:String, width:Number, size:uint, checkModeRef:String) {
			super(label, width, size, checkModeRef);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function get color():* {
			return $button.color;
		}
		override public function set color(value:*):void {
			$button.color = $iconBtn.color = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {
			$button.height = $iconBtn.height = super.height = value;
		}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void {
			IUIObject($itemsList).width = super.width = value;
		}
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the first button 
		 * 	crontrol is selected(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get selected():Boolean {
			return $button.selected; }
		public function set selected(value:Boolean):void {
			$button.selected = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Radius Corner API
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private
		 */
		override public function set topLeftCorner(value:Number):void {
			$tlc = value;
			fixBtnCorners();
		}
		
		/**
		 *	@private
		 */
		override public function set topRightCorner(value:Number):void {
			$trc = value;
			fixBtnCorners();
		}
		
		/**
		 *	@private
		 */
		override public function set bottomLeftCorner(value:Number):void {
			$blc = value;
			fixBtnCorners();
		}
		
		/**
		 *	@private
		 */
		override public function set bottomRightCorner(value:Number):void {
			$brc = value;
			fixBtnCorners();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The reference to the button that controls the the drop-down list object.
		 */
		protected var $iconBtn:IconizedButton;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The reference to the button that displays the selected text of this
		 * 	<code>DropButtonListBase</code> instance.
		 */
		protected var $button:ABM;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function setIconColors(defineStateIcon:Boolean):void {
			var icon:Icon = $iconBtn.icon;
			if (icon.brush is StateIcon) {
				if(defineStateIcon) $stateIcon = icon.brush as StateIcon;
				(icon.brush as StateBrush).colors = $iconColors;
			} else {
				if(defineStateIcon) $stateIcon = null;
				icon.brush.color = $iconColors.up;
			}
			setIconState();
		}
		
		/**
		 * @private
		 */
		protected function fixWidth():void {
			var W:Number = $iconBtn.x + $iconBtn.width;
			$button.x = $buttonPosition == DropButtonPosition.RIGHT ? 0 : W;
			$button.width = $buttonPosition == DropButtonPosition.RIGHT ? $iconBtn.x : $width-W;
		}
		
		/**
		 * @private
		 */
		protected function fixButtonPosition():void {
			$iconBtn.x = $buttonPosition == DropButtonPosition.RIGHT ? $width - $height : 0;
		}
		
		/**
		 * @private
		 */
		protected function fixBtnCorners():void {
			if ($buttonPosition == DropButtonPosition.RIGHT) {
				$iconBtn.setCornerRadiuses(
					0, isNaN($trc) ? lookAndFeel.getButtonTopRadius() : $trc,
					isNaN($brc) ? lookAndFeel.getButtonBottomRadius() : $brc, 0
					);
				$button.setCornerRadiuses(
					isNaN($tlc) ? lookAndFeel.getButtonTopRadius() : $tlc, 0,
					0, isNaN($blc) ? lookAndFeel.getButtonBottomRadius() : $blc
					);
			} else {
				$iconBtn.setCornerRadiuses(
					isNaN($tlc) ? lookAndFeel.getButtonTopRadius() : $tlc, 0,
					0, isNaN($blc) ? lookAndFeel.getButtonBottomRadius() : $blc
					);
				$button.setCornerRadiuses(
					0, isNaN($trc) ? lookAndFeel.getButtonTopRadius() : $trc,
					isNaN($brc) ? lookAndFeel.getButtonBottomRadius() : $brc, 0
					);
			}
		}
		
		/**
		 * @private
		 */
		protected function createEvents():void {
			$evtColl.addEvent($iconBtn, UIMouseEvent.ROLL_OVER, rollOverHandler);
			$evtColl.addEvent($iconBtn, UIMouseEvent.ROLL_OUT, rollOutHandler);
			$evtColl.addEvent($iconBtn, UIMouseEvent.PRESS, dropListMouseDownHandler);
			$evtColl.addEvent($iconBtn, UIMouseEvent.RELEASE, mouseUpHandler);
			$evtColl.addEvent($button, UIMouseEvent.CLICK, clickHandler);
		}
		
		/**
		 * @private
		 */
		protected function clickHandler(e:UIMouseEvent):void {
			dispatchButtonEvent(UIMouseEvent.CLICK);
		}
		
		/**
		 * @private
		 */
		protected function rollOverHandler(e:UIMouseEvent):void {
			$button.state = ButtonState.OVER;
		}
		
		/**
		 * @private
		 */
		protected function rollOutHandler(e:UIMouseEvent):void {
			$button.state = ButtonState.UP;
		}
		
		/**
		 * @private
		 */
		protected function mouseUpHandler(e:UIMouseEvent):void {
			if ($active && $enabled) {
				if (!$isListHidden)
					$evtColl.addEvent($stage, MouseEvent.MOUSE_DOWN, dropListMouseOutsideHandler);
				$stateIcon = $iconBtn.icon.brush is StateIcon ?
					($iconBtn.icon.brush as StateIcon) : null;
				setIconState();
			}
		}
		
		/**
		 * @private
		 */
		protected function dropListMouseDownHandler(e:MouseEvent):void { 
			if ($active && $enabled) $itemsList.displayed ? hideList() : showList();
		}
	}
}