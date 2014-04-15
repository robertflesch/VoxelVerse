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
	// ResizablePanel.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 11/03/2011 17:10
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.ResizableUIObject;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.decorator.ResizableDecorator;
	
	use namespace spas_internal;
	
	[IconFile("ResizablePanel.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the resizing operation starts.
	 *
	 *  @eventType org.flashapi.swing.event.ResizerEvent.RESIZE_START
	 */
	[Event(name = "resizeStart", type = "org.flashapi.swing.event.ResizerEvent")]
	
	/**
	 *  Dispatched when the resizing operation is finished: the user releases the
	 * 	mouse button after having performed a resizing operation.
	 *
	 *  @eventType org.flashapi.swing.event.ResizerEvent.RESIZE_FINISH
	 */
	[Event(name = "resizeFinish", type = "org.flashapi.swing.event.ResizerEvent")]
	
	/**
	 *  Dispatched when the bounds of the <code>ResizablePanel</code> instance change
	 * 	during a resizing operation.
	 *
	 *  @eventType org.flashapi.swing.event.ResizerEvent.RESIZE_UPDATE
	 */
	[Event(name = "resizeUpdate", type = "org.flashapi.swing.event.ResizerEvent")]
	
	/**
	 * 	<img src="ResizablePanel.png" alt="ResizablePanel" width="18" height="18"/>
	 * 
	 * 	A <code>ResizablePanel</code> object consists in a <code>Panel</code> instance
	 * 	which can be resized by users.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class ResizablePanel extends Panel implements Initializable, ResizableUIObject {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>ResizablePanel</code> intance with the
		 * 					specified parameters.
		 * 
		 * 	@param	width	The width of the <code>ResizablePanel</code> intance, in
		 * 					pixels.
		 * 	@param	height	The height of the <code>ResizablePanel</code> intance, in
		 * 					pixels.
		 */
		public function ResizablePanel(width:Number = 150, height:Number = 130) {
			super(width, height);
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