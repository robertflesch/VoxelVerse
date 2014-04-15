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

package org.flashapi.swing.color {
	
	// -----------------------------------------------------------
	//  Color.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 21/11/2008 14:29
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.exceptions.InvalidArgumentException;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.util.StringUtil;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>ColorModuleBase</code> class is the base class for all "Color Module"
	 * 	objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ColorModuleBase implements ColorModule {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>ColorModuleBase</code> instance.
		 * 
		 * 	@param	name	The color keyword for the color to determine from this
		 * 					"Color Module".
		 * 	@param	hashRef A reference to the has table object used to define the
		 * 					color keyword by this "Color Module".
		 * 	@param	useList	Indicates whether <code>hashRef</code> object is list of
		 * 					hash tables (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@throws org.flashapi.swing.exceptions.InvalidArgumentException An InvalidArgumentException
		 * 			if the color keyword specified by the <code>name</code> parameter does
		 * 			not exist in this "Color Module".
		 */
		public function ColorModuleBase(name:String, hashRef:Object, useList:Boolean) {
			super();
			initObj(name, hashRef, useList);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>color</code> property.
		 * 
		 * 	@see #color
		 */
		protected var $color:uint;
		/**
		 * 	@inheritDoc
		 */
		public function get color():uint {
			return $color;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>name</code> property.
		 * 
		 * 	@see #name
		 */
		protected var $name:String = null;
		/**
		 * 	@inheritDoc
		 */
		public function get name():String {
			return $name;
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function get cssValue():String {
			return "#" + $string.substring(2);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@inheritDoc
		 */
		public function toString():String {
			return $string;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal <code>String</code> representation of the color object.
		 */
		protected var $string:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(name:String, hashRef:Object, useList:Boolean):void {
			var fixedName:String = name.toLowerCase();
			fixedName = StringUtil.removeWhitespace(fixedName);
			var colorObj:Object = useList ? hashRef[fixedName.charAt(0)] : hashRef;
			var value:String = colorObj[fixedName];
			if (value == null)
				throw new InvalidArgumentException(Locale.spas_internal::ERRORS.COLOR_KEYWORD_ERROR + name);
			$name = name;
			$color = Number(value);
			$string = value;
		}
	}
}