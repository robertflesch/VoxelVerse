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

package org.flashapi.swing.plaf.basic {
	
	// -----------------------------------------------------------
	// BasicPictureGalleryUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/07/2008 22:14
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.plaf.core.LafDTO;
	import org.flashapi.swing.plaf.PictureGalleryUI;
	
	/**
	 * 	The <code>BasicPictureGalleryUI</code> class is the SPAS 3.0 "flex-like" look and feel
	 * 	for <code>PictureGallery</code> instances.
	 * 
	 * 	@see org.flashapi.swing.PictureGallery
	 * 	@see org.flashapi.swing.plaf.PictureGalleryUI
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class BasicPictureGalleryUI extends BasicUI implements PictureGalleryUI {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@copy org.flashapi.swing.plaf.spas.SpasBoxHelpUI#SpasBoxHelpUI()
		 */
		public function BasicPictureGalleryUI(dto:LafDTO) {
			super(dto);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc 
		 */
		public function getBoxLaf():Class {
			return BasicBoxUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getThumbnailLaf():Class {
			return BasicThumbnailUI;
		}
		
		/**
		 *  @inheritDoc 
		 */
		public function getTextLaf():Class {
			return BasicTextUI;
		}
	}
}