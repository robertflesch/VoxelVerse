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
	// ButtonBar.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.3, 08/04/2011 17:47
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.Dictionary;
	import org.flashapi.swing.button.core.AbstractButtonBar;
	import org.flashapi.swing.constants.ButtonBarOrientation;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.list.ListItem;
	import org.flashapi.swing.plaf.libs.ButtonBarUIRef;
	import org.flashapi.swing.util.Iterator;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("ButtonBar.png")]
	
	/**
	 * 	<img src="ButtonBar.png" alt="ButtonBar" width="18" height="18"/>
	 * 
	 * 	The <code>ButtonBar</code> class defines a horizontal, or vertical, group
	 * 	of logically related buttons with a common look and feel and navigation.
	 * 
	 * 	<p>You can use the <code>toggleMode</code> property to define a group of
	 * 	toggle buttons from a <code>ButtonBar</code> instance.</p>
	 * 
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>ButtonBar</code> instance.
	 * 	Each item of the <code>DataProvider</code> object have to contain the following
	 * 	properties:</p>
	 * 	
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>label</code> property defined by 
	 * 			the <code>Button</code> class,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter for the
	 * 			<code>ButtonBar.addItem()</code> method,</li>
	 * 		<li><code>width:Number</code>; the <code>width</code> property defined by 
	 * 			the <code>UIObject</code> class,</li>
	 * 		<li><code>height:Number</code>; the <code>width</code> property defined by 
	 * 			the <code>UIObject</code> class,</li>
	 * 		<li><code>alt:String</code>; the <code>alt</code> property defined by 
	 * 			the <code>Button</code> class,</li>
	 * 		<li><code>selected:Boolean</code>; the <code>selected</code> property defined by 
	 * 			the <code>Button</code> class,</li>
	 * 		<li><code>active:Boolean</code>; the <code>active</code> property defined by 
	 * 			the <code>UIObject</code> class,</li>
	 * 		<li><code>className:String</code>; the <code>className</code> property defined by 
	 * 			the <code>UIObject</code> class,</li>
	 * 		<li><code>id:String</code>; the <code>id</code> property defined by 
	 * 			the <code>UIObject</code> class,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the URL to an external file, or the display object
	 * 			usually passed as parameter for the <code>Button.setIcon()</code> method,</li>
	 * 		<li><code>icon:Brush</code>; the <code>Brush</code> class reference usually
	 * 			passed as parameter for the <code>Button.drawIcon()</code> method.</li>
	 * 	</ul>
	 * 	
	 * 
	 * 	<p>You also can assign a <code>XMLQuery</code> object to a <code>ButtonBar</code>
	 * 	instance.</p>
	 * 
	 * 	<pre>
	 * 		&lt;?xml version="1.0" encoding="utf-8"?&gt;
	 *		&lt;spas:XMLQuery xmlns:spas="http://www.flashapi.org/spas" caller="ButtonBar" urlPath="my_URLPath"&gt;
	 *			&lt;item icon="my_icon.png" label="label" width="80" data="my_data" /&gt;
	 * 			...
	 *		&lt;/spas:XMLQuery&gt;
	 * 	</pre>
	 * 
	 * 	<p>The following table lists the attributes you can specify, their data types, and
	 * 	their purposes:</p>
	 * 
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Attribute</th>
	 * 			<th>Type</th>
	 * 			<th>Description</th>
	 * 		</tr> 
	 * 		<tr>
	 * 			<td><code>XMLQuery.caller</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Must be <code>"ButtonBar"</code>; if you set the <code>XMLQuery.strictMode</code>
	 * 			to <code>true</code> you must specifie this attribute.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.urlPath</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the URI used for the <code>ButtonBar.urlPath</code> property.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.label</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the text used as label for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.data</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>A string used as the <code>data</code> property for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.width</code></td>
	 * 			<td><code>Number</code></td>
	 * 			<td>Specifies the width for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.height</code></td>
	 * 			<td><code>Number</code></td>
	 * 			<td>Specifies the height for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.alt</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the alternate text for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.active</code></td>
	 * 			<td><code>Boolean</code></td>
	 * 			<td>Indicates whether this item is active (<code>true</code>),
	 * 			or not (<code>false</code>).</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.selected</code></td>
	 * 			<td><code>Boolean</code></td>
	 * 			<td>Indicates whether this item is selected (<code>true</code>),
	 * 			or not (<code>false</code>).</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.className</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the CSS class name for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.id</code></td>
	 * 			<td><code>String</code></td>
	 * 			<td>Specifies the CSS Unique Identifier for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.icon</code></td>
	 * 			<td><code><em>untyped</em></code></td>
	 * 			<td>Specifies the icon file for this item.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>XMLQuery.item.brush</code></td>
	 * 			<td><code>Brush</code></td>
	 * 			<td>Specifies the <code>Brush</code> class reference to draw
	 * 			the icon for this item.</td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	<p>The following codes illustrate three different ways of adding items to n
	 * 		<code>ButtonBar</code> instance:</p>
	 * 	<p>
	 * 		- using the <code>ButtonBar.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var bb:ButtonBar = new ButtonBar();
	 * 
	 * 			bb.addItem("Label 1", myData1);
	 * 			bb.addItem("Label 2", myData2);
	 * 			bb.addItem("Label 3", myData3);
	 * 			bb.addItem("Label 4", myData4);
	 * 
	 * 			bb.display();
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>ButtonBar.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var bb:ButtonBar = new ButtonBar();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 
	 * 			dp.addAll(  { label:"Label 1", icon:"icon_01.jpg", data:myData1 },
	 * 						{ label:"Label 2", icon:"icon_02.jpg", data:myData2 },
	 * 						{ label:"Label 3", icon:"icon_03.jpg", data:myData3 },
	 * 						{ label:"Label 4", icon:"icon_04.jpg", data:myData4 });
	 * 			bb.dataProvider = dp;
	 * 
	 * 			bb.display();
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>ButtonBar.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item icon="icon_1.jpg" label="Label 1" data="myData1" /&gt;
	 *								&lt;item icon="icon_2.jpg" label="Label 2" data="myData2" /&gt;
	 *								&lt;item icon="icon_3.jpg" label="Label 3" data="myData3" /&gt;
	 * 								&lt;item icon="icon_4.jpg" label="Label 4" data="myData4" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var bb:ButtonBar = new ButtonBar();
	 * 			bb.xmlQuery = request;
	 * 
	 * 			bb.display();
	 * 		</listing>
	 * 	</p>
	 * 
	 *  @includeExample ButtonBarExample.as
	 *
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.plaf.ButtonBarUI
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class ButtonBar extends AbstractButtonBar implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>ButtonBar</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	orientation	The buttonbar orientation. Possible values are 
		 * 						<code>ButtonBarOrientation.HORIZONTAL</code> or
		 * 						<code>ButtonBarOrientation.VERTICAL</code>. Default
		 * 						value is <code>ButtonBarOrientation.HORIZONTAL</code>.
		 * 	@param	width	The width od the <code>ButtonBar</code> instance, in pixels.
		 */
		public function ButtonBar(orientation:String = "horizontal", width:Number = 100) {
			super(orientation, width);
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
		spas_internal static const INIT_ID:uint = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function updateItemList():void {
			$dataList = new Dictionary(true);
			var it:Iterator = $objList.iterator;
			var btn:Button;
			var s:uint = $objList.size;
			var i:uint = 0;
			var horizontal:Boolean = $orientation == ButtonBarOrientation.HORIZONTAL ? true : false;
			while(it.hasNext()) {
				var next:ListItem = it.next() as ListItem;
				btn = next.item;
				btn.spas_internal::setIndex(i);
				$dataList[btn] = next;
				if (i == 0) {
					if (s == 1) {
						btn.topLeftCorner = $tlc;
						btn.bottomLeftCorner = $blc;
						btn.bottomRightCorner = $brc
						btn.topRightCorner = $trc;
					} else {
						if (horizontal) {
							btn.topLeftCorner = $tlc
							btn.bottomLeftCorner = $blc;
							btn.topRightCorner = btn.bottomRightCorner = 0;
						} else {
							btn.topLeftCorner = $tlc
							btn.topRightCorner = $trc;
							btn.bottomLeftCorner = btn.bottomRightCorner = 0;
						}
					}
				} else if (i > 0 && i < s - 1) {
					btn.bottomRightCorner = btn.bottomLeftCorner =
					btn.topLeftCorner = btn.topRightCorner = 0;
				} else if (i > 0 && i == s-1) {
					if (horizontal) {
						btn.topRightCorner = $trc;
						btn.bottomRightCorner = $brc;
						btn.topLeftCorner = btn.bottomLeftCorner = 0;
					} else {
						btn.bottomRightCorner = $brc;
						btn.bottomLeftCorner = $blc;
						btn.topLeftCorner = btn.topRightCorner = 0;
					}
				}
				fixButtonWidth(btn);
				++i;
			}
			it.reset();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			$buttonClass = Button;
			$buttonSelector = Selectors.BUTTON_BAR_ITEM;
			initLaf(ButtonBarUIRef);
			spas_internal::setSelector(Selectors.BUTTON_BAR);
			spas_internal::isInitialized(1);
		}
	}
}