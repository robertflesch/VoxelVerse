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

package org.flashapi.swing {
	
	// -----------------------------------------------------------
	// SplashScreen.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 26/07/2009 18:57
	* @see http://www.flashapi.org/
	*/
	
	[IconFile("SplashScreen.png")]
	
	/**
	 * 	<img src="SplashScreen.png" alt="SplashScreen" width="18" height="18"/>
	 * 
	 * 	The <code>SplashScreen</code> class provides the API for controlling the  
	 * 	splash screen of a SPAS 3.0 application. <code>SplashScreen</code> are used to
	 * 	set the <code>splashScreen</code> property of <code>Initializator</code>
	 * 	instances.
	 * 
	 * 	<p>The splash screen is displayed as an undecorated frame containing an image.
	 * 	You can use bitmap or movie clip objects for the image. The frame is positioned
	 * 	at the center of the screen (the position on multi-monitor systems is not specified).
	 * 	The frame is removed automatically as soon as the associated 
	 * 	<code>Initializator</code>  is finalized.</p>
	 * 
	 *  @includeExample SplashScreenExample.as
	 * 
	 * 	@see org.flashapi.swing.Initializator#splashScreen
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class SplashScreen extends Object {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>SplashScreen</code> instance.
		 */
		public function SplashScreen() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The width of the <code>SplashScreen</code> instance, in pixels.
		 * 
		 * 	@see #height
		 */
		public var width:Number = 250;
		
		/**
		 * 	The height of the <code>SplashScreen</code> instance, in pixels.
		 * 
		 * 	@see #width
		 */
		public var height:Number = 200;
		
		/**
		 * 	The skin used to create the <code>SplashScreen</code> instance.
		 */
		public var skin:*;
		
		/**
		 * 	The left padding property for the <code>SplashScreen</code> instance,
		 * 	in pixels.
		 * 
		 * 	@see #paddingBottom
		 * 	@see #paddingRight
		 * 	@see #paddingTop
		 */
		public var paddingLeft:Number = 0;
		
		/**
		 * 	The right padding property for the <code>SplashScreen</code> instance,
		 * 	in pixels.
		 * 
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 * 	@see #paddingTop
		 */
		public var paddingRight:Number = 0;
		
		/**
		 * 	The top padding property for the <code>SplashScreen</code> instance,
		 * 	in pixels.
		 * 
		 * 	@see #paddingBottom
		 * 	@see #paddingLeft
		 * 	@see #paddingRight
		 */
		public var paddingTop:Number = 0;
		
		/**
		 * 	The bottom padding property for the <code>SplashScreen</code> instance,
		 * 	in pixels.
		 * 
		 * 	@see #paddingTop
		 * 	@see #paddingLeft
		 * 	@see #paddingRight
		 */
		public var paddingBottom:Number = 0;
	}
}