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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// XMLUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/03/2011 23:04
	* @see http://www.flashapi.org/
	*/
	
	import flash.xml.XMLNode;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>XMLUtil</code> class is a utility class that defines all-static
	 * 	methods for working with XML data.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	*/
	public class XMLUtil {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *@throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				XMLUtil instance.
		 */
		public function XMLUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//	Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Executes a function on each node with the specified name in the
		 * 	<code>XML</code> object.
		 * 
		 * 	@param	xml	The <code>XML</code> object for which to find specific node
		 * 				names.
		 * 	@param	name	The name of the xml nodes to find within the <code>XML</code>
		 * 					object.
		 * 	@param	callback	The function to run on each node found in the <code>XML</code>
		 * 						object. This function can contain a simple command
		 * 						(for example, a <code>print()</code>statement) or a
		 * 						more complex operation, and is invoked with two arguments;
		 * 						the value of a node and the main <code>XML</code> object:
		 * 						<pre>    function callback(node:XML, parent:XML):void;</pre> 
		 * 	@param	recursive	A <code>Boolean</code> value that indicates whether
		 * 						this method is recursive (<code>true</code>), or not
		 * 						(<code>false</code>). Default value is <code>true</code>.					
		 */
		public static function filterNodesByName(xml:XML, name:String, callback:Function, recursive:Boolean = true):void {
			var n:int = 0;
			var c:XML;
			var list:XMLList = xml.children();
			var l:int = list.length();
			while (n < l) {
				c = list[n];
				if(c.name() == name) callback(c, xml);
				if(recursive) filterNodesByName(c, name, callback);
				++n;
			}
		}
		
		/**
		 * 	Executes a function on each node that contains the specified <code>attribute</code> value 
		 * 	in the <code>XML</code> object.
		 * 
		 * 	@param	xml	The <code>XML</code> object for which to find a specific attribute
		 * 				value.
		 * 	@param	name	The name of the attribute value to find within the <code>XML</code>
		 * 					object.
		 * 	@param	callback	The function to run on each node with the sepcified attribute found 
		 * 						in the <code>XML</code> object. This function can contain a simple 
		 * 						command (for example, a <code>print()</code>statement) or a
		 * 						more complex operation, and is invoked with threes arguments;
		 * 						the value of a node, the name of the attribute value to find and
		 * 						the main <code>XML</code> object:
		 * 						<pre>    function callback(node:XML, attribute:String, parent:XML):void;</pre> 
		 * 	@param	recursive	A <code>Boolean</code> value that indicates whether
		 * 						this method is recursive (<code>true</code>), or not
		 * 						(<code>false</code>). Default value is <code>true</code>.					
		 */
		public static function filterAttributeNames(xml:XML, attribute:String, callback:Function, recursive:Boolean = true):void {
			if(xml.@[attribute] != null){
				callback(xml, attribute, xml);
			}
			var n:int = 0;
			var c:XML;
			var list:XMLList = xml.children();
			var l:int = list.length();
			while(n < l){
				c = list[n];
				if(c.@[attribute] != null) callback(c, attribute, xml);
				if(recursive) filterAttributeNames(c, attribute, callback);
				++n;
			}
		}
		
		/**
		 * 	Removes the default namespace from the specified <code>XML</code> object,
		 * 	if it exists, and returns a copy of the original <code>XML</code> object,
		 * 	without default namespace.
		 * 
		 * 	@param	xml	The <code>XML</code> object for which to remove the default
		 * 				namespace.
		 * 
		 * 	@return	A copy of the original <code>XML</code> object without default
		 * 			namespace.
		 */
		public static function removeDefaultNamespaceFromXML(xml:XML):XML {
			var rawXMLString:String = xml.toXMLString();
			var xmlnsPattern:RegExp = new RegExp(XMLNS_PATTERN, "gi");
			var cleanXMLString:String = rawXMLString.replace(xmlnsPattern, "");
			return new XML(cleanXMLString);
		}
		
		/**
		 * 	Removes the default namespace from a <code>String</code> that represents a 
		 * 	valid <code>XML</code> object, if it exists, and the original <code>String</code>,
		 * 	without default namespace.
		 * 
		 * 	@param	xmlString	The <code>String</code>, that represents a valid
		 * 						<code>XML</code> object, for which to remove the
		 * 						default namespace.
		 * 
		 * 	@return A the original <code>String</code> representation of a <code>XML</code> 
		 * 			object, without default namespace.
		 */
		public static function removeDefaultNamespaceFromString(xmlString:String):String {
			var xmlnsPattern:RegExp = new RegExp(XMLNS_PATTERN, "gi");
			return xmlString.replace(xmlnsPattern, "");
		}
		
		/**
		 * 	Returns the local name of the specified <code>XMLNode</code> object.
		 *
		 *  @param node An <code>XMLNode</code> object.
		 *
		 * 	@return The local name of an <code>XMLNode</code> object.
		 */
		public static function getNodeLocalName(node:XMLNode):String {
			var nodeName:String = node.nodeName;
			var namePos:int = nodeName.indexOf(":");
			if (namePos != -1) nodeName = nodeName.substring(namePos + 1);
			return nodeName;
		}
		
		//--------------------------------------------------------------------------
		//
		//	Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const XMLNS_PATTERN:String = 'xmlns=[^\"]*\"[^\"]*\"';
		
		/*-----------------------------------
			Recursively replace nodeNames.
		-------------------------------------
		public static function findAndReplaceNodeNames(xml:XML, find:String, replace:String):XML {
			if(xml.localName() == find){
				xml.setLocalName(replace);
			}
			var n:int = 0;
			var c:XML;
			while (n < xml.children().length()) {
				c = xml.children()[n];
				findAndReplaceNodeNames(c, find, replace);
				n++;
			}
			return xml;
		}
		
		-----------------------------------------
			Recursively replace attributes.
		-------------------------------------------
		private function findAndReplaceAttributeNames(xml:XML, find:String, replace:String, in_tags_named:String = ""):XML {
			var ok:Boolean=true;
			if(in_tags_named != "" && xml.localName() != in_tags_named){
				ok = false;
			}
			if(xml.@[find] != null && ok){
				xml.@[replace] = xml.@[find];
				delete xml.@[find];
			}
			var n:int=0;
			var c:XML;
			while(n <xml.children().length()){
				c = xml.children()[n];
				findAndReplaceAttributeNames(c, find, replace);
				n++;
			}
			return xml;
		}
 
		---------------------------------------------
			Recursively find and remove attributes.
		-----------------------------------------------
		private function findAndRemoveAttributeNames (xml:XML, find:String, in_tags_named:String = ""):XML {
			var ok:Boolean=true;
			if(in_tags_named != "" && xml.localName() != in_tags_named){
				ok = false;
			}
			if(xml.@[find] != null && ok){
				delete xml.@[find];
			}
			var n:int=0;
			var c:XML;
			while(n <xml.children().length()){
				c = xml.children()[n];
				findAndRemoveAttributeNames(c, find);
				n++;
			}
			return xml;
		}*/
	}
}