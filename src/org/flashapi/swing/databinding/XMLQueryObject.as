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

package org.flashapi.swing.databinding {

	// -----------------------------------------------------------
	//  XMLQueryObject.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.2, 31/05/2009 16:27
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.core.Finalizable;
	
	/**
	 * 	The <code>XMLQueryObject</code> interface defines the basic set of APIs that you
	 * 	must implement to create XML data management objects for <code>Listable</code>
	 * 	instances. To create non XML data management objects for <code>Listable</code>
	 * 	instances, use <code>DataProviderObject</code> controls.
	 * 
	 * 	@see org.flashapi.swing.databinding.DataProviderObject
	 * 	@see org.flashapi.swing.list.Listable
	 * 	
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface XMLQueryObject extends Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies whehther the <code>XMLQueryObject</code> object uses <code>strictMode</code>
		 * 	(<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #checkStrictMode()
		 */
		function get strictMode():Boolean;
		function set strictMode(value:Boolean):void;
		
		/**
		 * 	Returns a global URI path associated to this <code>XMLQueryObject</code>
		 * 	object.
		 * 
		 * 	@default null
		 */
		function get urlPath():String;
		
		/**
		 * 	Returns a reference to the XML data contained within this <code>XMLQueryObject</code>
		 * 	object, or <code>null</code> if not contains any XML data.
		 */
		function get xml():XML;
		
		/**
		 * 	Returns an integer that represents the number of XML children for this
		 * 	<code>XMLQueryObject</code> object. If no XML children are contained
		 * 	within the <code>XMLQueryObject</code> object, returns <code>-1</code>.
		 * 
		 * 	@default -1
		 */
		function get length():int;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a XML data object to this <code>XMLQueryObject</code> object.
		 * 
		 * 	@param	value The XML object to add within this <code>XMLQueryObject</code>
		 * 	object.
		 */
		function add(value:XML):void;
		
		/**
		 * 	Loads and adds a XML file with the <code>XMLQueryObject</code> object,
		 * 	from the specified URI.
		 * 
		 * 	@param	value	The URI of the XML file to add to this <code>XMLQueryObject</code>
		 * 					object.
		 */
		function load(value:String):void;
		
		/**
		 * 	Checks whether a XML file added to this <code>XMLQueryObject</code> object
		 * 	uses correct namespace when the <code>strictMode</code> property is
		 * 	<code>true</code>; if not, an exception is thrown.
		 * 
		 * 	@param	caller	A string that represents the <code>Listable</code> object
		 * 					reference which has called the <code>checkStrictMode()</code>
		 * 					method. If <code>strictMode</code> is <code>true</code>,
		 * 					this parameter must match the XML <code>caller</code>
		 * 					attribute value.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.DataFormatException Throws a
		 * 	<code>DataFormatException</code> error if the namespace prefix is different
		 * 	from <code>spas</code> when <code>strictMode</code> is <code>true</code>.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.DataFormatException Throws a
		 * 	<code>DataFormatException</code> error if the namespace is different
		 * 	from <code>"http://www.flashapi.org/spas"</code> when
		 * 	<code>strictMode</code> is <code>true</code>.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.DataFormatException Throws a
		 * 	<code>DataFormatException</code> error if the value specified by the
		 * 	<code>caller</code> parameter does not match the XML <code>caller</code>
		 * 	attribute value.
		 */
		function checkStrictMode(caller:String):void;
		
		/**
		 * 	Returns the XMLList "item" that exists at the specified index.
		 * 
		 * 	@param	index	The index position of the "item" XMLList object.
		 * 	@return	The "item" XMLList object at the specified index position.
		 */
		function getItemAt(index:uint):XMLList
	}
}