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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// SizeAdjuster.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 13/03/2009 11:59
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>SizeAdjuster</code> interface is implemented by objects that have
	 * 	a different size than values returned by their <code>width</code> and
	 * 	<code>height</code> properties (e.g. <code>org.flashapi.swing.wtk.AWM</code>).
	 * 	It provides a set of methods that allow to deal with the real size of these
	 * 	objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface SizeAdjuster {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets the width and the height of the object by considering its real effective
		 * 	size.
		 * 
		 * 	@param	width	The new real effective width for this object.
		 * 	@param	height	The new real effective height for this object.
		 * 
		 * 	@see #getRealHeight()
		 * 	@see #setRealHeight()
		 * 	@see #getRealWidth()
		 * 	@see #setRealWidth()
		 */
		function setRealSize(width:Number, height:Number):void;
		
		/**
		 * 	Returns the real effective height for this object. The value returned
		 * 	by the <code>getRealHeight()</code> method is different from the value defined
		 * 	by the <code>height</code> property.
		 * 
		 * 	@return A <code>Number</code> that represents the real height of this object.
		 * 
		 * 	@see #setRealSize()
		 * 	@see #setRealHeight()
		 * 	@see #getRealWidth()
		 * 	@see #setRealWidth()
		 */
		function getRealHeight():Number;
		
		/**
		 * 	Sets the height of the object by considering its real effective size.
		 * 
		 * 	@param	value	The new real effective height for this object.
		 * 
		 * 	@see #setRealSize()
		 * 	@see #getRealHeight()
		 * 	@see #getRealWidth()
		 * 	@see #setRealWidth()
		 */
		function setRealHeight(value:Number):void;
		
		/**
		 * 	Returns the real effective width for this object. The value returned
		 * 	by the <code>getRealWidth()</code> method is different from the value defined
		 * 	by the <code>width</code> property.
		 * 
		 * 	@return A <code>Number</code> that represents the real width of this object.
		 * 
		 * 	@see #setRealSize()
		 * 	@see #getRealHeight()
		 * 	@see #setRealHeight()
		 * 	@see #setRealWidth()
		 */
		function getRealWidth():Number;
		
		/**
		 * 	Sets the width of the object by considering its real effective size.
		 * 
		 * 	@param	value	The new real effective width for this object.
		 * 
		 * 	@see #setRealSize()
		 * 	@see #getRealHeight()
		 * 	@see #setRealHeight()
		 * 	@see #getRealWidth()
		 */
		function setRealWidth(value:Number):void;
		
		/**
		 * 	Returns the real effective minimum width for this object. The value returned
		 * 	by the <code>getRealMinWidth()</code> method is different from the value defined
		 * 	by the <code>minWidth</code> property.
		 * 
		 * 	@return A <code>Number</code> that represents the real minimum width of
		 * 	this object.
		 * 
		 * 	@see #getRealMinHeight()
		 */
		function getRealMinWidth():Number;
		
		/**
		 * 	Returns the real effective minimum height for this object. The value returned
		 * 	by the <code>getRealMinHeight()</code> method is different from the value defined
		 * 	by the <code>minHeight</code> property.
		 * 
		 * 	@return A <code>Number</code> that represents the real minimum height of
		 * 	this object.
		 * 
		 * 	@see #getRealMinWidth()
		 */
		function getRealMinHeight():Number;
	}
}