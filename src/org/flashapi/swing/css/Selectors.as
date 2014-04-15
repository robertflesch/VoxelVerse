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

package org.flashapi.swing.css {
	
	// -----------------------------------------------------------
	// Selectors.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.5, 27/02/2010 15:03
	* @see http://www.flashapi.org/
	*/

	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>Selectors</code> class is an enumeration of constant values that
	 * 	specify the predefined CSS selectors that can be used to define how SPAS 3.0
	 * 	elements should be displayed.
	 * 
	 * 	@see org.flashapi.swing.css.Properties
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class Selectors {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				Selectors instance.
		 */
		public function Selectors() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The CSS selector for <code>Accordion</code> objects. 
		 */
		public static const ACCORDION:String = "accordion";
		
		/**
		 * 	The CSS selector for header objects displayed within <code>Accordion</code>
		 * 	objects. 
		 */
		public static const ACCORDION_HEADER:String = "accordionHeader";
		
		/**
		 * 	The CSS selector for <code>ALERT</code> objects. 
		 */
		public static const ALERT:String = "alert";
		
		/**
		 * 	The CSS selector for the <code>Application</code> class. 
		 */
		public static const BODY:String = "body";
		
		/**
		 * 	The CSS selector for <code>Box</code> objects. 
		 */
		public static const BOX:String = "box";
		
		/**
		 * 	The CSS selector for <code>BoxHelp</code> objects. 
		 */
		public static const BOXHELP:String = "boxhelp";
		
		/**
		 * 	The CSS selector for <code>Button</code> objects.
		 * 	The <code class="css">button</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">button:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">button:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">button:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">button:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">button:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const BUTTON:String = "button";
		
		/**
		 * 	The CSS selector for <code>PushButton</code> objects.
		 * 	The <code class="css">pushButton</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">pushButton:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">pushButton:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">pushButton:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">pushButton:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">pushButton:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const PUSH_BUTTON:String = "pushButton";
		
		/**
		 * 	The CSS selector for <code>ButtonBar</code> objects. 
		 */
		public static const BUTTON_BAR:String = "buttonBar";
		
		/**
		 * 	The CSS selector for buttons displayed within <code>ButtonBar</code> objects. 
		 */
		public static const BUTTON_BAR_ITEM:String = "buttonbaritem";
		
		/**
		 * 	The CSS selector for <code>Canvas</code> objects. 
		 */
		public static const CANVAS:String = "canvas";
		
		/**
		 * 	The CSS selector for <code>CheckBox</code> objects. 
		 */
		public static const CHECK_BOX:String = "checkBox";
		
		/**
		 * 	The CSS selector for <code>ColorButton</code> objects.
		 * 	The <code class="css">colorButton</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">colorButton:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">colorButton:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">colorButton:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">colorButton:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">colorButton:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const COLOR_BUTTON:String = "colorbutton";
		
		/**
		 * 	The CSS selector for <code>ComboBox</code> objects.
		 * 	The <code class="css">comboBox</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">comboBox:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">comboBox:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">comboBox:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">comboBox:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">comboBox:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const COMBOBOX:String = "combobox";
		
		/**
		 * 	The CSS selector for <code>Container</code> objects. 
		 */
		public static const uioSprite:String = "container";
		
		/**
		 * 	The CSS selector for <code>ControlBar</code> objects. 
		 */
		public static const CONTROL_BAR:String = "controlbar";
		
		/**
		 * 	The CSS selector for <code>DatePicker</code> objects.
		 */
		public static const DATEPICKER:String = "datepicker";
		
		/**
		 * 	The CSS selector for <code>DataGrid</code> objects.
		 */
		public static const DATAGRID:String = "datagrid";
		
		/**
		 * 	The CSS selector for <code>DataGridHeader</code> objects.
		 * 	The <code class="css">datagridHeader</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">datagridHeader:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">datagridHeader:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">datagridHeader:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">datagridHeader:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">datagridHeader:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const DATAGRID_HEADER:String = "datagridheader";
		
		/**
		 * 	The CSS selector for <code>DateField</code> objects.
		 */
		public static const DATE_FIELD:String = "datefield";
		
		/**
		 * 	The CSS selector for divider buttons.
		 */
		public static const DIVIDER:String = "divider";
		
		/**
		 * 	The CSS selector for <code>DividedBox</code> objects.
		 */
		public static const DIVIDED_BOX:String = "dividedbox";
		
		/**
		 * 	The CSS selector for <code>Dock</code> objects. 
		 */
		public static const DOCK:String = "dock";
		
		/**
		 * 	The CSS selector for <code>Drawing</code> objects. 
		 */
		public static const DRAWING:String = "drawing";
		
		/**
		 * 	The CSS selector for <code>DropButton</code> objects.
		 * 	The <code class="css">dropButton</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">dropButton:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">dropButton:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">dropButton:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">dropButton:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">dropButton:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const DROP_BUTTON:String = "dropbutton";
		
		/**
		 * 	The CSS selector for <code>DropIcon</code> objects.
		 * 	The <code class="css">dropIcon</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">dropIcon:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">dropIcon:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">dropIcon:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">dropIcon:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">dropIcon:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const DROP_ICON:String = "dropicon";
		
		/**
		 * 	The CSS selector for <code>DropList</code> objects.
		 * 	The <code class="css">dropList</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">dropList:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">dropList:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">dropList:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">dropList:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">dropList:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const DROP_LIST:String = "droplist";
		
		/**
		 * 	The selector for <code>WindowControlContainer</code> "footer" objects. 
		 */
		public static const FOOTER:String = "footer";
		
		/**
		 * 	The selector for <code>WindowControlContainer</code> "header" objects.
		 */
		public static const HEADER:String = "header";
		
		/**
		 * 	The common CSS selector for all initializator objects. 
		 */
		public static const INITIALIZATOR:String = "initializator";
		
		/**
		 * 	The CSS selector for <code>TextInput</code> objects.
		 */
		public static const INPUT:String = "input";
		
		/**
		 * 	The CSS selector for <code>Image</code> objects. 
		 */
		public static const IMAGE:String = "image";
		
		/**
		 * 	The CSS selector for <code>Label</code> objects. 
		 */
		public static const LABEL:String = "label";
		
		/**
		 * 	The CSS selector for <code>LabelInput</code> objects. 
		 */
		public static const LABEL_INPUT:String = "labelinput";
		
		/**
		 * 	The CSS selector for <code>LabelTextArea</code> objects. 
		 */
		public static const LABEL_TEXTAREA:String = "labeltextarea";
		
		/**
		 * 	The CSS selector for <code>LinkBar</code> objects. 
		 */
		public static const LINK_BAR:String = "linkbar";
		
		/**
		 * 	The CSS selector for link buttons displayed within <code>LinkBar</code> objects. 
		 */
		public static const LINK_BAR_ITEM:String = "linkbaritem";
		
		/**
		 * 	The CSS selector for <code>LinkButton</code> objects.
		 * 	The <code class="css">linkButton</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">linkButton:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">linkButton:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">linkButton:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">linkButton:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">linkButton:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const LINK_BUTTON:String = "linkbutton";
		
		/**
		 * 	The CSS selector for <code>Listbox</code> objects. 
		 */
		public static const LISTBOX:String = "listbox";
		
		/**
		 * 	The CSS selector for <code>Menu</code> objects.
		 */
		public static const MENU:String = "menu";
		
		/**
		 * 	The selector for <code>Box</code> elements that contain <code>Menu</code> objects.
		 */
		public static const MENU_CONTAINER:String = "menucontainer";
		
		/**
		 * 	The selector for <code>SelectableItem</code> instances used within
		 * 	<code>Menu</code> objects. 
		 */
		public static const MENU_ITEM:String = "menuitem";
		
		/**
		 * 	The CSS selector for <code>MenuBar</code> objects.
		 */
		public static const MENU_BAR:String = "menubar";
		
		/**
		 * 	The CSS selector for <code>MenuButton</code> objects.
		 * 	The <code class="css">menuButton</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">menuButton:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">menuButton:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">menuButton:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">menuButton:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">menuButton:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const MENU_BUTTON:String = "menubutton";
		
		/**
		 * 	The CSS selector for <code>MultiView</code> objects.
		 */
		public static const MULTI_VIEW:String = "multiview";
		
		/**
		 * 	The CSS selector for <code>Panel</code> objects.
		 */
		public static const PANEL:String = "panel";
		
		/**
		 * 	The CSS selector for <code>PanelContainer</code> objects.
		 */
		public static const PANEL_CONTAINER:String = "panelcontainer";
		
		/**
		 * 	The CSS selector for <code>PictureFlow</code> objects.
		 */
		public static const PICTURE_FLOW:String = "pictureflow";
		
		/**
		 * 	The CSS selector for <code>PictureGallery</code> objects.
		 */
		public static const PICTURE_GALLERY:String = "picturegallery";
		
		/**
		 * 	The CSS selector for thumbnails displayed within <code>PictureGallery</code> objects.
		 */
		public static const GALLERY_THUMBNAIL:String = "gallerythumbnail";
		
		/**
		 * 	The CSS selector for <code>RadioButton</code> objects.
		 * 	The <code class="css">radioButton</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">radioButton:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">radioButton:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">radioButton:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">radioButton:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">radioButton:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const RADIO_BUTTON:String = "radiobutton";
		
		/**
		 * 	The CSS selector for <code>ReactivePanel</code> objects.
		 * 	The <code class="css">reactivePanel</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">reactivePanel:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">reactivePanel:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">reactivePanel:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">reactivePanel:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">reactivePanel:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const REACTIVE_PANEL:String = "reactivepanel";
		
		/**
		 * 	The CSS selector for <code>SelectableItem</code> objects.
		 * 	The <code class="css">selectableItem</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">selectableItem:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">selectableItem:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">selectableItem:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">selectableItem:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">selectableItem:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const SELECTABLE_ITEM:String = "selectableitem";
		
		/**
		 * 	The CSS selector for <code>ScrollBar</code> objects.
		 */
		public static const SCROLLBAR:String = "scrollbar";
		
		/**
		 * 	The CSS selector for <code>ScrollPane</code> objects.
		 */
		public static const SCROLLPANE:String = "scrollpane";
		
		/**
		 * 	The CSS selector for <code>Separator</code> objects.
		 */
		public static const SEPARATOR:String = "separator";
		
		/**
		 * 	The CSS selector for <code>Slider</code> objects. 
		 */
		public static const SLIDER:String = "slider";
		
		/**
		 * 	The CSS selector for <code>SeekBar</code> objects.
		 */
		public static const SEEKBAR:String = "seekbar";
		
		/**
		 * 	The CSS selector for <code>TabBar</code> objects.
		 */
		public static const TAB_BAR:String = "tabbar";
		
		/**
		 * 	The CSS selector for <code>TabButton</code> objects.
		 * 	The <code class="css">tabButton</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">tabButton:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">tabButton:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">tabButton:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">tabButton:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">tabButton:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const TAB_BUTTON:String = "tabbutton";
		
		/**
		 * 	The CSS selector for <code>TabButton</code> objects displayed within a <code>TabBar</code>
		 * 	objects.
		 * 
		 * 	@see #TAB_BUTTON
		 */
		public static const TAB_BAR_ITEM:String = "tabbaritem";
		
		/**
		 * 	The CSS selector for <code>TabbedPane</code> objects.
		 */
		public static const TABBED_PANE:String = "tabbedpane";
		
		/**
		 * 	The CSS selector for <code>Table</code> objects.
		 */
		public static const TABLE:String = "table";
		
		/**
		 * 	The CSS selector for <code>Text</code> objects.
		 */
		public static const TEXT:String = "text";
		
		/**
		 * 	The CSS selector for <code>TextArea</code> objects.
		 */
		public static const TEXTAREA:String = "textarea";
		
		/**
		 * 	The CSS selector for <code>Cell</code> objects.
		 */
		public static const TD:String = "td";
		
		/**
		 * 	The CSS selector for <code>TableHeader</code> objects.
		 */
		public static const TH:String = "th";
		
		/**
		 * 	The CSS selector for <code>TableRow</code> objects.
		 */
		public static const TR:String = "tr";
		
		/**
		 * 	The CSS selector for <code>Thumbnail</code> objects.
		 */
		public static const THUMBNAIL:String = "thumbnail";
		
		/**
		 * 	The CSS selector for <code>ToolTip</code> objects.
		 */
		public static const TOOLTIP:String = "tooltip";
		
		/**
		 * 	The common selector for all <code>UIObjects</code>.
		 */
		public static const UIOBJECT:String = "uiobject";
		
		/**
		 * 	The CSS selector for <code>VideoStream</code> objects.
		 */
		public static const VIDEO:String = "video";
		
		/**
		 * 	The CSS selector for <code>Window</code> and <code>Popup</code> objects.
		 */
		public static const WINDOW:String = "window";
		
		/**
		 * 	The CSS selector for <code>SoundAnalizer</code> objects.
		 */
		public static const SOUND_ANALIZER:String = "soundanalizer";
		
		/**
		 * 	The CSS selector for <code>AnalogClock</code> objects.
		 */
		public static const CLOCK:String = "clock";
		
		/**
		 * 	The CSS selector for <code>AnalogClock</code> objects.
		 */
		public static const DIGIT_CLOCK:String = "digitclock";
		
		/**
		 * 	The CSS selector for <code>CubicView</code> objects.
		 */
		public static const CUBIC_VIEW:String = "cubicview";
		
		/**
		 * 	The CSS selector for <code>EditableLabel</code> objects.
		 */
		public static const EDITABLE_LABEL:String = "editablelabel";
		
		/**
		 * 	The CSS selector for <code>KnobButton</code> objects.
		 * 	The <code class="css">knobButton</code> selector accepts the use of the following
		 * 	CSS pseudo-selectors:
		 * 	<ul>
		 * 		<li><code class="css">up</code> (e.g. <code class="css">knobButton:up</code>),</li>
		 * 		<li><code class="css">down</code> (e.g. <code class="css">knobButton:down</code>),</li>
		 * 		<li><code class="css">over</code> (e.g. <code class="css">knobButton:over</code>),</li>
		 * 		<li><code class="css">selected</code> (e.g. <code class="css">knobButton:selected</code>),</li>
		 * 		<li><code class="css">disabled</code> (e.g. <code class="css">knobButton:disabled</code>).</li>
		 * 	</ul>
		 */
		public static const KNOB_BUTTON:String = "knobbutton";
		
		/**
		 * 	The CSS selector for <code>ScrollGallery</code> objects.
		 */
		public static const SCROLL_GALLERY:String = "scrollgallery";
		
		/**
		 * 	The CSS selector for <code>WebSafeColopPicker</code> objects.
		 */
		public static const WSCP:String = "wscp";
		
		/**
		 * 	The CSS selector for <code>SeekBarThumb</code> objects.
		 */
		public static const SEEKBAR_THUMB:String = "seekbarthumb";
		
		/**
		 * 	@private 
		 */
		public static const UNDEFINED:String = "";
		
		/**
		 * 	The CSS selector for <code>PageNavigator</code> objects.
		 */
		public static const PAGE_NAVIGATOR:String = "pageNavigator";
		
		/**
		 * 	The CSS selector for <code>SpinButton</code> objects.
		 */
		public static const SPIN_BUTTON:String = "spinButton";
		
		/**
		 * 	The CSS selector for <code>IconizedButton</code> controls used within
		 * 	<code>SpinButton</code> objects.
		 */
		public static const SPIN_BUTTON_CONTROL:String = "SpinButtonControl";
		
		//--------------------------------------------------------------------------
		//
		// Form selectors
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The CSS selector for <code>Label</code> objects used within a
		 * 	<code>Form</code> instance.
		 */
		public static const FORM_LABEL:String = "formlabel"; 
		
		/**
		 * 	The CSS selector for <code>TextInput</code> objects used within a
		 * 	<code>Form</code> instance.
		 */
		public static const FORM_INPUT:String = "forminput";
	}
}