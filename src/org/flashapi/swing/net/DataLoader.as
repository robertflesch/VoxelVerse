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

package org.flashapi.swing.net {
	
	// -----------------------------------------------------------
	// DataLoader.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 05/06/2009 15:45
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import org.flashapi.swing.core.Finalizable;
	import org.flashapi.swing.net.UILoader;
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when data has been loaded successfully.
	 *
	 *  @eventType org.flashapi.swing.event.LoaderEvent.COMPLETE
	 */
	[Event(name = "complete", type = "org.flashapi.swing.event.LoaderEvent")]
	
	/**
	 *  Dispatched when an error causes a send or load operation to fail.
	 *
	 *  @eventType org.flashapi.swing.event.LoaderEvent.IO_ERROR
	 */
	[Event(name = "ioError", type = "org.flashapi.swing.event.LoaderEvent")]
	
	/**
	 *  Dispatched when the loader attempts to connect to a port lower than 1024.
	 *
	 *  @eventType org.flashapi.swing.event.LoaderEvent.SECURITY_ERROR
	 */
	[Event(name = "securityError", type = "org.flashapi.swing.event.LoaderEvent")]
	
	/**
	 * 	The <code>DataLoader</code> class provides an easy-to-use process to manage 
	 * 	data loading from the Web.
	 * 	
	 * 	<p>Data to load can be:
	 * 		<ul>
	 * 			<li>text or html files,</li>
	 * 			<li>xml files,</li>
	 * 			<li>image or swf files,</li>
	 * 			<li>cached image or swf files,</li>
	 * 			<li>css files,</li>
	 * 			<li>csv files,</li>
	 * 			<li>data files.</li>
	 * 		</ul>
	 * 	</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DataLoader extends EventDispatcher implements Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DataLoader</code> object.
		 */
		public function DataLoader() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>data</code> property lets you pass a value to this
		 * 	<code>DataLoader</code> instance.
		 */
		public var data:* = null;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>typeOfData</code> property.
		 * 
		 * 	@see #typeOfData
		 */
		protected var $typeOfData:String;
		/**
		 * 	Returns the type of data for this data loader.
		 * 	Valid values are <code>DataFormat</code> constants.
		 * 
		 *  @default DataFormat.GRAPHIC
		 */
		public function get typeOfData():String {
			return $typeOfData;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	Loads an object from the specified URI.
		 * 	
		 * 	@param	uri		The URI of the object to load.
		 * 	@param	type	A <code>DataFormat</code> constant that indicates the 
		 * 					primitive type of data the object which you pass in the uri 
		 * 					parameter is. Default value is <code>DataFormat.GRAPHIC</code>.
		 * 	
		 * 	@return	A reference to the loaded object from the URI that you pass in the
		 * 			uri parameter.
		 */
		public function load(uri:String, type:String = "graphic", parameters:LoaderParameters = null):* {
			$typeOfData = type;
			this.close();
			_uiLoader = new UILoader(this, type);
			_uiLoader.load(uri, parameters);
			return _uiLoader.loader;
		}
		
		/**
		 * 	Closes the load operation in progress. Any load operation in progress is
		 * 	immediately terminated. 
		 */
		public function close():void {
			if(_uiLoader) this.finalize();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function finalize():void {
			_uiLoader.finalize();
			_uiLoader = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _uiLoader:UILoader;
	}
}