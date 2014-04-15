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
	// DropButton.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 15/03/2010 21:47
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.list.DropButtonListBase;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.plaf.libs.DropListUIRef;
	import org.flashapi.swing.state.ColorState;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DropButton.png")]
	
	/**
	 * 	<img src="DropButton.png" alt="DropButton" width="18" height="18"/>
	 * 
	 * 	The <code>DropButton</code> class creates a button object with a main sub-button and
	 * 	a secondary sub-button. By clicking on the secondary (right) sub-button, the user will
	 * 	display a drop-down list from which the he can select a single value. When a user
	 * 	clicks the main button (left), the <code>DropButton</code> also dispatches a
	 * 	<code>UIMouseEvent.CLICK</code> event.
	 * 	
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>DropButton</code> instance.
	 * 	Each item for <code>DataProvider</code> object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>label:String</code>; the <code>value</code> parameter for the
	 * 			<code>DropButton.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter for
	 * 			the <code>DropButton.addItem()</code> method,</li>
	 * 		<li><code>className:String</code>; the <code>className</code> parameter for
	 * 			<code>DropButton</code> items,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the icon rendered by <code>DropButton</code>
	 * 			items.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 	<p>The following codes illustrate three different ways of adding items to a
	 * 	<code>DropButton</code>:</p>
	 * 	<p>
	 * 		- using the <code>DropButton.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var db:DropButton = new DropButton();
	 * 
	 * 			db.addItem("Label 1", myData1);
	 * 			db.addItem("Label 2", myData2);
	 * 			var li3:ListItem = db.addItem("Label 3", myData3);
	 * 			li3.item.setIcon("myIcon.jpg");
	 * 			var li4:ListItem = db.addItem("Label 4", myData4);
	 * 			li4.item.setIcon("myIcon.jpg");
	 * 
	 * 			db.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>DropButton.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var db:DropButton = new DropButton();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 			dp.addAll(  { label:"Label 1", data:myData1 },
	 * 						{ label:"Label 2", data:myData2 },
	 * 						{ label:"Label 3", data:myData3, icon:"myIcon.jpg" },
	 * 						{ label:"Label 4", data:myData4, icon:"myIcon.jpg" });
	 * 			db.dataProvider = dp;
	 * 
	 * 			db.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>DropButton.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item label="Label 1" data="myData1" /&gt;
	 *								&lt;item label="Label 2" data="myData2" /&gt;
	 *								&lt;item label="Label 3" data="myData3" icon="myIcon.jpg" /&gt;
	 * 								&lt;item label="Label 4" data="myData4" icon="myIcon.jpg" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var db:DropButton = new DropButton();
	 * 			db.xmlQuery = request;
	 * 
	 * 			db.display();
	 * 		</listing>
	 * 	</p>
	 * 
	 * 	<p><strong><code>DropButton</code> instances support the following CSS
	 * 	properties:</strong></p>
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code class="css">font-color</code></td>
	 * 			<td>Sets the font color of the object.</td>
	 * 			<td>A valid color keywords, a CSS hexadecimal color value (e.g. <code>#ff6699</code>),
	 * 			or an hexadecimal integer value (e.g. <code>0xff6699</code>).</td>
	 * 			<td><code>fontColor</code></td>
	 * 			<td><code>Properties.COLOR</code></td>
	 * 		</tr>
	 * 	</table> 
	 *
	 * 	@includeExample DropButtonExample.as
	 * 
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.list.ALM#xmlQuery
	 * 	@see org.flashapi.swing.databinding.XMLQuery
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DropButton extends DropButtonListBase implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>DropButton</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	label	Text to display within the <code>DropButton</code> instance.
		 * 	@param	width	The width of the <code>DropButton</code> instance, in pixels.
		 * 	@param	size	The number of items displayed within the drop-down list
		 * 					object.
		 */
		public function DropButton(label:String = "", width:Number = 150, size:uint = 5) {
			super(label, width, size, "DropButton");
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
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Sets or gets the text color for this <code>DropButton</code> instance.
		 * 	Valid values are:
		 *  <ul>
		 * 		<li>a positive integer</li>
		 * 		<li>a string that defines a SVG Color Keyword</li>
		 * 		<li>an hexadecimal value</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 *  <p>See the <a href="http://www.w3.org/TR/css3-color/">"CSS3 Color Module"</a> recommendation
		 *  to kow more about SVG color keywords, and especially the
		 * 	<a href="http://www.w3.org/TR/css3-color/#svg-color">"4.3. SVG color keywords"</a> section
		 *  of the document to get valid SVG color keyword names.</p>
		 * 
		 *  @see org.flashapi.swing.color.SVGCK
		 * 	@see #fontColors
		 */
		public function get fontColor():* {
			return $button.fontColor;
		}
		public function set fontColor(value:*):void {
			$button.fontColor = value;
		}
		
		/**
		 *	A <code>ColorState</code> object. The <code>fontColors</code> property sets
		 * 	and gets the text color of the <code>DropButton</code> instance for each state.
		 * 	<code>ColorState</code> instances define five different states:
		 * 	<ul>
		 * 		<li>ColorState.disabled</li>
		 * 		<li>ColorState.selected</li>
		 * 		<li>ColorState.down</li>
		 * 		<li>ColorState.over</li>
		 *  	<li>ColorState.up</li>
		 * 	</ul>
		 * 	<p>Valid values for each state of the <code>ColorState</code> object are the same as
		 *  valid values for the color property. The default value for each state is
		 *  <code>StateObjectValue.NONE</code>. To unset a color state value, use the
		 * 	<code>StateObjectValue.NONE</code> constant.</p>
		 * 
		 * 	<p>When you use the <code>fontColors</code> property, the <code>fontColor</code>
		 * 	property is automatically set to <code>StateObjectValue.NONE</code>.</p>
		 *  
		 * 	@see #fontColor
		 *  @see org.flashapi.swing.core.UIObject#color
		 * 	@see org.flashapi.swing.state.ColorState
		 *  @see org.flashapi.swing.color.SVGCK
		 */
		public function get fontColors():ColorState {
			return $button.fontColors;
		}
		public function set fontColors(value:ColorState):void {
			$button.fontColor = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override public function display(x:Number = undefined, y:Number = undefined):void {
			if(!$displayed) {
				move(x, y);
				createUIObject();
				doStartEffect();
			}
		}
		
		/**
		 * 	@private
		 */
		override public function remove():void {
			$itemsList.remove();
			$listContainer.remove();//$stageremoveChild(listContainer);
			UIDescriptor.getUIManager().topLevelManager.spas_internal::removeObject($listContainer);
			if($displayed) unload();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			$listContainer.removeElements();
			$itemsList.finalize();
			$listContainer.finalize();
			$button.finalize();
			super.finalize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function createItemsList():void {
			$itemsList = new ListBox($width, $size);
		}
		
		/**
		 * 	@private
		 */
		override protected function refresh():void {
			fixButtonPosition();
			setLabel();
			setEffects();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			IUIObject($itemsList).lockLaf(lookAndFeel.getListLaf(), true);
			$button.lockLaf(lookAndFeel.getButtonLaf(), true);
			$iconBtn.lockLaf(lookAndFeel.getButtonLaf(), true);
			fixBtnCorners();
			initIconColors();
			$iconBtn.drawIcon(lookAndFeel.getIcon(), $iconBtn.getRect(null));
			setIconColors(true);
		}
		
		/**
		 * @private
		 */
		override protected function setLabel():void {
			$button.label = $defaultLabel == null ? $label : $defaultLabel;
			fixWidth();
		}
		
		/**
		 * @private
		 */
		override protected function initListForDisplay():void {
			ListBox($itemsList).vscrollValue = 0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createObjs();
			initLaf(DropListUIRef);
			createEvents();
			spas_internal::setSelector(Selectors.DROP_BUTTON);
			spas_internal::isInitialized(1);
		}
		
		private function createObjs():void {
			$iconBtn = new IconizedButton();
			$iconBtn.spas_internal::setSelector(Selectors.UNDEFINED);
			$button = new Button();
			$iconBtn.spas_internal::setSelector(Selectors.UNDEFINED);
			$iconBtn.height = $iconBtn.width = $button.height = $height;
			$button.target = $iconBtn.target = spas_internal::uioSprite;
			$iconBtn.display();
			$button.display();
		}
	}
}