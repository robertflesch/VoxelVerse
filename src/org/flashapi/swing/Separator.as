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
	// Separator.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.4, 17/03/2010 22:04
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Point;
	import org.flashapi.swing.constants.SeparatorOrientation;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.geom.Segment;
	import org.flashapi.swing.plaf.libs.SeparatorUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Separator.png")]
	
	/**
	 * 	<img src="Separator.png" alt="Separator" width="18" height="18"/>
	 * 
	 * 	The <code>Separator</code> class creates dividers between menu items that
	 * 	breaks them up into logical groupings. <code>Separator</code> objects
	 * 	can be displayed vertically or horizontally. To create exclusive
	 * 	vertical or horizontal separators, use the <code>HorizontalSeparator</code>
	 * 	or the <code>VerticalSeparator</code> classes.
	 * 
	 * <p><strong><code>Separator</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">orientation</code></td>
	 * 			<td>Sets the object orientation.</td>
	 * 			<td>Valid values are <code class="css">horizontal</code> and
	 * 			<code class="css">vertical</code></td>
	 * 			<td><code>orientation</code></td>
	 * 			<td>Properties.ORIENTATION</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@see org.flashapi.swing.HorizontalSeparator
	 * 	@see org.flashapi.swing.VerticalSeparator
	 * 
	 *  @includeExample SeparatorExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Separator extends UIObject implements Observer, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.	Creates a new <code>Separator</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	length 		The lenght of the <code>Separator</code> instance,
		 * 						in pixels.
		 * 	@param	orientation	The orientation of the <code>Separator</code> instance.
		 * 						Valid values are <code>SeparatorOrientation.VERTICAL</code>
		 * 						or <code>SeparatorOrientation.HORIZONTAL</code>.
		 * 						Default value is <code>SeparatorOrientation.VERTICAL</code>.
		 */
		public function Separator(length:Number = 100, orientation:String =	"vertical") {
			super();
			initObj(length, orientation);
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
		 *  @private
		 */
		override public function get height():Number {
			return _orientation == SeparatorOrientation.HORIZONTAL ?
				spas_internal::uioSprite.height : _length;
		}
		
		/**
		 *  @private
		 */
		override public function set height(value:Number):void {
			if (_orientation == SeparatorOrientation.VERTICAL) {
				_length = value;
				setRefresh();
			}
		}
		
		private var _length:Number;
		/**
		 * 	Sets or gets the lenght of the <code>Separator</code> instance, in
		 * 	pixels.
		 * 
		 * 	@default 100
		 */
		public function get length():Number {
			return _length;
		}
		public function set length(value:Number):void { 
			_length = value;
			setRefresh();
		}
		
		private var _orientation:String = SeparatorOrientation.VERTICAL;
		/**
		 * 	Sets or gets the orientation of the <code>Separator</code> instance.
		 * 	<p>Possible values are:
		 * 		<ul>
		 * 			<li>SeparatorOrientation.VERTICAL,</li>
		 * 			<li>SeparatorOrientation.HORIZONTAL.</li>
		 * 		</ul>
		 *	</p>
		 * 	<p>
		 * 	If <code>SeparatorOrientation.VERTICAL</code>, the separator is displayed
		 * 	vertically; if <code>SeparatorOrientation.HORIZONTAL</code>, the separator
		 * 	is displayed horizontally.</p>
		 * 
		 * 	@default SeparatorOrientation.VERTICAL
		 */
		public function get orientation():String {
			return _orientation;
		}
		public function set orientation(value:String):void {
			_orientation = value;
			spas_internal::metricsChanged = true;
			setRefresh();
		}
		
		/**
		 * 	Returns the thickness of the <code>Separator</code> instance,
		 * 	in pixels.
		 */
		public function get thickness():Number {
			return orientation == SeparatorOrientation.VERTICAL ?
						spas_internal::uioSprite.width : spas_internal::uioSprite.height;
		}
		
		/**
		 *  @private
		 */
		override public function get width():Number {
			return _orientation == SeparatorOrientation.HORIZONTAL ?
						_length : spas_internal::uioSprite.width;
		}
		
		/**
		 *  @private
		 */
		override public function set width(value:Number):void {
			if (_orientation == SeparatorOrientation.HORIZONTAL) {
				_length = value;
				setRefresh();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			var pt1:Point = _segH.b;
			var pt2:Point = _segS.a;
			var pt3:Point = _segS.b;
			switch (orientation) {
				case SeparatorOrientation.VERTICAL:
					pt1.x = pt2.y = 0;
					pt3.x = pt2.x = 1;
					pt1.y = pt3.y = _length;
					break;
				case SeparatorOrientation.HORIZONTAL:
					pt1.y = pt2.x = 0;
					pt2.y = pt3.y = 1;
					pt1.x = pt3.x = _length;
					break;
			}
			lookAndFeel.drawLines();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _segH:Segment;
		private var _segS:Segment;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(length:Number, orientation:String):void {
			_length = length;
			_orientation = orientation;
			_segH = new Segment();
			_segS = new Segment();
			spas_internal::lafDTO.highlightLine = _segH;
			spas_internal::lafDTO.shadowLine = _segS;
			initLaf(SeparatorUIRef);
			spas_internal::setSelector(Selectors.SEPARATOR);
			spas_internal::isInitialized(1);
		}
	}
}