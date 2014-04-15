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

package org.flashapi.swing.scroll {
	
	// -----------------------------------------------------------
	// AbstractThumb.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/11/2010 16:01
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.ButtonState;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.managers.TextureManager;
	import org.flashapi.swing.skin.Skinable;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>AbstractThumb</code> class is the base class for all thumb buttons
	 * 	used by <code>Scrollable</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractThumb extends UIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>AbstractThumb</code> instance.
		 */
		public function AbstractThumb() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The default value in, pixels, of the <code>width</code> property.
		 */
		public static const DEFAULT_WIDTH:Number = 22;
		
		/**
		 * 	The default value, in pixels, of the <code>height</code> property.
		 */
		public static const DEFAULT_HEIGHT:Number = 22;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>greyTint</code> property.
		 * 
		 * 	@see #greyTint
		 */
		protected var $greyTint:Boolean = false;
		/**
		 *  A <code>Boolean</code> value that indicates whether the thumb button
		 * 	is rendered with a grey tinted color (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get greyTint():Boolean {
			return $greyTint;
		}
		public function set greyTint(value:Boolean):void {
			$greyTint = value;
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void {
			$autoHeight = isNaN(value);
			setAutoSize();
			spas_internal::lafDTO.height = $height = value;
			drawInitialState();
			dispatchMetricsEvent();
		}
		
		/**
		 * 	Sets or gets the current state of the thumb button.
		 * 	<p>Valid values are defined by the <code>ButtonState</code> class constants:
		 * 	<ul>
		 * 		<li><code>ButtonState.UP</code>,</li>
		 * 		<li><code>ButtonState.OVER</code>,</li>
		 * 		<li><code>ButtonState.DOWN</code>,</li>
		 * 		<li><code>ButtonState.SELECTED</code>,</li>
		 * 		<li><code>ButtonState.DISABLED</code>.</li>
		 * 	</ul>
		 * 	</p>
		 * 
		 * 	@default ButtonState.UP
		 */
		public function get state():String {
			return spas_internal::lafDTO.state;
		}
		public function set state(value:String):void {
			spas_internal::lafDTO.state = value;
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void { 
			$autoWidth = isNaN(value);
			setAutoSize();
			spas_internal::lafDTO.width = $width = value;
			drawInitialState();
			dispatchMetricsEvent();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//override protected function setSpecificLafChanges():void {}
		
		/**
		 * @private
		 */
		override public function set skin(value:Skinable):void {
			if ($hasSkin) spas_internal::background.removeChildAt(0);
			super.skin = value;
			if($skinObject) {
				spas_internal::background.graphics.clear();
				spas_internal::background.addChildAt($skinObject.getBitmapClip(), 0);
			}
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected porperties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the thumb button
		 * 	uses the default height an width values to be displayed (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@see #DEFAULT_HEIGHT
		 * 	@see #DEFAULT_WIDTH
		 */
		protected var $useDefaultSizes:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function init(width:Number, height:Number):void {
			createBackground();
			$textureManager = new TextureManager(spas_internal::background);
			$borderWidth = 1;
			spas_internal::lafDTO.target = spas_internal::background;
			$width = width; $height = height;
			$autoWidth = isNaN($width);
			$autoHeight = isNaN($height);
			setAutoSize();
			if($autoSize) {
				$width = DEFAULT_WIDTH;
				$height = DEFAULT_HEIGHT;
				$useDefaultSizes = true;
			}
			spas_internal::lafDTO.spas_internal::setSize($width, $height);
			createColorsObj();
			createBorderColorsObj();
			spas_internal::lafDTO.state = ButtonState.UP;
		}
		
		/**
		 * @private
		 */
		protected function drawInitialState():void {
			var skinObj:Object = getSkinObj();
			switch (spas_internal::lafDTO.state) {
				case ButtonState.DOWN:
					skinObj.drawPressedState();
					break;
				case ButtonState.OVER:
					skinObj.drawOverState();
					break;
				case ButtonState.UP:
					skinObj.drawOutState();
					break;
				case ButtonState.SELECTED:
					skinObj.drawSelectedState();
					break;
				case ButtonState.DISABLED:
					skinObj.drawInactiveState();
					break;
			}
			//doReflection();
			dispatchChangeEvent();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			drawInitialState();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function setAutoSize():void {
			$autoSize = ($autoWidth && $autoHeight);
		}
	}
}