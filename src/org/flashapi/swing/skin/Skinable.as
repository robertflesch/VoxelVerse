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
	// Skinable.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 24/09/2007 18:08
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	
	/**
	 * 	The <code>Skinable</code> interface describes the properties and 
	 * 	methods that must be implemented by skin definition objects to
	 * 	use bitmap as SWF files to skin <code>UIObjects</code> instead
	 * 	of Lokook and Feels. The skins used by a <code>Skinnable</code>
	 * 	objects are typically child classes of the <code>Skin</code> class.
	 * 
	 * 	@see org.flashapi.swing.skin.Skin
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Skinable {
		
		/**
		 * 	The current scaling grid that is in effect. If <code>null</code>
		 * 	the entire <code>Skinable</code> object is scaled normally when
		 * 	any scale transformation is applied.
		 * 
		 * 	@default null
		 */
		function get scale9Grid():Rectangle;
		function set scale9Grid(value:Rectangle):void;
		
		/**
		 * 	Indicates the instance name of the <code>Skinable</code> object.
		 * 
		 * 	<p class="hide">The object can be identified in the list of the  
		 * 	main <code>SkinManager</code> instance by calling the
		 * 	<code>SkinManager.getSkinByName()</code> method.</p>
		 */
		function get name():String;
		function set name(value:String):void;
		
		/**
		 * 	A <code>Boolean</code> that indicates whether the <code>Skinable</code> object
		 * 	is smoothed when scaled (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		function get smoothing():Boolean;
		function set smoothing(value:Boolean):void;
		
		/**
		 * 	Returns a new <code>Skinable</code> object which is a clone of the 
		 * 	original instance, with an exact copy of the contained skin.
		 * 
		 * 	@return	A new <code>Skinable</code> object that is identical
		 * 			to the original.  
		 */
		function clone():Skinable;
		
		/**
		 * 	Finalizes this <code>Skinable</code> object. This method is called
		 * 	when the <code>UIObject.skin</code> property is set to <code>null</code>.
		 * 	You must use the <code>Skinable.finalize()</code> to make the
		 * 	<code>Skinable</code> object elligible for garbage collection.
		 */
		function finalize():void;
	}
}