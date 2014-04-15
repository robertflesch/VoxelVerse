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

package org.flashapi.swing.framework.locale.us {
	
	// -----------------------------------------------------------
	// LocaleErrors.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/01/2011 19:57
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 
	 * 	The <code>LocaleErrors</code> class is an enumeration of constant values that
	 * 	are internally used by the SPAS 3.0 localization API to set the language of
	 * 	exception messages thrown by the SPAS 3.0 core API.
	 * 
	 * 	<p><strong>Classes contained within the <code>org.flashapi.swing.framework.locale.us</code>
	 * 	package define SPAS 3.0 core localization for the English US language.</strong>
	 * 	</p>
	 * 
	 * 	@see org.flashapi.swing.framework.locale.Locale
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */	
	public class LocaleErrors extends LocaleLang {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				LocaleErrors instance.
		 */
		public function LocaleErrors() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An error message dispatched by <code>RadioButtonGroup</code> objects.
		 * 
		 * 	@see org.flashapi.swing.button.RadioButtonGroup
		 */
		public static const GROUP_INDEX_ERROR:String =
			"The index value must not be higher than the group length.";
		
		/**
		 * 	An error message dispatched by <code>UIObject</code> objects.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject
		 */
		public static const UNIQUE_ID_ERROR:String =
			"The ID must be unique in a document: ";
		
		/**
		 * 	An error message dispatched by <code>UIObject</code> objects.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject
		 */
		public static const MIN_WIDTH_ERROR:String =
			"The minimum width must be greater than the default minimum width.";
		
		/**
		 * 	An error message dispatched by <code>UIObject</code> objects.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject
		 */
		public static const MIN_HEIGHT_ERROR:String =
			"The minimum height must be greater than the default minimum height.";
		
		/**
		 * 	An error message dispatched by <code>UIObject</code> objects.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject
		 */
		public static const INIT_ERROR:String = "Initialization error";
		
		/**
		 * 	An error message dispatched by <code>ColorModule</code> objects.
		 * 
		 * 	@see org.flashapi.swing.color.ColorModuleBase
		 */
		public static const COLOR_KEYWORD_ERROR:String =
			"The specified color keyword does not exist in this 'Color Module': ";
		
		/**
		 * 	An error message dispatched by <code>RGB</code> objects.
		 * 
		 * 	@see org.flashapi.swing.color.RGB
		 */
		public static const COLOR_COMPONENT_ERROR:String =
			"Color parameter outside of expected range: ";
		
		/**
		 * 	An error message dispatched by <code>RGB</code> objects and thrown by
		 * 	<code>DeniedConstructorAccessException</code> exceptions.
		 * 
		 * 	@see org.flashapi.swing.color.DeniedConstructorAccess
		 * 	@see org.flashapi.swing.exceptions.DeniedConstructorAccessException
		 */
		public static const DENIED_CONSTRUCTOR_ERROR:String =
			"The following member cannot be accessed: ";
		
		/**
		 * 	An error message dispatched by <code>UIContainer</code> objects.
		 * 
		 * 	@see org.flashapi.swing.containers.UIContainer
		 */
		public static const CSS_PARAMETER_ERROR:String =
			"The value parameter must be a valid CSS URI or a StyleSheet object.";
		
		/**
		 * 	An error message dispatched by <code>UIObject</code> objects.
		 * 
		 * 	@see org.flashapi.swing.core.UIObject
		 * 	@see org.flashapi.swing.core.LAFValidator
		 */
		public static const LAF_ERROR:String =
			"This object does not implement the LookAndFeel interface: ";
		
		/**
		 * 	An error message dispatched by <code>Library</code> objects.
		 * 
		 * 	@see org.flashapi.swing.core.Library
		 */
		public static const LIBRARY_ERROR:String =
			"Class definition not found in this Library: ";
		
		/**
		 * 	An error message dispatched by <code>XMLQuery</code> objects.
		 * 
		 * 	@see org.flashapi.swing.databinding.XMLQuery
		 */
		public static const SPAS_PREFIX_NAMESPACE_MISMATCH:String =
			"Namespace prefix mismatch: prefix must be 'spas' when using strict mode.";
		
		/**
		 * 	An error message dispatched by <code>XMLQuery</code> objects.
		 * 
		 * 	@see org.flashapi.swing.databinding.XMLQuery
		 */
		public static const SPAS_NAMESPACE_MISMATCH:String =
			"Namespace mismatch: when using strict mode, namespace must be: ";
		
		/**
		 * 	An error message dispatched by <code>XMLQuery</code> objects.
		 * 
		 * 	@see org.flashapi.swing.databinding.XMLQuery
		 */
		public static const SPAS_CALLER_MISMATCH:String =
			"Caller attribute mismatch: when using strict mode, caller must be: ";
		
		/**
		 * 	An error message dispatched by <code>DnDManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.DnDManager
		 */
		public static const DND_SINGLETON_ERROR:String =
			"Only one DnDManager instance is authorized.";
		
		/**
		 * 	An error message dispatched by <code>ImageMap</code> objects.
		 * 
		 * 	@see org.flashapi.swing.draw.ImageMap
		 */
		public static const MAP_TARGET_ERROR:String =
			"The target parameter must be a UIObject or a DisplayObjectContainer.";
		
		/**
		 * 	An error message dispatched by <code>ImageMap</code> objects.
		 * 
		 * 	@see org.flashapi.swing.draw.ImageMap
		 */
		public static const MAP_DATA_ERROR:String =
			"Value must be a valid xml file or a string.";
		
		/**
		 * 	An error message dispatched by <code>RangeChecker</code> objects.
		 * 
		 * 	@see org.flashapi.swing.util.RangeChecker
		 */
		public static const GET_OUT_OF_RANGE_ERROR:Function = 
			function (parameter:String, value:*):String {
				return parameter + " is out of range: " + String(value);
			}
		
		/**
		 * 	An error message dispatched by the <code>Application</code> class.
		 * 
		 * 	@see org.flashapi.swing.Application
		 */
		public static const ENTRY_POINT_ERROR:String =
			"An entryPoint function has already been set.";
		
		/**
		 * 	[Deprecated] An error message dispatched by <code>BitmapFlow</code>
		 * 	objects.
		 * 
		 * 	@see org.flashapi.swing.BitmapFlow
		 */
		public static const BITMAP_FLOW_ERROR:String =
			"No source file is defined for the current picture node: ";
		
		/**
		 * 	An error message dispatched by <code>Initializator</code> objects.
		 * 
		 * 	@see org.flashapi.swing.Initializator
		 */
		public static const INITIALIZATOR_CSS_ERROR:String =
			"'css' parameter must be a valid CSS URI or a StyleSheet object.";
		
		/**
		 * 	An error message dispatched by <code>SoundUI</code> objects.
		 * 
		 * 	@see org.flashapi.swing.SoundUI
		 */
		public static const SOUNDUI_ID_ERROR:String =
			"The SoundUI ID must be unique in a document: ";
		
		/**
		 * 	An error message dispatched by <code>VideoStream</code> objects.
		 * 
		 * 	@see org.flashapi.swing.VideoStream
		 */
		public static const NETCONNECTION_ERROR:String =
			"Error #2126: NetConnection object must be connected.";
		
		/**
		 * 	An error message dispatched by <code>MultiForm</code> objects.
		 * 
		 * 	@see org.flashapi.swing.form.MultiForm
		 */
		public static const FORM_OBJECT_ERROR:String =
			"Value parameter must be a FormObject: ";
		
		/**
		 * 	An error message dispatched by <code>TableLayout</code> objects.
		 * 
		 * 	@see org.flashapi.swing.layout.TableLayout
		 */
		public static const COLUMN_SIZE_ERROR:String =
			"Column size is not a valid value.";
		
		/**
		 * 	An error message dispatched by <code>TableLayout</code> objects.
		 * 
		 * 	@see org.flashapi.swing.layout.TableLayout
		 */
		public static const ROW_SIZE_ERROR:String =
			"Row size is not a valid value.";
		
		/**
		 * 	An error message dispatched by <code>TableLayout</code> objects.
		 * 
		 * 	@see org.flashapi.swing.layout.TableLayout
		 */
		public static const COLUMN_NUMBER_ERROR:String =
			"Column number cannot be null.";
		
		/**
		 * 	An error message dispatched by <code>TableLayout</code> objects.
		 * 
		 * 	@see org.flashapi.swing.layout.TableLayout
		 */
		public static const ROW_NUMBER_ERROR:String =
			"Row number cannot be null";
		
		/**
		 * 	An error message dispatched by <code>CSSManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.CSSManager
		 */
		public static const CSS_MANAGER_SINGLETON_ERROR:String =
			"Only one CSSManager instance is authorized.";
		
		/**
		 * 	An error message dispatched by <code>FocusManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.FocusManager
		 */
		public static const FOCUS_MANAGER_SINGLETON_ERROR:String =
			"Only one FocusManager instance is authorized.";
		
		/**
		 * 	An error message dispatched by <code>KeyboardManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.KeyboardManager
		 */
		public static const KEYBOARD_MANAGER_SINGLETON_ERROR:String =
			"Only one KeyboardManager instance is authorized.";
		
		/**
		 * 	An error message dispatched by <code>LayoutManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.LayoutManager
		 */
		public static const LAYOUT_MANAGER_SINGLETON_ERROR:String =
			"Only one LayoutManager instance is authorized.";
		
		/**
		 * 	An error message dispatched by <code>LibraryManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.LibraryManager
		 */
		public static const LIBRARY_MANAGER_SINGLETON_ERROR:String =
			"Only one LibraryManager instance is authorized.";
		
		/**
		 * 	An error message dispatched by <code>AEM</code> objects.
		 * 
		 * 	@see org.flashapi.swing.effect.core.AEM
		 */
		public static const AEM_EFFECT_DURATION_ERROR:String =
			"Duration cannot be changed while effect is playing.";
		
		/**
		 * 	An error message dispatched by <code>StateManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.StateManager
		 */
		public static const STATE_MANAGER_ERROR:String =
			"Illegal to call this method if no state action has been registred.";
		
		/**
		 * 	An error message dispatched by <code>CSSManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.CSSManager
		 */
		public static const STYLE_PARAMETER_ERROR:String =
			"The 'styleSheet' parameter must be a String or a StyleSheet.";
		
		/**
		 * 	An error message dispatched by <code>CSSManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.CSSManager
		 */
		public static const CSS_BOOLEAN_ERROR:String =
			"Invalid CSS value, property must be 'true' or 'false': ";
		
		/**
		 * 	An error message dispatched by <code>CSSManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.CSSManager
		 */
		public static const CSS_LAYOUT_CLASS_ERROR:String =
			"Invalid Layout class name: ";
		
		/**
		 * 	An error message dispatched by <code>CSSManager</code> objects.
		 * 
		 * 	@see org.flashapi.swing.managers.CSSManager
		 */
		public static const CSS_LAYOUT_ALIGNMENT_ERROR:String =
			"Invalid Layout alignment value: ";
		
		/**
		 * 	An error message dispatched by <code>BitmapMapper</code> objects.
		 * 
		 * 	@see org.flashapi.swing.tools.BitmapMapper
		 */
		public static const BITMAP_MAPPER_ERROR:String =
			"The XML map or bitmapdata source cannot be null.";
			
		/**
		 * 	An error message dispatched by <code>MappedBitmapLoader</code> objects.
		 * 
		 * 	@see org.flashapi.swing.net.MappedBitmapLoader
		 */
		public static const BITMAP_INVALID_MAP_ERROR:String =
			"The map property must be a valid XML object or file.";
		
		/**
		 * 	An error message dispatched by <code>MappedBitmapLoader</code> objects.
		 * 
		 * 	@see org.flashapi.swing.net.MappedBitmapLoader
		 */
		public static const BITMAP_INVALID_BITMAP_ERROR:String =
			"The source property must be a valid BitmapData object or file.";
		
		/**
		 * 	An error message dispatched by <code>SoundAnalizer</code> objects.
		 * 
		 * 	@see org.flashapi.swing.SoundAnalizer
		 */
		public static const SOUND_ANALYSER_LIB_ERROR:String =
			"The parameter is not a SpectrumLibrary object: ";
		
		/**
		 * 	An error message printed by a <code>UILoader</code> object within the
		 * 	output panel when an error occurs after having tried to load an external
		 * 	asset.
		 * 
		 * 	@see org.flashapi.swing.net.UILoader
		 */
		public static const LOADING_ERROR:String =
			"Error while loading the following URL: ";
		
		/**
		 * 	An error message dispatched by <code>AbstractValidator</code> objects.
		 * 
		 * 	@see org.flashapi.swing.validators.AbstractValidator
		 * 	@see org.flashapi.swing.localization.validation.LocaleValidation
		 */
		public static const LOCALE_VALIDATION_ERROR:String =
			"This object does not implement the LocaleValidation interface: ";
			
		/**
		 * 	A warning message dispatched by <code>UIObject</code> instances when trying
		 * 	to set a deprecated property.
		 */
		public static const GET_DEPRECATED_PROP_WARNING_MESSAGE:Function = 
			function(prop:String, replacement:String):String {
				return 	"The " + prop + " property is no longer supported for this object. Use the " +
						replacement + " property instead.";
			}
		
		/**
		 * 	An error message dispatched by <code>Initializator</code> objects when 
		 * 	trying to run the <code>initXmlQuery()</code> method with an invalid xml
		 * 	file.
		 * 
		 * 	@see org.flashapi.swing.Initializator
		 */
		public static const GET_INVALID_XML_INIT_ERROR:Function = 
			function(obj:String):String {
				return 	"The xml parameter used to initialize this object is not valid: " + obj;
			}
		
		/**
		 * 	An error message printed by a <code>DateRange</code> object within the
		 * 	output panel when an error occurs after having tried to set the start and
		 * 	end dates with start greater than end.
		 * 
		 * 	@see org.flashapi.swing.calendar.DateRange
		 */
		public static const DATE_RANGE_ERROR:String =
			"endDate must be greater than startDate.";
		
	}
}