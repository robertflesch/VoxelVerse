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

package org.flashapi.swing.skin {
	
	// -----------------------------------------------------------
	// Skin.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/09/2009 13:39
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.core.BitmapDataCollector;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	
	use namespace spas_internal;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>Skin</code> class defines the base class for skinnable objects.
	 * 	Associate a skin class with a SPAS 3.0 control object by setting the
	 * 	<code>skin</code> property of the <code>UIObject</code> class.
	 * 
	 * 	@see org.flashapi.swing.skin.Skinnable
	 * 	@see org.flashapi.swing.core.UIObject#skin
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Skin extends EventDispatcher implements IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>Skin</code> object with the specified
		 * 	parameters.
		 * 
		 * 	@param	name	The instance name of the <code>Skin</code> object.
		 * 	@param	smoothing	Indicates whether the <code>Skin</code> object
		 * 						is smoothed when scaled (<code>true</code>), or not 
		 * 						(<code>false</code>).
		 */
		public function Skin(name:String, smoothing:Boolean = false) {
			super();
			initObj(name, smoothing);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		/**
		 * 	@copy org.flashapi.swing.skin.Skinable#name
		 */
		public function get name():String {
			return _name;
		}
		public function set name(value:String):void {
			_name = value;
		}
		
		/**
		 * @private
		 */
		protected var $smoothing:Boolean;
		/**
		 * 	@copy org.flashapi.swing.skin.Skinable#smoothing
		 */
		public function get smoothing():Boolean {
			return $smoothing;
		}
		public function set smoothing(value:Boolean):void {
			$smoothing = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.skin.Skinable#finalize()
		 */
		public function finalize():void {
			$evtColl.finalize();
			$evtColl = null;
			$bmpColl.finalize();
			$bmpColl = null;
			uio = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>EventCollector</code> instance
		 * 	for this <code>Skin</code>.
		 */
		protected var $evtColl:EventCollector;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores a reference to the internal <code>BitmapDataCollector</code> 
		 * 	instance for this <code>Skin</code>.
		 */
		protected var $bmpColl:BitmapDataCollector;
		
		/**
		 * 	@private
		 */
		spas_internal var uio:UIObject;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		protected  function assignProp(obj:Skinable, list:XMLList):void {
			var i:int = list.length() - 1;
			for (; i >= 0 ; i--) obj[list[i].@name] = this[list[i].@name];
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(name:String, smoothing:Boolean):void {
			$evtColl = new EventCollector();
			$bmpColl = new BitmapDataCollector();
			_name = name;
			$smoothing = smoothing;
		}
	}
}