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

package org.flashapi.swing.databinding {
	
	// -----------------------------------------------------------
	//  LangNamesProviderEn.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 22/09/2011 13:45
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.constants.LanguageNameWeb;
	
	/**
	 * 	The <code>LangNamesProviderEn</code> class creates a <code>DataProviderObject</code>
	 * 	that contains all information about standard names of languages, in english,
	 * 	according to the ISO 639-1 Code.
	 * 
	 * 	@see org.flashapi.swing.constants.LanguageNameWeb
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 6.1
	 */
	public class LangNamesProviderEn extends AbstractDataProvider {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>LangNamesProviderEn</code> instance.
		 */
		public function LangNamesProviderEn() {
			super();
			initObj();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj():void {
			super.createStack( [
				{ label:"Afar", data:LanguageNameWeb.AAR },
				{ label:"Abkhazian", data:LanguageNameWeb.ABK },
				{ label:"Afrikaans", data:LanguageNameWeb.AFR },
				{ label:"Akan", data:LanguageNameWeb.AKA },
				{ label:"Albanian", data:LanguageNameWeb.ALB },
				{ label:"Amharic", data:LanguageNameWeb.AMH },
				{ label:"Arabic", data:LanguageNameWeb.ARA },
				{ label:"Aragonese", data:LanguageNameWeb.ARG },
				{ label:"Armenian", data:LanguageNameWeb.ARM },
				{ label:"Assamese", data:LanguageNameWeb.ASM },
				{ label:"Avaric", data:LanguageNameWeb.AVA },
				{ label:"Avestan", data:LanguageNameWeb.AVE },
				{ label:"Aymara", data:LanguageNameWeb.AYM },
				{ label:"Azerbaijani", data:LanguageNameWeb.AZE },
				{ label:"Bashkir", data:LanguageNameWeb.BAK },
				{ label:"Bambara", data:LanguageNameWeb.BAM },
				{ label:"Basque", data:LanguageNameWeb.BAQ },
				{ label:"Belarusian", data:LanguageNameWeb.BEL },
				{ label:"Bengali", data:LanguageNameWeb.BEN },
				{ label:"Bihari languages", data:LanguageNameWeb.BIH },
				{ label:"Bislama", data:LanguageNameWeb.BIS },
				{ label:"Tibetan", data:LanguageNameWeb.TIB },
				{ label:"Bosnian", data:LanguageNameWeb.BOS },
				{ label:"Breton", data:LanguageNameWeb.BRE },
				{ label:"Bulgarian", data:LanguageNameWeb.BUL },
				{ label:"Burmese", data:LanguageNameWeb.BUR },
				{ label:"Catalan", data:LanguageNameWeb.CAT },
				{ label:"Czech", data:LanguageNameWeb.CZE },
				{ label:"Chamorro", data:LanguageNameWeb.CHA },
				{ label:"Chechen", data:LanguageNameWeb.CHE },
				{ label:"Chinese", data:LanguageNameWeb.CHI },
				{ label:"Church Slavic", data:LanguageNameWeb.CHU },
				{ label:"Chuvash", data:LanguageNameWeb.CHV },
				{ label:"Cornish", data:LanguageNameWeb.COR },
				{ label:"Corsican", data:LanguageNameWeb.COS },
				{ label:"Cree", data:LanguageNameWeb.CRE },
				{ label:"Welsh", data:LanguageNameWeb.WEL },
				{ label:"Czech", data:LanguageNameWeb.CZE },
				{ label:"Danish", data:LanguageNameWeb.DAN },
				{ label:"German", data:LanguageNameWeb.GER },
				{ label:"Divehi", data:LanguageNameWeb.DIV },
				{ label:"Dutch", data:LanguageNameWeb.DUT },
				{ label:"Dzongkha", data:LanguageNameWeb.DZO },
				{ label:"Greek, Modern (1453-)", data:LanguageNameWeb.GRE },
				{ label:"English", data:LanguageNameWeb.ENG },
				{ label:"Esperanto", data:LanguageNameWeb.EPO },
				{ label:"Estonian", data:LanguageNameWeb.EST },
				{ label:"Basque", data:LanguageNameWeb.BAQ },
				{ label:"Ewe", data:LanguageNameWeb.EWE },
				{ label:"Faroese", data:LanguageNameWeb.FAO },
				{ label:"Persian", data:LanguageNameWeb.PER },
				{ label:"Fijian", data:LanguageNameWeb.FIJ },
				{ label:"Finnish", data:LanguageNameWeb.FIN },
				{ label:"French", data:LanguageNameWeb.FRE },
				{ label:"Western Frisian", data:LanguageNameWeb.FRY },
				{ label:"Fulah", data:LanguageNameWeb.FUL },
				{ label:"Georgian", data:LanguageNameWeb.GEO },
				{ label:"German", data:LanguageNameWeb.GER },
				{ label:"Gaelic", data:LanguageNameWeb.GLA },
				{ label:"Irish", data:LanguageNameWeb.GLE },
				{ label:"Galician", data:LanguageNameWeb.GLG },
				{ label:"Manx", data:LanguageNameWeb.GLV },
				{ label:"Greek, Modern (1453-)", data:LanguageNameWeb.GRE },
				{ label:"Guarani", data:LanguageNameWeb.GRN },
				{ label:"Gujarati", data:LanguageNameWeb.GUJ },
				{ label:"Haitian", data:LanguageNameWeb.HAT },
				{ label:"Hausa", data:LanguageNameWeb.HAU },
				{ label:"Hebrew", data:LanguageNameWeb.HEB },
				{ label:"Herero", data:LanguageNameWeb.HER },
				{ label:"Hindi", data:LanguageNameWeb.HIN },
				{ label:"Hiri Motu", data:LanguageNameWeb.HMO },
				{ label:"Croatian", data:LanguageNameWeb.HRV },
				{ label:"Hungarian", data:LanguageNameWeb.HUN },
				{ label:"Armenian", data:LanguageNameWeb.ARM },
				{ label:"Igbo", data:LanguageNameWeb.IBO },
				{ label:"Icelandic", data:LanguageNameWeb.ICE },
				{ label:"Ido", data:LanguageNameWeb.IDO },
				{ label:"Sichuan Yi", data:LanguageNameWeb.III },
				{ label:"Inuktitut", data:LanguageNameWeb.IKU },
				{ label:"Interlingue", data:LanguageNameWeb.ILE },
				{ label:"Interlingua (International Auxiliary Language Association)", data:LanguageNameWeb.INA },
				{ label:"Indonesian", data:LanguageNameWeb.IND },
				{ label:"Inupiaq", data:LanguageNameWeb.IPK },
				{ label:"Icelandic", data:LanguageNameWeb.ICE },
				{ label:"Italian", data:LanguageNameWeb.ITA },
				{ label:"Javanese", data:LanguageNameWeb.JAV },
				{ label:"Japanese", data:LanguageNameWeb.JPN },
				{ label:"Kalaallisut", data:LanguageNameWeb.KAL },
				{ label:"Kannada", data:LanguageNameWeb.KAN },
				{ label:"Kashmiri", data:LanguageNameWeb.KAS },
				{ label:"Georgian", data:LanguageNameWeb.GEO },
				{ label:"Kanuri", data:LanguageNameWeb.KAU },
				{ label:"Kazakh", data:LanguageNameWeb.KAZ },
				{ label:"Central Khmer", data:LanguageNameWeb.KHM },
				{ label:"Kikuyu", data:LanguageNameWeb.KIK },
				{ label:"Kinyarwanda", data:LanguageNameWeb.KIN },
				{ label:"Kirghiz", data:LanguageNameWeb.KIR },
				{ label:"Komi", data:LanguageNameWeb.KOM },
				{ label:"Kongo", data:LanguageNameWeb.KON },
				{ label:"Korean", data:LanguageNameWeb.KOR },
				{ label:"Kuanyama", data:LanguageNameWeb.KUA },
				{ label:"Kurdish", data:LanguageNameWeb.KUR },
				{ label:"Lao", data:LanguageNameWeb.LAO },
				{ label:"Latin", data:LanguageNameWeb.LAT },
				{ label:"Latvian", data:LanguageNameWeb.LAV },
				{ label:"Limburgan", data:LanguageNameWeb.LIM },
				{ label:"Lingala", data:LanguageNameWeb.LIN },
				{ label:"Lithuanian", data:LanguageNameWeb.LIT },
				{ label:"Luxembourgish", data:LanguageNameWeb.LTZ },
				{ label:"Luba-Katanga", data:LanguageNameWeb.LUB },
				{ label:"Ganda", data:LanguageNameWeb.LUG },
				{ label:"Macedonian", data:LanguageNameWeb.MAC },
				{ label:"Marshallese", data:LanguageNameWeb.MAH },
				{ label:"Malayalam", data:LanguageNameWeb.MAL },
				{ label:"Maori", data:LanguageNameWeb.MAO },
				{ label:"Marathi", data:LanguageNameWeb.MAR },
				{ label:"Malay", data:LanguageNameWeb.MAY },
				{ label:"Macedonian", data:LanguageNameWeb.MAC },
				{ label:"Malagasy", data:LanguageNameWeb.MLG },
				{ label:"Maltese", data:LanguageNameWeb.MLT },
				{ label:"Mongolian", data:LanguageNameWeb.MON },
				{ label:"Maori", data:LanguageNameWeb.MAO },
				{ label:"Malay", data:LanguageNameWeb.MAY },
				{ label:"Burmese", data:LanguageNameWeb.BUR },
				{ label:"Nauru", data:LanguageNameWeb.NAU },
				{ label:"Navajo", data:LanguageNameWeb.NAV },
				{ label:"Ndebele, South", data:LanguageNameWeb.NBL },
				{ label:"Ndebele, North", data:LanguageNameWeb.NDE },
				{ label:"Ndonga", data:LanguageNameWeb.NDO },
				{ label:"Nepali", data:LanguageNameWeb.NEP },
				{ label:"Dutch", data:LanguageNameWeb.DUT },
				{ label:"Norwegian Nynorsk", data:LanguageNameWeb.NNO },
				{ label:"Bokma, Norwegian", data:LanguageNameWeb.NOB },
				{ label:"Norwegian", data:LanguageNameWeb.NOR },
				{ label:"Chichewa", data:LanguageNameWeb.NYA },
				{ label:"Occitan (post 1500)", data:LanguageNameWeb.OCI },
				{ label:"Ojibwa", data:LanguageNameWeb.OJI },
				{ label:"Oriya", data:LanguageNameWeb.ORI },
				{ label:"Oromo", data:LanguageNameWeb.ORM },
				{ label:"Ossetian", data:LanguageNameWeb.OSS },
				{ label:"Panjabi", data:LanguageNameWeb.PAN },
				{ label:"Persian", data:LanguageNameWeb.PER },
				{ label:"Pali", data:LanguageNameWeb.PLI },
				{ label:"Polish", data:LanguageNameWeb.POL },
				{ label:"Portuguese", data:LanguageNameWeb.POR },
				{ label:"Pushto", data:LanguageNameWeb.PUS },
				{ label:"Quechua", data:LanguageNameWeb.QUE },
				{ label:"Romansh", data:LanguageNameWeb.ROH },
				{ label:"Romanian", data:LanguageNameWeb.RUM },
				{ label:"Romanian", data:LanguageNameWeb.RUM },
				{ label:"Rundi", data:LanguageNameWeb.RUN },
				{ label:"Russian", data:LanguageNameWeb.RUS },
				{ label:"Sango", data:LanguageNameWeb.SAG },
				{ label:"Sanskrit", data:LanguageNameWeb.SAN },
				{ label:"Sinhala", data:LanguageNameWeb.SIN },
				{ label:"Slovak", data:LanguageNameWeb.SLO },
				{ label:"Slovak", data:LanguageNameWeb.SLO },
				{ label:"Slovenian", data:LanguageNameWeb.SLV },
				{ label:"Northern Sami", data:LanguageNameWeb.SME },
				{ label:"Samoan", data:LanguageNameWeb.SMO },
				{ label:"Shona", data:LanguageNameWeb.SNA },
				{ label:"Sindhi", data:LanguageNameWeb.SND },
				{ label:"Somali", data:LanguageNameWeb.SOM },
				{ label:"Sotho, Southern", data:LanguageNameWeb.SOT },
				{ label:"Spanish", data:LanguageNameWeb.SPA },
				{ label:"Albanian", data:LanguageNameWeb.ALB },
				{ label:"Sardinian", data:LanguageNameWeb.SRD },
				{ label:"Serbian", data:LanguageNameWeb.SRP },
				{ label:"Swati", data:LanguageNameWeb.SSW },
				{ label:"Sundanese", data:LanguageNameWeb.SUN },
				{ label:"Swahili", data:LanguageNameWeb.SWA },
				{ label:"Swedish", data:LanguageNameWeb.SWE },
				{ label:"Tahitian", data:LanguageNameWeb.TAH },
				{ label:"Tamil", data:LanguageNameWeb.TAM },
				{ label:"Tatar", data:LanguageNameWeb.TAT },
				{ label:"Telugu", data:LanguageNameWeb.TEL },
				{ label:"Tajik", data:LanguageNameWeb.TGK },
				{ label:"Tagalog", data:LanguageNameWeb.TGL },
				{ label:"Thai", data:LanguageNameWeb.THA },
				{ label:"Tibetan", data:LanguageNameWeb.TIB },
				{ label:"Tigrinya", data:LanguageNameWeb.TIR },
				{ label:"Tonga (Tonga Islands)", data:LanguageNameWeb.TON },
				{ label:"Tswana", data:LanguageNameWeb.TSN },
				{ label:"Tsonga", data:LanguageNameWeb.TSO },
				{ label:"Turkmen", data:LanguageNameWeb.TUK },
				{ label:"Turkish", data:LanguageNameWeb.TUR },
				{ label:"Twi", data:LanguageNameWeb.TWI },
				{ label:"Uighur", data:LanguageNameWeb.UIG },
				{ label:"Ukrainian", data:LanguageNameWeb.UKR },
				{ label:"Urdu", data:LanguageNameWeb.URD },
				{ label:"Uzbek", data:LanguageNameWeb.UZB },
				{ label:"Venda", data:LanguageNameWeb.VEN },
				{ label:"Vietnamese", data:LanguageNameWeb.VIE },
				{ label:"Volapuk", data:LanguageNameWeb.VOL },
				{ label:"Welsh", data:LanguageNameWeb.WEL },
				{ label:"Walloon", data:LanguageNameWeb.WLN },
				{ label:"Wolof", data:LanguageNameWeb.WOL },
				{ label:"Xhosa", data:LanguageNameWeb.XHO },
				{ label:"Yiddish", data:LanguageNameWeb.YID },
				{ label:"Yoruba", data:LanguageNameWeb.YOR },
				{ label:"Zhuang", data:LanguageNameWeb.ZHA },
				{ label:"Chinese", data:LanguageNameWeb.CHI },
				{ label:"Zulu", data:LanguageNameWeb.ZUL }
			]);
		}
	}
}