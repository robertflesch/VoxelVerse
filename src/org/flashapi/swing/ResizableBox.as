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
	//  ResizableBox.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 12/03/2011 14:24
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.ResizableUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.decorator.ResizableDecorator;
	
	use namespace spas_internal;
	
	[IconFile("ResizableBox.png")]
	
	/**
	 * 	<img src="ResizableBox.png" alt="ResizableBox" width="18" height="18"/>
	 * 
	 *	The <code>ResizableBox</code> control is a rectangular or rounded rectangular box,
	 * 	based partly on the CSS box model, which can be resized by users.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class ResizableBox extends Box implements Initializable, ResizableUIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ResizableBox</code> instance with the specified
		 * 	parameters.
		 * 
		 * 	@param	width 	The width of the <code>ResizableBox</code> instance, in
		 * 					pixels.
		 * 	@param	height 	The height of the <code>ResizableBox</code> instance, in
		 * 					pixels.
		 * 	@param	borderStyle The type of border for this the <code>ResizableBox</code>
		 * 						instance, defined by the <code>BorderStyle</code> class.
		 * 						Default value is <code>BorderStyle.NONE</code>.
		 */
		public function ResizableBox(width:Number = 100, height:Number = 100, borderStyle:String = "none") {
			super(width, height, borderStyle);
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
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			_resizer.finalize();
			_resizer = null;
			super.finalize();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function deactivateHandles(... rest):void {
			_resizer.deactivateHandles(rest);
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function activateHandles(... rest):void {
			_resizer.activateHandles(rest);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _resizer:ResizableDecorator;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			initResizer();
			spas_internal::isInitialized(2);
		}
		
		private function initResizer():void {
			_resizer = new ResizableDecorator(this);
		}
	}
}