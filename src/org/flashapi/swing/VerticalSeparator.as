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
	// VerticalSeparator.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 18/06/2009 21:11
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.SeparatorOrientation;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("VerticalSeparator.png")]
	
	/**
	 * 	<img src="VerticalSeparator.png" alt="VerticalSeparator" width="18" height="18"/>
	 * 
	 * 	The <code>VerticalSeparator</code> class creates vertical dividers between
	 * 	menu items that breaks them up into logical groupings.
	 * 
	 *  @includeExample VerticalSeparatorExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class VerticalSeparator extends Separator implements Observer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>VerticalSeparator</code> instance
		 * 					with the specified length.
		 * 
		 * 	@param	length 	The lenght of the <code>VerticalSeparator</code> instance,
		 * 					in pixels.
		 */
		public function VerticalSeparator(length:Number = 100) {
			super(length, SeparatorOrientation.VERTICAL);
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 2;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function set orientation(value:String):void { }
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			spas_internal::isInitialized(2);
		}
	}
}