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
	// ReactivePanel.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 10/04/2010 19:36
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.state.OpacityState;
	
	use namespace spas_internal;
	
	[IconFile("ReactivePanel.png")]
	
	/**
	 * 	<img src="ReactivePanel.png" alt="ReactivePanel" width="18" height="18"/>
	 * 
	 * 	A <code>ReactivePanel</code> object consists of a content area which interacts
	 * 	with mouse actions, such like buttons do.
	 * 
	 * 	<p><strong>Note that <code>ReactivePanel</code> objects do not interact with
	 * 	<code>UIMouseEvent.DOUBLE_CLICK</code> or <code>MouseEvent.DOUBLE_CLICK</code>
	 * 	events.</strong></p>
	 * 
	 * 	<p><strong><code>ReactivePanel</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">highlight-opacity</code></td>
	 * 			<td>Sets the highlighted-state opacity for this object.</td>
	 * 			<td>Posible values are numbers from <code>0</code> (fully transparent)
	 * 			to <code>1</code> (fully opaque).</td>
	 * 			<td><code>highlightOpacity</code></td>
	 * 			<td><code>Properties.HIGHLIGHT_OPACITY</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@includeExample ReactivePanelExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ReactivePanel extends UIContainer implements Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ReactivePanel</code> instance with
		 * 					the specified properties.
		 * 
		 * 	@param	width	The width of the <code>ReactivePanel</code> instance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>ReactivePanel</code> instance, in
		 * 					pixels.
		 */
		public function ReactivePanel(width:Number = 100, height:Number = 100) {
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
		
		private var _backgroundColors:ColorState;
		/**
		 * 	A <code>ColorState</code> object that sets and gets the background color
		 * 	for each state of the <code>ReactivePanel</code> instance. <code>ColorState</code> 
		 * 	instances define five different states:
		 * 	<ul>
		 * 		<li><code>ColorState.disabled</code>,</li>
		 * 		<li><code>ColorState.down</code>,</li>
		 * 		<li><code>ColorState.over</code>,</li>
		 *  	<li><code>ColorState.up</code>,</li>
		 *  	<li><code>ColorState.selected</code>.</li>
		 * 	</ul>
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are
		 * 	the same as the values used for for the <code>color</code> property.
		 * 	The default value for each state is <code>StateObjectValue.NONE</code>.
		 * 	To unset a color state value, use the <code>StateObjectValue.NONE</code>
		 * 	constant.</p>
		 *  
		 *  @see org.flashapi.swing.core.UIObject#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		public function get backgroundColors():ColorState {
			return _backgroundColors;
		}
		public function set backgroundColors(value:ColorState):void {
			_backgroundColors = value;
			setRefresh();
		}
		
		private var _borderOpacity:OpacityState;
		/**
		 * 	An <code>OpacityState</code> object that sets and gets the border opacity
		 * 	for each state of the <code>ReactivePanel</code> instance. <code>OpacityState</code> 
		 * 	instances define five different states:
		 * <ul>
		 * 		<li><code>OpacityState.disabled</code>,</li>
		 * 		<li><code>OpacityState.down</code>,</li>
		 * 		<li><code>OpacityState.over</code>,</li>
		 *  	<li><code>OpacityState.up</code>,</li>
		 *  	<li><code>OpacityState.selected</code>.</li>
		 * 	</ul>
		 * 
		 * 	@see #highlightOpacity
		 * 	@see org.flashapi.swing.state.OpacityState
		 */
		public function get borderOpacity():OpacityState {
			return _borderOpacity;
		} 
		public function set borderOpacity(value:OpacityState):void {
			_borderOpacity = value;
			setRefresh();
		} 
		
		private var _opacity:OpacityState;
		/**
		 * 	An <code>OpacityState</code> object that sets and gets the background opacity
		 * 	for each state of the <code>ReactivePanel</code> instance. <code>OpacityState</code> 
		 * 	instances define five different states:
		 * <ul>
		 * 		<li><code>OpacityState.disabled</code>,</li>
		 * 		<li><code>OpacityState.down</code>,</li>
		 * 		<li><code>OpacityState.over</code>,</li>
		 *  	<li><code>OpacityState.up</code>,</li>
		 *  	<li><code>OpacityState.selected</code>.</li>
		 * 	</ul>
		 * 
		 * 	@see org.flashapi.swing.state.OpacityState
		 */
		public function get highlightOpacity():OpacityState {
			return _opacity;
		} 
		public function set highlightOpacity(value:OpacityState):void {
			_opacity = value;
			setRefresh();
		}
		
		private var _selected:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>ReactivePanel</code>
		 * 	instance is currently selected (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get selected():Boolean {
			return _selected;
		}
		public function set selected(value:Boolean):void {
			_selected = value;
			_state = value ? ButtonState.SELECTED : ButtonState.UP;
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
		override protected function refresh():void {
			drawPanel();
			drawMask();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _state:String = ButtonState.UP;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			$padL = $padT = $padR = $padB = 5;
			$horizontalGap = $verticalGap = 5;
			$width = width;
			$height = height;
			spas_internal::uioSprite.addChild($content);
			createStateObjects();
			addMask();
			addEvents();
			spas_internal::setSelector(Selectors.REACTIVE_PANEL);
			spas_internal::isInitialized(1);
		}
		
		private function addMask():void {
			$contentMask = new Shape();
			spas_internal::uioSprite.addChild($contentMask);
			$content.mask = $contentMask;
		}
		
		private function addEvents():void {
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OUT, setState);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_OVER, setState);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_DOWN, setState);
			$evtColl.addEvent(spas_internal::uioSprite, MouseEvent.MOUSE_UP, setState);
		}
		
		private function setState(e:MouseEvent):void {
			if(!_selected) {
				switch(e.type) {
					case MouseEvent.MOUSE_DOWN :
						_state = ButtonState.DOWN;
						break;
					case MouseEvent.MOUSE_UP :
						_state = ButtonState.OVER;
						break;
					case MouseEvent.MOUSE_OVER :
						_state = ButtonState.OVER;
						break;
					case MouseEvent.MOUSE_OUT :
						_state = ButtonState.UP;
						break;
				}
			}
			drawPanel();
		}
		
		private function drawMask():void {
			var f:Figure = Figure.setFigure($contentMask);
			f.clear();
			f.beginFill(0);
			f.drawRectangle($padL, $padT, $width-$padR, $height-$padB);
			f.endFill();
		}
		
		private function drawPanel():void {
			var c:uint;
			var a:Number;
			var ba:Number;
			switch(_state) {
				case ButtonState.UP:
					c = _backgroundColors.up;
					a = _opacity.up;
					ba = _borderOpacity.up;
				break;
				case ButtonState.OVER:
					c = _backgroundColors.over;
					a = _opacity.over;
					ba = _borderOpacity.over;
					break;
				case ButtonState.DOWN:
					c = _backgroundColors.down;
					a = _opacity.down;
					ba = _borderOpacity.down;
					break;
				case ButtonState.SELECTED:
					c = _backgroundColors.selected;
					a = _opacity.selected;
					ba = _borderOpacity.selected;
					break;
				case ButtonState.DISABLED:
					c = _backgroundColors.disabled;
					a = _opacity.disabled;
					ba = _borderOpacity.disabled;
					break;
			}
			var cd:Number = isNaN($cornerRadius) ? 4 : $cornerRadius;
			var f:Figure = Figure.setFigure(spas_internal::uioSprite);
			f.clear();
			f.beginFill(c, a);
			f.lineStyle(1, c, ba, true);
			f.drawRoundedRectangle(0, 0, $width, $height, cd, cd);
			f.endFill();
		}
		
		private function createStateObjects():void {
			_backgroundColors = new ColorState(this);
			_backgroundColors.up = _backgroundColors.over = _backgroundColors.disabled = 
			_backgroundColors.down = _backgroundColors.selected = 0xFFFFFF;
			//_borderColors = new ColorState(this);
			_opacity = new OpacityState(this);
			_borderOpacity = new OpacityState(this);
			_opacity.up = _borderOpacity.up = 0;
			_borderOpacity.over = _borderOpacity.down =
			_borderOpacity.selected = _borderOpacity.disabled = .8;
			_opacity.over = _opacity.down = _opacity.selected = _opacity.disabled = .4;
		}
	}
}