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

package org.flashapi.swing.sound.analizer {
	
	// -----------------------------------------------------------
	// AnalizerLibrary.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 07/08/2009 01:22
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.sound.SoundAnalizerDTO;
	
	/**
	 * 	The <code>AnalizerLibrary</code> interface defines the basic set of APIs that 
	 * 	you must implement to create visual sound representation libraries to be used
	 * 	with <code>SoundAnalizer</code> objects.
	 * 
	 * 	@see org.flashapi.swing.SoundAnalizer
	 * 	@see org.flashapi.swing.sound.analizer.AbstractAnalizer
	 * 	@see org.flashapi.swing.sound.analizer.DefaultAnalizer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface AnalizerLibrary {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//FFTMode:Boolean = false, stretchFactor:int = 0
		
		/**
		 * 	Finalizes this <code>AnalizerLibrary</code> object to make it elligible 
		 * 	for garbage collection.
		 * 
		 * 	@param	soundDTO	The <code>SoundAnalizerDTO</code> object that contains
		 * 						properties defined by the <code>SoundAnalizer</code>
		 * 						that use this library.
		 */
		function finalize(soundDTO:SoundAnalizerDTO):void;
		
		/**
		 * 	Initializes the spectrum visualization that renders this library.
		 * 
		 * 	@param	soundDTO	The <code>SoundAnalizerDTO</code> object that contains
		 * 						properties defined by the <code>SoundAnalizer</code>
		 * 						that use this library.
		 */
		function initSpectrum(soundDTO:SoundAnalizerDTO):void;
		
		/**
		 * 	Updates the spectrum visualization that renders this library.
		 * 
		 * 	@param	soundDTO	The <code>SoundAnalizerDTO</code> object that contains
		 * 						properties defined by the <code>SoundAnalizer</code>
		 * 						that use this library.
		 */
		function drawSpectrum(soundDTO:SoundAnalizerDTO):void;
		
		/**
		 * 	Resizes the spectrum visualization that renders this library.
		 * 
		 * 	@param	soundDTO	The <code>SoundAnalizerDTO</code> object that contains
		 * 						properties defined by the <code>SoundAnalizer</code>
		 * 						that use this library.
		 */
		function resizeSpectrum(soundDTO:SoundAnalizerDTO):void;
		
		/**
		 *  Returns the background color of the <code>SoundAnalizer</code>,
		 * 	specified by this library.
		 * 
		 * 	@default 0xFFFFFF
		 */
		function getBackgroundColor():uint;
		
		/**
		 *  Returns the border style of the <code>SoundAnalizer</code>,
		 * 	specified by this library.
		 * 
		 * 	@default BorderStyle.NONE
		 */
		function getBorderStyle():String;
		
		//function getBorderColor():uint;
		
		/**
		 * 	@default 1000
		 */
		function getRessourceManagerDelay():uint;
		
		/**
		 * 	Returns a <code>Boolean</code> value that indicates whether the
		 * 	<code>AnalizerLibrary</code> specifies the <code>SoundAnalizer</code>
		 * 	to use a gradient background (<code>true</code>), or not
		 * 	(<code>false</code>).
		 * 
		 * 	@return
		 * 
		 * 	@default false 	A <code>Boolean</code> value to indicate whether
		 * 					to use a gradient background, or not.
		 * 
		 * 	@see #getGradientProperties()
		 */
		function getGradientMode():Boolean;
		
		/**
		 * 	Returns an <code>Object</code> that defines the gradient background
		 * 	properties to use with the <code>SoundAnalizer</code> when the
		 * 	value returned by the <code>getGradientMode()</code> method is
		 * 	<code>true</code>.
		 * 
		 * 	@return An <code>Object</code> that defines the gradient background
		 * 			properties of the <code>SoundAnalizer</code>.
		 * 
		 * 	@default null
		 * 
		 * 	@see #getGradientMode()
		 */
		function getGradientProperties():Object;
	}
}