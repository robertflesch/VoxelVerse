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

////////////////////////////////////////////////////////////////////////////////
//
//	AS3 Syntax Highlighting Example By Dean North - 23/01/07
//	Atlas Computer Systems Ltd - www.atlascs.co.uk
//	Project page: http://www.atlascs.co.uk/Default.aspx?tabid=63&EntryID=2
//
////////////////////////////////////////////////////////////////////////////////

package org.flashapi.swing.text {
	
	// -----------------------------------------------------------
	// AS3Highlighter.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @author Dean NORTH
	* @version 1.0.0, 09/11/2008 18:32
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.flashapi.swing.constants.WebFonts;
	
	/**
	 * 	The <code>AS3Highlighter</code> class defines syntax highlighting objects
	 * 	that display ActionScript 3.0 text source codes in different colors and
	 * 	fonts according to the category of terms. These include keywords, comments,
	 * 	hexadecimal values, and other elements.
	 * 
	 * 	<p>Each <code>AS3Highlighter</code> object is associated with a unique
	 * 	<code>TextField</code> instance. Highlight colors can be changed by
	 * 	using specific color properties defined by the <code>AS3Highlighter</code> 
	 * 	class. You also can add custom keywords to be colorized.</p>
	 * 
	 *  @includeExample AS3HighlighterExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AS3Highlighter {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new ActionScript 3.0 highlighter object associated
		 * 	with the <code>TextField</code> specified by the <code>target</code> parameter.
		 *
		 * @param	target	A unique <code>TextField</code> instance associated with
		 * 					this <code>AS3Highlighter</code> object.
		 */
		public function AS3Highlighter(target:TextField) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public static properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An integer that represents the color used to render AS3 keywords.
		 * 
		 * 	@default 0x0000FF
		 */
		public static var keywordColor:uint = 0x0000FF;
		
		/**
		 * 	An integer that represents the color used to render AS3 objects.
		 * 
		 * 	@default 0x009999
		 */
		public static var systemObjectColor:uint = 0x009999;
		
		/**
		 * 	An integer that represents the color used to render AS3 AsDoc keywords.
		 * 
		 * 	@default 0x990000
		 */
		public static var docKeywordColors:uint = 0x990000;
		
		/**
		 * 	An integer that represents the color used to render brackets.
		 * 
		 * 	@default 0x000000
		 */
		public static var bracketColor:uint = 0x000000;
		
		/**
		 * 	An integer that represents the color used to render strings.
		 * 
		 * 	@default 0x009900
		 */
		public static var stringColor:uint = 0x009900;
		
		/**
		 * 	An integer that represents the color used to render comments.
		 * 
		 * 	@default 0x666666
		 */
		public static var commentColor:uint = 0x666666;
		
		/**
		 * 	An integer that represents the color used to render hexadecimal values.
		 * 
		 * 	@default 0xFF00FF
		 */
		public static var hexadecimalColor:uint = 0xFF00FF;
		
		/**
		 * 	An integer that represents the default color used to render AS3 code.
		 * 
		 * 	@default 0x000000
		 */
		public static var defaultColor:uint = 0x000000;
		
		/**
		 * 	An integer that represents the color used to render custom objects.
		 * 
		 * 	@default 0xFF6600
		 */
		public static var customObjectColor:uint = 0xFF6600;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _target:TextField;
		/**
		 * 	Returns a reference to the unique <code>TextField</code> instance associated
		 * 	with this <code>AS3Highlighter</code> object.
		 */
		public function get target():TextField { return _target; }
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Displays the targeted ActionScript 3.0 source code in different colors
		 * 	according to the category of terms. 
		 */
		public function render():void {
			_target.setTextFormat(_format);
			var hasMultilineComments:Boolean = false;
			var i:uint = 0;
			for (; i < _target.numLines; i++) {
				if(hasMultilineComments){
					_target.setTextFormat(_format, _target.getLineOffset(i), _target.getLineOffset(i) + _target.getLineText(i).length);
					hasMultilineComments = !parseExpression(END_MULTILINE_QUOTE_EXP, commentColor, i, false);
				} else {
					parseExpression(KEYWORDS_EXP, keywordColor, i, true);
					if (_customObjects != null) parseExpression(_customObjectsExp, customObjectColor, i, false);
					//parseExpression(_SYSTEM_OBJECTS_EXP, systemObjectColor, i, true);
					parseExpression(HEXA_VALUE_EXP, hexadecimalColor, i, false);
					parseExpression(BRACKETS_EXP, bracketColor, i, false);
					parseExpression(SINGLE_QUOTE_EXP, stringColor, i, false);
					parseExpression(DOUBLE_QUOTE_EXP, stringColor, i, false);
					parseExpression(COMMENTS_EXP, commentColor, i, false, true);
					hasMultilineComments = parseExpression(START_MULTILINE_QUOTE_EXP, commentColor, i, false, true);
					if (hasMultilineComments) hasMultilineComments = !parseExpression(END_MULTILINE_QUOTE_EXP, commentColor, i, false, true);
					parseExpression(DOC_KEYWORDS_EXP, docKeywordColors, i, true);
				}
			}
		}
		
		/**
		 * 	[Not yet available.]
		 * 
		 * 	@param	tag
		 */
		public function renderHTMLTag(tag:String = "code"):void { }
		
		/**
		 * 	Sets all colors used to render the code in the targeted <code>TextField</code>
		 * 	instance.
		 * 
		 * 	@param	defaultColor	The default color used to render AS3 code.
		 * 	@param	keywordColor	The color used to render AS3 keywords.
		 * 	@param	bracketColor	The color used to render AS3 brackets.
		 * 	@param	stringColor		The color used to render AS3 stringss.
		 * 	@param	hexadecimalColor	The color used to render AS3 hexadecimal values.
		 * 	@param	commentColor	Thecolor used to render AS3 comments.
		 * 	@param	docKeywordColors	The color used to render AS3 AsDoc keywords.
		 * 	@param	systemObjectColor	The color used to render AS3 objects.
		 * 	@param	customObjectColor	The color used to render user defined objects.
		 */
		public function setFormatColors(defaultColor:uint = 0x000000, keywordColor:uint = 0x0000FF, bracketColor:uint = 0x000000, stringColor:uint = 0x009900, hexadecimalColor:uint = 0xFF00FF, commentColor:uint = 0x666666, docKeywordColors:uint = 0x990000, systemObjectColor:uint = 0xFF0000, customObjectColor:uint = 0xFF0000):void {
			AS3Highlighter.defaultColor = defaultColor, AS3Highlighter.keywordColor = keywordColor, AS3Highlighter.bracketColor = bracketColor,
			AS3Highlighter.stringColor = stringColor, AS3Highlighter.hexadecimalColor = hexadecimalColor, AS3Highlighter.commentColor = commentColor,
			AS3Highlighter.systemObjectColor = systemObjectColor, AS3Highlighter.customObjectColor = customObjectColor;
			AS3Highlighter.docKeywordColors = docKeywordColors;
		}
		
		/**
		 * 	Adds custom keywords to extend the syntax highlight parsing capabilities.
		 * 	You can add only one keyword, or any keywords as you want, at the one time.
		 * 	If you want to insert multiple keywords, you can use the <code>|</code> (pipe)
		 * 	delimiter to separate them (e.g. <code>myHighlight.addCustomObjects("KeyWord1|KeyWord2");</code>).
		 * 
		 * 	<p>If you pass <code>null</code> to the <code>value</code> parameter,
		 * 	all extended parsing capabilities already registred with the
		 * 	<code>addCustomObjects()</code> method will be removed.</p>
		 * 
		 * 	@param	value	A string that represents the custom keywords added to extend
		 * 					the syntax highlighting parsing capabilities of this
		 * 					<code>AS3Highlighter</code> object.
		 */
		public static function addCustomObjects(value:String):void {
			if (value != null) {
				_customObjects == null ? _customObjects = value : _customObjects += ("|" + value);
				_customObjectsExp = OBJ_START_EXP + _customObjects + OBJ_END_EXP;
			}
			else _customObjects = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private static properties
		//
		//--------------------------------------------------------------------------
		
		private static const AS3_KEYWORDS:String = "addEventListener|align|ArgumentError|arguments|Array|as|AS3|Boolean|break|case|catch|class|Class|const|continue|data|Date|decodeURI|decodeURIComponent|default|DefinitionError|delete|do|dynamic|each|else|encodeURI|encodeURIComponent|Error|escape|EvalError|extends|false|finally|flash_proxy|for|function|get|getLineOffset|height|if|implements|import|in|include|index|Infinity|instanceof|interface|internal|intrinsic|is|isFinite|isNaN|isXMLName|label|load|namespace|NaN|native|new|null|Null|object_proxy|override|package|parseFloat|parseInt|private|protected|public|return|set|static|super|switch|this|throw|trace|true|try|typeof|undefined|unescape|use|var|void|while|with|Accessibility|AccessibilityProperties|ActionScriptVersion|ActivityEvent|AntiAliasType|ApplicationDomain|AsyncErrorEvent|AVM1Movie|BevelFilter|Bitmap|BitmapData|BitmapDataChannel|BitmapFilter|BitmapFilterQuality|BitmapFilterType|BlendMode|BlurFilter|ByteArray|Camera|Capabilities|CapsStyle|ColorMatrixFilter|ColorTransform|ContextMenu|ContextMenuBuiltInItems|ContextMenuEvent|ContextMenuItem|ConvolutionFilter|CSMSettings|DataEvent|Dictionary|DisplacementMapFilter|DisplacementMapFilterMode|DisplayObject|DisplayObjectContainer|DropShadowFilter|Endian|EOFError|ErrorEvent|Event|EventDispatcher|EventPhase|ExternalInterface|FileFilter|FileReference|FileReferenceList|FocusEvent|Font|FontStyle|FontType|FrameLabel|Function|GlowFilter|GradientBevelFilter|GradientGlowFilter|GradientType|Graphics|GridFitType|HTTPStatusEvent|IBitmapDrawable|ID3Info|IDataInput|IDataOutput|IDynamicPropertyOutput|IDynamicPropertyWriter|IEventDispatcher|IExternalizable||IllegalOperationError|IME|IMEConversionMode|IMEEvent|int|InteractiveObject|InterpolationMethod|InvalidSWFError|IOError|IOErrorEvent|JointStyle|Keyboard|KeyboardEvent|KeyLocation|LineScaleMode|Loader|LoaderContext|LoaderInfo|LocalConnection|Math|Matrix|MemoryError|Microphone|MorphShape|Mouse|MouseEvent|MovieClip|Namespace|NetConnection|NetStatusEvent|NetStream|Number|Object|ObjectEncoding|PixelSnapping|Point|PrintJob|PrintJobOptions|PrintJobOrientation|ProgressEvent|Proxy|QName|RangeError|Rectangle|ReferenceError|RegExp|resize|result|Responder|scaleMode|Scene|ScriptTimeoutError|Security|SecurityDomain|SecurityError|SecurityErrorEvent|SecurityPanel|setTextFormat|Shape|SharedObject|SharedObjectFlushStatus|SimpleButton|Socket|Sound|SoundChannel|SoundLoaderContext|SoundMixer|SoundTransform|SpreadMethod|Sprite|StackOverflowError|Stage|stageHeight|stageWidth|StageAlign|StageQuality|StageScaleMode|StaticText|StatusEvent|String|StyleSheet|SWFVersion|SyncEvent|SyntaxError|System|text|TextColorType|TextDisplayMode|TextEvent|TextField|TextFieldAutoSize|TextFieldType|TextFormat|TextFormatAlign|TextLineMetrics|TextRenderer|TextSnapshot|Timer|TimerEvent|Transform|true|TypeError|uint|URIError|URLLoader|URLLoaderDataFormat|URLRequest|URLRequestHeader|URLRequestMethod|URLStream|URLVariables|VerifyError|Video|width|XML|XMLDocument|XMLList|XMLNode|XMLNodeType|XMLSocket";
		//private static const FLASH_PROPS:String = "initialize|display|color|shadow";
		private static const DOC_KEYWORDS:String = "@param|@default|@private|@inheritDoc";
		private static const SINGLE_QUOTE_EXP:String = "\'.*\'";
		private static const DOUBLE_QUOTE_EXP:String = "\".*\"";
		private static const START_MULTILINE_QUOTE_EXP:String = "/\\*.*";
		private static const END_MULTILINE_QUOTE_EXP:String = "\\*/.*";
		private static const KEYWORDS_EXP:String = OBJ_START_EXP + AS3_KEYWORDS + OBJ_END_EXP;
		//private static const SYSTEM_OBJECTS_EXP:String = OBJ_START_EXP + _FLASH_PROPS + OBJ_END_EXP;
		private static const DOC_KEYWORDS_EXP:String = OBJ_START_EXP + DOC_KEYWORDS + OBJ_END_EXP;
		private static const COMMENTS_EXP:String = "//.*";
		private static const BRACKETS_EXP:String = "(\\{|\\[|\\(|\\}|\\]|\\))";
		private static const HEXA_VALUE_EXP:String = "0x[0-9a-fA-f]{6,8}";
		private static const OBJ_START_EXP:String = "(\\b)(";
		private static const OBJ_END_EXP:String = "){1}(\\.|(\\s)+|;|,|\\(|\\)|\\]|\\[|\\{|\\}){1}";
		
		private static var _format:TextFormat =
			new TextFormat(WebFonts.COURIER_NEW, 12, AS3Highlighter.defaultColor);
		private static var _customObjects:String = null;
		private static var _customObjectsExp:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _pattern:RegExp;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:TextField):void {
			_target = target;
		}
		
		private function parseExpression(exp:String, color:uint, lineNum:Number, trim:Boolean, dontSearchStrings:Boolean = false):Boolean {
			_pattern = new RegExp(exp, "g");
			var result:Object = _pattern.exec(_target.getLineText(lineNum));
			if (result == null) return false;
			var isInString:Boolean = false;
			var lastIndex:int;
			var i:int;
			while (result != null) {
				if(dontSearchStrings){
					isInString = false;
					isInString = (checkInString(result, SINGLE_QUOTE_EXP, lineNum) == true);
					isInString = (checkInString(result, DOUBLE_QUOTE_EXP, lineNum) == true);
					if (isInString) return false;
				}
				i = _target.getLineOffset(lineNum) + result.index;
				lastIndex = trim ? i + result[0].length - 1 : i + result[0].length;
				_format.color = color;
				_target.setTextFormat(_format, i, lastIndex);
				result = _pattern.exec(_target.getLineText(lineNum));
				
			}
			return true;
		}

		private function checkInString(result:Object, exp:String, lineNum:Number):Boolean {
			var p:RegExp = new RegExp(exp, "g");
			var textLine:String = _target.getLineText(lineNum);
			var stringResult:Object = p.exec(textLine);
			var isInString:Boolean = false;
			while (stringResult != null) {
				if(result.index > stringResult.index && result.index < stringResult.index + stringResult[0].length) isInString = true;
				stringResult = p.exec(textLine);
			}
			return isInString;
		}
	}
}