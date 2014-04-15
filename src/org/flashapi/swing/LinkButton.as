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
	// LinkButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 16/03/2010 22:04
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.button.core.ABM;
	import org.flashapi.swing.constants.HorizontalAlignment;
	import org.flashapi.swing.constants.LabelPlacement;
	import org.flashapi.swing.constants.VerticalAlignment;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.framework.locale.Locale;
	import org.flashapi.swing.plaf.libs.LinkButtonUIRef;
	import org.flashapi.swing.state.OpacityState;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("LinkButton.png")]
	
	/**
	 * 	<img src="LinkButton.png" alt="LinkButton" width="18" height="18"/>
	 * 
	 * 	The <code>LinkButton</code> class is a borderless <code>Button</code>
	 * 	class whose contents are highlighted when a user moves the mouse over it.
	 * 	These traits are often exhibited by HTML links contained within a
	 * 	browser page. In order for the <code>LinkButton</code> class to
	 * 	perform some action, you must specify a click event handler,
	 * 	as you do with a <code>Button</code> instance.
	 * 
	 * 	<p><strong><code>LinkButton</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">highlight-opacity</code></td>
	 * 			<td>Sets the highlighted-state opacity for this object.</td>
	 * 			<td>Posible values are numbers from <code>0</code> (fully transparent)
	 * 			to <code>1</code> (fully opaque).</td>
	 * 			<td><code>highlightOpacity</code></td>
	 * 			<td><code>Properties.HIGHLIGHT_OPACITY</code></td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 
	 * 	@includeExample LinkButtonExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class LinkButton extends ABM implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>LinkButton</code> instance with the
		 * 					specified parameters
		 * 	
		 * 	@param	label 	Text to display within the <code>LinkButton</code> instance. 
		 * 					If the label is wider than the width of the <code>LinkButton</code>
		 * 					instance, it is truncated and terminated by an ellipsis
		 * 					(...). The default value is <code>LinkButton</code>.
		 * 	@param	width 	The width of the <code>LinkButton</code> instance, in pixels.
		 * 					If <code>NaN</code>, the button width is internally computed
		 * 					to allow label to not being truncated. In that case, the
		 * 					<code>autoWidth</code> is set to <code>true</code>.
		 * 					Default value is <code>NaN</code>.
		 * 	@param	height 	The height of the <code>LinkButton</code> instance, in pixels.
		 * 					If <code>NaN</code>, the button height is internally computed
		 * 					to allow label to not being truncated. In that case, the
		 * 					<code>autoHeight</code> is set to <code>true</code>.
		 * 					Default value is <code>NaN</code>.
		 * 	@param	htmlText 	Specifies whether the text to display within the
		 * 						<code>LinkButton</code> instance is HTML (<code>true</code>),
		 * 						or not (<code>false</code>).
		 * 						Default value is <code>false</code>.
		 * 	
		 * 	<p><strong>Note: </strong>if width and height parameters are both set to
		 * 	<code>NaN</code>, the <code>autoSize</code> property is automatically set to
		 * 	<code>true</code>.</p>
		 */
		public function LinkButton(label:String = null, width:Number = NaN, height:Number = NaN, htmlText:Boolean = false) {
			super();
			initObj(label, width, height, htmlText);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Initialization ID constant
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	Stores the internal value for the <code>highlightOpacity</code> property.
		 * 
		 * 	@see #highlightOpacity
		 */
		protected var $opacity:OpacityState;
		/**
		 * 	An <code>OpacityState</code> object. The <code>highlightOpacity</code>
		 * 	property sets and gets the highlight opacity of the link button for each
		 * 	state. <code>OpacityState</code> instances define five different states:
		 * <ul>
		 * 		<li><code>OpacityState.disabled</code>,</li>
		 * 		<li><code>OpacityState.down</code>,</li>
		 * 		<li><code>OpacityState.over</code>,</li>
		 *  	<li><code>OpacityState.up</code>,</li>
		 * 		<li><code>OpacityState.selected</code>.</li>
		 * 	</ul>
		 * 
		 * 	@see org.flashapi.swing.state.OpacityState
		 */
		public function get highlightOpacity():OpacityState {
			return $opacity;
		} 
		public function set highlightOpacity(value:OpacityState):void {
			spas_internal::lafDTO.highlightOpacity = $opacity = value;
			setRefresh();
		}
		
		/**
		 *  @private
		 */
		override public function set active(value:Boolean):void {
			spas_internal::lafDTO.active = $active = value;
			setButtonMode();
			setRefresh();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function finalize():void {
			spas_internal::lafDTO.highlightOpacity = null;
			$opacity = null;
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(label:String, width:Number, height:Number, htmlText:Boolean):void {
			init(label == null ? Locale.spas_internal::LABELS.LINK_BUTTON_LABEL : label,
				width, height, htmlText);
			initMinSize(5, 5);
			initLaf(LinkButtonUIRef);
			$vAlign = VerticalAlignment.TOP;
			$hAlign = HorizontalAlignment.LEFT; 
			$labelPlacement = LabelPlacement.RIGHT;
			initTextField();
			$opacity = new OpacityState(this);
			$opacity.up = 0;
			$opacity.over = $opacity.down = .8;
			spas_internal::lafDTO.highlightOpacity = $opacity;
			setButtonMode();
			spas_internal::setSelector(Selectors.LINK_BUTTON);
			spas_internal::isInitialized(1);
		}
		
		private function setButtonMode():void {
			$hitArea.buttonMode = $hitArea.useHandCursor = $active;
		}
	}
}