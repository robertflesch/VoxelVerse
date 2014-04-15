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
	// XMLSerializer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/03/2011 14:27
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.Dictionary;
	import org.flashapi.swing.constants.PrimitiveType;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>XMLSerializer</code> class provides convenient static methods to
	 * 	serialize and deserialize objects into and from XML documents.
	 * 	The <code>XMLSerializer</code> enables you to control how objects are encoded
	 * 	into XML.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class XMLSerializer {
		
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
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new
		 * 				XMLSerializer instance.
		 */
		public function XMLSerializer() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Deserializes and converts an XML object into a standard ActionScript object.
		 * 	Whether the <code>target</code> parameter is <code>null</code>, returns  
		 * 	a new <code>Object</code> instance; adds deserialized data into the
		 * 	<code>target</code> parameter object otherwise.
		 * 
		 * 	@param	node	The XML object to unserialize and convert.
		 * 	@param	target	An existing <code>Object</code> to hold the decoded
		 * 					XML data.
		 * 
		 * 	@return A standard ActionScript object that contains the converted XML data.
		 */
		public static function decode(node:XML, target:Object = null):Object {
			var obj:Object = XMLSerializer.parseNode(node, { });
			return obj;
		}
		
		/**
		 * 	Serializes and converts a standard ActionScript object into a XML object.
		 * 
		 * 	@param	obj		The <code>Object</code> to serialize and convert.
		 * 	@param	rootNodeName	The name of the root node for the new XML object.
		 * 
		 * 	@return	A XML object that contains the converted data.
		 */
		public static function encode(obj:Object, rootNodeName:String = "root"):XML {
			var xml:XML = <temp/>;
			xml.setName(rootNodeName);
			if (obj == null) return xml;
			if(typeof(obj) == PrimitiveType.STRING || typeof(obj) ==  PrimitiveType.NUMBER) {
				xml.appendChild(obj);
				return xml;
			}
			var name:String;
			var value:*;
			var leaf:XML;
			for (name in obj) {
				value = obj[name];
				switch(typeof(value)) {
					case PrimitiveType.STRING :
					case PrimitiveType.NUMBER :
					case PrimitiveType.XML :
						leaf = <temp>{value}</temp>; 
						leaf.setName(name);
						xml.appendChild(leaf);
						break;
					case PrimitiveType.OBJECT :
						if (value is Array || value is Dictionary) 
							serializeCollection(xml, name, value);
						else {
							leaf = XMLSerializer.encode(value, name);
							xml.appendChild(leaf);
						}
						break;
				}
			}
			return xml;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private static function serializeCollection(node:XML, leafName:String, collection:Object):void {
			var prop:*;
			var leaf:XML;
			var i:uint = 0;
			for each(prop in collection) {
				leaf = XMLSerializer.encode(prop, leafName);
				node.appendChild(leaf);
				++i;
			}
			if (i == 0) {
				leaf = <temp/>;
				leaf.setName(leafName);
				node.appendChild(leaf);
			}
		}
		
		private static function parseNode(node:XML, obj:Object):Object {
			if (node == null) return obj;
			XMLSerializer.extractAttributes(obj, node.attributes());
			var children:XMLList = node.children();
			var length:int = children.length();
			var child:XML;
			var i:int = 0;
			var nodeName:String;
			var dic:Object = { };
			var leaf:Object;
			for (; i < length; ++i) {
				child = children[i];
				nodeName = child.localName();
				if (child.hasComplexContent()) {
					leaf = parseNode(child, { } );
					XMLSerializer.fixChildrenSequence(dic, nodeName, obj, leaf);
					XMLSerializer.extractAttributes(leaf, child.attributes());
				} else {
					var isEmpty:Boolean = (child.text() == undefined);
					switch(child.nodeKind()) {
						case "element" :
							if (!isEmpty) {
								XMLSerializer.fixChildrenSequence(dic, nodeName, obj,
												XMLSerializer.convertTextValue(child.text()));
								XMLSerializer.extractAttributes(obj[nodeName], child.attributes());
							} else {
								leaf = { };
								if(XMLSerializer.extractAttributes(leaf, child.attributes())) {
									XMLSerializer.fixChildrenSequence(dic, nodeName, obj, leaf);
								} else {
									XMLSerializer.fixChildrenSequence(dic, nodeName, obj, null);
								}
							}
							break;
						/*case "text" :
							print(nodeName, child.text());
							//--> TODO implement nested text nodes
							//obj[nodeName] = undefined;
							break;*/
					}
				}
			}
			return obj;
		}
		
		private static function fixChildrenSequence(dic:Object, nodeName:String, obj:Object, value:*):void {
			if (dic[nodeName] == null) {
				dic[nodeName] = nodeName;
				obj[nodeName] = value;
			} else {
				var existingObj:* = obj[nodeName];
				if (existingObj is Array) existingObj.push(value);
				else {
					existingObj = [existingObj];
					existingObj.push(value);
					obj[nodeName] = existingObj;
				}
			}
		}
		
		private static function extractAttributes(obj:Object, att:XMLList):Boolean {
			var l:int = att.length();
			var hasAtt:Boolean = l > 0;
			if (hasAtt) {
				l -= 1;
				var xml:XML;
				for (; l >= 0; l--) {
					xml = att[l];
					obj[xml.localName()] = XMLSerializer.convertTextValue(xml.toXMLString());
				}
			}
			return hasAtt;
		}
		
		private static function convertTextValue(value:String):* {
			var converted:*;
			//--> Numbers that start with 0 are left as strings:
			var firstChar:String = value.charAt(0);
			var num:* = Number(value);
			if (isNaN(num) || (firstChar == '0') || ((firstChar == '-') && (value.charAt(1) == '0')) || value.charAt(value.length -1) == 'E') {
				var s:String = value.toString();
				//--> XML attributes are case sensitives:
				var boolCheck:String = s.toLowerCase();
				if (boolCheck == "true") converted = true;
				else if (boolCheck == "false") converted = false;
				else converted = s;
			} else converted = num;
			return converted;
		}
	}
}