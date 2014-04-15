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
	// DropIcon.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/03/2010 22:29
	* @see http://www.flashapi.org/
	*/
	
	import flash.geom.Rectangle;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.IUIObject;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.list.DropButtonListBase;
	import org.flashapi.swing.list.IconListBox;
	import org.flashapi.swing.list.Listable;
	import org.flashapi.swing.plaf.libs.DropIconUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DropIcon.png")]
	
	/**
	 * 	<img src="DropIcon.png" alt="DropIcon" width="18" height="18"/>
	 * 
	 * 	The <code>DropIcon</code> class creates a button object with a main sub-button and
	 * 	a secondary sub-button. By clicking on the secondary (right) sub-button, the user will
	 * 	display a drop-down list from which the he can select a single value. When a user
	 * 	clicks the main button (left), the <code>DropIcon</code> also dispatches a
	 * 	<code>UIMouseEvent.CLICK</code> event.
	 * 	
	 * 	<p>As for all <code>Listable</code> objects, you can assign a <code>DataProvider</code>
	 * 	object to a <code>DropButton</code> instance.
	 * 	Each item for <code>DataProvider</code> object have to contain the following properties:
	 * 	<ul>
	 * 		<li><code>alt:String</code>; the <code>value</code> parameter for the
	 * 			<code>DropIcon.addItem()</code> method,</li>
	 * 		<li><code>data:<em>untyped</em></code>; the <code>data</code> parameter for
	 * 			the <code>DropIcon.addItem()</code> method,</li>
	 * 		<li><code>className:String</code>; the <code>className</code> parameter for
	 * 			<code>DropIcon</code> items,</li>
	 * 		<li><code>icon:<em>untyped</em></code>; the icon rendered by <code>DropIcon</code>
	 * 			items.</li>
	 * 	</ul>
	 * 	</p>
	 * 
	 * 	<p>The following codes illustrate three different ways of adding items to a
	 * 	<code>DropIcon</code>:</p>
	 * 	<p>
	 * 		- using the <code>DropIcon.addItem()</code> method:
	 *  	<listing version="3.0">
	 * 			var di:DropIcon = new DropIcon();
	 * 
	 * 			di.addItem( { alt:"Label 1", icon:"myIcon1.png" }, myData1);
	 * 			di.addItem( { alt:"Label 2", icon:"myIcon2.png" }, myData2);
	 * 			di.addItem( { alt:"Label 3", icon:"myIcon3.png" }, myData3);
	 * 			di.addItem( { alt:"Label 4", icon:"myIcon4.png" }, myData4);
	 * 
	 * 			di.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>DropIcon.dataProvider</code> property:
	 *  	<listing version="3.0">
	 * 			var di:DropIcon = new DropIcon();
	 * 
	 * 			var dp:DataProvider = new DataProvider();
	 * 			dp.addAll(  { alt:"Label 1", data:myData1, icon:"myIcon1.jpg" },
	 * 						{ alt:"Label 2", data:myData2, icon:"myIcon2.jpg" },
	 * 						{ alt:"Label 3", data:myData3, icon:"myIcon3.jpg" },
	 * 						{ alt:"Label 4", data:myData4, icon:"myIcon4.jpg" });
	 * 			di.dataProvider = dp;
	 * 
	 * 			di.display()
	 * 		</listing>
	 * 	</p>
	 * 	<p>
	 * 		- using the <code>DropIcon.xmlQuery</code> property:
	 *  	<listing version="3.0">
	 * 			var data:XML = 	&lt;XMLQuery&gt;
	 *								&lt;item alt="Label 1" data="myData1" icon="myIcon1.jpg" /&gt;
	 *								&lt;item alt="Label 2" data="myData2" icon="myIcon2.jpg" /&gt;
	 *								&lt;item alt="Label 3" data="myData3" icon="myIcon3.jpg" /&gt;
	 * 								&lt;item alt="Label 4" data="myData4" icon="myIcon4.jpg" /&gt;
	 *							&lt;/XMLQuery&gt;;
	 * 
	 *			var request:XMLQuery = new XMLQuery();
	 * 			request.add(data);
	 * 
	 * 			var di:DropIcon = new DropIcon();
	 * 			di.xmlQuery = request;
	 * 
	 * 			di.display();
	 * 		</listing>
	 * 	</p>
	 *
	 * <p><strong><code>DropIcon</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
	 * 		<tr>
	 * 			<th>CSS property</th>
	 * 			<th>Description</th>
	 * 			<th>Possible values</th>
	 * 			<th>SPAS property</th>
	 * 			<th>Constant value</th>
	 * 		</tr>
	 *		<tr>
	 * 			<td><code class="css">icon</code></td>
	 * 			<td>Add an icon to this object.</td>
	 * 			<td>Must be a valid URI to an image or a SWF file.</td>
	 * 			<td>The <code>setIcon()</code> method.</td>
	 * 			<td><code>Properties.ICON</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 * 	@see org.flashapi.swing.list.ALM#dataProvider
	 * 	@see org.flashapi.swing.databinding.DataProvider
	 * 	@see org.flashapi.swing.list.ALM#xmlQuery
	 * 	@see org.flashapi.swing.databinding.XMLQuery
	 *  @see org.flashapi.swing.list.ListItem
	 * 
	 *	@includeExample DropIconExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DropIcon extends DropButtonListBase implements Observer, Listable, LafRenderer, Initializable {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor.	Creates a new <code>DropIcon</code> instance with the
		 * 					specified parameters.
		 * 
		 * 	@param	alt		Alternate text to display when the mouse is over the
		 * 					<code>DropIcon</code> instance.
		 * 	@param	width	The width of the <code>DropIcon</code> instance, in pixels.
		 * 	@param	size	The number of items displayed within the drop-down list
		 * 					object.
		 */
		public function DropIcon(alt:String = null, width:Number = 50) {
			super("", width, 5, "DropIcon");
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
		
		private var _alt:String;
		/**
		 * 	Sets or gets the alternate text of the <code>DropIcon</code> instance.
		 * 	If <code>null</code>, no alternate text is displayed when the mouse is
		 * 	over the <code>DropIcon</code> button.
		 * 
		 * 	@default null
		 */
		public function get alt():String {
			return _alt;
		}
		public function set alt(value:String):void {
			$button.alt = _alt = alt;
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
			$listContainer.remove();//$stage.removeChild(listContainer);
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
		
		/**
		 * 	@private
		 */
		override public function reset(label:String = null):void {
			this.alt = label;
			super.reset(label);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Icon
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Clears an icon drawn with the <code>drawIcon()</code> method.
		 * 
		 * 	@see #drawIcon()
		 */
		public function clearIcon():void {
			$button.clearIcon();
		}
		
		/**
		 * 	Removes an icon added with the <code>setIcon()</code> method.
		 * 
		 * 	@see #setIcon()
		 */
		public function deleteIcon():void {
			$button.deleteIcon();
		}
		
		/**
		 * 	Draws an icon on the button face by using the specified <code>StateBrush</code>
		 * 	object.
		 * 	
		 * 	@param	brush 	The <code>StateBrush</code> object to be used to draw
		 * 					the icon.
		 * 	@param	rect 	The rectangle area that defines the bounds within to
		 * 					draw the icon.
		 * 
		 * 	@see #clearIcon()
		 * 	@see org.flashapi.swing.brushes.StateBrush
		 */
		public function drawIcon(brush:Class, rect:Rectangle = null):void {
			$button.drawIcon(brush, rect = null)
		}
		
		/**
		 * 	Adds an icon to the button using the specified element.
		 * 
		 * 	<p>Valid elements are the same as elements passed as parameter of the
		 * 	<code>Icon.addElement()</code> method.</p>
		 * 	
		 * 	@param	value An element to add as an icon to the button.
		 * 
		 * 	@see #deleteIcon()
		 * 	@see org.flashapi.swing.Icon
		 */
		public function setIcon(value:*):void {
			$button.setIcon(value);
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
			$itemsList = new IconListBox(150);
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
			if ($listItem) {
				setIcon($listItem.item.getIconCopy());
				$button.alt = _alt = $listItem.item.alt;
			}
			fixWidth();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			createObjs(alt);
			initLaf(DropIconUIRef);
			createEvents();
			spas_internal::setSelector(Selectors.DROP_ICON);
			spas_internal::isInitialized(1);
		}
		
		private function createObjs(alt:String):void {
			$iconBtn = new IconizedButton();
			$iconBtn.spas_internal::setSelector(Selectors.UNDEFINED);
			$button = new IconizedButton();
			$button.alt = _alt = alt;
			$iconBtn.spas_internal::setSelector(Selectors.UNDEFINED);
			$iconBtn.height = $iconBtn.width = $button.height = $height;
			$button.target = $iconBtn.target = spas_internal::uioSprite;
			$iconBtn.display();
			$button.display();
		}
	}
}