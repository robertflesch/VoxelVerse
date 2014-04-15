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

package org.flashapi.vsound.lib {
	
	// -----------------------------------------------------------
	// SpectrumRenderer.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 28/11/2010 09:34
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.BitmapData;
	
	/**
	 * 	The <code>SpectrumRenderer</code> interface provides a set of methods 
	 * 	for creating visual compute spectrum effects that can be rendered by
	 * 	<code>VSoundDisplayObject</code> class instances.
	 * 
	 * 	<p>Typically, <code>SpectrumRenderer</code> effects use the
	 * 	<code>SoundMixer.computeSpectrum()</code> method to perform the
	 * 	visual representation of a <code>Sound</code> object.</p>
	 * 
	 * 	@see org.flashapi.vsound.VSoundDisplayObject
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public interface SpectrumRenderer {
		
		/**
		 * 	The <code>init()</code> is called by the <code>VSoundDisplayObject</code>
		 * 	instance each time a new <code>SpectrumRenderer</code> object is created.
		 * 	Developers must use this method to initialize their visual compute spectrum
		 * 	effects.
		 * 	
		 * 	@param	buffer 	A reference to the <code>BitmapData</code> instance used
		 * 					by the calling <code>VSoundDisplayObject</code> object to
		 * 					render this compute spectrum visual effect.
		 * 
		 * 	@see #update()
		 */
		function init(buffer:BitmapData):void;
		
		/**
		 * 	The <code>update()</code> is called by the <code>VSoundDisplayObject</code>
		 * 	instance each time the visual compute spectrum effect needs to be redrawn.
		 * 	Developers must use this method to refresh their visual compute spectrum
		 * 	effects by reading data computed from the <code>SoundMixer.computeSpectrum()</code>
		 * 	method.
		 * 
		 * 	@param	buffer 	A reference to the <code>BitmapData</code> instance used
		 * 					by the calling <code>VSoundDisplayObject</code> object to
		 * 					render this compute spectrum visual effect.
		 * 
		 * 	@see #init()
		 */
		function update(buffer:BitmapData):void;
		
		/**
		 * 	Disposes this <code>SpectrumRenderer</code> instance.
		 */
		function dispose():void;
		
		/**
		 * 	Sets the size of this <code>SpectrumRenderer</code> instance to the specified
		 * 	<code>width</code> and <code>height</code>.
		 * 
		 * 	@param	width	The new width for the <code>SpectrumRenderer</code> instance,
		 * 					in pixels.
		 * 	@param	height	The new height for the <code>SpectrumRenderer</code> instance,
		 * 					in pixels.
		 */
		function resize(width:Number, height:Number):void;
	}
}