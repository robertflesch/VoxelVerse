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
	// Label.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 15/03/2010 22:53
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextFieldAutoSize;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.LabelUIRef;
	import org.flashapi.swing.text.ASTM;
	import org.flashapi.swing.util.Observer;
	import org.flashapi.swing.util.TextTransform;
	
	use namespace spas_internal;
	
	[IconFile("Label.png")]
	
	/**
	 * 	<img src="Label.png" alt="Label" width="18" height="18"/>
	 * 
	 * 	The <code>Label</code> class displays a single line of noneditable text.
	 * 	Use the <code>Text</code> class to create blocks of multiline noneditable text.
	 * 	<code>Label</code> objects do not have backgrounds or borders and cannot take focus.
	 * 
	 * 	@see org.flashapi.swing.Text
	 * 
	 *  @includeExample LabelExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Label extends ASTM implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Label</code> instance with the specified
		 * 					parameters.
		 * 
		 *	@param	text 	Specifies the plain text displayed by the <code>Label</code>
		 * 					instance.	
		 * 	@param	width	The width of the <code>Label</code> instance, in pixels.
		 * 					If <code>NaN</code>, the width is adjusted automatically to
		 * 					display all characters from the <code>text</code> property.
		 * 					Default value is <code>NaN</code>.
		 */
		public function Label(text:String = "", width:Number = NaN) {
			super(text, width);
			initObj(width);
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
		 * @private
		 */
		override public function set height(value:Number):void {}
			
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function get width():Number {
			//return isNaN(_width) ? spas_internal::textRef.width : _width;
			return isNaN($width) ? spas_internal::uioSprite.getBounds(null).width : $width;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function createUIObject(x:Number = undefined, y:Number = undefined):void {
			super.createUIObject(x, y);
			initStoredHeight();
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			updateText();
			var txt:String = new TextTransform($text, $textTransform).getTexTransform();
			$html ? spas_internal::textRef.htmlText = txt : spas_internal::textRef.text = txt;
			spas_internal::textRef.autoSize = TextFieldAutoSize.LEFT;
			var h:Number = spas_internal::textRef.height;
			if(!$autoSize || !isNaN($width) || $fixToParentWidth) {
				spas_internal::textRef.autoSize = TextFieldAutoSize.NONE;
				spas_internal::textRef.width = getTextWidth();
			} else $width = spas_internal::textRef.width;
			spas_internal::textRef.height = h;
			//spas_internal::textRef.y = 0;
			setPositions();
			lookAndFeel.update();
			updateButtonMode();
			fixBaseLine();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number):void {
			$autoWidth = isNaN(width);
			initMinSize(); 
			initLaf(LabelUIRef);
			initTextFormat();
			createContainer();
			spas_internal::uioSprite.addChild(spas_internal::textRef);
			fixHeight();
			$selectable = false;
			spas_internal::setSelector(Selectors.LABEL);
			spas_internal::isInitialized(1);
		}
	}
}