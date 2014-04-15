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
	// ViewportDataGrid.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 21/04/2011 13:50
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.flashapi.swing.border.Border;
	import org.flashapi.swing.color.Color;
	import org.flashapi.swing.constants.BorderStyle;
	import org.flashapi.swing.constants.ScrollableOrientation;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.decorator.BorderDecorator;
	import org.flashapi.swing.plaf.libs.ViewportDataGridUIRef;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DataGrid.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	<img src="DataGrid.png" alt="ViewportDataGrid" width="18" height="18"/>
	 * 
	 * 	The <code>ViewportDataGrid</code> class creates a scrollable vieport that
	 * 	contains a <code>DataGrid</code> object. You can access the <code>DataGrid</code>
	 * 	instance by using the <code>getDataGrid()</code> method.
	 * 
	 * 	@see org.flashapi.swing.DataGrid
	 * 
	 *  @includeExample ViewportDataGridExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.7
	 */
	public class ViewportDataGrid extends UIObject implements Initializable, Border, Observer, LafRenderer {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>ViewportDataGrid</code> instance with the 
		 * 					specified parameters.
		 * 
		 * 	@param	width
		 * 	@param	height
		 * 	@param	dataWidth
		 */
		public function ViewportDataGrid(width:Number = 300, height:Number = 250, dataWidth:Number = 300) {
			super();
			initObj(width, height, dataWidth);
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
		//  Border API
		//
		//--------------------------------------------------------------------------
		
		private var _borderDecorator:BorderDecorator;
		/**
		 *	@inheritDoc
		 */
		public function get backgroundContainer():Sprite {
			return spas_internal::uioSprite;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundWidth():Number {
			return $width;
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get backgroundHeight():Number {
			return $height;
		}
		
		/**
		 *	@inheritDoc
		 */
		public function get bordersContainer():Sprite {
			return spas_internal::borders;
		}
		
		private var _borderStyle:String = BorderStyle.SOLID;
		/**
		 *	@inheritDoc
		 */
		public function get borderStyle():String {
			return _borderStyle;
		}
		public function set borderStyle(value:String):void {
			_borderStyle = value;
			redrawDecorator();
		}
		
		private var _btColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderTopColor():* {
			return _btColor;
		}
		public function set borderTopColor(value:*):void {
			_btColor = getColor(value);
			redrawDecorator();
		}
		
		private var _brColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderRightColor():* {
			return _brColor;
		}
		public function set borderRightColor(value:*):void {
			_brColor = getColor(value);
			redrawDecorator();
		}
		
		private var _bbColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomColor():* {
			return _bbColor;
		}
		public function set borderBottomColor(value:*):void {
			_bbColor = getColor(value);
			redrawDecorator();
		}
		
		private var _blColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftColor():* {
			return _blColor;
		}
		public function set borderLeftColor(value:*):void {
			_blColor = getColor(value);
			redrawDecorator();
		}
		
		private var _bShadowColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowColor():* {
			return _bShadowColor;
		}
		public function set borderShadowColor(value:*):void {
			_bShadowColor = getColor(value);
			redrawDecorator();
		}
		
		private var _bHighlightColor:* = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightColor():* {
			return _bHighlightColor;
		}
		public function set borderHighlightColor(value:*):void {
			_bHighlightColor = getColor(value);
			redrawDecorator();
		}
		
		private var _bto:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderTopOpacity():Number {
			return _bto;
		}
		public function set borderTopOpacity(value:Number):void {
			_bto = value;
			redrawDecorator();
		}
		
		private var _bro:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderRightOpacity():Number {
			return _bro;
		}
		public function set borderRightOpacity(value:Number):void {
			_bro = value;
			redrawDecorator();
		}
		
		private var _bbo:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderBottomOpacity():Number {
			return _bbo;
		}
		public function set borderBottomOpacity(value:Number):void {
			_bbo = value;
			redrawDecorator();
		}
		
		private var _blo:Number = NaN;
		/**
		 *  @inheritDoc
		 */
		public function get borderLeftOpacity():Number {
			return _blo;
		}
		public function set borderLeftOpacity(value:Number):void {
			_blo = value;
			redrawDecorator();
		}
		
		private var _bso:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderShadowOpacity():Number {
			return _bso;
		}
		public function set borderShadowOpacity(value:Number):void {
			_bso = value;
			redrawDecorator();
		}
		
		private var _bho:Number = 1;
		/**
		 *  @inheritDoc
		 */
		public function get borderHighlightOpacity():Number {
			return _bho;
		}
		public function set borderHighlightOpacity(value:Number):void {
			_bho = value;
			redrawDecorator();
		}
		
		/**
		 *  @private
		 * 	FOR DEVELOPERS ONLY
		 * 
		 * 	Calls the redrawing functions od the BorderDecorator instance.
		 */
		private function redrawDecorator():void {
			_borderDecorator.drawBackground();
			_borderDecorator.drawBorders();
			setEffects();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _dataWidth:Number;
		/**
		 * 	Sets or gets the width of the <code>DataGrid</code> object displayed
		 * 	whithin the <code>ViewportDataGrid</code> instance, in pixels.
		 * 
		 * 	@default 300
		 */
		public function get dataWidth():Number {
			return _dataWidth;
		}
		public function set dataWidth(value:Number):void {
			$datagrid.width = _dataWidth = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns a reference to the <code>DataGrid</code> object displayed
		 * 	whithin this <code>ViewportDataGrid</code> instance.
		 * 
		 * 	@return The <code>DataGrid</code> object displayed whithin this
		 * 			<code>ViewportDataGrid</code> instance.
		 */
		public function getDatagrid():DataGrid {
			return $datagrid;
		}
		
		/**
		 * 	@inheritDoc
		 */
		override public function finalize():void {
			_vScroll.remove();
			_vScroll.target = null;
			$datagrid.finalize();
			_vScroll = null;
			_hScroll.finalize();
			_hScroll = null;
			super.finalize();
		}
		
		/**
		 *  @private
		 */
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, $width, $height);
		}
		
		/**
		 *  @private
		 */
		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle {
			return new Rectangle(0, 0, $width, $height);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overriden Datagrid API
		//
		//--------------------------------------------------------------------------
		
		private var _headerHeight:Number;
		/**
		 * 	Sets or gets the height used by default to render header items within this
		 * 	<code>DataGrid</code> instance.
		 */
		public function get headerHeight():Number {
			return $datagrid.headerHeight;
		}
		public function set headerHeight(value:Number):void {
			_headerHeight =  spas_internal::lafDTO.headerHeight = $datagrid.headerHeight = value;
			setRefresh();
		}
		
		private var _headerColor:* = NaN;
		/**
		 * 	The background color of the datagrid headers row. Valid values are:
		 *  <ul>
		 * 		<li>a positive integer,</li>
		 * 		<li>a string that defines a SVG Color Keyword,</li>
		 * 		<li>an hexadecimal value,</li>
		 * 		<li>the <code>Color.DEFAULT</code> constant.</li>
		 * 	</ul>
		 */
		public function get headerBackgroundColor():* {
			return _headerColor;
		}
		public function set headerBackgroundColor(value:*):void {
			if (value == Color.DEFAULT) {
				_useDefaultHeaderColor = true;
				_headerColor = $datagrid.headerContainer.lookAndFeel.getColor();
			} else {
				_useDefaultHeaderColor = false;
				_headerColor = new Color().getValue(value);
			}
			spas_internal::lafDTO.headerColor =
				$datagrid.headerBackgroundColor = _headerColor;
			lookAndFeel.drawScrollBarHeader();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 * 
		 * 	An internal reference to the <code>Datagrid</code> object displayed within
		 * 	this <code>ViewportDataGrid</code> instance.
		 */
		protected var $datagrid:DataGrid;
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			$datagrid.lockLaf(lookAndFeel.getDataGridLaf(), true);
			_hScroll.lockLaf($datagrid.lookAndFeel.getScrollBarLaf(), true);
			if (_useDefaultHeaderColor) {
				spas_internal::lafDTO.headerColor = _headerColor =
					$datagrid.headerContainer.lookAndFeel.getColor();
			}
		}
		
		/**
		 *  @private
		 */
		override protected function refresh():void {
			var _offset:Number = _hScroll.thickness;
			var h:Number = $height - _offset;
			var w:Number = $width - _offset;
			
			_borderDecorator.drawBackground();
			
			var headerOffset:Number = $width - _dataWidth;
			headerOffset = headerOffset <= _offset ? _offset : headerOffset;
			spas_internal::lafDTO.headerWidth = headerOffset;
			_scrollHeader.x = w - headerOffset + _offset;
			lookAndFeel.drawScrollBarHeader();
			
			_vScroll.length = h - _headerHeight;
			_vScroll.y = _headerHeight;
			$datagrid.height = _hScroll.y = h;
			_hScroll.length = _vScroll.x = w;
			drawMask(w, h);
			
			_borderDecorator.drawBorders();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _scrollHeader:Sprite;
		private var _hScroll:ScrollBar;
		private var _vScroll:ScrollBar;
		private var _mask:Shape;
		private var _useDefaultHeaderColor:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(width:Number, height:Number, dataWidth:Number):void {
			initSize(width, height);
			_dataWidth = dataWidth;
			
			createControls();
			initLaf(ViewportDataGridUIRef);
			//spas_internal::setSelector(Selectors.ALERT);
			spas_internal::isInitialized(1);
		}
		
		private function createControls():void {
			spas_internal::borders = new Sprite();
			createBackgroundTextureManager(spas_internal::uioSprite);
			_borderDecorator = new BorderDecorator(this, $backgroundTextureManager);
			
			_mask = new Shape();
			$datagrid = new DataGrid(_dataWidth, 6);
			$datagrid.spas_internal::borderDecorator.active = false;
			deactivateDataGridBorderApi($datagrid.spas_internal::borders);
			deactivateDataGridBorderApi($datagrid.spas_internal::background);
			
			$datagrid.spas_internal::autoScrollPosition = false;
			
			_vScroll = $datagrid.spas_internal::vScroll;
			_vScroll.remove();
			_vScroll.showBottomRightCorner = true;
			_hScroll = new ScrollBar($datagrid, $width, ScrollableOrientation.HORIZONTAL);
			$datagrid.spas_internal::uioSprite.mask = _mask;
			
			_vScroll.target = _hScroll.target = $datagrid.target = spas_internal::uioSprite;
			$datagrid.display();
			spas_internal::uioSprite.addChild(_mask);
			
			_scrollHeader = new Sprite();
			_hScroll.display();
			spas_internal::uioSprite.addChild(_scrollHeader);
			_vScroll.display();
			
			spas_internal::uioSprite.addChild(spas_internal::borders);
			
			_headerHeight = spas_internal::lafDTO.headerHeight = $datagrid.headerHeight;
			spas_internal::lafDTO.currentTarget = _scrollHeader;
		}
		
		private function deactivateDataGridBorderApi(target:Sprite):void {
			target.visible = false;
			$datagrid.spas_internal::uioSprite.removeChild(target);
		}
		
		private function drawMask(w:Number, h:Number):void {
			with (_mask.graphics) {
				clear();
				beginFill(0);
				drawRect(0, 0, w, h);
				endFill();
			}
		}
	}
}