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

package org.flashapi.swing.scroll {
	
	// -----------------------------------------------------------
	// ScrollableThumb.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/02/2011 20:40
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.tween.core.Easing;
	
	/**
	 *  The <code>ScrollableThumb</code> interface  defines the basic set of APIs that 
	 * 	you must implement to create SPAS 3.0 visual <code>Scrollable</code> that
	 * 	allow user to move a thumb along a scroll track.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ScrollableThumb {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.scroll.Scrollable#decimalMode
		 */
		function get decimalMode():Boolean;
		function set decimalMode(value:Boolean):void;
		
		/**
		 * 	Sets or gets the duration of the animation that moves the thumb
		 * 	to the mouse position when the user clicks on the scroll track.
		 * 
		 * 	@default 300
		 * 
		 * 	@see #setEasingFunction()
		 */
		function get slideDuration():Number;
		function set slideDuration(value:Number):void;
		
		/**
		 *  Returns the length of the scroll thumb, in pixels.
		 */
		function get thumbLength():Number;
		
		/**
		 * 	Sest or gets the increment value of the <code>ScrollableThumb</code>
		 * 	instance while the user moves the thumb. For example, if <code>snapInterval</code>
		 * 	is <code>2</code>, 	the <code>minimum</code> value is <code>0</code> and
		 * 	the <code>maximum</code> value is <code>10</code>, the thumb snaps to the
		 * 	values <code>0</code>, <code>2</code>, <code>4</code>, <code>6</code>,
		 * 	<code>8</code> and <code>10</code> while the user moves the thumb.
		 * 	A value of <code>1</code> means that the thumb moves continuously between
		 * 	the <code>minimum</code> and <code>maximum</code> values.
		 * 
		 * 	@default 10
		 * 
		 * 	@see #minimum
		 * 	@see #maximum
		 */
		function get snapInterval():Number;
		function set snapInterval(value:Number):void;
		
		/**
		 * 	Sets or gets the color of the value track of this <code>ScrollableThumb</code>
		 * 	instance. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 * 
		 * 	<p>In <code>NaN</code> the color of the value track is defined by 
		 * 	the current Look and Feel.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #clearHighlight()
		 * 	@see #drawHighlight()
		 * 
		 * 	@default NaN
		 */
		function get highlightColor():*;
		function set highlightColor(value:*):void;
		
		/**
		 * 	A <code>Number</code> that represents the minimum available value for the
		 * 	<code>ScrollableThumb</code> instance.
		 * 
		 * 	@see #maximum
		 */
		function get minimum():Number;
		function set minimum(value:Number):void;
		
		/**
		 * 	A <code>Number</code> that represents the maximum available value for the
		 * 	<code>ScrollableThumb</code> instance.
		 * 
		 * 	@see #minimum
		 */
		function get maximum():Number;
		function set maximum(value:Number):void;
		
		/**
		 * 	Gets or sets the current value of this <code>ScrollableThumb</code>
		 * 	instance.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #percentValue
		 */
		function get value():Number;
		function set value(value:Number):void;
		
		/**
		 * 	Gets or sets the current value of this <code>ScrollableThumb</code>
		 * 	instance, in percentage.
		 * 
		 * 	@default 0
		 * 
		 * 	@see #value
		 */
		function get percentValue():Number;
		function set percentValue(value:Number):void;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies the <code>Easing</code> function used to animate the thumb
		 * 	when the user clicks on the track of this <code>ScrollableThumb</code>
		 * 	instance.
		 * 
		 * 	@param	value	An <code>Easing</code> function that defines the animation
		 * 					used to move the thumb when the user clicks on the track.
		 * 					If <code>null</code>, the thumb is not animated. 
		 * 					Default value is <code>null</code>.
		 * 
		 * 	@see #slideDuration
		 */
		function setEasingFunction(value:Easing):void;
		
		/**
		 * 	Clears the highlight of the value track within this <code>ScrollableThumb</code>
		 * 	instance.
		 * 
		 * 	@see #drawHighlight()
		 */
		function clearHighlight():void;
		
		/**
		 * 	Highlights the value track of this <code>ScrollableThumb</code> instance.
		 * 
		 * 	@param	minimum		The starting position for highlighting the value track.
		 * 	@param	maximum		The ending position for highlighting the value track.
		 * 
		 * 	@see #clearHighlight()
		 * 	@see #highlightColor
		 */
		function drawHighlight(minimum:Number = 0, maximum:Number = 100):void;
	}
}