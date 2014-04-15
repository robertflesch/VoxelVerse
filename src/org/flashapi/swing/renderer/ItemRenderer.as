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

package org.flashapi.swing.renderer {
	
	// -----------------------------------------------------------
	// ItemRenderer.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/05/2009 15:48
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.Finalizable;
	
	/**
	 * 	The <code>ItemRenderer</code> interface defines the basic set of APIs 
	 * 	that you must implement to create SPAS 3.0 item renderer objects.
	 * 	Typically, values displayed by, and stored within, an <code>ItemRenderer</code>
	 * 	object can be modified by users by using the <code>ItemEditor</code> 
	 * 	instance specified by the <code>itemEditor</code> property.
	 * 
	 * 	@see org.flashapi.swing.renderer.ItemEditor
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ItemRenderer extends Finalizable {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The data to render or edit.
		 */
		function get data():*;
		function set data(value:*):void;
		
		/**
		 * 	Sets or gets the plain text displayed by this <code>ItemRenderer</code>
		 * 	object.
		 */
		function get label():String;
		function set label(value:String):void;
		
		/**
		 * 	Sets or gets the index of this <code>ItemRenderer</code> object.
		 */
		function get index():int;
		function set index(value:int):void;
		
		/**
		 * 	Sets or gets the <code>ItemEditor</code> object which allows to edit
		 * 	this <code>ItemRenderer</code> object.
		 * 
		 * 	@default null
		 * 
		 * 	@see #editable
		 */
		function get itemEditor():ItemEditor;
		function set itemEditor(value:ItemEditor):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether this <code>ItemRenderer</code>
		 * 	object can be edited (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #itemEditor
		 */
		function get editable():Boolean;
		function set editable(value:Boolean):void;
		
		/**
		 *  A reference to the object that contains this <code>ItemRenderer</code> object.
		 */
		function get target():*;
		function set target(value:*):void;
		
		/**
		 *  Sets or gets the width of this <code>ItemRenderer</code> object, in pixels.
		 * 
		 * 	@see #height
		 */
		function get width():Number;
		function set width(value:Number):void;
		
		/**
		 *  Sets or gets the height of this <code>ItemRenderer</code> object, in pixels.
		 * 
		 * 	@see #width
		 */
		function get height():Number;
		function set height(value:Number):void;
		
		/**
		 *  Indicates the x coordinate of the <code>ItemRenderer</code> relative to the 
		 * 	local coordinates of the parent <code>DisplayObjectContainer</code>.
		 * 
		 * 	@see #y
		 */
		function get x():Number;
		function set x(value:Number):void;
		
		/**
		 *  Indicates the y coordinate of the <code>ItemRenderer</code> relative to the 
		 * 	local coordinates of the parent <code>DisplayObjectContainer</code>.
		 * 
		 * 	@see #x
		 */
		function get y():Number;
		function set y(value:Number):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a rectangle that defines the bounds of the <code>ItemRenderer</code>,
		 * 	based on the coordinate system defined by the <code>targetCoordinateSpace</code>
		 * 	parameter, excluding any strokes on shapes.
		 * 
		 * 	@param	The display object that defines the coordinate system to use.
		 * 
		 * 	@return A rectangle that defines the area of the <code>ItemRenderer</code>
		 * 			object.
		 */
		function getRect(targetCoordinateSpace:DisplayObject):Rectangle;
		
		/**
		 * 	Updates information contained within, and/or displayed by, this 
		 * 	<code>ItemRenderer</code> object.
		 * 
		 * 	@param	info	An object that contains updated information.
		 */
		function updateItem(info:Object):void;
		
		/**
		 * 	Resets the <code>ItemRenderer</code> object.
		 */
		function resetItem():void;
	}
}