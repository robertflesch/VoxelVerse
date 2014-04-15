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
	// Calculator.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 14/03/2010 19:35
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.Canvas;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.CalculatorButton;
	import org.flashapi.swing.constants.DataFormat;
	import org.flashapi.swing.constants.StateObjectValue;
	import org.flashapi.swing.constants.TableFillType;
	import org.flashapi.swing.constants.TextAlign;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.layout.TableLayout;
	import org.flashapi.swing.math.RpnExp;
	import org.flashapi.swing.plaf.libs.CalculatorUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Calculator.png")]
	
	/**
	 * 	<img src="Calculator.png" alt="Calculator" width="18" height="18"/>
	 * 
	 * 	The <code>Calculator</code> class is an easy-to-use calculator that allows to
	 * 	perform four-function arithmetic operations. <code>Calculator</code> isnatnces
	 * 	have a simplified interface and small size.
	 * 
	 *  <p>The <code>Calculator</code> class provides storage variables functionalities
	 * 	for intermediate results wich are the same as the classic accumulator memory
	 * 	of pocket calculators.</p>
	 * 
	 * 	@see org.flashapi.swing.constants.CalculatorButton
	 * 
	 * 	@includeExample CalculatorExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Calculator extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>Calculator</code> instance.
		 */
		public function Calculator() {
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
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A constant value used by the <code>decimalSeparator</code> property.
		 */
		public static const POINT:String = ".";
		
		/**
		 * 	A constant value used by the <code>decimalSeparator</code> property.
		 */
		public static const COMMA:String = ",";
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 */
		override public function set cornerRadius(value:Number):void {
			spas_internal::lafDTO.cornerRadius = $cornerRadius =
			_panel.cornerRadius = value;
		}
		
		private var _decSymbol:String = Calculator.POINT;
		/**
		 * 	Sets or gets the decimal separator for the "decimal" button.
		 * 
		 * 	<p>The decimal separator is a symbol used to mark the boundary between
		 * 	the integral and the fractional parts of a decimal numeral. Terms implying 
		 * 	the symbol used are decimal point and decimal comma.</p>
		 * 
		 * 	<p>Possible values are <code>Calculator.POINT</code> or
		 * 	<code>Calculator.COMMA</code>.</p>
		 * 
		 * 	@default Calculator.POINT
		 */
		public function get decimalSeparator():String {
			return _decSymbol;
		}
		public function set decimalSeparator(value:String):void {
			_decSymbol = value;
		}
		
		private var _panel:Panel;
		/**
		 *  Returns a reference to the <code>Panel</code> instance that contains all
		 * 	controls, such as <code>Buttons</code> or <code>TextInputs</code>, used
		 * 	by this <code>Calculator</code> instance.
		 */
		public function get panel():Panel {
			return _panel;
		}
		
		/**
		 * @private
		 */
		override public function get width():Number {
			return _panel.width;
		}
		
		/**
		 * @private
		 */
		override public function get height():Number {
			return _panel.height;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>doActionByButtonName()</code> method enables to programmatically 
		 * 	act on a <code>Calculator</code> instance as if it was a user mouse action. 
		 * 	Setting the <code>buttonName</code>, parameter by using a
		 * 	<code>CalculatorButton</code> class constant, allows to simulate a user
		 * 	click on the corresponding button within the <code>Calculator</code>
		 * 	instance.
		 * 
		 * 	@param	buttonName	A <code>CalculatorButton</code> class constant.
		 * 
		 * 	@see org.flashapi.swing.constants.CalculatorButton
		 */
		public function doActionByButtonName(buttonName:String):void {
			var btn:Button = _panel.getElementByName(buttonName) as Button;
			setAction(btn);
		}
		
		/**
		 * @private
		 */
		override public function finalize():void {
			_firstLineCont.finalizeElements();
			_panel.finalizeElements();
			_panel.finalize();
			_btnStack = [];
			_btnStack = null;
			_resultView = null;
			_memView = null;
			_firstLineCont = null;
			_panel = null;
			super.finalize();
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
			move(x, y);
			_panel.display();
			refresh();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			var viewLaf:Class = lookAndFeel.getTextInputLaf();
			if (viewLaf == _resultView.getLaf()) return;
			_panel.invalidateLayout = true;
			fixButtonsLaf();
			fixPanelLaf();
			fixViewsLaf(viewLaf);
			_panel.invalidateLayout = false;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _isDecimal:Boolean = false;
		private var _isNewNumber:Boolean = true;
		private var _memory:Number = 0;
		
		private var _resultView:TextInput;
		private var _memView:TextInput;
		private var _resetBtnData:Array;
		private var _memBtnData:Array;
		private var _btnData:Array;
		private var _btnStack:Array = [];
		private var _btnWidth:Number = 35;
		private var _btnHeight:Number = 30;
		private var _firstLineCont:Canvas;
		
		//private var _operatorColorOut:uint = 0x444444;
		//private var _operandColorOut:uint = 0x222222;
		
		private var _rpnexp:RpnExp;
		private var _expression:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			initNum();
			createContainers();
			initArrays();
			createViews();
			initLaf(CalculatorUIRef);
			spas_internal::isInitialized(1);
		}
		
		private function fixViewsLaf(viewLaf:Class):void {
			_resultView.lockLaf(viewLaf, true);
			_memView.lockLaf(viewLaf, true);
		}
		
		private function fixPanelLaf():void {
			_panel.lockLaf(lookAndFeel.getPanelLaf(), true);
		}
		
		private function fixButtonsLaf():void {
			var l:int = _btnStack.length - 1;
			var btn:Button;
			var c:int;
			var btnLafRef:Class = lookAndFeel.getButtonLaf();
			var c1:uint = lookAndFeel.getOperatorColor();
			var c2:uint = lookAndFeel.getOperandColor();
			for (; l >= 0; l--) {
				btn = _btnStack[l];
				c = btn.type == 'operator' ? c1 : c2;
				if (c == -1) btn.fontColors.up = btn.fontColor = StateObjectValue.NONE;
				else btn.fontColors.up = btn.fontColor = c;
				btn.lockLaf(btnLafRef, true);
			}
		}
		
		private function shrowResult(result:String):void {
			_resultView.text = result;
			initNum();
		}
		
		private function initNum():void {
			_rpnexp = new RpnExp();
			_expression = "";
			_isNewNumber = true;
			_isDecimal = false;
		}
		
		private function createContainers():void {
			_panel = new Panel(250);
			_panel.target = spas_internal::uioSprite;
			_panel.autoHeight = true;
			_firstLineCont = new Canvas();
			_panel.verticalGap = _panel.horizontalGap = _firstLineCont.horizontalGap = 2;
			var w:Number = _btnWidth;
			var h:Number = _btnHeight;
			_panel.layout = new TableLayout([[w, TableFillType.FILL, w, w, w, w, w], [25, 10, h, 5, h, h, h, h]]);
			_firstLineCont.layout = new TableLayout([[2.5*w, w, w], [TableFillType.FILL]]);
		}
		
		private function createViews():void {
			_resultView = new TextInput("");
			_resultView.selectable = true;
			_resultView.textAlign = TextAlign.RIGHT;
			_resultView.text = "0";
			
			_memView = new TextInput("");
			_memView.backgroundAlpha = 0.25;
			_memView.borderStyle = BorderStyle.INSET;
			_memView.borderWidth = 1;
			_memView.textAlign = TextAlign.CENTER;
			_resultView.editable = _memView.selectable = _memView.editable = _memView.autoFocus = false;
			
			_panel.invalidateLayout = true;
			_panel.addElement(_resultView, DataFormat.GRAPHIC, "1,1,7,1");
			_panel.addElement(_memView, DataFormat.GRAPHIC, "1,3");
			createButtons(_panel, _memBtnData);
			createButtons(_panel, _btnData);
			_panel.addElement(_firstLineCont, DataFormat.GRAPHIC, "3,3,7,3")
			_panel.invalidateLayout = false;
			createButtons(_firstLineCont, [[CalculatorButton.BACKSPACE, "Backspace", "1,1", 0]]);
			createButtons(_firstLineCont, _resetBtnData);
		}
		
		private function initArrays():void {
			_resetBtnData = [
				[CalculatorButton.CE, "CE", "2,1", 0],
				[CalculatorButton.C, "C", "3,1", 0]
				];
			_memBtnData = [
				[CalculatorButton.MEMORY_CLEAR, "MC", "1,5", 0],
				[CalculatorButton.MEMORY_RECALL, "MR", "1,6", 0],
				[CalculatorButton.MEMORY_STORE, "MS", "1,7", 0],
				[CalculatorButton.MEMORY_PLUS, "M+", "1,8", 0]
				];
			_btnData = [
				[CalculatorButton.SEVEN, "7", "3,5", 1],
				[CalculatorButton.EIGHT, "8", "4,5", 1],
				[CalculatorButton.NINE, "9", "5,5", 1],
				[CalculatorButton.DIVIDE, "/", "6,5", 0],
				[CalculatorButton.SQRT, "Sqrt", "7,5", 1],
				[CalculatorButton.FOUR, "4", "3,6", 1],
				[CalculatorButton.FIVE, "5", "4,6", 1],
				[CalculatorButton.SIX, "6", "5,6", 1],
				[CalculatorButton.MULTIPLY, "*", "6,6", 0],
				[CalculatorButton.PERCENT, "%", "7,6", 1],
				[CalculatorButton.ONE, "1", "3,7", 1],
				[CalculatorButton.TWO, "2", "4,7", 1],
				[CalculatorButton.THREE, "3", "5,7", 1],
				[CalculatorButton.MINUS, "-", "6,7", 0],
				[CalculatorButton.INVERSE, "1/x", "7,7", 1],
				[CalculatorButton.ZERO, "0", "3,8", 1],
				[CalculatorButton.PLUS_MINUS, "+/-", "4,8", 1],
				[CalculatorButton.DECIMAL, _decSymbol, "5,8", 1],
				[CalculatorButton.PLUS, "+", "6,8", 0],
				[CalculatorButton.EQUAL, "=", "7,8", 0]
				];
		}
		
		private function createButtons(c:UIContainer, arr:Array):void {
			var l:int = arr.length;
			var i:uint = 0;
			var btn:Button;
			for (; i < l; i++) {
				btn = new Button(arr[i][1]);
				btn.name = arr[i][0];
				if (arr[i][0] != CalculatorButton.BACKSPACE) btn.paddingLeft = btn.paddingRight = 0;
				else btn.paddingLeft = btn.paddingRight = 10;
				btn.spas_internal::setType(arr[i][3] == 0 ? 'operator' : 'operand');
				$evtColl.addEvent(btn, UIMouseEvent.CLICK, buttonActionHandler);
				$evtColl.addEvent(btn, UIMouseEvent.ROLL_OVER, refreshReflection);
				$evtColl.addEvent(btn, UIMouseEvent.ROLL_OUT, refreshReflection);
				c.addElement(btn, DataFormat.GRAPHIC, arr[i][2]);
				_btnStack.push(btn);
			}
		}
		
		private function refreshReflection(e:UIMouseEvent):void {
			doReflection();
		}
		
		private function buttonActionHandler(e:UIMouseEvent):void {
			setAction(e.target as Button);
		}
		
		private function setAction(btn:Button):void {
			var lab:String = _resultView.text;
			switch(btn.name) {
				case CalculatorButton.ZERO :
				case CalculatorButton.ONE :
				case CalculatorButton.TWO :
				case CalculatorButton.THREE :
				case CalculatorButton.FOUR :
				case CalculatorButton.FIVE :
				case CalculatorButton.SIX :
				case CalculatorButton.SEVEN :
				case CalculatorButton.EIGHT :
				case CalculatorButton.NINE :
					if (_isNewNumber) {
						_isNewNumber = false;
						_resultView.text = btn.label;
					} else _resultView.text = lab + btn.label;
					break;
				case CalculatorButton.DECIMAL :
					if (!_isDecimal) {
						_isDecimal = true;
						_resultView.text += _decSymbol;
						}
					break;
				case CalculatorButton.CE :
					_expression = "";
					shrowResult("0");
					break;
				case CalculatorButton.C :
					shrowResult("0");
					break;
				case CalculatorButton.BACKSPACE :
					if (lab == "0" && _isNewNumber) break;
					if (lab.charAt(lab.length - 2) == _decSymbol)  {
						lab = lab.substr(0, lab.length - 2);
						_isDecimal = false;
					} else lab = lab.substr(0, lab.length-1);
					if (lab == "") {
						lab = "0";
						initNum();
					}
					_resultView.text = lab;
					break;
				case CalculatorButton.MEMORY_CLEAR :
					_memory = 0;
					_memView.text = "";
					_isNewNumber = true;
					break;
				case CalculatorButton.MEMORY_RECALL :
					_resultView.text = String(_memory);
					_isNewNumber = true;
					break;
				case CalculatorButton.MEMORY_STORE :
					_memory = parseFloat(lab);
					if (lab != "0") _memView.text = "M";
					_isNewNumber = true;
					break;
				case CalculatorButton.MEMORY_PLUS :
					_memory += parseFloat(lab);
					if (lab != "0") _memView.text = "M";
					_isNewNumber = true;
					break;
				case CalculatorButton.EQUAL :
					calculate();
					break;
				case CalculatorButton.PLUS :
					setOperator("+");
					break;
				case CalculatorButton.MINUS :
					setOperator("-");
					break;
				case CalculatorButton.MULTIPLY :
					setOperator("*");
					break;
				case CalculatorButton.DIVIDE :
					setOperator("/");
					break;
				case CalculatorButton.SQRT :
					shrowResult(getResult("sqrt(" + lab + ")"));
					break;
				case CalculatorButton.INVERSE :
					shrowResult(String(1 / Number(lab)));
					break;
				case CalculatorButton.PLUS_MINUS :
					if (lab != "0") {
						_resultView.text = (lab.charAt(0) == "-") ?
							lab.substr(1, lab.length) : "-" + lab;
					}
					break;
				case CalculatorButton.PERCENT :
					_expression += lab + "/100";
					_resultView.text = getResult(_expression);
					_isNewNumber = true;
					break;
			}
			doReflection();
		}
		
		/*private function fixDecimalSymbol():void {
			if(_resultView.text.indexOf(_decSymbol) == -1) _resultView.text += _decSymbol;
		}*/
		
		private function setOperator(op:String):void {
			setExp(op);
			initNum();
		}
		
		private function calculate():void {
			setExp();
			shrowResult(getResult(_expression));
		}
		
		private function setExp(op:String = ""):void {
			_expression += _resultView.text + op;
		}
		
		private function getResult(exp:String):String {
			return String(_rpnexp.exec(exp));
		}
	}
}