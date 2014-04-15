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
	// DisplayListUtil.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 21/05/2009 17:53
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 	The <code>DisplayListUtil</code> class creates convenient objects that 
	 * 	define methods for working with display list of
	 * 	<code>DisplayObjectContainer</code> instances.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DisplayListUtil {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DisplayListUtil</code> object with the 
		 * 	specified parameter.
		 * 
		 * 	@param	target	The <code>DisplayObjectContainer</code> instance 
		 * 					for which to manipulate display list by using this 
		 * 					<code>DisplayListUtil</code> object.
		 */
		public function DisplayListUtil(target:DisplayObjectContainer) { 
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Adds a child <code>DisplayObject</code> instance to the <code>DisplayObjectContainer</code>
		 * 	instance associated with this <code>DisplayListUtil</code> object.
		 * 	The child is added to the front (top) of all other children in the
		 * 	<code>DisplayObjectContainer</code> instance.
		 * 
		 * 	<p>If you add a child object that already has a different display object
		 * 	container as a parent, the object is removed from the child list of the
		 * 	other display object container.</p>
		 * 
		 * 	@param	child	The <code>DisplayObject</code> instance to add as a child
		 * 					of the <code>DisplayObjectContainer</code> instance associated 
		 * 					with this <code>DisplayListUtil</code> object.
		 * 
		 * 	@see #addChildren()
		 */
		public function addChild(child:DisplayObject):void {
			_target.addChild(child);
		}
		
		/**
		 * 	Adds a colletion of comma-separated child <code>DisplayObject</code>
		 * 	instances to the <code>DisplayObjectContainer</code> instance associated with
		 * 	this <code>DisplayListUtil</code> object.
		 * 
		 * 	@param	... arg	A colletion of comma-separated child <code>DisplayObject</code>
		 * 					instances to add as a children of the <code>DisplayObjectContainer</code>
		 * 					instance associated with this <code>DisplayListUtil</code>
		 * 					object.
		 * 
		 * 	@see #addChild()
		 */
		public function addChildren(... arg):void {
			var l:uint = arg.length;
			var i:uint = 0;
			for (; i < l; ++i) _target.addChild(arg[i]);
		}
		
		/**
		 * 	Removes a colletion of comma-separated child <code>DisplayObject</code>
		 * 	instances from the <code>DisplayObjectContainer</code> instance associated with
		 * 	this <code>DisplayListUtil</code> object.
		 * 
		 * 	@param	... arg	A colletion of comma-separated child <code>DisplayObject</code>
		 * 					instances to remove from the <code>DisplayObjectContainer</code>
		 * 					instance associated with this <code>DisplayListUtil</code>
		 * 					object.
		 * 
		 * 	@see #removeAllChildren()
		 */
		public function removeChildren(... arg):void {
			var l:uint = arg.length;
			var i:uint = 0;
			for (; i < l; ++i) _target.removeChild(arg[i]);
		}
		
		/**
		 * 	Removes all child <code>DisplayObject</code> instances from the
		 * 	<code>DisplayObjectContainer</code> instance associated with
		 * 	this <code>DisplayListUtil</code> object.
		 * 
		 * 	@see #removeChildren()
		 */
		public function removeAllChildren():void {
			while (_target.numChildren > 0) {
				try { _target.removeChildAt(0); }
				catch (e:Error) { }
			}
		}
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the
		 * 	<code>DisplayObjectContainer</code> instance associated with this
		 * 	<code>DisplayListUtil</code> object has child objects (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@return	<code>true</code> if the <code>DisplayObjectContainer</code>
		 * 			instance has child objects; <code>false</code> otherwise.
		 */
		public function hasChildren():Boolean {
			var flag:Boolean = _target.numChildren > 0 ? true : false;
			return flag;
		}
		
		/*public function getChildren():Collection {
			var startNum:uint = _parent.numChildren;
			for(var i:uint = 0; i<startNum; i++) _parent.removeChildAt(0);
		}*/
		
		//--------------------------------------------------------------------------
		//
		// 	Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _target:DisplayObjectContainer;
		
		//--------------------------------------------------------------------------
		//
		// 	Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:DisplayObjectContainer):void {
			_target = target;
		}
	}
}