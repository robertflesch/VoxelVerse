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

package org.flashapi.swing.scroll {
	
	// -----------------------------------------------------------
	// ColorizableScrollbarDTO.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 11/04/2011 01:57
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	<code>ColorizableScrollbarDTO</code> proxy objects provide access to the
	 * 	colors specified by the <code>ColorizableScrollbar</code> interface.
	 * 
	 * 	@see org.flashapi.swing.scroll.Scrollable
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ColorizableScrollbarDTO extends Object {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>ColorizableScrollbarDTO</code> instance
		 * 	for the <code>ColorizableScrollbar</code> target object.
		 * 
		 * 	@param	target	The <code>ColorizableScrollbar</code> object for which this
		 * 					<code>ColorizableScrollbarDTO</code> instance is defined.
		 */
		public function ColorizableScrollbarDTO(target:ColorizableScrollbar) {
			super();
			initObj(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the color of the arrow elements of a scroll arrow.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarArrowColor():* {
			return _tgt.scrollbarArrowColor;
		}
		
		/**
		 * 	Returns the color of the main elements of a scroll bar,
		 * 	which include the scroll box, track, and scroll arrows.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarBaseColor():* {
			return _tgt.scrollbarBaseColor;
		}
		
		/**
		 * Returns the color of the scroll box of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarFaceColor():* {
			return _tgt.scrollbarFaceColor;
		}
		
		/**
		 * 	Returns the highlighted line color of the scroll box of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarHighlightColor():* {
			return _tgt.scrollbarHighlightColor;
		}
		
		/**
		 * 	Returns the dark line color of the scroll box of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarShadowColor():* {
			return _tgt.scrollbarShadowColor;
		}
		
		/**
		 * 	Returns the color of the track element of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarTrackColor():* {
			return _tgt.scrollbarTrackColor;
		}
		
		/**
		 * 	Returns the color of the bottom-right corner of a scroll bar.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarJoinColor():* {
			return _tgt.scrollbarJoinColor;
		}
		
		/**
		 * 	Returns the color of the bottom-right corner of a scroll bar
		 * 	when the scroll bar is deactivated.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarInactiveJoinColor():* {
			return _tgt.scrollbarInactiveJoinColor;
		}
		
		
		/**
		 * 	Returns the color of the track element of a scroll bar
		 * 	when the scroll bar is deactivated.
		 * 
		 * 	@default NaN
		 */
		public function get scrollbarInactiveTrackColor():* {
			return _tgt.scrollbarInactiveTrackColor;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _tgt:ColorizableScrollbar;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(target:ColorizableScrollbar):void {
			_tgt = target;
		}
	}
}