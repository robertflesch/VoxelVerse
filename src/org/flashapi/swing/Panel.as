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
	// Panel.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.5, 17/03/2010 21:18
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Shape;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.draw.Figure;
	import org.flashapi.swing.plaf.libs.PanelUIRef;
	import org.flashapi.swing.skin.Skinable;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Panel.png")]
	
	/**
	 * 	<img src="Panel.png" alt="Panel" width="18" height="18"/>
	 * 
	 * 	A <code>Panel</code> object consists of a content area, with a plain background
	 * 	shape, for displaying child elements. Typically, you use <code>Panel</code> 
	 * 	objects to wrap simple application modules. To wrap more complex application modules,
	 * 	you can use <code>PanelContainer</code> or <code>Window</code> objects.
	 * 
	 * <p><strong>Note: </strong> <code>Panel</code> instance are not similar to
	 * 	Flex <code>mx.containers.Panel</code> controls; if you need Flex-like 
	 * 	<code>Panel</code> container, use <code>PanelContainer</code> class instead.</p>
	 * 
	 * 	@see org.flashapi.swing.PanelContainer
	 * 
	 * 	@includeExample PanelExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Panel extends UIContainer implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Panel</code> intance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>Panel</code> intance, in pixels.
		 * 	@param	height	The height of the <code>Panel</code> intance, in pixels.
		 */
		public function Panel(width:Number = 150, height:Number = 130) {
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
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>hasMask</code> property.
		 * 
		 * 	@see #hasMask
		 */
		protected var $hasMask:Boolean = false;
		/**
		 * 	A <code>Boolean</code> that indicates of the content of the panel has a
		 * 	mask (<code>true</code>), or not (<code>false</code>). If <code>true</code>,
		 * 	the bounds of the mask are delimited by the padding values of the
		 * 	<code>Panel</code> object.
		 * 
		 * 	@default false
		 */
		public function get hasMask():Boolean {
			return $hasMask;
		}
		public function set hasMask(value:Boolean):void {
			$hasMask = value;
			value ? addMask() : removeMask();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function set skin(value:Skinable):void {
			if ($hasSkin) spas_internal::uioSprite.removeChildAt(0);
			super.skin = value;
			if($skinObject) {
				spas_internal::uioSprite.graphics.clear();
				spas_internal::uioSprite.addChildAt($skinObject.getBitmapClip(), 0);
			}
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
			var skinObj:Object = getSkinObj();
			skinObj.drawPanel();
			if($hasMask) drawMask();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number):void {
			$padL = $padT = $padR = $padB = 10;
			$horizontalGap = $verticalGap = 5;
			createTextureManager(spas_internal::uioSprite);
			spas_internal::lafDTO.width = $width = width;
			spas_internal::lafDTO.height = $height = height;
			spas_internal::lafDTO.currentTarget = spas_internal::uioSprite;
			initLaf(PanelUIRef);
			$textureManager.color = lookAndFeel.getColor();
			//spas_internal::lafDTO.borderColor = $borderColor = lookAndFeel.getBorderColor();
			spas_internal::uioSprite.addChild($content);
			spas_internal::setSelector(Selectors.PANEL);
			spas_internal::isInitialized(1);
		}
		
		private function addMask():void {
			if ($contentMask == null) {
				$contentMask = new Shape();
				spas_internal::uioSprite.addChild($contentMask);
				$content.mask = $contentMask;
				drawMask();
			}
		}
		
		private function removeMask():void {
			if ($contentMask != null) {
				$content.mask = null;
				spas_internal::uioSprite.removeChild($contentMask);
				$contentMask = null;
			}
		}
		
		private function drawMask():void {
			var f:Figure = Figure.setFigure($contentMask);
			f.clear();
			f.beginFill(0);
			f.drawRectangle($padL, $padT, $width-$padR, $height-$padB);
			f.endFill();
		}
	}
}