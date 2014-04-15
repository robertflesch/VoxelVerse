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
	// Text.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 17/03/2010 22:17
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.plaf.libs.TextUIRef;
	import org.flashapi.swing.text.ACTM;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Text.png")]
	
	/**
	 * 	<img src="Text.png" alt="Text" width="18" height="18"/>
	 * 
	 * 	The <code>Text</code> class is used to display multiline, noneditable
	 * 	text. Use the <code>Label</code> class if you need only a single line
	 * 	of noneditable text. You can format the text in a <code>Text</code>
	 * 	instance using HTML tags. The text in a <code>Text</code> object is
	 * 	selectable by default, but you can make it unselectable by setting
	 * 	the <code>selectable</code> property to <code>false</code>.
	 * 	
	 * 	<p>The <code>Text</code> class does not support scroll bars. If
	 * 	you need scrolling, you should use a non-editable <code>TextArea</code> 
	 * 	object.</p>
	 * 
	 * 	<p><code>Text</code> instances do not have backgrounds or borders
	 * 	and cannot take focus.</p>
	 * 
	 * 	@see org.flashapi.swing.TextArea
	 * 	@see org.flashapi.swing.Label
	 * 
	 *  @includeExample TextExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class Text extends ACTM implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Text</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>Text</code> instance, in pixels.
		 * 	@param	height	The height of the <code>Text</code> instance, in pixels.
		 */
		public function Text(width:Number = 200, height:Number = 150) {
			super(width, height);
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
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			var r:Rectangle;
			if($autoHeight || $autoSize) r = spas_internal::textRef.getBounds(targetCoordinateSpace);
			else r = new Rectangle(0, 0, $width, $height);
			return r;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override protected function refresh():void {
			updateText();
			fixSize();
			setPositions();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			initMinSize();
			initLaf(TextUIRef);
			initTextFormat();
			$selectable = $autoFocus = true;
			createContainer();
			spas_internal::textRef.width = $width;
			spas_internal::textRef.height = $height;
			spas_internal::setSelector(Selectors.TEXT);
			spas_internal::isInitialized(1);
		}
	}
}