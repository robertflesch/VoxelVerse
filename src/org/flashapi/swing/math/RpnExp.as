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

package org.flashapi.swing.math {
	
	// -----------------------------------------------------------
	// RpnExp.as
	// -----------------------------------------------------------
	
	/**
	* @author	Barbichette (Delphi) http://www.delphifr.com//code.aspx?ID=45846
	* @author	Raffour (AS2) http://www.flashkod.com//code.aspx?ID=46406
	* @author	Pascal ECHEMANN (AS3)
	* @version	beta 1.7, 27/02/2011 19:14
	* @see		http://www.flashapi.org/
	*/
	
	import flash.utils.Dictionary;
	import org.flashapi.swing.math.rpn.PostFixItem;
	import org.flashapi.swing.math.rpn.rpn_internal;
	import org.flashapi.swing.math.rpn.RpnConstant;
	import org.flashapi.swing.math.rpn.RpnException;
	import org.flashapi.swing.math.rpn.RpnOperator;
	import org.flashapi.swing.math.rpnlib.Algebra;
	import org.flashapi.swing.math.rpnlib.RpnLibrary;
	
	use namespace rpn_internal;
	
	/**
	 * 	The <code>RpnExp</code> class lets you work with literal string representing
	 * 	a mathematical expression. These mathematical expressions are evaluated using
	 * 	a "Reverse Polish Notation" engine.
	 * 
	 * 	<p><img src="../../../../images/rpnexp.jpg" alt="RpnExp Project" /></p>
	 * 
	 * 	<p>For more information, see the <a href="http://en.wikipedia.org/wiki/Reverse_Polish_notation">
	 * 	"Reverse Polish notation"</a> article on Wikipedia.</p>
	 * 
	 * 	@example 	<p>The following code creates a new instance of the <code>RpnExp</code>
	 * 				class and calculates the area of a circle wich radius is <code>3</code>
	 * 				units, and its circumference:
	 * 				<listing version="3.0">
	 * 					var exp:RpnExp = new RpnExp();
	 * 					var area:Number = exp.exec("pi &#42; 3&#94; 2");
	 * 					var circum:Number = exp.exec("2 &#42; pi &#42; 3");
	 * 					trace(area); &#47;&#47; 28.274333882308138
	 * 					trace(circum); &#47;&#47; 18.84955592153876
	 * 				</listing>
	 * 				</p>
	 * 
	 * 	<p>The <code>RpnExp</code> class uses the <code>Algebra</code> class as default
	 * 	library, to perform several mathematical expressions calculation.
	 * 	To extend the <code>RpnExp</code> class capabilities, you can use
	 * 	any library classes from the <a href="rpnlib/package-detail.html">org.flashapi.swing.math.rpnlib</a>
	 * 	package, or create your own library classes.</p>
	 * 
	 * 	@see org.flashapi.swing.math.rpnlib.Algebra
	 * 	@see org.flashapi.swing.math.rpnlib.RpnLibrary
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RpnExp {
		
		//TODO: implement localization.
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>RpnExp</code> instance. The <code>RpnExp</code>
		 * 	class uses the <code>RpnStandardLibrary</code> as default library.
		 * 
		 * 	@param	exp	A string representing a mathematical expression to be evaluated
		 * 				by the <code>RpnExp</code> object.
		 */
		public function RpnExp(exp:String = "") {
			super();
			initObj(exp);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _errorMode:Boolean = true;
		/**
		 * 	Specifies whether the <code>RpnExp</code> object ignores error messages
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get errorMode():Boolean {
			return _errorMode;
		}
		public function set errorMode(value:Boolean):void {
			_errorMode = value;
		}
		
		private var _expression:String;
		/**
		 * 	Sets or gets the string representing a mathematical expression to be
		 * 	evaluated by the <code>test()</code> or <code>exec()</code> methods.
		 * 
		 * 	@see #test()
		 * 	@see #exec()
		 */
		public function get expression():String {
			return _expression;
		}
		public function set expression(value:String):void {
			_expression = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a mathematical functions library object to extend the <code>RpnExp</code>
		 * 	class calculation capabilities. 
		 * 	<p><strong>Note: </strong> the <code>RpnExp</code> class uses the
		 * 	<code>RpnStandardLibrary</code> class as default library to perform basic
		 * 	calculations.</p>
		 * 	
		 * 	@param	library	A <code>RpnLibrary</code> object used to add new calculation
		 * 					capabilities.
		 * 
		 * 	@see #addLibraryClass()
		 * 	@see org.flashapi.swing.math.rpn.RpnLibrary
		 * 	@see org.flashapi.swing.math.rpn.RpnStandardLibrary
		 */
		public function addLibrary(library:RpnLibrary):void {
			addRpnLibrary(library);
		}
		
		/**
		 * 	Adds a mathematical functions library class to extend the <code>RpnExp</code>
		 * 	class calculation capabilities.
		 * 
		 * 	<p><strong>Note: </strong> the <code>RpnExp</code> class uses the
		 * 	<code>RpnStandardLibrary</code> class as default library to perform basic
		 * 	calculations.</p>
		 * 	
		 * 	@param	library	A class reference used to add new calculation capabilities.
		 * 
		 * 	@return	A new <code>RpnLibrary</code> instance instantiated from the
		 * 			<code>library</code> parameter.
		 * 
		 * 	@see #addLibrary()
		 * 	@see org.flashapi.swing.math.rpn.RpnLibrary
		 * 	@see org.flashapi.swing.math.rpn.RpnStandardLibrary
		 */
		public function addLibraryClass(library:Class):RpnLibrary {
			var lib:RpnLibrary = new library() as RpnLibrary;
			//InterfaceValidator.validate(lib, "org.flashapi.swing.math.rpnlib::RpnLibrary", "is not a RpnLibrary object."
			return addRpnLibrary(lib);
		}
		
		/**
		 * 	Test if the string representing a mathematical expression is valid.
		 * 
		 * 	@param	exp	The mathematical expression to test.
		 * 
		 * 	@return	The result of the test represented by the <code>exp</code>
		 * 			parameter, or the <code>expression</code> property; 
		 * 			<code>true</code> if the string mathematical expression is
		 * 			valid; <code>false</code> otherwise.
		 * 
		 * 	@see #expression
		 */
		public function test(exp:String = null):Boolean {
			if (exp != null) _expression = exp;
			if (_expression == "") return true;
			else return tokenize();
		}
		
		/**
		 * 	Evaluates a string representing a mathematical expression and returns
		 * 	the result.
		 * 
		 * 	@param	exp	A string representing a mathematical expression to be
		 * 				evaluated by the <code>RpnExp</code> instance.
		 * 
		 * 	@return	The result of the calculation represented by the <code>exp</code>
		 * 			parameter, or the <code>expression</code> property;
		 * 			<code>NaN</code> if the string mathematical expression is not valid.
		 * 
		 * 	@see #expression
		 */
		public function exec(exp:String = null):* {
			if (exp != null) _expression = exp;
			return tokenize() ? eval() : NaN;
		}
		
		//--------------------------------------------------------------------------
		//
		//  RPN package internal functions
		//
		//--------------------------------------------------------------------------
		
		private var _expStack:Array;
		/**
		 * 	@internal
		 * 
		 * 	Returns a reference to the internal stack used by the Reverse Polish Notation
		 * 	engine.
		 * 
		 * 	@see	http://en.wikipedia.org/wiki/Reverse_Polish_notation
		 */
		rpn_internal function get stack():Array {
			return _expStack;
		}
		
		private var _exp:String;
		/**
		 * 	Returns a reference to the internal expression used by the Reverse Polish
		 * 	Notation engine.
		 * 
		 * 	@see	http://en.wikipedia.org/wiki/Reverse_Polish_notation
		 */
		rpn_internal function get parsedExp():String {
			return _exp;
		}
		rpn_internal function set parsedExp(value:String):void {
			_exp = value;
		}
		
		/**
		 * 	The <code>setError()</code> method allows developers to deal with the 
		 * 	error mode when they creates new mathematical functions libraries.
		 * 
		 * 	@param	value	A positive integer that represent a <code>RpnException</code>
		 * 					error, or a string that represent custom error message.
		 * 
		 * 	@see	#errorMode
		 * 	@see 	org.flashapi.swing.math.rpn.RpnException
		 */
		rpn_internal function setError(value:*):void {
			getError(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _operatorList:Dictionary;
		private var _specialSymbols:Dictionary;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(exp:String):void {
			_operatorList = new Dictionary(true);
			_specialSymbols = new Dictionary(true);
			addLibraryClass(Algebra);
			_expression = exp;
		}
		
		private function tokenize():Boolean {
			if (!checkExp()) return false;
			_expStack = [];
			var len:int;
			var i:int = 0;
			var j:int;
			var lBr:String = '({[';
			var rBr:String = ')}]';
			var lr:String = 'abcdefghijklmnopqrstuvwxyz';
			var ln:String = 'abcdefghijklmnopqrstuvwxyz0123456789_!';
			var num:String = '0123456789.';
			var pp:String = '/*^%';
			var str:String;
			var bracketNum:int = 0;
			var op:RpnOperator;
			while (i < _exp.length) {
				len = _exp.length;
				switch(true) {
					//---> white space:
					case (_exp.charAt(i) == " ") :
						++i;
						break;
					//---> left bracket:
					case (lBr.indexOf(_exp.charAt(i)) > -1) :
						addToStack(0, "", RpnConstant.LEFT_BRACKET);
						i++;
						bracketNum++;
						break;
					//---> right bracket:
					case (rBr.indexOf(_exp.charAt(i)) > -1) :
						addToStack(0, "", RpnConstant.RIGHT_BRACKET);
						i++;
						bracketNum--;
						break;
					//---> letter:
					case (lr.indexOf(_exp.charAt(i)) > -1) :
						str = '';
						for (j = i; j <= len; j++){
							if (ln.indexOf (_exp.charAt(j)) > -1) str += _exp.charAt(j);
							else  break;
						}
						i = j;
						op = getOperator(str);
						if (op == null) return false;
						if (op.parsingFunction != null) {
							op.tokenId = i;
							var errorFlag:* = op.parsingFunction(_exp);
							if (errorFlag != null) return getError(errorFlag);
							i = op.tokenId;
						} else {
							if (op.notation != "") addToStack(0, op.notation, RpnConstant.FUNCTION);
							else addToStack(0, "", RpnConstant.VARIABLE);
						}
						break;
					//---> number:
					case ((num + ",").indexOf(_exp.charAt(i)) > -1) :
						str = '';
						for (j = i; j <= len; j++) {
							if (num.indexOf (_exp.charAt(j)) > -1) str = str + _exp.charAt(j);
							else if (_exp.charAt(j) == ',') str += '.';
							else break;
						}
						i = j;
						var v:Number = Number(str);
						if (isNaN(v)) return getError(5);
						addToStack(v, "" , RpnConstant.VALUE);
						break;
					//---> separator:
					case (_exp.charAt(i) == ";") :
						addToStack(0, "", RpnConstant.SEPARATOR);
						i++;
						break;
					//---> minus or plus:
					case (_exp.charAt(i) == "-" || _exp.charAt(i) == "+" ) :
						if (i == 0) addToStack(0, "", RpnConstant.VALUE);
						else if(i == len-1) return getError(8);
						addToStack(0, _exp.charAt(i), RpnConstant.OPERATOR);
						i++;
						break;
					//---> mult, div, mod or ^:
					case (pp.indexOf(_exp.charAt(i)) > -1) :
						addToStack(0, _exp.charAt(i), RpnConstant.OPERATOR);
						i++;
						break;
					//---> unknown or special characters:
					default :
						str = _exp.charAt(i);
						if (_specialSymbols[str]) {
							op = getOperator(_specialSymbols[str]);
							if (op == null) return false;
							if (op.parsingFunction != null) {
								op.tokenId = i;
								errorFlag = op.parsingFunction(_exp);
								if (errorFlag != null) return getError(errorFlag);
								i = op.tokenId;
							} else {
								if (op.notation != "") addToStack(0, op.notation, RpnConstant.FUNCTION);
								else addToStack(0, "", RpnConstant.VARIABLE);
							}
							i++;
						} else return getError(1);
				}
				
			}
			if (bracketNum > 0) return getError(6);
			return writeRpn();
		}
		
		private function checkExp():Boolean {
			//_exp = _expression.toLowerCase();
			_exp = _expression;
			//var re:RegExp = /\s/g;
			//_exp = _exp.replace(re, "");
			var re:RegExp = /\+\*|\-\*|\*\\|\\\*/x;
			if (re.test(_exp)) return getError(7);
			re = /\+\+|\-\-/gx;
			_exp = _exp.replace(re, "+");
			re = /\+\-|\-\+/gx;
			_exp = _exp.replace(re, "-");
			re = /$^\/|$^\*|$^\^|$^%/x;
			if (re.test(_exp)) return getError(8);
			return true;
		}
		
		private function addToStack(val:Number, op:String, tpe:String):void {
			var token:PostFixItem = new PostFixItem(val, op, tpe);
			_expStack.push(token);
		}
		
		private function getError(value:*):Boolean {
			if (_errorMode) throw new RpnException(value);
			return false;
		}
		
		private function getOperator(exp:String):RpnOperator {
			if (_operatorList[exp] == null) {
				getError(1);
				return _operatorList["null"];
			}
			return _operatorList[exp];
		}
		
		private function writeRpn():Boolean {
			var result:Array = [];
			var stack:Array = [];
			var token:PostFixItem;
			var op:RpnOperator;
			var i:int = 0;
			for (; i < _expStack.length; i++) {
				token = _expStack[i];
				switch (token.type) {
					case RpnConstant.VALUE :
					case RpnConstant.STRING :
					case RpnConstant.VARIABLE :
						result.push(token);
						break;
					case RpnConstant.FUNCTION :
						op = _specialSymbols[token.operator] != undefined ?
							getOperator(_specialSymbols[token.operator]) : getOperator(token.operator);
						//--> We consider that if there are no operands, that function
						// returns a constant value, or has it own internal parsing process.
						// These kind of functions must be considered by the stack as if
						// they were type of VALUE.
						op.operandNum == 0 ? result.push(token) : stack.push(token); break;
					case RpnConstant.LEFT_BRACKET :
						stack.push(token);
						break;
					case RpnConstant.RIGHT_BRACKET :
						while (stack.length != 0 && stack[stack.length - 1].type != RpnConstant.LEFT_BRACKET) {
								result.push(stack[stack.length - 1]);
								stack.pop();
							}
							if (stack.length == 0) return getError(6);
							else stack.pop(); 
							if (stack.length != 0 && stack[stack.length - 1].type == RpnConstant.FUNCTION) {
								result.push(stack[stack.length - 1]);
								stack.pop();
							}
							break;
					case RpnConstant.SEPARATOR:
						while (stack.length != 0 && stack[stack.length - 1].type != RpnConstant.LEFT_BRACKET) {
							result.push(stack[stack.length - 1]);
							stack.pop();
						}
						if (stack.length == 0) return getError(6);
						break;
					case RpnConstant.OPERATOR :
						op = getOperator(token.operator);
						if(op == null) return false;
						while (	stack.length > 0 && stack[stack.length - 1].type == RpnConstant.OPERATOR &&
								op.priority <= getOperator(stack[stack.length - 1].operator).priority) {
							result.push(stack[stack.length - 1]);
							stack.pop();
						}
						stack.push(token);
						break;
				}
			}
			while (stack.length > 0) {
				result.push(stack[stack.length - 1]);
				stack.pop();
			}
			_expStack = result;
			return true;
		}
		
		private function eval():* {
			var _resultStack:Array = [];
			var id:int = 0;
			var i:int;
			var arg:Array;
			var token:PostFixItem;
			var op:RpnOperator;
			while (id < _expStack.length) {
				token = 
					new PostFixItem(_expStack[id].value, _expStack[id].operator, _expStack[id].type);
				switch (token.type) {
					case RpnConstant.STRING : 
					case RpnConstant.VALUE :
						_resultStack.push(token);
						break;
					case RpnConstant.OPERATOR :
					case RpnConstant.FUNCTION :
						op = _specialSymbols[token.operator] != undefined ?
							getOperator(_specialSymbols[token.operator]) :
							getOperator(token.operator);
						if (op == null) return NaN;
						if (_resultStack.length < op.operandNum) getError(10);
						else {
							arg = [];
							//var tempOp:RpnOperator;
							for (i = 0; i < op.operandNum; i++) arg[i] = _resultStack.pop().value;
							token = new PostFixItem(op.operation(arg));
							_resultStack.push(token);
						}
						break;
				}
				id++;
			}
			return _resultStack.length > 0 ? _resultStack[0].value : 0;
		}
		
		private function addRpnLibrary(lib:RpnLibrary):RpnLibrary {
			lib.rpnInstance = this;
			var i:int = lib.operatorList.length - 1;
			for (; i >= 0; i--) {
				var op:RpnOperator = lib.operatorList[i];
				_operatorList[op.notation] = op;
			}
			if (lib.specialSymbolList.length > 0) {
				i = lib.specialSymbolList.length - 1;
				var s:String = "";
				for (; i >= 0; i--) {
					s = lib.specialSymbolList[i];
					_specialSymbols[s] = s;
				}
			}
			return lib;
		}
	}
}