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

package org.flashapi.swing.textures {
	
	// -----------------------------------------------------------
	// Texture.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 25/05/2008 16:20
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	
	/**
	 * 	The <code>Texture</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 programmatic textures.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Texture {
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a <code>String</code> that represents the name of this <code>Texture</code>
		 * 	instance.
		 */
		function get name():String;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Use the <code>finalize()</code> method to ensure that all internal process
		 * 	of a <code>Texture</code> object are killed before you delete it. Typically,
		 * 	the <code>finalize</code> action should remove all <code>BitmapData</code>
		 * 	instances associated with this objects.
		 * 
		 * 	<p><strong>After calling this function you must set the object to <code>null</code>
		 * 	to definitely kill it.</strong></p>
		 */
		function finalize():void;
		
		/**
		 * 	Creates a <code>BitmapData</code> instance with the specified  <code>width</code>
		 * 	and  <code>height</code>, then applies this <code>Texture</code> to it by
		 * 	calling the <code>render()</code> method.
		 * 
		 * 	@param	width	The width of the created <code>BitmapData</code> instance,
		 * 					in pixels.
		 * 	@param	height	The height of the created <code>BitmapData</code> instance,
		 * 					in pixels.
		 * 
		 * 	@return	The <code>BitmapData</code> instance that is used to render this 
		 * 			<code>Texture</code> object.
		 * 
		 * 	@see #render()
		 */
		function createBitmap(width:Number, height:Number):BitmapData;
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Applies the effect define by this <code>Texture</code> object to the
		 * 	<code>BitmapData</code> instance specified by the <code>bmp</code> parameter.
		 * 
		 * 	@param	bmp	The <code>BitmapData</code> instance on which to apply
		 * 				the texuring process.
		 * 
		 * 	@see #createBitmap()
		 */
		function render(bmp:BitmapData):void;
	}
}