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

package org.flashapi.vsound {
	
	// -----------------------------------------------------------
	// VSoundDisplayObject.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/11/2010 15:23
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.IEventDispatcher;
	
	/**
	 * 	The <code>VSoundDisplayObject</code> interface defines methods for controlling
	 * 	"vsound" display objects.
	 * 	
	 * 	@see org.flashapi.vsound.VSound
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public interface VSoundDisplayObject extends IEventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		//  Acessors
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the height of the <code>VSoundDisplayObject</code> instance,
		 * 	in pixels.
		 * 
		 * 	@see #width
		 * 	@see #resize()
		 */
		function get height():Number;
		
		/**
		 * 	Returns the width of the <code>VSoundDisplayObject</code> instance,
		 * 	in pixels.
		 * 
		 * 	@see #height
		 * 	@see #resize()
		 */
		function get width():Number;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a boolean value that indicates whether the compute spectrum
		 * 	effects is rendering (<code>true</code>), or not (<code>false</code>).
		 * 
		 * 	@return	<code>true</code> if the compute spectrum effects is rendering.
		 * 			<code>false</code> otherwise.
		 */
		function isPlaying():Boolean;
		
		/**
		 * 	Starts the rendering of the <code>VSoundDisplayObject</code> object.
		 * 
		 * 	@see #stop()
		 */
		function play():void;
		
		/**
		 * 	Stops the rendering of the <code>VSoundDisplayObject</code> object.
		 * 
		 * 	@see #play()
		 */
		function stop():void;
		
		/**
		 * 	Sets the size of this <code>VSoundDisplayObject</code> instance to 
		 * 	the specified <code>width</code> and <code>height</code>.
		 * 
		 * 	@param	width	The new width for the <code>VSoundDisplayObject</code>
		 * 					instance, in pixels.
		 * 	@param	height	The new height for the <code>VSoundDisplayObject</code>
		 * 					instance, in pixels.
		 * 
		 * 	@see #width
		 * 	@see #height
		 */
		function resize(width:Number, height:Number):void;
		
		/**
		 * 	Disposes this <code>VSoundDisplayObject</code> instance. When you call the 
		 * 	<code>dispose()</code>, all internal sub-processes are destroyed to free
		 * 	memory. Once you have called this method, you must set the
		 * 	<code>VSoundDisplayObject</code> instance reference to <code>null</code>
		 * 	to definitely make it eligible for garbage collection.
		 */
		function dispose():void;
	}
}