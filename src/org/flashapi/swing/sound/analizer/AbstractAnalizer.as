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
	//  AbstractAnalizer.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.1, 04/06/2009 15:32
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.sound.SoundAnalizerDTO;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>AbstractAnalizer</code> class defines a set of abstract methods
	 * 	that must be implemented to create <code>AnalizerLibrary</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class AbstractAnalizer {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Constructor. Creates a new <code>AbstractAnalizer</code> instance.
		 */
		public function AbstractAnalizer() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function finalize(soundDTO:SoundAnalizerDTO):void {}
		
		/**
		 * 	@copy org.flashapi.swing.sound.analizer.AnalizerLibrary#initSpectrum()
		 */
		public function initSpectrum(soundDTO:SoundAnalizerDTO):void {}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the background color of the
		 * 	<code>AnalizerLibrary</code> object.
		 */
		protected var $backgroundColor:uint = 0xFFFFFF;
		/**
		 * 	@copy org.flashapi.swing.sound.analizer.AnalizerLibrary#getBackgroundColor()
		 */
		public function getBackgroundColor():uint {
			return $backgroundColor;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores an internal reference to the border style of the
		 * 	<code>AnalizerLibrary</code> object.
		 */
		protected var $borderStyle:String = BorderStyle.NONE;
		/**
		 * 	@copy org.flashapi.swing.sound.analizer.AnalizerLibrary#getBorderStyle()
		 */
		public function getBorderStyle():String {
			return $borderStyle;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An integer that indicates how long an <code>AbstractAnalizer</code> object
		 * 	has to render an <code>AnalizerLibrary</code> effect before definitely
		 * 	stop the rendering.
		 */
		protected var $ressourceManagerDelay:uint = 1000;
		/**
		 * 	@copy org.flashapi.swing.sound.analizer.AnalizerLibrary#getRessourceManagerDelay()
		 */
		public function getRessourceManagerDelay():uint {
			return $ressourceManagerDelay;
		}
		
		/**
		 * 	@copy org.flashapi.swing.sound.analizer.AnalizerLibrary#resizeSpectrum()
		 */
		public function resizeSpectrum(soundDTO:SoundAnalizerDTO):void { }
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal <code>Boolean</code> value that indicates whether the
		 * 	<code>AnalizerLibrary</code> object specifies to use a gradient background
		 * 	(<code>true</code>), or not (<code>false</code>).
		 */
		protected var $gradientMode:Boolean = false;
		/**
		 * 	@copy org.flashapi.swing.sound.analizer.AnalizerLibrary#getGradientMode()
		 */
		public function getGradientMode():Boolean {
			return $gradientMode;
		}
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An object that defines the properties of the gradient background for
		 * 	this <code>AnalizerLibrary</code> object.
		 */
		protected var $gradientProperties:Object = null;
		/**
		 * 	@copy org.flashapi.swing.sound.analizer.AnalizerLibrary#getGradientProperties()
		 */
		public function getGradientProperties():Object {
			return $gradientProperties;
		}
		
		//FFTMode:Boolean = false, stretchFactor:int = 0
	}
}