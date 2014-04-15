/* ***** BEGIN MIT LICENSE BLOCK *****
 * 
 * Copyright (c) 2009 DevelopmentArc LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 *
 * ***** END MIT LICENSE BLOCK ***** */
package com.developmentarc.core.utils
{
	import flash.external.ExternalInterface;
	
	import mx.utils.URLUtil;
	
	/**
	 * Class is a utility class that provides a mix of functionaltity from Flex's BrowserManager and URLUtil classes.  
	 * The goal of the class is to give an application a mechinism to query the browser's current url (like one can with BrowserManager),
	 * but without leveraging the history managment system that flex provides. This allows application that do not include history.js a 
	 * way to retreive the current runtime url and parse all the various parts pieces. Below is a breakdown of a typical url and all
	 * the properties one can access.
	 * <br />
	 * <listing version="3.0">
	 *    https://google.com:8080/path/is/here/?param1=value1#page2
	 *    \___/   \________/ \__/\____________/ \___________/ \__/
	 *      |        |        |       |               |        |
     *   |   server name  port    path           query   fragment    
	 *   protocal 
	 * </listing>              
	 */
	public class BrowserLocationUtil
	{
		
		/**
		 * @private 
		 */
		protected static var _testURL:String;
		
		/**
		 * Method returns the current full url in the application.
		 * The functionality of this method relies on ExternalInterface to call
		 * 'window.location.href.toString' to gather the current url.
		 * 
		 * @return String of the current url.
		 */
		public static function get url():String {
			
			if(_testURL) {
				return _testURL;
			}
			else {
				return ExternalInterface.call('window.location.href.toString');
			}
			
		}
		/**
		 * Method encapsulates the URLUtil's getProtocal method returning the protocal of the current url.
		 * <br/>
		 * Example: http://google.com:8080/path/is/here/?param1=value1#page2 returns  http
		 * 
		 * @return String Current protocal used on the current url.
		 */
		public static function get protocal():String {
			return URLUtil.getProtocol(BrowserLocationUtil.url);
		}
		
		/**
		 * Method returns the server name in the current url of the application.
		 * <br/>
		 * Example: http://google.com:8080/path/is/here/?param1=value1#page2 returns google.com
		 * 
		 * @return String Current server name in url.
		 */ 
		public static function get serverName():String {
			return URLUtil.getServerName(BrowserLocationUtil.url);
		}
		
		/**
		 * Method returns the port number specificed in the current url. If no port is provided 0 will be returned.
		 * This method utilizes the Flex URLUtil.getPort() method. See that method for more details.
		 * <br/>
		 * Example: http://google.com:8080/path/is/here/?param1=value1#page2 returns 8080
		 * 
		 * @return String Current port used in the url.
		 */
		public static function get port():uint {
			return URLUtil.getPort(BrowserLocationUtil.url);
		}
		
		/**
		 * Method returns the path portion of the current url
		 *<br/>
		 * Example: http://google.com:8080/path/is/here/?param1=value1#page2 returns /path/is/here/
		 * 
		 * @return String Path in the current url.
		 */
		public static function get path():String {
			var url:String = BrowserLocationUtil.url;
			var serverName:String = URLUtil.getServerNameWithPort(url);
			var firstIndex:int = url.indexOf(serverName, 0) + serverName.length;
			
			var lastIndex:int;
			
			// Split on ?
			lastIndex = url.indexOf("?");
			
			// No ? - Split on #
			if(lastIndex == -1) {
				lastIndex = url.indexOf("#");
			} 
			// No ? or # use end of url
			if(lastIndex == -1) {
				lastIndex = url.length;
			}			
			
			return url.slice(firstIndex, lastIndex);
		}
		/**
		 * Method return the current query string of the url, which is the protion of the url
		 * after the servername and/or port and before the framgment of the url.
		 * <br/>
		 * Example: http://google.com:8080/path/is/here/?param1=value1#page2 returns param1=value1
		 * 
		 * @return query String of the query portion of the current url in the system.
		 */
		public static function get query():String {
			var parts:Array = BrowserLocationUtil.url.split("?");
			
			if(parts.length == 2) {
				return parts[1].split("#")[0];
			}
			else {
				return "";
			}
		}
		
		/**
		 * Method breaks down the query string of the current url
		 * passing back a generic object with each key/value pair.
		 * <br/>
		 * Example: http://google.com:8080/path/is/here/?param1=value1#page2 returns {param1:'value1'}
		 * <br />
		 * <b>Note:</b>  This method utilizes the mx.utils.URLUtil.stringToObject() method, which 
		 * overrides parameters of the same name with the last value found in the string.
		 * <br />
		 * Example: Example: http://google.com:8080/path/is/here/?param1=value1&param1=value2#page2 returns {param1:'value2'} 
		 * 
		 * @return Object Generic object containing each key/value pair found in the current urls query.
		 */
		public static function get parameters():Object {
			var query:String = BrowserLocationUtil.query;
			
				if(query.length > 0) {
					var parameters:String = query.split("#")[0];
					return mx.utils.URLUtil.stringToObject(parameters,"&");	
				}
				else {
					return new Object();
				}
		}
		
		/**
		 * Method returns the fragment portion of the url which is all data after the "#".
		 * <br/>
		 * Example: http://google.com:8080/path/is/here/?param1=value1#page2 returns page2
		 * 
		 * @return String Current fragment in the current url.
		 */
		public static function get fragment():String {
			var parts:Array = BrowserLocationUtil.url.split("#");
			
			if(parts.length == 2) {
				return parts[1];
			}
			else {
				return "";
			}
		}
	}
}