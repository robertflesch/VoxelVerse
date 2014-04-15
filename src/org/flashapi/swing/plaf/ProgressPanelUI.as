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

package org.flashapi.swing.plaf {
	
	// -----------------------------------------------------------
	// ProgressPanelUI
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 10/11/2010 15:33
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ProgressPanelUI</code> interface defines the interface required to
	 * 	create <code>ProgressPanel</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.ProgressPanel
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public interface ProgressPanelUI extends LookAndFeel {
		
		/**
		 * 	Returns a number that represents the vertical gap between the value bar
		 * 	and the text displayed on the face of the <code>ProgressPanel</code>.
		 * 
		 *	@return The gap between the bar and the text displayed on the face of the
		 * 			<code>ProgressPanel</code>.
		 */
		function getLabelDelay():Number;
		
		/**
		 *	Returns the <code>ProgressPanel</code> top offset distance.
		 * 
		 *	@return The <code>ProgressPanel</code> top offset distance.
		 */
		function getTopOffset():Number;
		
		/**
		 *	Returns the <code>ProgressPanel</code> left offset distance.
		 * 
		 *	@return The <code>ProgressPanel</code> left offset distance.
		 */
		function getLeftOffset():Number;
		
		/**
		 *	Returns the <code>ProgressPanel</code> right offset distance.
		 * 
		 *	@return The <code>ProgressPanel</code> right offset distance.
		 */
		function getRightOffset():Number;
		
		/**
		 *	Returns the <code>ProgressPanel</code> bottom offset distance.
		 * 
		 *	@return The <code>ProgressPanel</code> bottom offset distance.
		 */
		function getBottomOffset():Number;
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
		
		/**
		 * 	Returns the default color of the progress panel label.
		 * 
		 * 	@return	The default color of the progress panel label.
		 */
		function getDefaultLabelColor():uint;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>ProgressPanel</code> progress bar. This class must implement the
		 * 	<code>ProgressBarUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>ProgressPanel</code>
		 * 			progress bar.
		 * 
		 * 	@see org.flashapi.swing.plaf.ProgressBarUI
		 */
		function getProgressBarLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>ProgressPanel</code> label. This class must implement the
		 * 	<code>PanelUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for the <code>ProgressPanel</code>
		 * 			label.
		 * 
		 * 	@see org.flashapi.swing.plaf.PanelUI
		 */
		function getPanelLaf():Class;
		
		/**
		 * 	Returns the a reference of the class used as look and feel for
		 * 	the <code>ProgressPanel</code> text. This class must implement the
		 * 	<code>LabelUI</code> interface.
		 * 
		 * 	@return The class used as look and feel for <code>ProgressPanel</code>
		 * 			text.
		 * 
		 * 	@see org.flashapi.swing.plaf.LabelUI
		 */
		function getLabelLaf():Class;
	}
}