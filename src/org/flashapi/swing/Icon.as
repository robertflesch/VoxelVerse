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
	// Icon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 14/03/2010 18:45
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import org.flashapi.swing.brushes.Brush;
	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.event.LoaderEvent;
	import org.flashapi.swing.layout.AbsoluteLayout;
	import org.flashapi.swing.layout.Layout;
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.libs.IconUIRef;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Icon.png")]
	
	/**
	 * 	<img src="Icon.png" alt="Icon" width="18" height="18"/>
	 * 
	 *  The <code>Icon</code> class represents a common windows-like icon. <code>Icon</code>
	 * 	instances can render <code>Brush</code> or <code>StateBrush</code> objects.
	 * 	They can be used to display external icons, such as SWF and bitmap files, or
	 * 	embeded icons.
	 * 
	 * 	@see org.flashapi.swing.brushes.Brush
	 * 	@see org.flashapi.swing.brushes.StateBrush
	 * 
	 *  @includeExample IconExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Icon extends UIContainer implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor. Creates a new <code>Icon</code> instance.
		 */
		public function Icon() {
			super();
			initObj();
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
		
		private var _brush:Brush;
		/**
		 * 	A reference to the <code>Brush</code> instance used to draw the icon.
		 * 	
		 * 	@default null
		 * 
		 * 	@see #brushRef
		 * 	@see #setBrush()
		 */
		public function get brush():Brush {
			return _brush;
		}
		
		private var _brushRef:Class;
		/**
		 * 	A reference to the <code>Brush</code> class used to draw the icon.
		 * 
		 * 	@default null
		 * 
		 * 	@see #brush
		 * 	@see #setBrush()
		 */
		public function get brushRef():Class {
			return _brushRef;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>iconColors</code> property.
		 * 
		 * 	@see #iconColors
		 */
		protected var $iconColors:ColorState;
		/**
		 * 	A <code>ColorState</code> object that sets and gets the color of the icon
		 * 	for each state defined by the <code>ColorState</code> instance:
		 * <ul>
		 * 		<li><code>ColorState.disabled</code>,</li>
		 * 		<li><code>ColorState.down</code>,</li>
		 * 		<li><code>ColorState.over</code>,</li>
		 *  	<li><code>ColorState.up</code>.</li>
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
		 * 
		 * 	@see #iconColor
		 */
		public function get iconColors():ColorState {
			return $iconColors;
		}
		public function set iconColors(value:ColorState):void { 
			$iconColors = value;
			if (_brush != null) setBrushColors();
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function get width():Number {
			return spas_internal::uioSprite.width;
		}
		
		/**
		 *  @private
		 */
		override public function get height():Number {
			return spas_internal::uioSprite.height;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>src</code> property.
		 * 
		 * 	@see #src
		 */
		protected var $src:* = null;
		/**
		 * 	Returns a reference to the source object displayed within this <code>Icon</code>
		 * 	instance. Possible values are;
		 * 	<ul>
		 * 		<li>a <code>String</code> if the source object is an external asset,</li>
		 * 		<li>the fully qualified class name of the source object if it is a
		 * 		<code>Brush</code>, a <code>StateBrush</code>, a <code>DisplayObject</code>
		 * 		or a <code>UIObject</code> instance,</li>
		 * 		<li><code>null</code> if no icon is currently displayed by this<code>Icon</code>
		 * 		instance.</li>
		 * 	</ul>
		 * 
		 * 	@default null
		 */
		public function get src():* {
			return $src is String ? $src : $src.getQualifiedClassName();
		}
		
		private var _hasIcon:Boolean = false;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>Icon</code>
		 * 	instance currently displays an icon, added by the <code>Icon.paint()</code>
		 * 	or <code>Icon.addIcon()</code> methods, (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@default false
		 */
		public function get hasIcon():Boolean {
			return _hasIcon;
		}
		
		/**
		 *  @private
		 */
		override public function set layout(value:Layout):void {}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * 	@param	src
		 */
		public function addIcon(src:*):void {
			removeIcon();
			clear();
			$src = src;
			_hasIcon = true;
			super.addElement(src);
		}
		
		/**
		 * 
		 */
		public function removeIcon():void {
			super.removeElements();
			_hasIcon = false;
			$src = null;
		}
		
		/**
		 *  Clears the icon drawn by a specific Brush class.
		 * 
		 * 	@see #paint()
		 * 	@see #setBrush()
		 */
		public function clear():void {
			if (_brush != null) {
				_brush.clear();
				clearBoundsArea();
				_hasIcon = false;
				fixSize();
			}
		}
		
		/**
		 *  Draws the icon defined by a specific Brush class.
		 * 	
		 * 	@see #clear()
		 * 	@see #setBrush()
		 */
		public function paint():void {
			removeIcon();
			if (_brush != null) {
				_brush.paint();
				drawBoundsArea(_brush.rectangle);
				_hasIcon = true;
				fixSize();
			}
		}
		
		/**
		 *  Defines the specific <code>Brush</code> class used to draw the icon, and returns
		 * 	the created <code>Brush</code> instance.
		 * 
		 *	@param	brush	The <code>Brush</code> class to use to render the icon.
		 * 	@param	rect	A rectangular area that defines the brush bounds.
		 * 	@param	dto	
		 * 
		 * 	@return 	the <code>Brush</code> instance used to draw the icon.
		 * 
		 * 	@see #clear()
		 * 	@see #paint()
		 */
		public function setBrush(brush:*, rect:Rectangle = null, dto:LafDTO = null):Brush {
			deleteBrush();
			_brushRef = brush as Class;
			_brush = new _brushRef(spas_internal::uioSprite, rect, dto) as Brush;
			setBrushColors();
			return _brush;
		}
		
		public function deleteBrush():void {
			if (_brush != null) {
				_brush.clear();
				_brush.finalize();
				_brush = null;
				_brushRef = null;
			}
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			deleteBrush();
			spas_internal::uioSprite.removeChild(_boundsArea);
			_boundsArea = null;
			/*$iconColors.finalize();
			$iconColors = null;*/
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _boundsArea:Shape;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$layout = new AbsoluteLayout();
			initLaf(IconUIRef);
			_boundsArea = new Shape();
			_boundsArea.cacheAsBitmap = true;
			spas_internal::uioSprite.addChild(_boundsArea);
			initSize(0, 0);
			drawBoundsArea(new Rectangle(0, 0, 0, 0));
			spas_internal::uioSprite.addChild($content);
			$iconColors = new ColorState(this);
			$evtColl.addEvent(this, LoaderEvent.COMPLETE, fixBoundsArea);
			spas_internal::isInitialized(1);
		}
		
		private function drawBoundsArea(rect:Rectangle):void {
			if (rect != null) {
				with (Figure.setFigure(_boundsArea)) {
					clear();
					beginFill(0xFF0000, 0);
					drawRectangle(rect.x, rect.y, rect.width - rect.x, rect.height - rect.y);
					endFill();
				}
			}
		}
		
		private function clearBoundsArea():void {
			_boundsArea.graphics.clear();
		}
		
		private function setBrushColors():void {
			if(_brush is StateBrush) (_brush as StateBrush).colors = $iconColors;
		}
		
		private function fixBoundsArea(e:LoaderEvent):void {
			//var r:Rectangle = $content.getBounds($content);
			drawBoundsArea($content.getBounds($content));
			fixSize();
			dispatchMetricsEvent();
		}
		
		private function fixSize():void {
			$width = spas_internal::uioSprite.width;
			$height = spas_internal::uioSprite.height;
		}
	}
}