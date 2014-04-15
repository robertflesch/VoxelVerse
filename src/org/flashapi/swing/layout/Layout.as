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

package org.flashapi.swing.layout {
	
	// -----------------------------------------------------------
	// Layout.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 17/02/2009 13:13
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	import org.flashapi.swing.containers.UIContainer;
	import org.flashapi.tween.core.Easing;
	
	/**
	 * 	The <code>Layout</code> interface defines the basic set of APIs that 
	 * 	you must implement to create classes that present a GUI with specified
	 * 	appearance and resize the behavior and distinguish the responsibilities
	 * 	of layout managers from those of containers.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Layout extends IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether this <code>Layout</code>
		 * 	object lays object by using a motion tween animation (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 * 
		 * 	@see #duration
		 * 	@see #easingFunction
		 */
		function get animated():Boolean;
		function set animated(value:Boolean):void;
		
		/**
		 * 	Sets or gets the duration of the animation tween if <code>autoSizeAnimated</code>
		 * 	is <code>true</code>.
		 * 	
		 * 	@default 250
		 * 
		 * 	@see #autoSizeAnimated
		 * 	@see #autoSizeEasingFunction
		 */
		function get autoSizeDuration():uint;
		function set autoSizeDuration(value:uint):void;
		
		/**
		 * 	A <code>Boolean</code> value that indicates whether the <code>Layout</code>
		 * 	object resizes its associated container by using a motion tween animation
		 * 	when auto size properties are set (<code>true</code>), or not (<code>false</code>).
		 * 	
		 * 	@default false
		 * 
		 * 	@see #autoSizeDuration
		 * 	@see #autoSizeEasingFunction
		 */
		function get autoSizeAnimated():Boolean;
		function set autoSizeAnimated(value:Boolean):void;
		
		/**
		 * 	Specifies the <code>Easing</code> function of the animation tween if
		 * 	<code>autoSizeAnimated</code> is <code>true</code>.
		 * 	
		 * 	@default	An instance of the <code>Linear</code> class.
		 * 
		 * 	@see org.flashapi.swing.motion.effects.Easing
		 * 	@see org.flashapi.swing.motion.effects.Tween#setEasingFunction()
		 * 	@see #autoSizeDuration
		 * 	@see #autoSizeAnimated
		 */
		function get autoSizeEasingFunction():Easing
		function set autoSizeEasingFunction(value:Easing):void;
		
		/**
		 * 	Sets or gets the duration of the animation tween if <code>animated</code>
		 * 	is <code>true</code>.
		 * 	
		 * 	@default 500
		 * 
		 * 	@see #animated
		 * 	@see #easingFunction
		 */
		function get duration():uint;
		function set duration(value:uint):void;
		
		/**
		 * 	Specifies the <code>Easing</code> function of the animation tween if
		 * 	<code>animated</code> is <code>true</code>.
		 * 	
		 * 	@default	An instance of the <code>Linear</code> class.
		 * 
		 * 	@see org.flashapi.swing.motion.effects.Easing
		 * 	@see org.flashapi.swing.motion.effects.Tween#setEasingFunction()
		 * 	@see #animated
		 * 	@see #duration
		 */
		function set easingFunction(value:Easing):void;
		function get easingFunction():Easing;
		
		/**
		 * 	Returns an integer that represents the number of elements managed by
		 * 	this <code>Layout</code> object.
		 */
		function get elementsListLength():int;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	A <code>Boolean</code> value that indicates whether the number of elements
		 * 	contained within the container associated with this <code>Layout</code> object
		 * 	has changed (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	<p><strong>Must be accessed only by <code>UIContainer</code> and
		 * 	<code>Layout</code> objects.</strong></p>
		 * 	
		 * 	@default false
		 */
		function get hasElementListChanged():Boolean;
		function set hasElementListChanged(value:Boolean):void;
		
		/**
		 * 	Sets or gets the horizontal alignment of elements contained within the container
		 * 	associated with this <code>Layout</code> object. Valid values are the constants
		 * 	of the <code>LayoutHorizontalAlignment</code> class.
		 * 
		 * 	@default LayoutHorizontalAlignment.LEFT
		 * 
		 * 	@see #verticalAlignment
		 * 	@see #orientation
		 */
		function get horizontalAlignment():String 
		function set horizontalAlignment(value:String):void;
		
		/**
		 * 	Returns the value of the height used by this <code>Layout</code> object
		 * 	to layout elements contained within its associated container, in pixels.
		 * 	
		 * 	@see #layoutWidth
		 */
		function get layoutHeight():Number;
		
		/**
		 * 	Returns the value of the height used by this <code>Layout</code> object
		 * 	to layout elements contained within its associated container, in pixels.
		 * 	
		 * 	@see #layoutHeight
		 */
		function get layoutWidth():Number;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the <code>Layout</code>
		 * 	object is currently processing the objects layout (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 	
		 * 	@default false
		 */
		function get isRendering():Boolean;
		
		/**
		 * 	Sets or gets the orientation of this <code>Layout</code> object. Valid
		 * 	values are the constants of the <code>LayoutOrientation</code> class.
		 * 
		 * 	@default LayoutOrientation.HORIZONTAL
		 * 
		 * 	@see #horizontalAlignment
		 * 	@see #verticalAlignment
		 */
		function get orientation():String;
		function set orientation(value:String):void;
		
		/**
		 * 	Sets or gets the vertical alignment of elements contained within the container
		 * 	associated with this <code>Layout</code> object. Valid values are the constants
		 * 	of the <code>LayoutVerticalAlignment</code> class.
		 * 
		 * 	@default LayoutVerticalAlignment.TOP
		 * 
		 * 	@see #horizontalAlignment
		 * 	@see #orientation
		 */
		function get verticalAlignment():String;
		function set verticalAlignment(value:String):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Adds a collection of elements, specified by the <code>collection</code>
		 * 	array parameter, to this <code>Layout</code> object. Elements can be
		 * 	either <code>UIObject</code> or <code>DisplayObject</code> instances.
		 * 
		 * 	<p><strong>Must be accessed only by <code>UIContainer</code> and
		 * 	<code>Layout</code> objects.</strong></p>
		 * 
		 * 	@param	collection	A collection of elements to add into this 
		 * 						<code>Layout</code> object.
		 * 
		 * 	@see #addObject()
		 * 	@see #removeObject()
		 * 	@see #clear()
		 */
		function addAllObjects(collection:Array):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Adds an elements, specified by the <code>obj</code> parameter, to this 
		 * 	<code>Layout</code> object. Elements can be either <code>UIObject</code>
		 * 	or <code>DisplayObject</code> instances.
		 * 
		 * 	@param	obj	An element to add into this <code>Layout</code> object.
		 * 
		 * 	@see #addAllObjects()
		 * 	@see #removeObject()
		 * 	@see #clear()
		 */
		function addObject(obj:*):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Called within the container object associated with this <code>Layout</code>
		 * 	instance to start elements layout.
		 * 
		 * 	@param	bounds	A <code>Rectangle</code> that specifies the bounds
		 * 					to perform the layout of the elements contained within
		 * 					the container object associated with this <code>Layout</code>
		 * 					instance.
		 * 	@param	caller	A reference to the container object that requires a
		 * 					layout update.
		 */
		function moveObjects(bounds:Rectangle, caller:* = null):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Removes all child elements previously added to this <code>Layout</code>
		 * 	object. The child element can be either a <code>UIObject</code> or
		 * 	<code>DisplayObject</code> instance.
		 * 
		 * 	<p><strong>Must be accessed only by <code>UIContainer</code> and
		 * 	<code>Layout</code> objects.</strong></p>
		 * 
		 * 	@see #addObject()
		 * 	@see #removeObject()
		 * 	@see #addAllObjects()
		 */
		function clear():void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Removes the child element, specified by the <code>obj</code> parameter,
		 * 	from this <code>Layout</code> object.
		 * 
		 * 	<p><strong>Must be accessed only by <code>UIContainer</code> and
		 * 	<code>Layout</code> objects.</strong></p>
		 * 
		 * 	@param	obj	The child element to remove from this <code>Layout</code>
		 * 				object.
		 * 
		 * 	@see #addObject()
		 * 	@see #clear()
		 * 	@see #addAllObjects()
		 */
		function removeObject(obj:*):void;
		
		/**
		 * 	Sets the horizontal orientation of elements contained within the container
		 * 	associated with this <code>Layout</code> object. Valid values are the 
		 * 	constants of the <code>LayoutHorizontalAlignment</code> class.
		 * 
		 * 	@param	value	The horizontal orientation of child elements within the
		 * 					target container.
		 * 
		 * 	@see #setVerticalOrientation()
		 */
		function setHorizontalOrientation(value:String):void;
		
		/**
		 * 	Sets the vertical alignment of elements contained within the container
		 * 	associated with this <code>Layout</code> object. Valid values are the 
		 * 	constants of the <code>LayoutVerticalAlignment</code> class.
		 * 
		 * 	@param	value	The vertical orientation of child elements within the
		 * 					target container.
		 * 
		 * 	@see #setHorizontalOrientation()
		 */
		function setVerticalOrientation(value:String):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Specifies the container object associated with this <code>Layout</code>
		 * 	instance.
		 * 
		 * 	<p><strong>Must be accessed only by <code>UIContainer</code> and
		 * 	<code>Layout</code> objects.</strong></p>
		 * 
		 * 	@param	target	The container object associated with this 
		 * 					<code>Layout</code> instance.
		 */
		function setTarget(target:UIContainer):void;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Swaps the z-order (front-to-back order) of the two specified child
		 * 	elements.
		 * 
		 * 	<p><strong>Must be accessed only by <code>UIContainer</code> and
		 * 	<code>Layout</code> objects.</strong></p>
		 * 
		 * 	@param	index1	The first child element.
		 * 	@param	index2	The second child element.
		 */
		function swapElementsAt(index1:int, index2:int):void;
	}
}