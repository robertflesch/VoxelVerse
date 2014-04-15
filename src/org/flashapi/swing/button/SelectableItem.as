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

package org.flashapi.swing.button {
	
	// -----------------------------------------------------------
	// SelectableItem.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.5, 17/03/2010 21:35
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.brushes.StateBrush;
	import org.flashapi.swing.button.core.GroupButtonBase;
	import org.flashapi.swing.constants.MenuIconName;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.Icon;
	import org.flashapi.swing.plaf.libs.SelectableItemUIRef;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>SelectableItem</code> class defines the appearance of the navigation
	 * 	buttons of a list of items such as <code>Menu</code>, <code>LisBox</code> or
	 * 	<code>ComboBox</code> object..
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SelectableItem extends GroupButtonBase implements Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SelectableItem</code> instance.
		 * 	
		 * 	@param	label Text to display on the <code>SelectableItem</code> instance. 
		 * 			If the label is wider than the button, the label is truncated and
		 * 			terminated by an ellipsis (...).
		 * 			The default value is "".
		 * 	@param	width The button width, in pixels. If set to <code>NaN</code>,
		 * 			the button width is automatically set to allow label to be untruncated.
		 * 			In that case, the <code>autoWidth</code> property is set to <code>true</code>.
		 * 			The default value is <code>NaN</code>.
		 * 	@param	height The button height, in pixels. If set to <code>NaN</code>,
		 * 			the button height is automatically set to allow label to be untruncated.
		 * 			In that case, <code>autoWidth</code> property is set to <code>true</code>.
		 * 			The default value is <code>NaN</code>.
		 * 	@param	htmlText Specifies whether the text to display on the button recognize
		 * 			HTML tags (<code>true</code>), or not (<code>false</code>).
		 * 			The default value is <code>true</code>.
		 * 	
		 * 	<p><strong>Note: </strong>if both <code>width</code> and <code>height</code> 
		 * 	parametersare <code>NaN</code>, the <code>autoSize</code> property is 
		 * 	automatically set to <code>true</code>.</p>
		 */
		public function SelectableItem(label:String = null, width:Number = 60, height:Number = 22, html:Boolean = false) {
			super(	(label == null ? Locale.spas_internal::LABELS.SELECTABLE_ITEM_LABEL : label),
					width, height, html, SelectableItemUIRef);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the left icon is
		 * 	checked when the <code>SelectableItem</code> instance is used as "check"
		 * 	or "radio" button within a <code>Menu</code> instance; <code>true</code>
		 * 	when the icon is checked, <code>false</code> otherwise.
		 *  
		 * 	@default false
		 */
		public function get menuIconChecked():Boolean {
			return spas_internal::isIconChecked;
		}
		public function set menuIconChecked(value:Boolean):void {
			var ic:Icon;
			for each (ic in iconsStack) {
				if (ic.name == MenuIconName.ICON_LEFT) {
					value ? ic.paint() : ic.clear();
					spas_internal::isIconChecked = value;
					break;
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Additional icons management
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal var iconsStack:Array;
		
		
		/**
		 *  @private
		 */
		spas_internal var isIconChecked:Boolean;
		
		/**
		 *  @private
		 */
		override public function set iconColor(value:*):void {
			super.iconColor = value;
			fixBrushesColors();
		}
		
		/**
		 *  @private
		 */
		override public function set iconColors(value:ColorState):void { 
			super.iconColors = value;
			fixBrushesColors();
		}
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			var ic:Icon;
			for each (ic in iconsStack) {
				ic.finalize();
				ic = null;
			}
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::setSelector(Selectors.SELECTABLE_ITEM);
			spas_internal::isIconChecked = false;
			spas_internal::iconsStack = [];
		}
		
		private function fixBrushesColors():void {
			var ic:Icon;
			var l:int = iconsStack.length - 1;
			for (; l >= 0; l-- ) {
				ic = iconsStack[l];
				if(ic.brush != null) (ic.brush as StateBrush).colors = $iconColors;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  TODO:
		//
		//--------------------------------------------------------------------------
		
		/*
		public function setIcon(_icon:String, spacer:Number):Void {
			var L = this.textField;
			var SI = this;
			var D = outerLabelFieldMargin;
			createIconContainer(this);
			var IL = new IconLoader(_icon, iconContainer);
			IL.onLoadInit = function() {
				var IC = SI.iconContainer;
				if(spacer!=undefined) {
					L._x = spacer+D, L._width = SI.width-L._x-2*D;
				} else {
					L._x = IC._x+IC._width+2, L._width = SI.width-L._x-2*D;
				}
				switch(SI._iconAlignment){
					case "top":
					IC._y = 0;
					break;
					case "middle":
					(L._height>IC._height) ? IC._y = (L._height-IC._height)/2 : IC._y = -(IC._height-L._height)/2;
					break;
					case "bottom":
					IC._y = L._height-IC._height;
					break;
				}
			};
			IL.onLoadError = IL.onLoadInit();
			IL.createObject();
		}
		public function set iconAlignment(alignment:String):Void {
			if(alignment=="top" || alignment=="middle" || alignment=="bottom") _iconAlignment = alignment;
		}
		public function get iconAlignment():String {
			return _iconAlignment;
		}
		public function set encloseIcon(flag:Boolean):Void {
			_encloseIcon = flag;
		}
		public function get encloseIcon():Boolean{
			return _encloseIcon;
		}
		public function set labelPlacement(Void):Void {}*/
		}
}