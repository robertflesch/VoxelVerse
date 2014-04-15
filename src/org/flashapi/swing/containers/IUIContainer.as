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

package org.flashapi.swing.containers {
	
	// -----------------------------------------------------------
	// IUIContainer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/03/2010 20:35
	* @see http://www.flashapi.org/
	*/
	
	import flash.text.StyleSheet;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.Element;
	import org.flashapi.swing.layout.Layout;
	
	/**
	 * 	The <code>IUIContainer</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 <code>UIContainer</code> objects.
	 * 
	 * 	@see org.flashapi.swing.containers.UIContainer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface IUIContainer extends IUIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Sets or gets the <code>Layout</code> instance for this <code>UIContainer</code>.
		 *  The default layout is an instance of the <code>FlowLayout</code> class.
		 *
		 *  @see #setLayout()
		 *  @see org.flashapi.swing.layout.Layout
		 *  @see org.flashapi.swing.layout.FlowLayout
		 */
		function get layout():Layout;
		function set layout(value:Layout):void;
		
		/**
		 *  A <code>Boolean</code> value that indicates whether the <code>UIContainer</code>
		 * 	must adjust his size itself when adding a child from a URI (<code>true</code>)
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default false
		 */
		function get autoAdjustSize():Boolean;
		function set autoAdjustSize(value:Boolean):void;
		
		/**
		 * 	Sets or gets the orientation that is used to horizontally order the elements
		 * 	within this <code>UIContainer</code>.
		 * 	<code>Layout</code> subclasses that wish to respect horizontal orientation
		 * 	should call this method to get the <code>UIContainer</code> horizontal
		 * 	orientation before performing layout or drawing.
		 * 
		 * 	<p>Valid values are <code>LayoutHorizontalDirection.LEFT_TO_RIGHT</code>
		 * 	and <code>LayoutHorizontalDirection.RIGHT_TO_LEFT</code>.</p>
		 * 
		 * 	@default LayoutHorizontalDirection.LEFT_TO_RIGHT 
		 * 
		 * 	@see #verticalOrientation
		 */
		function get horizontalOrientation():String;
		function set horizontalOrientation(value:String):void;
		
		/**
		 * 	Prevents layout to be updated; if <code>true</code> the position of elements
		 * 	within the <code>UIContainer</code> are not changed. This property is useful 
		 * 	to save ressources when working with complex dynamic layouts.
		 * 
		 * 	@default false
		 */
		function get invalidateLayout():Boolean;
		function set invalidateLayout(value:Boolean):void
		
		/**
		 * 	Returns the number of children contained within this <code>UIContainer</code>. 
		 * 
		 *  @default 0
		 */
		function get numElements():uint;
		
		/**
		 * 	Returns the type of children contained within this <code>UIContainer</code>.
		 * 	Valid values are <code>DataFormat</code> constants.
		 * 
		 *  @default DataFormat.GRAPHIC
		 */
		function get typeOfContent():String;
		
		/**
		 * 	Sets or gets the orientation that is used to vertically order the elements
		 * 	within this <code>UIContainer</code>.
		 * 	<code>Layout</code> subclasses that wish to respect vertical orientation
		 * 	should call this method to get the <code>UIContainer</code> vertical
		 * 	orientation before performing layout or drawing.
		 * 
		 * 	<p>Valid values are <code>LayoutVerticalDirection.LEFT_TO_RIGHT</code>
		 * 	and <code>LayoutVerticalDirection.RIGHT_TO_LEFT</code>.</p>
		 * 
		 * 	@default LayoutVerticalDirection.LEFT_TO_RIGHT 
		 * 
		 * 	@see #horizontalOrientation
		 */
		function get verticalOrientation():String;
		function set verticalOrientation(value:String):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Forces the layout to be updated.
		 */
		function forceLayout():void;
		
		/**
		 * 	Sets a new <code>Layout</code> instance for this <code>UIContainer</code>
		 * 	object. If the <code>layout</code> parameter is <code>null</code>, the
		 * 	current layout is removed and replaced by a new <code>AbsoluteLayout</code>
		 * 	instance.
		 * 
		 * 	@param	layout	The new <code>Layout</code> instance for this <code>UIContainer</code>
		 * 					object.
		 * 
		 *  @see #layout
		 *  @see org.flashapi.swing.layout.Layout
		 *  @see org.flashapi.swing.layout.AbsoluteLayout
		 */
		function setLayout(layout:Layout = null):void;
		
		
		/**
		 *	Adds a child element to this <code>UIContainer</code>. The child element can be a
		 * 	<code>UIObject</code>, a <code>DisplayObject</code>, a <code>TextFile</code>, or an
		 * 	URI that links to a SWF, a HTML, a text, or an image file.
		 * 
		 * 	<p>Whether the <code>UIContainer</code> layout is an <code>AbsoluteLayout</code> instance,
		 * 	the child element is added to the front (top) of all other child elements within the
		 * 	container. (To add a child element at a specific index position, use the
		 * 	<code>addElementAt()</code> method.)
		 * 	<br />
		 * 	Otherwise, the child element is added using the coordinates specified by the
		 * 	<code>UIContainer</code> layout.</p>
		 * 	
		 * 	@param	value		The object to add as a child element of this <code>UIContainer</code>. 
		 * 	@param	type		A <code>DataFormat</code> constant that indicates the tytpe of object
		 * 						that is passed as the child element parameter. Default value is
		 * 						<code>DataFormat.GRAPHIC</code>.
		 * 	@param	constraints		An object expressing layout contraints for the added element.
		 * 
		 * 	@return			An <code>Element</code> object; a reference to the object that
		 * 					is passed as the child element parameter, outtyped to <code>Element</code>.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see org.flashapi.swing.TextFile
		 * 	@see org.flashapi.swing.core.UIObject
		 * 
		 * 	@see #layout
		 * 	@see #addElementdAt()
		 * 	@see #addGraphicElements()
		 */
		function addElement(value:*, type:String = "graphic", constraints:Object = null):Element;
		
		/**
		 * 	[Not available yet.]
		 * 	Adds a child element instance to this <code>UIContainer</code>. The child element is
		 * 	added at the index position specified. An index of <code>0</code> represents the back
		 * 	(bottom) of the display list for this <code>UIContainer</code> object.
		 * 	
		 * 	@param	value		The object to add as a child element of this <code>UIContainer</code>. 
		 * 	@param	index		The index position to which the child element is added.
		 * 						<span class="hide">If you specify a currently occupied index position,
		 * 						the child object that exists at that position and all higher positions
		 * 						are moved up one position in the child list.</span>
		 * 	@param	type		A <code>DataFormat</code> constant that indicates the tytpe of object
		 * 						that is passed as the child element parameter. Default value is
		 * 						<code>DataFormat.GRAPHIC</code>.
		 * 	@param	constraints		An object expressing layout contraints for the added element.
		 * 
		 * 	@return			An <code>Element</code> object; a reference to the object that
		 * 					is passed as the child element parameter, outtyped to <code>Element</code>.
		 * 
		 * 	@throws org.flashapi.swing.exceptions.IndexOutOfBoundsException Throws an <code>IndexOutOfBoundsException</code>
		 * 						error if the index position does not exist in the child elements list.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see org.flashapi.swing.TextFile
		 * 	@see org.flashapi.swing.core.UIObject
		 * 
		 * 	@see #addElementd()
		 * 	@see #addGraphicElements()
		 */
		function addElementAt(value:*, index:uint, type:String = "graphic", constraints:Object = null):Element;
		
		/**
		 * 	Adds a series of graphical child elements to this <code>UIContainer</code> instance.
		 * 	These child elements can be added separately, or as an <code>Array</code> that represents 
		 * 	a collection of elements.
		 * 	Child elements can be <code>UIObject</code> and <code>DisplayObject</code> instances, 
		 * 	or URI that link to SWF or image files.
		 * 
		 * 	<p>When you use the <code>addGraphicElements()</code> method, the layout of the parent
		 * 	container is only updated when the last child element is added to the container.</p>
		 * 
		 * 	@param	... rest	A collection or a series of graphical child elements to add 
		 * 						to this <code>UIContainer</code> instance.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject
		 * 
		 * 	@see #addElement()
		 * 	@see #addElementAt()
		 */
		function addGraphicElements(... rest):void;
		
		/**
		 * 	Returns the child element instance that exists at the specified index. 
		 * 
		 * 	@param	index	The index position of the child element.
		 * 
		 * 	@return			The child display element at the specified index position.
		 * 
		 *  @throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> if the index does not exist
		 * 			in the child list.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #getElementByName()
		 * 	@see #getElements()
		 * 	@see #getObjectAt()
		 */
		function getElementAt(index:int):Element;
		
		/**
		 * 	Returns the untyped child element instance that exists at the specified index.
		 * 	Because SPAS 3.0 <code>UIContainer</code> objects accept several type of
		 * 	objects as child elements, this method is usefull to re-assign the
		 * 	orignal type of a child object, instead of using the <code>Element</code> type.
		 * 
		 * 	@param	index	The index position of the child element. 
		 * 	@return			The untyped child display element at the specified index position.
		 * 
		 *  @throws org.flashapi.swing.exceptions.IndexOutOfBoundsException An
		 * 			<code>IndexOutOfBoundsException</code> if the index does not exist
		 * 			in the child list.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #getElementByName()
		 * 	@see #getElements()
		 * 	@see #getElementAt()
		 */
		function getObjectAt(index:int):*;
		
		/**
		 * 	Returns the index position of a child element instance. 
		 * 
		 *	@param	value	The child element instance to identify. 
		 * 	@return	The index position of the child element to identify. 
		 */
		function getElementIndex(value:*):int;
		
		/**
		 * 	Returns an <code>Array</code> of all elements contained within this
		 * 	<code>UIContainer</code> instance.
		 * 	
		 * 	@return All elements contained within this <code>UIContainer</code> instance.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #getElementByName()
		 * 	@see #getObjectAt()
		 * 	@see #getElementAt()
		 */
		function getElements():Array;
		
		/**
		 * 	Returns the child element that exists with the specified name. If more that
		 * 	one element has the specified name, the method returns the first object
		 * 	in the child element list.
		 * 
		 * 	@param	name	The name of the element to return.
		 * 	@return			The child element with the specified name.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #getElementAt()
		 * 	@see #getElements()
		 * 	@see #getObjectAt()
		 */
		function getElementByName(name:String):Element;
		
		/**
		 * 	Removes the specified child element instance from the child element list of
		 * 	the <code>UIContainer</code> instance. If the child element to remove is a 
		 * 	<code>DisplayObject</code>, the parent property of the removed child element 
		 *	is set to <code>null</code>, and the object is garbage collected if no other
		 * 	references to the child element exist.
		 * 	The index positions of any objects above the child element in the <code>UIContainer</code>
		 * 	are decreased by <code>1</code>. 
		 * 
		 * 	@param	value	The child <code>Element</code> instance to remove.
		 * 
		 * 	@return			The untyped child object that was removed.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #removeElement()
		 * 	@see #removeLastElement()
		 * 	@see #removefirstElement()
		 * 	@see #finalizeElements()
		 * 	@see #removeElements()
		 */
		function removeElement(value:*):*;
		
		/**
		 * 	Removes a child element from the specified index position in the child list
		 * 	of the <code>UIContainer</code>. If the child element to remove is a 
		 * 	<code>DisplayObject</code>, the parent property of the removed child element 
		 *	is set to <code>null</code>, and the object is garbage collected if no other
		 * 	references to the child element exist.
		 * 	The index positions of any objects above the child element in the <code>UIContainer</code>
		 * 	are decreased by <code>1</code>. 
		 * 
		 * 	@param	index	The child index of the <code>Element</code> to remove.
		 * 
		 * 	@return			The untyped child object that was removed.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #removeElement()
		 * 	@see #removeLastElement()
		 * 	@see #removefirstElement()
		 * 	@see #finalizeElements()
		 * 	@see #removeElements()
		 */
		function removeElementAt(index:int):*;
		
		/**
		 * 	Removes the last child element instance from the child element list of
		 * 	this <code>UIContainer</code> instance. If the child element to remove is a 
		 * 	<code>DisplayObject</code>, the parent property of the removed child element 
		 *	is set to <code>null</code>, and the object is garbage collected if no other
		 * 	references to the child element exist.
		 * 	The index positions of any objects above the child element in the <code>UIContainer</code>
		 * 	are decreased by <code>1</code>.
		 * 	
		 * 	@return	The untyped child object that was removed.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #removeElement()
		 * 	@see #removeElementAt()
		 * 	@see #removefirstElement()
		 * 	@see #finalizeElements()
		 * 	@see #removeElements()
		 */
		function removeLastElement():*;
		
		/**
		 * 	Removes the first child element instance from the child element list of
		 * 	this <code>UIContainer</code> instance. If the child element to remove is a 
		 * 	<code>DisplayObject</code>, the parent property of the removed child element 
		 *	is set to <code>null</code>, and the object is garbage collected if no other
		 * 	references to the child element exist.
		 * 	The index positions of any objects above the child element in the <code>UIContainer</code>
		 * 	are decreased by <code>1</code>.
		 * 	
		 * 	@return	The untyped child object that was removed.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #removeElement()
		 * 	@see #removeElementAt()
		 * 	@see #removeLastElement()
		 * 	@see #finalizeElements()
		 * 	@see #removeElements()
		 */
		function removefirstElement():*;
		
		/**
		 * 	Removes and finalizes all elements that are contained within this
		 * 	<code>UIContainer</code> instance.
		 * 	The parent property of removed child elements are set to <code>null</code>,
		 * 	and the object are garbage collected if no other references to them exist.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #removeElement()
		 * 	@see #removeElementAt()
		 * 	@see #removeLastElement()
		 * 	@see #removefirstElement()
		 * 	@see #removeElements()
		 */
		function finalizeElements():void;
		
		/**
		 * 	Removes all elements that are contained within this <code>UIContainer</code>
		 * 	instance.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #removeElement()
		 * 	@see #removeElementAt()
		 * 	@see #removeLastElement()
		 * 	@see #removefirstElement()
		 * 	@see #finalizeElements()
		 */
		function removeElements():void;
		
		/**
		 * 	Not implemented yet.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #swapElementsAt()
		 */
		function swapElements(element1:*, element2:*):void;
		
		/**
		 * 	Swaps the z-order (front-to-back order) of the two specified child element
		 * 	elements. All other child elements in the container remain in the same
		 * 	index positions.
		 * 
		 * 	@param	index1	The first child element object.
		 * 	@param	index2	The second child element object.
		 * 
		 * 	@see org.flashapi.swing.Element
		 * 	@see #swapElements()
		 */
		function swapElementsAt(index1:int, index2:int):void;
		
		//--------------------------------------------------------------------------
		//
		//  Deprecated API
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>[Deprecated]</strong> Indicates whether the text field container
		 * 	automatically wraps at the end of a line when it displays non-graphic data. 
		 * 	If <code>true</code>, the text wraps to occupy multiple lines if necessary.
		 * 
		 * 	@default false 
		 */
		function get wordWrap():Boolean;
		function set wordWrap(value:Boolean):void
		
		/**
		 * 	<strong>[Deprecated]</strong> Returns the <code>StyleSheet</code> object 
		 * 	that is set to render the text displayed within this <code>UIContainer</code>
		 * 	instance.
		 * 
		 * 	@return The <code>StyleSheet</code> object for this <code>UIContainer</code>
		 * 	instance.
		 * 
		 * 	@see #setStyle()
		 */
		function getStyle():StyleSheet;
		
		/**
		 * 	<strong>[Deprecated]</strong> Sets the <code>StyleSheet</code> object 
		 * 	that is used to render the text displayed within this <code>UIContainer</code>
		 * 	instance.
		 * 
		 * 	@param	value A <code>StyleSheet</code> object a URI which links to a valid
		 * 	CSS file.
		 * 
		 * 	@see #setStyle()
		 */
		function setStyle(value:*):void;
	}
}