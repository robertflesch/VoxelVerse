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

package org.flashapi.swing.sound {
	
	// -----------------------------------------------------------
	// SoundAnalizerDTO.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/03/2009 20:52
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import org.flashapi.swing.core.spas_internal;
	
	use namespace spas_internal;
	
	/**
	 * 	The <code>SoundAnalizerDTO</code> class lets you create a data transfert   
	 * 	object to set use with <code>SoundAnalizer</code> instances.
	 * 
	 * 	@see org.flashapi.swing.SoundAnalizer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public dynamic class SoundAnalizerDTO extends Object {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>SoundAnalizerDTO</code> data transfert
		 * 	object.
		 */
		public function SoundAnalizerDTO() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>XSound</code> object which is linked to the <code>SoundAnalizer</code>
		 * 	instance associated with this <code>SoundAnalizerDTO</code> object.
		 */
		public var sound:XSound;
		
		/**
		 * 	The width of the <code>SoundAnalizer</code> instance associated with this
		 * 	<code>SoundAnalizerDTO</code> object, in pixels.
		 */
		public var width:Number;
		
		/**
		 * 	The height of the <code>SoundAnalizer</code> instance associated with this
		 * 	<code>SoundAnalizerDTO</code> object, in pixels.
		 */
		public var height:Number;
		
		/**
		 * 	The <code>Sprite</code> object that is used by the associated <code>SoundAnalizer</code>
		 * 	instance to render the custom visualization of the <code>sound</code>
		 * 	object.
		 * 
		 * 	@see #sound
		 */
		public var target:Sprite;
		
		/**
		 * 	The internal <code>ByteArray</code> object defined by the <code>SoundAnalizer</code>
		 * 	instance associated with this <code>SoundAnalizerDTO</code> object.
		 * 	This <code>ByteArray</code> object enables to read binary data of the
		 * 	<code>sound</code> object to render custom visualization trough an
		 * 	<code>AnalizerLibrary</code> object.
		 * 
		 * 	@see #sound
		 * 	@see org.flashapi.swing.sound.analizer.AnalizerLibrary#drawSpectrum()
		 */
		public var byteArray:ByteArray;
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		spas_internal function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		/**
		 * @private
		 */
		spas_internal function finalize():void {
			sound = null;
			byteArray = null;
		}
	}
}