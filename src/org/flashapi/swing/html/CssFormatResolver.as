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

package org.flashapi.swing.html {
	
	// -----------------------------------------------------------
	// CssFormatResolver.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 04/03/2011 02:24
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowValueHolder;
	import flashx.textLayout.elements.IFormatResolver;
	import flashx.textLayout.elements.InlineGraphicElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.ITextLayoutFormat;
	import org.flashapi.swing.color.Color;
	
	/**
	 * 	[This class is under development.]
	 * 
	 * 	The <code>CssFormatResolver</code> class allows to use a valid <code>StyleSheet</code>
	 * 	object to format a <code>TextFlow</code> instance.
	 * 
	 * 	@see org.flashapi.swing.html.BasicHtmlParser
	 * 	@see org.flashapi.swing.html.BasicHtmlPage
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class CssFormatResolver implements IFormatResolver {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>CssFormatResolver</code> instance.
		 */
		public function CssFormatResolver() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _styleSheet:StyleSheet;
		/**
		 * 	Sets or gets the <code>StyleSheet</code> that must be transposed to
		 * 	a <code>ITextLayoutFormat</code> object. If <code>null</code>, all
		 * 	registred styles are removed from this <code>CssFormatResolver</code>
		 * 	and the <code>resolveFormat()</code> method will return <code>null</code>.
		 * 
		 * 	@default null
		 * 
		 * 	@see #resolveFormat();
		 */
		public function get styleSheet():StyleSheet {
			return _styleSheet;
		}
		public function set styleSheet(value:StyleSheet):void {
			_styleSheet = value;
			_sytleDefinitions = new Dictionary(true);
			if (_styleSheet == null) return;
			var names:Array = _styleSheet.styleNames;
			var l:int = names.length - 1;
			var name:String;
			for (; l >= 0; l--) {
				name = names[l];
				_sytleDefinitions[name] = _styleSheet.getStyle(name);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Invalidates any cached formatting information for a <code>TextFlow</code>
		 * 	so that formatting must be recomputed.
		 * 
		 * 	@param	textFlow
		 */
		public function invalidateAll(textFlow:TextFlow):void {
		}
		
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Invalidates cached formatting information on this element (e.g. the parent
		 * 	element, or the id or the <code>styleName</code> have changed).
		 * 
		 * 	@param	target
		 */
		public function invalidate(target:Object):void {
		}
		
		/**
		 * 	Returns any format settings for a <code>FlowElement</code> or
		 * 	<code>ContainerController</code> object.
		 * 
		 * 	@param	target	A text Layout Format element on which to apply
		 * 					a CSS style.
		 * 	
		 * 	@return	The format settings for the specified object.
		 */
		public function resolveFormat(target:Object):ITextLayoutFormat {
			var element:FlowElement;
			if (target is FlowElement) {
				element = target as FlowElement;
				var fmt:FlowValueHolder = element.format as FlowValueHolder;
			} else return new FlowValueHolder();
			if (_styleSheet == null) return fmt;
			var style:Object;
			var styleName:String;
			var styleRef:String = element.styleName;
			if (element.styleName != null) {
				var a:Array = styleRef.split("--");
				var l:int = a.length -1;
				for (; l >= 0; l--) {
					style = _sytleDefinitions[a[l]];
					if (style != null) {
						for (styleName in style) 
							defineFormat(element, fmt, style, styleName);
					}
				}
			}
			styleRef = element.id;
			if (styleRef != null) {
				style = _sytleDefinitions[styleRef];
				if (style == null) {
					return fmt;
				}
				for (styleName in style) 
					defineFormat(element, fmt, style, styleName);
			}
			return fmt;
		}
		
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Return the specified format value for a <code>FlowElement</code> or a
		 * 	<code>ContainerController</code>, or <code>undefined</code> if the value is
		 * 	not found.
		 * 
		 * 	@param	target
		 * 	@param	userFormat
		 * 
		 * 	@return	The value of the <code>userFormat</code> for the specified object.
		 */
		public function resolveUserFormat(target:Object, userFormat:String):* {
			return null;
		}
		
		/**
		 * 	[Not implemented yet.]
		 * 
		 * 	Returns the format resolver when a <code>TextFlow</code> is copied.
		 * 
		 * 	@param	oldFlow
		 * 	@param	newFlow
		 * 
		 * @return	The format resolver for the copy of the <code>TextFlow</code>.
		 */
		public function getResolverForNewFlow(oldFlow:TextFlow, newFlow:TextFlow):IFormatResolver {
			return null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _sytleDefinitions:Dictionary;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function defineFormat(elm:FlowElement, fmt:FlowValueHolder, style:Object, name:String):void {
			if (style[name]) {
				switch(name) {
					case "color" :
						fmt[name] = new Color().getValue(style[name]);
						break;
					case "width" : 
					case "height" : //--> Prevents iterative stack overflow for width and height properties:
						//elm.tlf_internal::appendElementsForDelayedUpdate(elm.getTextFlow(), ModelChange.ELEMENT_MODIFIED);
						if (elm is InlineGraphicElement) (elm as InlineGraphicElement)[name] = style[name];
						break;
					case "float" :
						if (elm is InlineGraphicElement) (elm as InlineGraphicElement)[name] = style[name];
						break;
					case "marginTop" :
						fmt.paragraphSpaceBefore = style[name];
						break;
					case "marginBottom" :
						fmt.paragraphSpaceAfter = style[name];
						break;
					default :
						fmt[name] = style[name];
				}
			}
		}
	}
}