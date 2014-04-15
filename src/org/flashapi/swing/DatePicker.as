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
	// DatePicker.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 10/12/2011 11:09
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import org.flashapi.collector.EventCollector;
	import org.flashapi.swing.calendar.DateRange;
	import org.flashapi.swing.calendar.SimpleDateButton;
	import org.flashapi.swing.constants.SpinButtonAction;
	import org.flashapi.swing.core.DateEventDispatcher;
	import org.flashapi.swing.core.Initializable;
	import org.flashapi.swing.core.KeyObserver;
	import org.flashapi.swing.core.LafRenderer;
	import org.flashapi.swing.core.spas_internal;
	import org.flashapi.swing.core.UIDescriptor;
	import org.flashapi.swing.core.UIObject;
	import org.flashapi.swing.css.Selectors;
	import org.flashapi.swing.date.DateFormatter;
	import org.flashapi.swing.event.CalendarEvent;
	import org.flashapi.swing.event.UIMouseEvent;
	import org.flashapi.swing.managers.KeyboardManager;
	import org.flashapi.swing.plaf.libs.DatePickerUIRef;
	import org.flashapi.swing.util.DisplayListUtil;
	import org.flashapi.swing.util.Observer;
	
	use namespace spas_internal;
	
	[IconFile("DatePicker.png")]
	
	//--------------------------------------------------------------------------
	//
	//  Events
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Dispatched when the value of the <code>date</code> property has changed
	 * 	due to mouse interaction within this <code>DatePicker</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.CalendarEvent.DATE_CHANGED
	 */
	[Event(name="dateChanged", type="org.flashapi.swing.event.CalendarEvent")]
	
	/**
	 *  Dispatched when the <code>allowUserChanges</code> property is <code>false</code>
	 * 	and the user clicks on a date within the <code>DatePicker</code> instance.
	 *
	 *  @eventType org.flashapi.swing.event.CalendarEvent.DATE_CLICKED
	 */
	[Event(name="dateClicked", type="org.flashapi.swing.event.CalendarEvent")]
	
	/**
	 *  Dispatched when the month changes due to user interaction.
	 *
	 *  @eventType org.flashapi.swing.event.CalendarEvent.MONTH_SCROLL
	 */
	[Event(name="monthScroll", type="org.flashapi.swing.event.CalendarEvent")]
	
	/**
	 *  Dispatched when the year changes due to user interaction.
	 *
	 *  @eventType org.flashapi.swing.event.CalendarEvent.YEAR_SCROLL
	 */
	[Event(name="yearScroll", type="org.flashapi.swing.event.CalendarEvent")]
	
	/**
	 * 	<img src="DatePicker.png" alt="DatePicker" width="18" height="18"/>
	 * 
	 * 	The <code>DatePicker</code> class lets users select dates from a calendar object.
	 * 
	 * <p><strong><code>DatePicker</code> instances support the following CSS properties:</strong></p>
	 * <table class="innertable"> 
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
	 * 			<td><code>Properties.FONT_COLOR</code></td>
	 * 		</tr>
	 * 	</table> 
	 * 
	 *  @includeExample DatePickerExample.as
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DatePicker extends UIObject implements Observer, LafRenderer, DateEventDispatcher, Initializable, KeyObserver {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>DatePicker</code> instance.
		 */
		public function DatePicker() {
			super();
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
		 *  @inheritDoc
		 */
		public function get date():String {
			return _selectedDate ? _dateFormater.format(_selectedDate) : "";
		}
		
		private var _disabledDays:Array;
		/**
		 * 	An <code>Array</code> collection that containes the days to disable in
		 * 	a week. All the dates in a month, for the specified day, are disabled.
		 * 	The elements of this array can have values from <code>0</code> (Monday)
		 * 	to <code>6</code> (Sunday). For example, a value of <code>[ 0, 6 ]</code>
		 * 	disables Monday and Sunday.
		 * 
		 * 	@default []
		 */
		public function get disabledDays():Array {
			return _disabledDays;
		}
		public function set disabledDays(value:Array):void {
			_disabledDays = value;
			setRefresh();
		}
		
		/**
		 *  The <code>displayedYear</code> property specifies the current year 
		 * 	displayed by the <code>DatePicker</code> instance.
		 * 
		 * 	@default The current year of the <code>DatePicker</code> instance.
		 */
		public function get displayedYear():uint {
			return _currentYear;
		}
		public function set displayedYear(value:uint):void {
			_currentYear = value;
			initializeDays(_currentYear, _currentMonth);
			setRefresh();
		}
		
		/**
		 *  The <code>displayedMonth</code> property specifies the current month 
		 * 	displayed by the <code>DatePicker</code> instance.
		 * 
		 * 	@default The current month of the <code>DatePicker</code> instance.
		 */
		public function get displayedMonth():uint {
			return _currentMonth;
		}
		public function set displayedMonth(value:uint):void {
			_currentMonth = value;
			initializeDays(_currentYear, _currentMonth);
			setRefresh();
		}
		
		private var _fontColor:*;
		/**
		 *  Sets and gets the color of the text displayed on the face of the <code>DatePicker</code>
		 * 	instance titlebar. If <code>NaN</code>, the text color is defined by the
		 * 	<code>DatePicker</code> Look and Feel.
		 * 
		 * 	@default NaN
		 */
		public function get fontColor():* {
			return _fontColor;
		}
		public function set fontColor(value:*):void {
			_fontColor = getColor(value);
			setRefresh();
		}
		
		private var _maxYear:uint;
		/**
		 * 	The last year selectable in the <code>DatePicker</code> instance.
		 * 
		 * 	@default 2100
		 * 
		 * 	@see #minYear
		 */
		public function get maxYear():uint {
			return _maxYear;
		}
		public function set maxYear(value:uint):void {
			_maxYear = value;
		}
		
		private var _minYear:uint;
		/**
		 * 	The first year selectable in the <code>DatePicker</code> instance.
		 * 
		 * 	@default 1900
		 * 
		 * 	@see #maxYear
		 */
		public function get minYear():uint {
			return _minYear;
		}
		public function set minYear(value:uint):void {
			_minYear = value;
		}
		
		/**
		 *  Returns a reference to the <code>IconizedButton</code> instance
		 * 	that is used as button to select the next date within the <code>DatePicker</code>
		 * 	instance.
		 * 
		 * 	@see #previous
		 */
		public function get next():IconizedButton {
			return _next;
		}
		
		/**
		 *  Returns a reference to the <code>IconizedButton</code> instance
		 * 	that is used as button to select the previous date within the <code>DatePicker</code>
		 * 	instance.
		 * 
		 * 	@see #previous
		 */
		public function get previous():IconizedButton {
			return _previous;
		}
		
		private var _selectedDate:Object;
		/**
		 * 	<strong>[Deprecated]</strong>
		 * 	Selects or unselects the current date within the <code>DatePicker</code>
		 * 	instance. When no date is currently selected within the <code>DatePicker</code> 
		 * 	instance, or when the <code>allowMultipleSelection</code> property is <code>true</code>,
		 * 	the <code>selectedDate</code> property is set to <code>null</code>. <code>selectedDate</code>
		 * 	is <code>null</code> after calling the <code>reset()</code> method.
		 * 
		 * 	@default null
		 * 
		 * 	@see #reset()
		 * 	@see #allowMultipleSelection
		 */
		public function get selectedDate():Date {
			if (_selectedDate == null) return null;
			return new Date(_selectedDate.year, _selectedDate.month, _selectedDate.day);
		}
		public function set selectedDate(value:Date):void {
			_selectedDate = { year:value.fullYear, month:value.month, day:value.date };
			setRefresh();
		}
		
		private var _showToday:Boolean;
		/**
		 * 	A <code>Boolean</code> value that indicates whether the date corrsponding 
		 * 	to the current day (today) on the user machine is highlighted (<code>true</code>),
		 * 	or not (<code>false</code>).
		 * 
		 * 	@default true
		 */
		public function get showToday():Boolean {
			return _showToday;
		}
		public function set showToday(value:Boolean):void {
			_showToday = value;
			fixCurrentDay();
			setRefresh();
		}
		
		private var _yearNavigationEnabled:Boolean;
		/**
		 *	Enables or disables year navigation. If <code>true</code>, an up and down
		 * 	spin button appear to the right of the displayed year. You can use this
		 * 	button to change the current year. The spin button appear to the left of 
		 * 	the year in locales where year comes before the month in the date format.
		 * 
		 * 	@default false
		 */
		public function get yearNavigationEnabled():Boolean {
			return _yearNavigationEnabled;
		}
		public function set yearNavigationEnabled(value:Boolean):void {
			fixYearNavigation(value);
			setDatePositions();
		}
		
		private var _navigationEnabled:Boolean;
		/**
		 *	Enables or disables month by month navigation.
		 * 
		 * 	@default true
		 */
		public function get navigationEnabled():Boolean {
			return _navigationEnabled;
		}
		public function set navigationEnabled(value:Boolean):void {
			_navigationEnabled = _next.visible = _previous.visible = value;
		}
		
		private var _yearSymbol:String = "";
		/**
		 * 	Sets of get an additional year symbol than can be used in languages 
		 * 	such like Japanese. Default value is an empty string.
		 * 
		 * 	@default ""
		 */
		public function get yearSymbol():String {
			return _yearSymbol;
		}
		public function set yearSymbol(value:String):void {
			_yearSymbol = value;
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function set height(value:Number):void {}
		
		/**
		 * 	@private
		 */
		override public function set width(value:Number):void { }
		
		private var _allowMultipleSelection:Boolean;
		/**
		 * 	If <code>true</code>, specifies that multiple selection is allowed in the
		 * 	<code>DatePicker</code> object.
		 * 
		 * 	@default false
		 * 
		 * 	@see #allowDisjointSelection
		 */
		public function get allowMultipleSelection():Boolean {
			return _allowMultipleSelection;
		}
		public function set allowMultipleSelection(value:Boolean):void {
			_allowMultipleSelection = value;
		}
		
		private var _allowDisjointSelection:Boolean;
		/**
		 * 	If <code>true</code>, specifies that non-contiguous(disjoint) selection is allowed 
		 * 	in the <code>DatePicker</code> object. This property has an effect only if the
		 * 	<code>allowMultipleSelection</code> property is <code>true</code>.
		 * 
		 * 	@default true
		 * 
		 * 	@see #allowMultipleSelection
		 */
		public function get allowDisjointSelection():Boolean {
			return _allowDisjointSelection;
		}
		public function set allowDisjointSelection(value:Boolean):void {
			_allowDisjointSelection = value;
		}
		
		private var _allowUserChanges:Boolean;
		/**
		 * 	If <code>true</code>, specifies that multiple selection is allowed in the
		 * 	<code>DatePicker</code> object.
		 * 
		 * 	@default true
		 */
		public function get allowUserChanges():Boolean {
			return _allowUserChanges;
		}
		public function set allowUserChanges(value:Boolean):void {
			_allowUserChanges = value;
		}
		
		private var _selectedRanges:Array;
		/**
		 * 	Sets or gets the selected date ranges. This property accepts an <code>Array</code>
		 * 	of <code>DateRange</code> objects as a parameter. Each <code>DateRange</code> instance
		 * 	in this array has two date properties, <code>startDate</code> and <code>endDate</code>.
		 * 	The range of dates between each set of <code>startDate</code> and <code>endDate</code>
		 * 	(inclusive) are selected. To select a single day, set both <code>startDate</code>
		 * 	and <code>endDate</code> to the same date.
		 * 
		 * 	@default []
		 * 
		 * 	@see #disabledRanges
		 * 	@see org.flashapi.swing.calendar.DateRange
		 */
		public function get selectedRanges():Array {
			return _selectedRanges;
		}
		public function set selectedRanges(value:Array):void {
			_selectedRanges = value;
			initializeDays(_currentYear, _currentMonth);
			setRefresh();
		}
		
		private var _disabledRanges:Array;
		/**
		 * 	[Not implemented yet.] Disables single and multiple days.
		 * 
		 * 	@default []
		 * 
		 * 	@see #selectedRanges
		 */
		public function get disabledRanges():Array {
			return _disabledRanges;
		}
		public function set disabledRanges(value:Array):void {
			_disabledRanges = value;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Resets the DatePicker object. Reseting a <code>DatePicker</code> instance 
		 * 	is equivalent to set the <code>selectedDate</code> property to
		 * 	<code>null</code>.
		 * 
		 * 	@see #selectedDate
		 */
		public function reset():void {
			_selectedDate = null;
			initSelRanges();
			setRefresh();
		}
		
		/**
		 * 	@private
		 */
		override public function finalize():void {
			_timer.stop();
			_timer = null;
			finalizeDayBtns();
			_dayBtnsEvtColl = null;
			_next.finalize();
			_previous.finalize();
			super.finalize();
		}
		
		/**
		 * 	@inheritDoc
		 */
		public function notifyKeyUpEvent(event:KeyboardEvent):void { }
		
		/**
		 * 	@inheritDoc
		 */
		public function notifyKeyDownEvent(event:KeyboardEvent):void { }
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function refresh():void {
			setPositions();
			lookAndFeel.drawTitleBar();
			lookAndFeel.drawBackground();
			displayDate();
			setDatePositions();
			setEffects();
			$storedSize.checkMetricsChanges();
		}
		
		/**
		 *  @private
		 */
		override protected function setSpecificLafChanges():void {
			setIconsLaf();
			setButtonSize();
			_previous.lockLaf(lookAndFeel.getButtonLaf(), true);
			_next.lockLaf(lookAndFeel.getButtonLaf(), true);
			setPositions(true);
			lookAndFeel.drawTitleBar();
			lookAndFeel.drawBackground();
			displayDate();
			setDatePositions();
			initializeDays(_currentYear, _currentMonth);
			renderYearNavigation();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const MONTH_LENGTH:Array =
			[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		private static const MIN_WIDTH:Number = 22;
		
		private var _keyManager:KeyboardManager;
		private var _dateFormater:DateFormatter;
		private var _month:TextField;
		private var _year:TextField;
		private var _currentDay:uint;
		private var _currentDate:uint;
		private var _currentMonth:uint;
		private var _currentYear:uint;
		private var _next:IconizedButton;
		private var _previous:IconizedButton;
		private var _rowWidth:Number;
		//private var _lineHeight:Number;
		private var _yearPanel:Sprite;
		private var _titleBar:Sprite;
		private var _weekBar:Sprite;
		private var _daysPanel:Sprite;
		private var _previousYear:Sprite;
		private var _nextYear:Sprite;
		private var _updateType:String;
		private var _dayBtnsEvtColl:EventCollector;
		private var _today:Object;
		private var _timer:Timer;
		private var _date:Date;
		private var _currentMonthLength:int;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			_keyManager = UIDescriptor.getUIManager().keyboardManager;
			initDate();
			createContainers();
			_fontColor = NaN;
			_rowWidth = MIN_WIDTH;
			//_lineHeight = 0;
			_allowMultipleSelection = false;
			_allowUserChanges = _showToday = _allowDisjointSelection = true;
			_previous = new IconizedButton();
			_next = new IconizedButton();
			initCollectionObjs();
			displayWeekDays();
			createNavigationButtons();
			createYearNavigation();
			fixYearNavigation(false);
			initLaf(DatePickerUIRef);
			spas_internal::setSelector(Selectors.DATEPICKER);
			spas_internal::isInitialized(1);
		}
		
		private function fixYearNavigation(value:Boolean):void {
			_yearNavigationEnabled = _nextYear.visible = _previousYear.visible = value;
		}
		
		private function initCollectionObjs():void {
			initSelRanges();
			_disabledRanges = [];
		}
		
		private function initSelRanges():void {
			_selectedRanges = [];
		}
		
		private function initDate():void {
			_minYear = 1900;
			_maxYear = 2100;
			createCalendarObj();
			_currentDay = _date.day;
			_currentDate = _date.getDate();
			_currentMonth = _date.month;
			_currentYear = _date.fullYear;
			_today = { day:_currentDate, month:_date.month+1, year:_date.fullYear };
			getFebruaryLength();
			_selectedDate = null;
		}
		
		private function createCalendarObj():void {
			_disabledDays = [];
			_dateFormater = new DateFormatter();
			_month = new TextField();
			_year = new TextField();
			_yearPanel = new Sprite();
			_titleBar = new Sprite();
			_weekBar = new Sprite();
			_daysPanel = new Sprite();
			_dayBtnsEvtColl = new EventCollector();
			_timer = new Timer(200, 1);
			_date = new Date();
		}
		
		private function getFebruaryLength():void {
			MONTH_LENGTH[1] = _currentYear % 4 == 0 ? 29 : 28;
		}
		
		private function createContainers():void {
			_titleBar.addChild(_month);
			_yearPanel.addChild(_year);
			_titleBar.addChild(_yearPanel);
			spas_internal::uioSprite.addChild(_titleBar);
			_month.selectable = _year.selectable = false;
			spas_internal::uioSprite.addChild(_weekBar);
			spas_internal::uioSprite.addChild(_daysPanel);
			spas_internal::lafDTO.titleBar = _titleBar;
			spas_internal::lafDTO.background = spas_internal::uioSprite;
		}
		
		private function createWeekDay(id:uint, text:String):Sprite {
			var s:Sprite = new Sprite();
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.LEFT;
			//t.border = true;
			t.selectable = false;
			t.text = text;
			s.addChild(t);
			_weekBar.addChild(s);
			return s
		}
		
		private function setWeekDayFormat(t:TextField):void {
			var fmt:TextFormat = lookAndFeel.getWeekTextFormat();
			t.setTextFormat(fmt);
		}
		
		private function createYearNavigation():void {
			_nextYear = new Sprite();
			_previousYear = new Sprite();
			$evtColl.addEvent(_nextYear, MouseEvent.MOUSE_DOWN, nextYearHandler);
			$evtColl.addEvent(_previousYear, MouseEvent.MOUSE_DOWN, previousYearHandler);
			$evtColl.addEvent(_nextYear, MouseEvent.MOUSE_DOWN, nextYearHandler);
			$evtColl.addEvent(_previousYear, MouseEvent.MOUSE_DOWN, previousYearHandler);
			_yearPanel.addChild(_nextYear);
			_yearPanel.addChild(_previousYear);
		}
		
		private function renderYearNavigation():void {
			spas_internal::lafDTO.currentTarget = _nextYear;
			lookAndFeel.drawNextYearOutState();
			spas_internal::lafDTO.currentTarget = _previousYear;
			lookAndFeel.drawPreviousYearOutState();
		}
		
		
		private function displayDate():void {
			_month.text = _dateFormater.months[_currentMonth];
			_year.text = String(_currentYear) + _yearSymbol;
			var myformat:TextFormat = lookAndFeel.getTitleTextFormat();
			if (!isNaN(_fontColor)) myformat.color = _fontColor;
			_month.setTextFormat(myformat);
			_year.setTextFormat(myformat);
			//_month.border = _year.border = true;
		}
		
		private function displayWeekDays():void {
			var d:Sprite;
			var i:uint = 0;
			for(; i<7; ++i) {
				d = createWeekDay(i, _dateFormater.days[i].substring(0, 2));
				if(d.width > _rowWidth) _rowWidth = d.width;
			}
		}
		
		private function finalizeDayBtns():void {
			_dayBtnsEvtColl.removeAllEvents();
			var dlu:DisplayListUtil = new DisplayListUtil(_daysPanel);
			dlu.removeAllChildren();
		}
		
		private function initializeDays(year:Number, month:Number):void {
			finalizeDayBtns();
			var firstDay:uint = new Date(year, month).day;
			var xPos:Number;
			switch(firstDay) {
				case 0 :
					xPos = 5;
					break;
				case 1 :
					xPos = -1;
					break;
				default :
					xPos = firstDay-2;
			}
			var yPos:uint = 0;
			var fmt:TextFormat = lookAndFeel.getDayTextFormat();
			var rp:Number = lookAndFeel.getRowPadding();
			var dbs:Number = lookAndFeel.getDayButtonSize();
			var i:uint = 1;
			var len:int = _currentMonthLength = MONTH_LENGTH[month];
			var db:SimpleDateButton;
			for (; i <= len; ++i) {
				
				db = new SimpleDateButton();
				db.setTextFormat(fmt);
				db.setText(String(i));
				db.setHeight(dbs);
				db.setWidth(_rowWidth - rp);
				
				if(xPos+1<7) xPos += 1;
				else xPos = 0, yPos +=1; 
				db.x = xPos*(_rowWidth+rp);
				db.y = yPos*(dbs+lookAndFeel.getLinePadding());
				
				db.setDate(i, month + 1, year, xPos);
				
				setDtoTgt(db);
				lookAndFeel.drawOutState();
				
				_daysPanel.addChild(db);
				_dayBtnsEvtColl.addEvent(db, MouseEvent.MOUSE_DOWN, dayDownHandler);
				_dayBtnsEvtColl.addEvent(db, MouseEvent.CLICK, dayClickHandler);
				_dayBtnsEvtColl.addEvent(db, MouseEvent.MOUSE_OVER, dayOverHandler);
				_dayBtnsEvtColl.addEvent(db, MouseEvent.MOUSE_OUT, dayOutHandler);
			}
			drawSelectedRanges();
			fixCurrentDay();
		}
		
		private function fixCurrentDay():void {
			var todayDay:int = _today.day;
			if (_today.year == _currentYear && (_today.month -1) == _currentMonth) {
				var db:SimpleDateButton = _daysPanel.getChildAt(_today.day - 1) as SimpleDateButton;
				setDtoTgt(db);
				if (_showToday) {
					if (db.selected) {
						lookAndFeel.drawTodaySelectedState();
					} else lookAndFeel.drawTodayOutState();
				}
			}
		}
		
		private function compareBtnDates(date1:Object, date2:Object):Boolean {
			return (date1.day == date2.day && date1.month == date2.month && date1.year == date2.year);
		}
		
		private function startAutoUpdate(updateType:String):void {
			_updateType = updateType;
			$evtColl.addEvent($stage, MouseEvent.MOUSE_UP, onButtonsReleaseOutside);
			$evtColl.addEvent(_timer, TimerEvent.TIMER, setAutoUpdate);
			_timer.start();
		}
		
		private function setPositions(updateLaf:Boolean = false):void {
			var s:Sprite;
			var i:uint = 0;
			var rp:Number = lookAndFeel.getRowPadding();
			var tbp:Number = lookAndFeel.getTitleBarPadding();
			for(; i<_weekBar.numChildren; ++i) {
				s = _weekBar.getChildAt(i) as Sprite;
				s.x = i * (_rowWidth + rp);
				if (updateLaf) {
					var t:TextField = s.getChildAt(0) as TextField;
					setWeekDayFormat(t);
				}
			}
			_daysPanel.x = _weekBar.x = rp;
			_weekBar.y = lookAndFeel.getTitleBarHeight() + rp;
			_daysPanel.y = _weekBar.y + _weekBar.height;
			spas_internal::lafDTO.width = $width = _weekBar.width + 2 * rp;
			spas_internal::lafDTO.height = $height =
				_daysPanel.y + _daysPanel.height + 2 * lookAndFeel.getLinePadding();
			_previous.x = _previous.y = _next.y = tbp;
			_next.x = $width - lookAndFeel.getButtonSize() - tbp;
		}
		
		private function setDatePositions():void {
			var tbp:Number = lookAndFeel.getTitleBarPadding();
			_month.autoSize = TextFieldAutoSize.CENTER;
			_year.autoSize = TextFieldAutoSize.LEFT;
			var bs:Number = lookAndFeel.getButtonSize();
			_nextYear.x = _previousYear.x = _year.width;
			_previousYear.y = _nextYear.height;
			var h:Number = _month.height;
			_month.autoSize = TextFieldAutoSize.NONE;
			var yearPanelWidth:Number = _yearNavigationEnabled ?
					_yearPanel.width : _yearPanel.width - Math.max(_nextYear.width, _previousYear.width);
			_month.width = $width - 2 * bs - 5 * tbp - yearPanelWidth;
			_month.height = h;
			_month.x = bs + 2 * tbp;
			_yearPanel.x = $width - bs - 2 * tbp - yearPanelWidth;
			_month.y = _yearPanel.y = (lookAndFeel.getTitleBarHeight()-_month.height)/2;
		}
		
		private function createNavigationButtons():void {
			_previous.target = _next.target = _titleBar;
			$evtColl.addEvent(_next, UIMouseEvent.PRESS, nextMonthHandler);
			$evtColl.addEvent(_previous, UIMouseEvent.PRESS, previousMonthHandler);
			_previous.display();
			_next.display();
		}
		
		private function setIconsLaf():void {
			_previous.drawIcon(lookAndFeel.getPreviousButtonBrush());
			_next.drawIcon(lookAndFeel.getNextButtonBrush());
		}
		
		private function setButtonSize():void {
			_previous.width = _next.width = _previous.height =
				_next.height = lookAndFeel.getButtonSize();
		}
		
		private function previousYearHandler(e:MouseEvent):void {
			if (_currentYear - 1 > _minYear) {
				_currentYear--;
				getFebruaryLength();
			}
			initializeDays(_currentYear, _currentMonth);
			refresh();
			//startAutoUpdate("decrease");
			
		}
		
		private function nextYearHandler(e:MouseEvent):void {
			if (_currentYear + 1 < _maxYear) {
				_currentYear++;
				getFebruaryLength();
			}
			initializeDays(_currentYear, _currentMonth);
			refresh();
			//startAutoUpdate("increase");
		}
		
		private function dayDownHandler(e:MouseEvent):void {
			if (_keyManager.getKeyObserver() != this) _keyManager.setKeyObserver(this);
		}
		
		private function dayClickHandler(e:MouseEvent):void {
			if (_allowUserChanges) {
				var db:SimpleDateButton = e.currentTarget as SimpleDateButton;
				if (!_allowMultipleSelection) doSingleSelection(db);
				else {
					if (_keyManager.isShiftPressed()) defineContinuousRange(db);
					else {
						if (_allowDisjointSelection && _keyManager.isControlPressed()) defineDiscontinuousRange(db);
						else doSingleSelection(db);
					}
				}
				fixCurrentDay();
				finishDayClickHandler(CalendarEvent.DATE_CHANGED);
			} else finishDayClickHandler(CalendarEvent.DATE_CLICKED);
		}
		
		private function defineDiscontinuousRange(db:SimpleDateButton):void {
			var len:int = _selectedRanges.length - 1;
			if (len == -1) doSingleSelection(db);
			else {
				var range:DateRange;
				var startDate:Date;
				var endDate:Date;
				var currentTime:Number = new Date(_currentYear, _currentMonth, db.day).getTime();
				var rangeStart:Number;
				var rangeEnd:Number;
				var rangeLength:int;
				for (; len >= 0; len--) {
					range = _selectedRanges[len];
					startDate = range.startDate;
					endDate = range.endDate;
					rangeStart = startDate.getTime();
					rangeEnd = endDate.getTime();
					rangeLength = range.getLength();
					if (rangeStart <= currentTime && currentTime <= rangeEnd && rangeLength > 1) {
						if (rangeLength == 2) {
							if (currentTime == rangeStart) range.startDate = endDate;
							else if (currentTime == rangeEnd) range.endDate = startDate;
						} else {
							var currDay:uint = db.day;
							var finalDate:Object = { day:endDate.date, month:endDate.getMonth(), year:endDate.getFullYear() };
							range.endDate = new Date(_currentYear, _currentMonth, currDay - 1);
							var splittedRange:DateRange = new DateRange(
								new Date(_currentYear, _currentMonth, currDay + 1),
								new Date(finalDate.year, finalDate.month, finalDate.day)
							);
							_selectedRanges.splice(len - 1, 0, splittedRange);
						}
						setDtoTgt(db);
						undrawDate(db);
						break;
					} else {
						if (db.selected) {
							setDtoTgt(db);
							undrawDate(db);
							initSelRanges();
						} else selectSingleDate(db);
						break;
					}
				}
			}
		}
		
		public function setDtoTgt(db:SimpleDateButton):void {
			spas_internal::lafDTO.currentTarget = db;
		}
		
		private function defineContinuousRange(db:SimpleDateButton):void {
			var len:int = _selectedRanges.length - 1;
			if (len >= 0) {
				var minDate:Object = { day:31, month:11, year:_maxYear };
				var maxDate:Object = { day:1, month:0, year:_minYear };
				var range:DateRange;
				var startDate:Date;
				var endDate:Date;
				for (; len >= 0; len--) {
					range = _selectedRanges[len];
					startDate = range.startDate;
					if (startDate.fullYear <= minDate.year && startDate.month <= minDate.month && startDate.date <= minDate.day) {
						setLimitDate(minDate, startDate);
					}
					endDate = range.endDate;
					if (endDate.fullYear >= maxDate.year && endDate.month >= maxDate.month && endDate.date >= maxDate.day) {
						setLimitDate(maxDate, endDate);
					}
				}
				removeAllRanges(null);
				var cursorDateMax:Date = new Date(maxDate.year, maxDate.month, maxDate.day);
				var cursorDate:Date = new Date(_currentYear, _currentMonth, db.day);
				var cursorDateMin:Date = new Date(minDate.year, minDate.month, minDate.day);
				var cursorMaxTime:Number = cursorDateMax.getTime();
				var cursorCurrTime:Number = cursorDate.getTime();
				var cursorMinTime:Number = cursorDateMin.getTime();
				if (cursorMinTime == cursorMaxTime) {
					range = cursorMinTime > cursorCurrTime ?
						new DateRange(cursorDate, cursorDateMin) :
						new DateRange(cursorDateMin, cursorDate);
				} else if(cursorCurrTime <= cursorMinTime) range = new DateRange(cursorDate, cursorDateMin);
				else if (cursorCurrTime >= cursorMaxTime) range = new DateRange(cursorDate, cursorDateMax);
				else range = new DateRange(cursorDateMin, cursorDate);
				_selectedRanges.push(range);
				drawSelectedRanges();
			} // else: do nothing when shift key is pressed and range list is empty.
		}
		
		private function setLimitDate(limit:Object, src:Date):void {
			limit.year = src.fullYear;
			limit.month = src.month;
			limit.day = src.date;
		}
		
		private function drawSelectedRanges():void {
			var len:int = _selectedRanges.length - 1;
			var range:DateRange;
			var startDate:Date;
			var endDate:Date;
			var cursorMinTime:Number = new Date(_currentYear, _currentMonth, 1).getTime();
			var cursorMaxTime:Number = new Date(_currentYear, _currentMonth, _currentMonthLength).getTime();
			var rangeStart:Number;
			var rangeEnd:Number;
			for (; len >= 0; len--) {
				range = _selectedRanges[len];
				startDate = range.startDate;
				endDate = range.endDate;
				rangeStart = startDate.getTime();
				rangeEnd = endDate.getTime();
				if (cursorMinTime <= rangeStart && rangeEnd <= cursorMaxTime) {
					drawDaysByRange(startDate.date, endDate.date);
				} else if (cursorMinTime >= rangeStart && rangeEnd >= cursorMinTime && rangeEnd <= cursorMaxTime) {
					drawDaysByRange(1, endDate.date);
				} else if (cursorMinTime <= rangeStart && rangeStart <= cursorMaxTime && rangeEnd >= cursorMaxTime) {
					drawDaysByRange(startDate.date, _currentMonthLength);
				} else if (rangeStart <= cursorMinTime && rangeEnd >= cursorMaxTime) {
					drawDaysByRange(1, _currentMonthLength);
				}
			}
		}
		
		private function drawDaysByRange(start:uint, end:uint):void {
			var db:SimpleDateButton;
			for (; start <= end; ++start) {
				db = SimpleDateButton(_daysPanel.getChildByName(String(start)));
				setDtoTgt(db);
				drawDate(db);
			}
		}
		
		private function finishDayClickHandler(evtType:String):void {
			_keyManager.deleteKeyObserver(this);
			doReflection();
			this.dispatchEvent(new CalendarEvent(evtType));
		}
		
		private function doSingleSelection(db:SimpleDateButton):void {
			removeAllRanges(db);
			setDtoTgt(db);
			if (db.selected && _keyManager.isControlPressed()) {
				undrawDate(db);
			} else selectSingleDate(db);
		}
		
		private function drawDate(db:SimpleDateButton):void {
			lookAndFeel.drawSelectedState();
			db.selected = true;
		}
		
		private function undrawDate(db:SimpleDateButton):void {
			lookAndFeel.drawOutState();
			db.selected = false;
			_selectedDate = null;
		}
		
		private function selectSingleDate(db:SimpleDateButton):void {
			drawDate(db);
			_selectedDate = { day:db.day, month:db.month, year:db.year, dayPosition:db.dayPosition };
			var d:Date = new Date(db.year, db.month - 1, db.day);
			var range:DateRange = new DateRange(d, d);
			_selectedRanges.push(range);
		}
		
		private function removeAllRanges(currBtn:SimpleDateButton):void {
			initSelRanges();
			var startDay:int = _currentMonthLength;
			var endDay:uint = 1;
			var db:SimpleDateButton;
			for (; startDay >= endDay; startDay--) {
				db = SimpleDateButton(_daysPanel.getChildByName(String(startDay)));
				setDtoTgt(db);
				lookAndFeel.drawOutState();
				if (currBtn != null) {
					if(currBtn != db) db.selected = false;
				} else db.selected = false;
			}
		}
		
		private function dayOverHandler(e:MouseEvent):void {
			var db:SimpleDateButton = e.currentTarget as SimpleDateButton;
			setDtoTgt(db);
			if(!db.selected) {
				compareBtnDates(db.date, _today) ?
					lookAndFeel.drawTodayOverState() : lookAndFeel.drawOverState();
				doReflection();
			}
		}
		
		private function dayOutHandler(e:MouseEvent):void {
			var db:SimpleDateButton = e.currentTarget as SimpleDateButton;
			setDtoTgt(db);
			if(!db.selected) {
				compareBtnDates(db.date, _today) && _showToday ?
					lookAndFeel.drawTodayOutState() : lookAndFeel.drawOutState();
				if (_selectedDate) {
					if (compareBtnDates(db.date, _selectedDate)) lookAndFeel.drawSelectedState();
				}
				doReflection();
			}
		}
		
		private function setAutoUpdate(e:TimerEvent):void {
			_timer.stop();
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setAutoUpdate);
			$evtColl.addEvent(_timer, TimerEvent.TIMER, setDelayeUpdate);
			_timer.repeatCount = 0;
			_timer.delay = 50;
			_timer.start();
		}
		
		private function setDelayeUpdate(e:TimerEvent):void {
			switch(_updateType) {
				case SpinButtonAction.INCREASE :
					nextMonthHandler(null);
					break;
				case SpinButtonAction.DECREASE :
					previousMonthHandler(null);
					break;
			}
		}
		
		private function stopAutoUpdate(e:UIMouseEvent):void {
			_timer.stop();
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setAutoUpdate);
			$evtColl.removeEvent(_timer, TimerEvent.TIMER, setDelayeUpdate);
			_timer.repeatCount = 1;
			_timer.delay = 200;
			$evtColl.removeEvent($stage, MouseEvent.MOUSE_UP, onButtonsReleaseOutside);
		}
		
		private function onButtonsReleaseOutside(event:MouseEvent):void {
			stopAutoUpdate(null);
		}
		
		private function previousMonthHandler(e:UIMouseEvent):void {
			if(_currentMonth-1>=0) _currentMonth--;
			else if (_currentYear > _minYear) {
				_currentMonth = 11;
				_currentYear--;
				getFebruaryLength();
			}
			initializeDays(_currentYear, _currentMonth);
			refresh();
			startAutoUpdate(SpinButtonAction.DECREASE);
		}
		
		private function nextMonthHandler(e:UIMouseEvent):void {
			if(_currentMonth+1<=11) _currentMonth++ ;
			else if (_currentYear < _maxYear) {
				_currentMonth = 0;
				_currentYear++;
				getFebruaryLength();
			}
			initializeDays(_currentYear, _currentMonth);
			refresh();
			startAutoUpdate(SpinButtonAction.INCREASE);
		}
	}
}