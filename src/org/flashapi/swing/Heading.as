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
	// Heading.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 06/03/2009 22:20
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.HeadingLevel;
	import org.flashapi.swing.constants.HeadingSize;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("Heading.png")]
	
	/**
	 * 	<img src="Heading.png" alt="Heading" width="18" height="18"/>
	 * 
	 * 	The <code>Heading</code> class represents the SPAS 3.0 equivalent for the
	 * 	HTML headings that are defined by HTML tags from <code>&lt;h1&gt;</code> to 
	 * 	<code>&lt;h6&gt;</code>.
	 * 
	 * 	<p><code>Heading</code> objects help to define the hierarchy and the
	 * 	structure of a web page.
	 * 	Like in HTML, there are six levels of headings in SPAS 3.0, defined by the 
	 * 	<code>HeadingLevel</code> class constants, with <code>HeadingLevel.H1</code>
	 * 	as the most important and <code>HeadingLevel.H6</code> as the least.
	 * 	The following table shows the correspondance between headings levels
	 * 	(defined by the <code>HeadingLevel</code> class) and heading sizes
	 * 	(defined by the <code>HeadingSize</code> class):</p>
	 * 
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Level</th>
	 * 			<th><code>HeadingLevel</code> constant</th>
	 * 			<th><code>HeadingSize</code> constant</th>
	 * 			<th>Type size</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>h1</code></td>
	 * 			<td><code>HeadingLevel.H1</code></td>
	 * 			<td><code>HeadingSize.H1Size</code></td>
	 * 			<td><code>24</code> point type - largest</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>h2</code></td>
	 * 			<td><code>HeadingLevel.H2</code></td>
	 * 			<td><code>HeadingSize.H2Size</code></td>
	 * 			<td><code>18</code> point type</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>h3</code></td>
	 * 			<td><code>HeadingLevel.H3</code></td>
	 * 			<td><code>HeadingSize.H3Size</code></td>
	 * 			<td><code>14</code> point type</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>h4</code></td>
	 * 			<td><code>HeadingLevel.H4</code></td>
	 * 			<td><code>HeadingSize.H4Size</code></td>
	 * 			<td><code>12</code> point type</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>h5</code></td>
	 * 			<td><code>HeadingLevel.H5</code></td>
	 * 			<td><code>HeadingSize.H5Size</code></td>
	 * 			<td><code>10</code> point type</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>h6</code></td>
	 * 			<td><code>HeadingLevel.H6</code></td>
	 * 			<td><code>HeadingSize.H6Size</code></td>
	 * 			<td><code>8</code> point type - smallest</td>
	 * 		</tr>
	 * 	</table>
	 * 
	 * 	@see org.flashapi.swing.constants.HeadingLevel
	 * 	@see org.flashapi.swing.constants.HeadingSize
	 * 
	 * 	@includeExample HeadingExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Heading extends Label implements Observer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>Heading</code> instance with the
		 * 					specified parameters.
		 * 
		 *	@param	label 	Specifies the plain text displayed by this <code>Heading</code>
		 * 					instance. Its appearance is determined by the Look and Feel
		 * 					of the <code>Label</code> class and then, by the CSS style,
		 * 					of the <code>Heading</code> instance. 
		 *	@param	level	A constant of the <code>HeadingLevel</code> class that
		 * 					specifies one of the six levels of HTML-like "heading levels".
		 * 					Default value is <code>HeadingLevel.H1</code>
		 * 	@param	width	The width of the <code>Heading</code> instance, in pixels.
		 * 					If <code>NaN</code>, the width of the <code>Heading</code>
		 * 					instance is automatically adjusted to display all characters
		 * 					from the <code>label</code> property.
		 * 					Default value is <code>NaN</code>.
		 */
		public function Heading(label:String = "", level:String = "h1", width:Number = NaN) {
			super(label, width);
			initObj(level);
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
		
		private var _level:String;
		/**
		 * 	Sets or gets the current level of this <code>Heading</code> instance.
		 * 	Possible values are constants of the <code>HeadingLevel</code> class.
		 * 
		 * 	@default HeadingLevel.H1
		 */
		public function get level():String {
			return _level;
		}
		public function set level(value:String):void {
			_level = value;
			setHeadingSize();
			spas_internal::setSelector(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(level:String):void {
			$textFormat.bold = true;
			this.level = level;
			spas_internal::isInitialized(2);
		}
		
		private function setHeadingSize():void {
			var s:uint;
			switch(_level) {
				case HeadingLevel.H1:
					s = HeadingSize.H1Size;
					break;
				case HeadingLevel.H2:
					s = HeadingSize.H2Size;
					break;
				case HeadingLevel.H3:
					s = HeadingSize.H3Size;
					break;
				case HeadingLevel.H4:
					s = HeadingSize.H4Size;
					break;
				case HeadingLevel.H5:
					s = HeadingSize.H5Size;
					break;
				case HeadingLevel.H6:
					s = HeadingSize.H6Size;
					break;
			}
			$textFormat.size = s;
			$needsTextFormatUpdate = true;
		}
	}
}