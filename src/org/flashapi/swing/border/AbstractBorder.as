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

package org.flashapi.swing.border {
	
	// -----------------------------------------------------------
	// AbstractBorder.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/12/2008 19:36
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.decorator.BorderDecorator;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>AbstractBorder</code> is the abstract superclass of <code>UIObject</code>
	 * 	components that implement the API defined by the <code>Border</code> interface.
	 * 
	 * 	<p>For a list of CSS properties supported by <code>Border</code> objects
	 * 	see: <a href="Border.html" title="org.flashapi.swing.border.Border">
	 * 	<code>org.flashapi.swing.border.Border</code></a>.</p>
	 * 
	 * 	@see org.flashapi.swing.border.Border
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractBorder extends UIObject implements Border {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AbstractBorder</code> instance.
		 */
		public function AbstractBorder() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@inheritDoc
		 */
		public function get backgroundContainer():Sprite {
			return spas_internal::background;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundWidth():Number {
			return $width;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundHeight():Number {
			return $height;
		}
		
		/**
		 *	@inheritDoc
		 */
		public function get bordersContainer():Sprite {
			return spas_internal::borders;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderStyle</code> property.
		 * 
		 * 	@see #borderStyle
		 */
		protected var $borderStyle:String = BorderStyle.SOLID;
		/**
		 *	@inheritDoc
		 */
		public function get borderStyle():String {
			return $borderStyle;
		}
		public function set borderStyle(value:String):void {
			$borderStyle = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderTopColor</code> property.
		 * 
		 * 	@see #borderTopColor
		 */
		protected var $btColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderTopColor():* {
			return $btColor;
		}
		public function set borderTopColor(value:*):void {
			$btColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderRightColor</code> property.
		 * 
		 * 	@see #borderRightColor
		 */
		protected var $brColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderRightColor():* {
			return $brColor;
		}
		public function set borderRightColor(value:*):void {
			$brColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderBottomColor</code> property.
		 * 
		 * 	@see #borderBottomColor
		 */
		protected var $bbColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomColor():* {
			return $bbColor;
		}
		public function set borderBottomColor(value:*):void {
			$bbColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderLeftColor</code> property.
		 * 
		 * 	@see #borderLeftColor
		 */
		protected var $blColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftColor():* {
			return $blColor;
		}
		public function set borderLeftColor(value:*):void {
			$blColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderShadowColor</code> property.
		 * 
		 * 	@see #borderShadowColor
		 */
		protected var $bShadowColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowColor():* {
			return $bShadowColor;
		}
		public function set borderShadowColor(value:*):void {
			$bShadowColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderHighlightColor</code> property.
		 * 
		 * 	@see #borderHighlightColor
		 */
		protected var $bHighlightColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightColor():* {
			return $bHighlightColor;
		}
		public function set borderHighlightColor(value:*):void {
			$bHighlightColor = getColor(value);
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderTopOpacity</code> property.
		 * 
		 * 	@see #borderTopOpacity
		 */
		protected var $bto:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderTopOpacity():Number {
			return $bto;
		}
		public function set borderTopOpacity(value:Number):void {
			$bto = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderRightOpacity</code> property.
		 * 
		 * 	@see #borderRightOpacity
		 */
		protected var $bro:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderRightOpacity():Number {
			return $bro;
		}
		public function set borderRightOpacity(value:Number):void {
			$bro = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderBottomOpacity</code> property.
		 * 
		 * 	@see #borderBottomOpacity
		 */
		protected var $bbo:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomOpacity():Number {
			return $bbo;
		}
		public function set borderBottomOpacity(value:Number):void {
			$bbo = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderLeftOpacity</code> property.
		 * 
		 * 	@see #borderLeftOpacity
		 */
		protected var $blo:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftOpacity():Number {
			return $blo;
		}
		public function set borderLeftOpacity(value:Number):void {
			$blo = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderShadowOpacity</code> property.
		 * 
		 * 	@see #borderShadowOpacity
		 */
		protected var $bso:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowOpacity():Number {
			return $bso;
		}
		public function set borderShadowOpacity(value:Number):void {
			$bso = value;
			redrawDecorator();
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>borderHighlightOpacity</code> property.
		 * 
		 * 	@see #borderHighlightOpacity
		 */
		protected var $bho:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightOpacity():Number {
			return $bho;
		}
		public function set borderHighlightOpacity(value:Number):void {
			$bho = value;
			redrawDecorator();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	The <code>BorderDecorator</code> instance for this <code>Border</code>
		 * 	object.
		 */
		protected var $borderDecorator:BorderDecorator;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::background = new Sprite();
			spas_internal::borders = new Sprite();
		}
		
		private function redrawDecorator():void {
			$borderDecorator.drawBackground();
			$borderDecorator.drawBorders();
			setEffects();
		}
	}
}