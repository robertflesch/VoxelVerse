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

package org.flashapi.swing.managers {
	
	// -----------------------------------------------------------
	// CSSManager.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 11/04/2011 02:05
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import org.flashapi.swing.Application;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.States;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.CSSGateway;
	import org.flashapi.swing.css.Properties;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.event.UIOEvent;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.exceptions.SingletonException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.util.StringUtil;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>CSSManager</code> singleton provides the private interface for 
	 * 	manipulating and applying Cascading Style Sheet properties to SPAS 3.0
	 * 	display objects.
	 * 
	 * 	@see org.flashapi.swing.UIManager#cssManager
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class CSSManager {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>CSSManager</code> singleton.
		 * 
		 *  @throws org.flashapi.swing.exceptions.SingletonException A <code>SingletonException</code>
		 * 			if you try create a new <code>CSSManager</code> instance.
		 */
		public function CSSManager() { 
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		spas_internal static function getInstance():CSSManager {
			_constructorAccess = false;
			return new CSSManager();
		}
		
		/**
		 * 	@private
		 */
		spas_internal function addStyle(styleSheet:*):Dictionary {
			if(styleSheet is StyleSheet) _style = styleSheet;
			else if (styleSheet is String) {
				_style = new StyleSheet();
				_style.parseCSS(styleSheet);
			} else {
				throw new IllegalArgumentException(Locale.spas_internal::ERRORS.STYLE_PARAMETER_ERROR);
			}
			var value:String;
			var prop:String;
			var item:String;
			var ruleName:String;
			var rule:Object;
			var proxy:Object;
			if (_lastRules == null) _lastRules = new Dictionary(true);
			var style:Object;
			var l:int = _style.styleNames.length - 1;
			for (; l >= 0; l--)  {
				ruleName = _style.styleNames[l];
				rule = _style.getStyle(ruleName);
				if (_rules[ruleName]) {
					//--> Get the existing rule:
					proxy = _rules[ruleName].rule;
					for(item in rule){
						value = StringUtil.trim(rule[item]);
						prop = StringUtil.trim(item);
						fixTexture(proxy);
						proxy[prop] = value;
					}
				} else {
					proxy = {};
					for(item in rule) {
						value = StringUtil.trim(rule[item]);
						prop = StringUtil.trim(item);
						fixTexture(proxy);
						proxy[prop] = value;
					}
				}
				style = { rule:proxy, name:ruleName };
				_lastRules[ruleName] = style;
				_rules[ruleName] = style;
			}
			function fixTexture(ruleToFix:Object):void {
				if(prop == Properties.TEXTURE && value != "none") ruleToFix.gradient = "false";
				if(prop == Properties.GRADIENT && value == "true") ruleToFix.texture = "none";
			}
			return _rules;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function updateRules():void {
			applyRules(_lastRules);
			_lastRules = null;
		}
		
		/**
		 * 	@private
		 */
		spas_internal function setCSS(uio:*):void {
			if (validProp(uio, "selector")) setRuleToElement(uio, uio.selector.toLowerCase());
			if(uio.className != "") setRuleToElement(uio, "." + uio.className.toLowerCase());
			if(uio.id != null) setRuleToElement(uio, "#" + uio.id);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private constants
		//
		//--------------------------------------------------------------------------
		
		private const PX:String = "px";
		private const PCT:String = "%";
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _style:StyleSheet;
		private var _rules:Dictionary = new Dictionary();
		private var _states:Array = [	States.NONE, States.UP, States.OVER,
										States.DOWN, States.DISABLED, States.SELECTED];
		//private var _invalidateTexturing:Boolean = false;
		private var _lastRules:Dictionary;
		
		//---> Singleton management:
		private static var _instanciable:Boolean = true;
		private static var _constructorAccess:Boolean = true;
		
		private var _layoutManager:LayoutManager;
		private var _uiManager:*;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			if (!_instanciable) {
				throw new SingletonException(Locale.spas_internal::ERRORS.CSS_MANAGER_SINGLETON_ERROR);
			}
			_uiManager = UIDescriptor.getUIManager();
			_layoutManager = _uiManager.layoutManager;
			_instanciable = false;
			_constructorAccess = true;
		}
		
		/*private function applyAllRules():void {
			applyRules(_rules);
		}*/
		
		/**
		 * 	@private
		 */
		private function applyRules(rules:Dictionary):void {
			if(rules != null) {
				_layoutManager.spas_internal::invalidateListUpdate = true;
				var doc:Application = _uiManager.document;
				var elementsList:Array;
				var className:String;
				var state:String;
				var name:String;
				var rule:Object;
				var len:int;
				var item:Object;
				var first:String;
				var colonPos:int;
				for each(item in rules) {
					name = item.name;
					rule = item.rule;
					len = name.length;
					if (name == Selectors.BODY) {
						applyRuleToElement(doc, rule, "none");
						continue;
					}
					first = name.charAt();
					colonPos = name.indexOf(":");
					state = colonPos == -1 ? "none" : name.substr(colonPos + 1, len);
					switch(first) {
						case "." :
							className = colonPos == -1 ? name.substr(1, len): name.substr(1, colonPos-1);
							elementsList = doc.getElementsByClassName(className);
							//if(elementsList.length == 0) break;
							len = elementsList.length - 1;
							for(; len >= 0; len--) applyRuleToElement(elementsList[len], rule, state);
							break;
						case "#" :
							className = colonPos == -1 ? name.substr(1, len): name.substr(1, colonPos-1)
							var elm:* = doc.getElementByID(className);
							if(elm != null) applyRuleToElement(elm, rule, state, 0);
							break;
						default :
							className = colonPos == -1 ? name.substr(0, len): name.substr(0, colonPos);
							elementsList = doc.getElementsBySelector(className);
							//if (elementsList.length == 0) break;
							len = elementsList.length - 1;
							for(; len >= 0; len--) applyRuleToElement(elementsList[len], rule, state);
					}
				}
			}
			_layoutManager.spas_internal::invalidateListUpdate = false;
			_layoutManager.spas_internal::updateList();
		}
		
		/**
		 * 	@private
		 */
		private function applyRuleToElement(element:*, item:Object, state:String, typeOfRule:int = 1):void {
			var check:Boolean = element is IUIObject;
			if (check) {
				if (typeOfRule == 1) {
					if (element.id != null && !element.cssOverridesIDProps)
					return;
				}
				element.spas_internal::invalidateChangeEvent =
				element.spas_internal::deactivateMetricsChanges = true;
			}
			applyRule(element, item, state);
			if(check) {
				element.spas_internal::invalidateChangeEvent =
				element.spas_internal::deactivateMetricsChanges = false;
				element.dispatchEvent(new UIOEvent(UIOEvent.METRICS_CHANGED));
			}
			//--> Verrifier la consomation de ressources ; en cas de pb voir si il n'y a pas un moyen moins gourmand.
			//--> 28/02/2009: Ne sert probablement plus à rien depuis l'utilisation des UIOEvent.METRICS_CHANGED;
			//if (element is UIContainer) element.spas_internal::updateLayout();
		}
		
		private function applyRule(elm:*, item:Object, state:String):void {
			var prop:String;
			var value:String;
			
			for(prop in item) {
				
				value = item[prop];
				
				switch(prop) {
					
					case Properties.ALIGN :
						if(elm.selector != Selectors.BODY) break;
						var i:uint = 0;
						var aligns:String = item[prop];
						var vAlign:Array = aligns.match(VerticalAlignment.TOP);
						if(vAlign == null) vAlign = aligns.match(VerticalAlignment.MIDDLE);
						if(vAlign == null)  vAlign = aligns.match(VerticalAlignment.BOTTOM);
						if(vAlign != null) i += 1;
						var hAlign:Array = aligns.match(HorizontalAlignment.LEFT);
						if(hAlign == null) hAlign = aligns.match(HorizontalAlignment.CENTER);
						if(hAlign == null) hAlign = aligns.match(HorizontalAlignment.RIGHT);
						if(hAlign != null) i += 2;
						switch(i) {
							case 0 :
								break;
							case 1 :
								elm.verticalAlignment = vAlign[0];
								break;
							case 2 :
								elm.horizontalAlignment = hAlign[0];
								break;
							case 3 :
								elm.setPosition(hAlign[0], vAlign[0]);
								break;
							}
						break;
					
					case Properties.WINDOWS_WORKSPACE_COLOR	: 
						if (elm.selector != Selectors.BODY) break;
						var wwc:Color = new Color();
						_uiManager.windowsWorkspaceColor = wwc.getValue(CSSGateway.fixColorValue(value));
						break;
						
					case Properties.BACKGROUND_COLOR :
						setStateProp(elm, state, "backgroundColor", "backgroundColors", CSSGateway.fixColorValue(value));
						break;
					
					case Properties.GRADIENT_BACKGROUND_COLORS : 
						if(validProp(elm, "backgroundGradientProperties")) {
							var bgColors:Array = value.split(" ");
							var bgLen:int = bgColors.length -1;
							for(; bgLen >=0; bgLen--) bgColors[bgLen] = CSSGateway.fixColorValue(bgColors[bgLen]);
							elm.backgroundGradientProperties.colors = bgColors;
						}
						break;
					
					case Properties.BACKGROUND_OPACITY :
						if (validProp(elm, "backgroundAlpha")) elm.backgroundAlpha = value;
						break;
					
					case Properties.BORDER_STYLE :
						if (validProp(elm, "borderStyle")) elm.borderStyle = value;
						break;
					
					case Properties.BORDER_WIDTH :
						if (validProp(elm, "borderWidth")) elm.borderWidth = value;
						break;
					
					case Properties.BORDER_OPACITY :
						if (validProp(elm, "borderAlpha")) elm.borderAlpha = value;
						break;
					
					case Properties.BORDER_COLOR :
						setStateProp(elm, state, "borderColor", "borderColors", CSSGateway.fixColorValue(value));
						break;
					
					case Properties.COLOR :
						setStateProp(elm, state, "color", "colors", CSSGateway.fixColorValue(value));
						break;
					
					case Properties.CONTENT_STYLE :
						if (validProp(elm, "setStyle")) elm.setStyle(value);
						break;
					
					case Properties.BORDER_RADIUS :
						if (validProp(elm, "cornerRadius")) {
							var tmpRad:Array = value.split(" ");
							switch(tmpRad.length) {
								case 1:
									elm.cornerRadius = value;
									break;
								case 2:
									elm.bottomLeftCorner = elm.topRightCorner = tmpRad[1];
									elm.topLeftCorner = elm.bottomRightCorner = tmpRad[0];
									break;
								case 4:
									elm.topLeftCorner = tmpRad[0]; elm.topRightCorner = tmpRad[1];
									elm.bottomRightCorner = tmpRad[3];
									elm.bottomLeftCorner = tmpRad[4];
									break;
							}
						}
						break;
					
					case Properties.BORDER_BOTTOM_LEFT_RADIUS :
						if (validProp(elm, "bottomLeftCorner")) elm.bottomLeftCorner = value;
						break;
					
					case Properties.BORDER_BOTTOM_RIGHT_RADIUS :
						if (validProp(elm, "bottomRightCorner")) elm.bottomRightCorner = value;
						break;
					
					case Properties.BORDER_TOP_RIGHT_RADIUS :
						if (validProp(elm, "topRightCorner")) elm.topRightCorner = value;
						break;
					
					case Properties.BORDER_TOP_LEFT_RADIUS :
						if (validProp(elm, "topLeftCorner")) elm.topLeftCorner = value;
						break;
					
					case Properties.FONT_COLOR :
						setStateProp(elm, state, "fontColor", "fontColors", CSSGateway.fixColorValue(value));
						break;
					
					case Properties.FONT_SIZE :
						setStateProp(elm, state, "fontSize", "fontSizes", value);
						break;
					
					case Properties.FONT_STYLE :
						if (validProp(elm, "italicized")) {
							switch(value) {
								case "none" :
									elm.italicized = false;
									break;
								case "italic" :
									elm.italicized = true;
									break;
							}
						}
						/*switch(state) {
							case "none" : 		if(validProp(elm, "italicized")) { elm.italicized = value == ; } break;
							case "up" : 		if(validProp(elm, "fontSizes")) { elm.fontSizes.up = value; } break;
							case "over" : 		if(validProp(elm, "fontSizes")) { elm.fontSizes.over = value; } break;
							case "down" : 		if(validProp(elm, "fontSizes")) { elm.fontSizes.down = value; } break;
							case "disabled" : 	if(validProp(elm, "fontSizes")) { elm.fontSizes.disabled = value; } break;
						}*/
						break;
					
					case Properties.FONT_WEIGHT :
						var bf:Boolean;
						if(value == "bold") bf = true;
						else if(value == "normal") bf = false;
						else break;
						setStateProp(elm, state, "boldFace", "boldFaces", bf);
						break;
					
					case Properties.FOOTER_COLOR :
						if (validProp(elm, "footerColor")) elm.footerColor = CSSGateway.fixColorValue(value);
						break;
					
					case Properties.GAP :
						if (validProp(elm, "gap")) elm.gap = value;
						break;
					
					case Properties.GLOW :	if (validProp(elm, "glow"))
						elm.glow = eval("glow", value);
						break;
					
					case Properties.GLOW_COLOR :
						setColor(elm, "glowColor", value);
						break;
					
					case Properties.GRADIENT :
						if (validProp(elm, "gradientMode")) elm.gradientMode = eval("gradientMode", value);
						break;
					
					case Properties.GRADIENT_COLORS :
						if(validProp(elm, "gradientProperties")) {
							var colors:Array = value.split(" "); 
							var len:int = colors.length -1;
							for (; len >=0; len--) colors[len] = CSSGateway.fixColorValue(colors[len]);
							elm.gradientProperties.colors = colors;
						}
						break;
					
					case Properties.GRADIENT_BACKGROUND :
						if (validProp(elm, "backgroundGradientMode")) {
							elm.backgroundGradientMode = eval("backgroundGradientMode", value);
						}
						break;
					
					case Properties.HEADER_COLOR :
						if (validProp(elm, "headerColor")) elm.headerColor = CSSGateway.fixColorValue(value);
						break;
					
					case Properties.HEIGHT :
						if (validProp(elm, "autoAdjust")) elm.autoAdjust = false;
						var phIndex:int = value.indexOf(PCT);
						if (phIndex > -1 && validProp(elm, "percentHeight")) elm.percentHeight = value.slice(0, phIndex);
						else {
							switch(value) {
								case "auto" :
									if (validProp(elm, "autoHeight")) elm.autoHeight = true;
									break;
								case "parent" :
									if (validProp(elm, "fixToParentHeight")) elm.fixToParentHeight = true;
									break;
								case "none" :
									if(validProp(elm, "autoHeight")) elm.autoHeight = false;
									if(validProp(elm, "fixToParentHeight")) elm.fixToParentHeight = false;
									if(validProp(elm, "autoAdjust")) elm.autoAdjust = true;
									break;
								default :
									if (validProp(elm, "autoHeight")) elm.autoHeight = false;
									if(validProp(elm, "fixToParentHeight")) elm.fixToParentHeight = false;
									elm.height = value;
							}
						}
						break;
					
					case Properties.HORIZONTAL_GAP :
						if (validProp(elm, "horizontalGap")) elm.horizontalGap = value;
						break;
					
					case Properties.HORIZONTAL_ALIGN :
						if (validProp(elm, "horizontalAlignment")) elm.horizontalAlignment = value;
						break;
					
					case Properties.HIGHLIGHT_OPACITY :
						switch(state) {
							case States.NONE :
								if (validProp(elm, "highlightOpacity")) {
									elm.highlightOpacity.up = elm.highlightOpacity.over =
									elm.highlightOpacity.down = elm.highlightOpacity.disabled = 
									 elm.highlightOpacity.selected = value;
								}
								break;
							case States.UP :
								if (validProp(elm, "highlightOpacity")) {
									elm.highlightOpacity.up = value;
								}
								break;
							case States.OVER :
								if (validProp(elm, "highlightOpacity")) {
									elm.highlightOpacity.over = value;
								}
								break;
							case States.DOWN :
								if (validProp(elm, "highlightOpacity")) {
									elm.highlightOpacity.down = value;
								}
								break;
							case States.DISABLED :
								if (validProp(elm, "highlightOpacity")) {
									elm.highlightOpacity.disabled = value;
								}
								break;
							case States.SELECTED :
								if (validProp(elm, "highlightOpacity")) {
									elm.highlightOpacity.selected = value;
								}
								break;
						}
						break;
					
					case Properties.HTML :
						if (validProp(elm, "html")) elm.html = eval("html", value);
						break;
					
					case Properties.ICON :
						if (validProp(elm, "setIcon")) elm.setIcon(value);
						break;
					
					case Properties.ICON_COLOR :
						setStateProp(elm, state, "iconColor", "iconColors", CSSGateway.fixColorValue(value));
						break;
					
					case Properties.INNER_PANEL :
						if (validProp(elm, "innerPanel")) elm.innerPanel = eval("innerPanel", value);
						break;
					
					case Properties.INNER_PANEL_COLOR :
						setColor(elm, "innerPanelColor", value);
						break;
					
					case Properties.WINDOW_OPACITY :
						if (validProp(elm, "windowOpacity")) elm.windowOpacity = value;
						break;
					
					/*case Properties.LAF_CLASS :
						if (elm is LafRenderer) {
							try { 
								var Laf:Class = getDefinitionByName(value) as Class;
								if(elm.getLaf() != Laf) elm.setLaf(Laf);
							}
							catch (e:Error) {
								throw new InvalidArgumentException("Invalid Look and Feel class name: " + value);
							}
						}
						break;*/
					
					case Properties.LAYOUT :
						if (elm is UIContainer) {
							try { 
								var Cl:Class = getDefinitionByName(value) as Class;
								elm.layout = new Cl();
							}
							catch (e:Error) { 
								throw new InvalidArgumentException(
									Locale.spas_internal::ERRORS.CSS_LAYOUT_CLASS_ERROR + value
								);
							}
						}
						break;
					
					case Properties.LAYOUT_ALIGNMENT :
						if (validProp(elm, "layout")) {
							var alignArr:Array = value.split(" ");
							var alignValue:String
							for each(alignValue in alignArr) {
								switch(alignValue) {
									case HorizontalAlignment.LEFT :
									case HorizontalAlignment.CENTER :
									case HorizontalAlignment.RIGHT :
										elm.layout.horizontalAlignment = alignValue;
										break;
									case VerticalAlignment.TOP :
									case VerticalAlignment.MIDDLE :
									case VerticalAlignment.BOTTOM :
										elm.layout.verticalAlignment = alignValue;
										break;
									default :
										throw new IllegalArgumentException(
											Locale.spas_internal::ERRORS.CSS_LAYOUT_ALIGNMENT_ERROR + value
										);
								}
							}
						}
						break;
					
					case Properties.LAYOUT_ORIENTATION :
						if (elm is UIContainer || elm is Application) {
							elm.layout.orientation = value;
						}
						break;
					
					case Properties.PADDING :
						if (validProp(elm, "padding")) elm.padding = value;
						break;
					
					case Properties.PADDING_BOTTOM :
						if (validProp(elm, "paddingBottom")) elm.paddingBottom = value;
						break;
					
					case Properties.PADDING_LEFT :
						if (validProp(elm, "paddingLeft")) elm.paddingLeft = value;
						break;
					
					case Properties.PADDING_RIGHT :
						if (validProp(elm, "paddingRight")) elm.paddingRight = value;
						break;
					
					case Properties.PADDING_TOP:
						if (validProp(elm, "paddingTop")) elm.paddingTop = value;
						break;
					
					case Properties.MARGIN :
						if (validProp(elm, "margin")) elm.margin = value;
						break;
					
					case Properties.MARGIN_BOTTOM :
						if (validProp(elm, "marginBottom")) elm.marginBottom = value;
						break;
					
					case Properties.MARGIN_LEFT :
						if (validProp(elm, "marginLeft")) elm.marginLeft = value;
						break;
					
					case Properties.MARGIN_RIGHT :
						if (validProp(elm, "marginRight")) elm.marginRight = value;
						break;
					
					case Properties.MARGIN_TOP :
						if (validProp(elm, "marginTop")) elm.marginTop = value;
						break;
					
					case Properties.OPACITY :
						elm.alpha = value;
						break;
					
					case Properties.ORIENTATION :
						if (validProp(elm, "orientation")) elm.orientation = value;
						break;
					
					case Properties.REFLECTION :
						if (validProp(elm, "reflection")) elm.reflection = eval("reflection", value);
						break;
					
					case Properties.SCROLLBAR_ARROW_COLOR :
						setColor(elm, "scrollbarArrowColor", value);
						break;
					
					case Properties.SCROLLBAR_BASE_COLOR :
						setColor(elm, "scrollbarBaseColor", value);
						break;
					
					case Properties.SCROLLBAR_FACE_COLOR :
						setColor(elm, "scrollbarFaceColor", value);
						break;
					
					case Properties.SCROLLBAR_HIGHLIGH_COLOR :
						setColor(elm, "scrollbarHighlightColor", value);
						break;
					
					case Properties.SCROLLBAR_SHADOW_COLOR :
						setColor(elm, "scrollbarShadowColor", value);
						break;
					
					case Properties.SCROLLBAR_TRACK_COLOR :
						setColor(elm, "scrollbarTrackColor", value);
						break;
					
					case Properties.SCROLLBAR_JOIN_COLOR :
						setColor(elm, "scrollbarJoinColor", value);
						break;
					
					case Properties.SCROLLBAR_INACTIVE_JOIN_COLOR :
						setColor(elm, "scrollbarInactiveJoinColor", value);
						break;
						
					case Properties.SCROLLBAR_INACTIVE_TRACK_COLOR :
						setColor(elm, "scrollbarInactiveTrackColor", value);
						break;
					
					case Properties.SHADOW :
						if (validProp(elm, "shadow")) elm.shadow = eval("shadow", value);
						break;
					
					case Properties.SIZE :
						if(validProp(elm, "autoAdjustSize")) elm.autoAdjustSize = false;
						if(!validProp(elm, "autoSize")) break;
						switch(value) {
							case "auto" :
								elm.autoSize = true;
								break;
							case "none" :
								elm.autoSize = false;
								elm.autoAdjustSize = true;
								break;
						}
						break;
											
					case Properties.SCROLL_POLICY :
						if (validProp(elm, "scrollPolicy")) elm.scrollPolicy = value;
						break;
					
					case Properties.TEXT_ALIGN :
						if (validProp(elm, "textAlign")) elm.textAlign = value;
						break;
					
					case Properties.TEXT_DECORATION :
						setStateProp(elm, state, "textDecoration", "textDecorations", value);
						break;
					
					case Properties.TEXT_TRANSFORM :
						if (validProp(elm, "textTransform")) elm.textTransform = value;
						break;
					
					case Properties.TEXTURE :
						if (validProp(elm, "texture")) value == "none" ? elm.texture = null : elm.texture = value;
						break;
					
					case Properties.VERTICAL_GAP :
						if (validProp(elm, "verticalGap")) elm.verticalGap = value;
						break;
					
					case Properties.VERTICAL_ALIGN :
						if (validProp(elm, "verticalAlignment")) elm.verticalAlignment = value; 
						break;
						
					case Properties.VISIBILITY :
						if(value == "hidden")  var flag:Boolean = false;
						else if(value == "visible") flag = true;
						if(elm.selector == Selectors.BODY) elm.bodyVisibility = flag;
						else elm.visible = flag;
						break;
					
					case Properties.WIDTH :
						if (validProp(elm, "autoAdjust")) elm.autoAdjust = false;
						var pwIndex:int = value.indexOf(PCT);
						if (pwIndex > -1 && validProp(elm, "percentWidth")) elm.percentWidth = value.slice(0, pwIndex);
						else {
							switch(value) {
								case "auto" :
									if (validProp(elm, "autoWidth")) elm.autoWidth = true;
									break;
								case "parent" :
									if (validProp(elm, "fixToParentWidth")) elm.fixToParentWidth = true;
									break;
								case "none" :
									if(validProp(elm, "autoWidth")) elm.autoWidth = false;
									if(validProp(elm, "fixToParentWidth")) elm.fixToParentWidth = false;
									if(validProp(elm, "autoAdjust")) elm.autoAdjust = true;
									break;
								default :
									if (validProp(elm, "autoWidth")) elm.autoWidth = false;
									if(validProp(elm, "fixToParentWidth")) elm.fixToParentWidth = false;
									elm.width = value;
							}
						}
						break;
					
					case Properties.BORDER_HIGHLIGHT_COLOR :
						setColor(elm, "borderHighlightColor", value);
						break;
					
					case Properties.BORDER_SHADOW_COLOR :
						setColor(elm, "borderShadowColor", value);
						break;
					
					default :
						if (validProp(elm, prop)) elm[prop] = value;
				}
			}
		}
		
		private function setRuleToElement(elm:*, name:String):void {
			var item:Object;
			var fullName:String;
			var l:int = _states.length-1;
			for (; l >=0; l--) {
				fullName = l == 0 ? name : name + ":" + _states[l];
				item = _rules[fullName];
				if(item != null) applyRule(elm, item.rule, _states[l]);
			}
		}
		
		private function validProp(element:*, property:String):Boolean {
			return element.hasOwnProperty(property);
		}
		
		private function setStateProp(elm:*, state:String, prop:String, stateProp:String, value:*):void {
			switch(state) {
				case States.NONE :
					if (validProp(elm, prop)) {
						elm[prop] = value;
					}
					break;
				case States.UP :
					if (validProp(elm, stateProp)) {
						elm[stateProp].up = value;
					}
					break;
				case States.OVER :
					if (validProp(elm, stateProp)) {
						elm[stateProp].over = value;
					}
					break;
				case States.DOWN :
					if (validProp(elm, stateProp)) {
						elm[stateProp].down = value;
					}
					break;
				case States.DISABLED :
					if (validProp(elm, stateProp)) {
						elm[stateProp].disabled = value;
					}
					break;
				case States.SELECTED :
					if (validProp(elm, stateProp)) {
						elm[stateProp].selected = value;
					}
					break;
			}
		}
		
		private function setColor(elm:*, prop:String, value:*):void {
			if(validProp(elm, prop)) {
				var c:* = CSSGateway.fixColorValue(value);
				elm[prop] = c;
			}
		}
		
		private function eval(prop:String, value:String):Boolean {
			if(value == "true") return true;
			else if (value == "false") return false;
			else {
				throw new IllegalArgumentException(Locale.spas_internal::ERRORS.CSS_BOOLEAN_ERROR + prop);
			}
			return false;
		}
	}
}