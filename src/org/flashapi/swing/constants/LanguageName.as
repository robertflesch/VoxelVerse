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

package org.flashapi.swing.constants {
	
	// -----------------------------------------------------------
	// LanguageName.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 22/09/2011 13:58
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.localization.ISO639;
	
	/**
	 * 	The <code>LanguageName</code> class is an enumeration of constant values that
	 * 	you can use to set all information about a language name, according to the ISO 
	 * 	639-2 standard.
	 * 
	 * 	@see org.flashapi.swing.localization.ISO639
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 6.1
	 */
	public class LanguageName {
		
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
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccessException if you try to create a new 
		 * 				LanguageName instance.
		 */
		public function LanguageName() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The ISO 639 standard language name values for Afar.
		 */
		public static const AAR:ISO639 = new ISO639("Afar", "aa", "aar");
		
		/**
		 * 	The ISO 639 standard language name values for Abkhazian.
		 */
		public static const ABK:ISO639 = new ISO639("Abkhazian", "ab", "abk");
		
		/**
		 * 	The ISO 639 standard language name values for Achinese.
		 */
		public static const ACE:ISO639 = new ISO639("Achinese", "", "ace");
		
		/**
		 * 	The ISO 639 standard language name values for Acoli.
		 */
		public static const ACH:ISO639 = new ISO639("Acoli", "", "ach");
		
		/**
		 * 	The ISO 639 standard language name values for Adangme.
		 */
		public static const ADA:ISO639 = new ISO639("Adangme", "", "ada");
		
		/**
		 * 	The ISO 639 standard language name values for Adyghe.
		 */
		public static const ADY:ISO639 = new ISO639("Adyghe", "", "ady");
		
		/**
		 * 	The ISO 639 standard language name values for Afro-Asiatic languages.
		 */
		public static const AFA:ISO639 = new ISO639("Afro-Asiatic languages", "", "afa");
		
		/**
		 * 	The ISO 639 standard language name values for Afrihili.
		 */
		public static const AFH:ISO639 = new ISO639("Afrihili", "", "afh");
		
		/**
		 * 	The ISO 639 standard language name values for Afrikaans.
		 */
		public static const AFR:ISO639 = new ISO639("Afrikaans", "af", "afr");
		
		/**
		 * 	The ISO 639 standard language name values for Ainu.
		 */
		public static const AIN:ISO639 = new ISO639("Ainu", "", "ain");
		
		/**
		 * 	The ISO 639 standard language name values for Akan.
		 */
		public static const AKA:ISO639 = new ISO639("Akan", "ak", "aka");
		
		/**
		 * 	The ISO 639 standard language name values for Akkadian.
		 */
		public static const AKK:ISO639 = new ISO639("Akkadian", "", "akk");
		
		/**
		 * 	The ISO 639 standard language name values for Albanian.
		 */
		public static const ALB:ISO639 = new ISO639("Albanian", "sq", "alb");
		
		/**
		 * 	The ISO 639 standard language name values for Aleut.
		 */
		public static const ALE:ISO639 = new ISO639("Aleut", "", "ale");
		
		/**
		 * 	The ISO 639 standard language name values for Algonquian languages.
		 */
		public static const ALG:ISO639 = new ISO639("Algonquian languages", "", "alg");
		
		/**
		 * 	The ISO 639 standard language name values for Southern Altai.
		 */
		public static const ALT:ISO639 = new ISO639("Southern Altai", "", "alt");
		
		/**
		 * 	The ISO 639 standard language name values for Amharic.
		 */
		public static const AMH:ISO639 = new ISO639("Amharic", "am", "amh");
		
		/**
		 * 	The ISO 639 standard language name values for English, Old (ca.450-1100).
		 */
		public static const ANG:ISO639 = new ISO639("English, Old (ca.450-1100)", "", "ang");
		
		/**
		 * 	The ISO 639 standard language name values for Angika.
		 */
		public static const ANP:ISO639 = new ISO639("Angika", "", "anp");
		
		/**
		 * 	The ISO 639 standard language name values for Apache languages.
		 */
		public static const APA:ISO639 = new ISO639("Apache languages", "", "apa");
		
		/**
		 * 	The ISO 639 standard language name values for Arabic.
		 */
		public static const ARA:ISO639 = new ISO639("Arabic", "ar", "ara");
		
		/**
		 * 	The ISO 639 standard language name values for Official Aramaic (700-300 BCE).
		 */
		public static const ARC:ISO639 = new ISO639("Official Aramaic (700-300 BCE)", "", "arc");
		
		/**
		 * 	The ISO 639 standard language name values for Aragonese.
		 */
		public static const ARG:ISO639 = new ISO639("Aragonese", "an", "arg");
		
		/**
		 * 	The ISO 639 standard language name values for Armenian.
		 */
		public static const ARM:ISO639 = new ISO639("Armenian", "hy", "arm");
		
		/**
		 * 	The ISO 639 standard language name values for Mapudungun.
		 */
		public static const ARN:ISO639 = new ISO639("Mapudungun", "", "arn");
		
		/**
		 * 	The ISO 639 standard language name values for Arapaho.
		 */
		public static const ARP:ISO639 = new ISO639("Arapaho", "", "arp");
		
		/**
		 * 	The ISO 639 standard language name values for Artificial languages.
		 */
		public static const ART:ISO639 = new ISO639("Artificial languages", "", "art");
		
		/**
		 * 	The ISO 639 standard language name values for Arawak.
		 */
		public static const ARW:ISO639 = new ISO639("Arawak", "", "arw");
		
		/**
		 * 	The ISO 639 standard language name values for Assamese.
		 */
		public static const ASM:ISO639 = new ISO639("Assamese", "as", "asm");
		
		/**
		 * 	The ISO 639 standard language name values for Asturian.
		 */
		public static const AST:ISO639 = new ISO639("Asturian", "", "ast");
		
		/**
		 * 	The ISO 639 standard language name values for Athapascan languages.
		 */
		public static const ATH:ISO639 = new ISO639("Athapascan languages", "", "ath");
		
		/**
		 * 	The ISO 639 standard language name values for Australian languages.
		 */
		public static const AUS:ISO639 = new ISO639("Australian languages", "", "aus");
		
		/**
		 * 	The ISO 639 standard language name values for Avaric.
		 */
		public static const AVA:ISO639 = new ISO639("Avaric", "av", "ava");
		
		/**
		 * 	The ISO 639 standard language name values for Avestan.
		 */
		public static const AVE:ISO639 = new ISO639("Avestan", "ae", "ave");
		
		/**
		 * 	The ISO 639 standard language name values for Awadhi.
		 */
		public static const AWA:ISO639 = new ISO639("Awadhi", "", "awa");
		
		/**
		 * 	The ISO 639 standard language name values for Aymara.
		 */
		public static const AYM:ISO639 = new ISO639("aym", "ay", "Aymara");
		
		/**
		 * 	The ISO 639 standard language name values for Azerbaijani.
		 */
		public static const AZE:ISO639 = new ISO639("aze", "az", "Azerbaijani");
		
		/**
		 * 	The ISO 639 standard language name values for Banda languages.
		 */
		public static const BAD:ISO639 = new ISO639("bad", "", "Banda languages");
		
		/**
		 * 	The ISO 639 standard language name values for Bamileke languages.
		 */
		public static const BAI:ISO639 = new ISO639("bai", "", "Bamileke languages");
		
		/**
		 * 	The ISO 639 standard language name values for Bashkir.
		 */
		public static const BAK:ISO639 = new ISO639("bak", "ba", "Bashkir");
		
		/**
		 * 	The ISO 639 standard language name values for Baluchi.
		 */
		public static const BAL:ISO639 = new ISO639("bal", "", "Baluchi");
		
		/**
		 * 	The ISO 639 standard language name values for Bambara.
		 */
		public static const BAM:ISO639 = new ISO639("bam", "bm", "Bambara");
		
		/**
		 * 	The ISO 639 standard language name values for Balinese.
		 */
		public static const BAN:ISO639 = new ISO639("ban", "", "Balinese");
		
		/**
		 * 	The ISO 639 standard language name values for Basque.
		 */
		public static const BAQ:ISO639 = new ISO639("baq", "eu", "Basque");
		
		/**
		 * 	The ISO 639 standard language name values for Basa.
		 */
		public static const BAS:ISO639 = new ISO639("bas", "", "Basa");
		
		/**
		 * 	The ISO 639 standard language name values for Baltic languages.
		 */
		public static const BAT:ISO639 = new ISO639("bat", "", "Baltic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Beja.
		 */
		public static const BEJ:ISO639 = new ISO639("bej", "", "Beja");
		
		/**
		 * 	The ISO 639 standard language name values for Belarusian.
		 */
		public static const BEL:ISO639 = new ISO639("bel", "be", "Belarusian");
		
		/**
		 * 	The ISO 639 standard language name values for Bemba.
		 */
		public static const BEM:ISO639 = new ISO639("bem", "", "Bemba");
		
		/**
		 * 	The ISO 639 standard language name values for Bengali.
		 */
		public static const BEN:ISO639 = new ISO639("ben", "bn", "Bengali");
		
		/**
		 * 	The ISO 639 standard language name values for Berber languages.
		 */
		public static const BER:ISO639 = new ISO639("ber", "", "Berber languages");
		
		/**
		 * 	The ISO 639 standard language name values for Bhojpuri.
		 */
		public static const BHO:ISO639 = new ISO639("bho", "", "Bhojpuri");
		
		/**
		 * 	The ISO 639 standard language name values for Bihari languages.
		 */
		public static const BIH:ISO639 = new ISO639("bih", "bh", "Bihari languages");
		
		/**
		 * 	The ISO 639 standard language name values for Bikol.
		 */
		public static const BIK:ISO639 = new ISO639("bik", "", "Bikol");
		
		/**
		 * 	The ISO 639 standard language name values for Bini.
		 */
		public static const BIN:ISO639 = new ISO639("bin", "", "Bini");
		
		/**
		 * 	The ISO 639 standard language name values for Bislama.
		 */
		public static const BIS:ISO639 = new ISO639("bis", "bi", "Bislama");
		
		/**
		 * 	The ISO 639 standard language name values for Siksika.
		 */
		public static const BLA:ISO639 = new ISO639("bla", "", "Siksika");
		
		/**
		 * 	The ISO 639 standard language name values for Bantu languages.
		 */
		public static const BNT:ISO639 = new ISO639("bnt", "", "Bantu languages");
		
		/**
		 * 	The ISO 639 standard language name values for Bosnian.
		 */
		public static const BOS:ISO639 = new ISO639("bos", "bs", "Bosnian");
		
		/**
		 * 	The ISO 639 standard language name values for Braj.
		 */
		public static const BRA:ISO639 = new ISO639("bra", "", "Braj");
		
		/**
		 * 	The ISO 639 standard language name values for Breton.
		 */
		public static const BRE:ISO639 = new ISO639("bre", "br", "Breton");
		
		/**
		 * 	The ISO 639 standard language name values for Batak languages.
		 */
		public static const BTK:ISO639 = new ISO639("btk", "", "Batak languages");
		
		/**
		 * 	The ISO 639 standard language name values for Buriat.
		 */
		public static const BUA:ISO639 = new ISO639("bua", "", "Buriat");
		
		/**
		 * 	The ISO 639 standard language name values for Buginese.
		 */
		public static const BUG:ISO639 = new ISO639("bug", "", "Buginese");
		
		/**
		 * 	The ISO 639 standard language name values for Bulgarian.
		 */
		public static const BUL:ISO639 = new ISO639("bul", "bg", "Bulgarian");
		
		/**
		 * 	The ISO 639 standard language name values for Burmese.
		 */
		public static const BUR:ISO639 = new ISO639("bur", "my", "Burmese");
		
		/**
		 * 	The ISO 639 standard language name values for Blin.
		 */
		public static const BYN:ISO639 = new ISO639("byn", "", "Blin");
		
		/**
		 * 	The ISO 639 standard language name values for Caddo.
		 */
		public static const CAD:ISO639 = new ISO639("cad", "", "Caddo");
		
		/**
		 * 	The ISO 639 standard language name values for Central American Indian languages.
		 */
		public static const CAI:ISO639 = new ISO639("cai", "", "Central American Indian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Galibi Carib.
		 */
		public static const CAR:ISO639 = new ISO639("car", "", "Galibi Carib");
		
		/**
		 * 	The ISO 639 standard language name values for Catalan.
		 */
		public static const CAT:ISO639 = new ISO639("cat", "ca", "Catalan");
		
		/**
		 * 	The ISO 639 standard language name values for Caucasian languages.
		 */
		public static const CAU:ISO639 = new ISO639("cau", "", "Caucasian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Cebuano.
		 */
		public static const CEB:ISO639 = new ISO639("ceb", "", "Cebuano");
		
		/**
		 * 	The ISO 639 standard language name values for Celtic languages.
		 */
		public static const CEL:ISO639 = new ISO639("cel", "", "Celtic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Chamorro.
		 */
		public static const CHA:ISO639 = new ISO639("cha", "ch", "Chamorro");
		
		/**
		 * 	The ISO 639 standard language name values for Chibcha.
		 */
		public static const CHB:ISO639 = new ISO639("chb", "", "Chibcha");
		
		/**
		 * 	The ISO 639 standard language name values for Chechen.
		 */
		public static const CHE:ISO639 = new ISO639("che", "ce", "Chechen");
		
		/**
		 * 	The ISO 639 standard language name values for Chagatai.
		 */
		public static const CHG:ISO639 = new ISO639("chg", "", "Chagatai");
		
		/**
		 * 	The ISO 639 standard language name values for Chuukese.
		 */
		public static const CHI:ISO639 = new ISO639("chi", "zh", "Chinese");
		
		/**
		 * 	The ISO 639 standard language name values for Chuukese.
		 */
		public static const CHK:ISO639 = new ISO639("chk", "", "Chuukese");
		
		/**
		 * 	The ISO 639 standard language name values for Mari.
		 */
		public static const CHM:ISO639 = new ISO639("chm", "", "Mari");
		
		/**
		 * 	The ISO 639 standard language name values for Chinook jargon.
		 */
		public static const CHN:ISO639 = new ISO639("chn", "", "Chinook jargon");
		
		/**
		 * 	The ISO 639 standard language name values for Choctaw.
		 */
		public static const CHO:ISO639 = new ISO639("cho", "", "Choctaw");
		
		/**
		 * 	The ISO 639 standard language name values for Chipewyan.
		 */
		public static const CHP:ISO639 = new ISO639("chp", "", "Chipewyan");
		
		/**
		 * 	The ISO 639 standard language name values for Cherokee.
		 */
		public static const CHR:ISO639 = new ISO639("chr", "", "Cherokee");
		
		/**
		 * 	The ISO 639 standard language name values for Church Slavic.
		 */
		public static const CHU:ISO639 = new ISO639("chu", "cu", "Church Slavic");
		
		/**
		 * 	The ISO 639 standard language name values for Chuvash.
		 */
		public static const CHV:ISO639 = new ISO639("chv", "cv", "Chuvash");
		
		/**
		 * 	The ISO 639 standard language name values for Cheyenne.
		 */
		public static const CHY:ISO639 = new ISO639("chy", "", "Cheyenne");
		
		/**
		 * 	The ISO 639 standard language name values for Chamic languages.
		 */
		public static const CMC:ISO639 = new ISO639("cmc", "", "Chamic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Coptic.
		 */
		public static const COP:ISO639 = new ISO639("cop", "", "Coptic");
		
		/**
		 * 	The ISO 639 standard language name values for Cornish.
		 */
		public static const COR:ISO639 = new ISO639("cor", "kw", "Cornish");
		
		/**
		 * 	The ISO 639 standard language name values for Corsican.
		 */
		public static const COS:ISO639 = new ISO639("cos", "co", "Corsican");
		
		/**
		 * 	The ISO 639 standard language name values for Creoles and pidgins, English based.
		 */
		public static const CPE:ISO639 = new ISO639("cpe", "", "Creoles and pidgins, English based");
		
		/**
		 * 	The ISO 639 standard language name values for Creoles and pidgins, French-based.
		 */
		public static const CPF:ISO639 = new ISO639("cpf", "", "Creoles and pidgins, French-based");
		
		/**
		 * 	The ISO 639 standard language name values for Creoles and pidgins, Portuguese-based.
		 */
		public static const CPP:ISO639 = new ISO639("cpp", "", "Creoles and pidgins, Portuguese-based");
		
		/**
		 * 	The ISO 639 standard language name values for Cree.
		 */
		public static const CRE:ISO639 = new ISO639("cre", "cr", "Cree");
		
		/**
		 * 	The ISO 639 standard language name values for Crimean Tatar.
		 */
		public static const CRH:ISO639 = new ISO639("crh", "", "Crimean Tatar");
		
		/**
		 * 	The ISO 639 standard language name values for Creoles and pidgins.
		 */
		public static const CRP:ISO639 = new ISO639("crp", "", "Creoles and pidgins");
		
		/**
		 * 	The ISO 639 standard language name values for Kashubian.
		 */
		public static const CSB:ISO639 = new ISO639("csb", "", "Kashubian");
		
		/**
		 * 	The ISO 639 standard language name values for Cushitic languages.
		 */
		public static const CUS:ISO639 = new ISO639("cus", "", "Cushitic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Czech.
		 */
		public static const CZE:ISO639 = new ISO639("cze", "cs", "Czech");
		
		/**
		 * 	The ISO 639 standard language name values for Dakota.
		 */
		public static const DAK:ISO639 = new ISO639("dak", "", "Dakota");
		
		/**
		 * 	The ISO 639 standard language name values for Danish.
		 */
		public static const DAN:ISO639 = new ISO639("dan", "da", "Danish");
		
		/**
		 * 	The ISO 639 standard language name values for Dargwa.
		 */
		public static const DAR:ISO639 = new ISO639("dar", "", "Dargwa");
		
		/**
		 * 	The ISO 639 standard language name values for Land Dayak languages.
		 */
		public static const DAY:ISO639 = new ISO639("day", "", "Land Dayak languages");
		
		/**
		 * 	The ISO 639 standard language name values for Delaware.
		 */
		public static const DEL:ISO639 = new ISO639("del", "", "Delaware");
		
		/**
		 * 	The ISO 639 standard language name values for Slave (Athapascan).
		 */
		public static const DEN:ISO639 = new ISO639("den", "", "Slave (Athapascan)");
		
		/**
		 * 	The ISO 639 standard language name values for German.
		 */
		public static const GER:ISO639 = new ISO639("ger", "de", "German");
		
		/**
		 * 	The ISO 639 standard language name values for Dogrib.
		 */
		public static const DGR:ISO639 = new ISO639("dgr", "", "Dogrib");
		
		/**
		 * 	The ISO 639 standard language name values for Dinka.
		 */
		public static const DIN:ISO639 = new ISO639("din", "", "Dinka");
		
		/**
		 * 	The ISO 639 standard language name values for Divehi.
		 */
		public static const DIV:ISO639 = new ISO639("div", "dv", "Divehi");
		
		/**
		 * 	The ISO 639 standard language name values for Dogri.
		 */
		public static const DOI:ISO639 = new ISO639("doi", "", "Dogri");
		
		/**
		 * 	The ISO 639 standard language name values for Dravidian languages.
		 */
		public static const DRA:ISO639 = new ISO639("dra", "", "Dravidian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Lower Sorbian.
		 */
		public static const DSB:ISO639 = new ISO639("dsb", "", "Lower Sorbian");
		
		/**
		 * 	The ISO 639 standard language name values for Duala.
		 */
		public static const DUA:ISO639 = new ISO639("dua", "", "Duala");
		
		/**
		 * 	The ISO 639 standard language name values for Dutch, Middle (ca.1050-1350).
		 */
		public static const DUM:ISO639 = new ISO639("dum", "", "Dutch, Middle (ca.1050-1350)");
		
		/**
		 * 	The ISO 639 standard language name values for Dutch.
		 */
		public static const DUT:ISO639 = new ISO639("dut", "nl", "Dutch");
		
		/**
		 * 	The ISO 639 standard language name values for Dyula.
		 */
		public static const DYU:ISO639 = new ISO639("dyu", "", "Dyula");
		
		/**
		 * 	The ISO 639 standard language name values for Dzongkha.
		 */
		public static const DZO:ISO639 = new ISO639("dzo", "dz", "Dzongkha");
		
		/**
		 * 	The ISO 639 standard language name values for Efik.
		 */
		public static const EFI:ISO639 = new ISO639("efi", "", "Efik");
		
		/**
		 * 	The ISO 639 standard language name values for Egyptian (Ancient).
		 */
		public static const EGY:ISO639 = new ISO639("egy", "", "Egyptian (Ancient)");
		
		/**
		 * 	The ISO 639 standard language name values for Ekajuk.
		 */
		public static const EKA:ISO639 = new ISO639("eka", "", "Ekajuk");
		
		/**
		 * 	The ISO 639 standard language name values for Greek, Modern.
		 */
		public static const GRE:ISO639 = new ISO639("gre", "el", "Greek");
		
		/**
		 * 	The ISO 639 standard language name values for Elamite.
		 */
		public static const ELX:ISO639 = new ISO639("elx", "", "Elamite");
		
		/**
		 * 	The ISO 639 standard language name values for English.
		 */
		public static const ENG:ISO639 = new ISO639("eng", "en", "English");
		
		/**
		 * 	The ISO 639 standard language name values for English, Middle (1100-1500).
		 */
		public static const ENM:ISO639 = new ISO639("enm", "", "English, Middle (1100-1500)");
		
		/**
		 * 	The ISO 639 standard language name values for Esperanto.
		 */
		public static const EPO:ISO639 = new ISO639("epo", "eo", "Esperanto");
		
		/**
		 * 	The ISO 639 standard language name values for Estonian.
		 */
		public static const EST:ISO639 = new ISO639("est", "et", "Estonian");
		
		/**
		 * 	The ISO 639 standard language name values for Ewe.
		 */
		public static const EWE:ISO639 = new ISO639("ewe", "ee", "Ewe");
		
		/**
		 * 	The ISO 639 standard language name values for Ewondo.
		 */
		public static const EWO:ISO639 = new ISO639("ewo", "", "Ewondo");
		
		/**
		 * 	The ISO 639 standard language name values for Fang.
		 */
		public static const FAN:ISO639 = new ISO639("fan", "", "Fang");
		
		/**
		 * 	The ISO 639 standard language name values for Faroese.
		 */
		public static const FAO:ISO639 = new ISO639("fao", "fo", "Faroese");
		
		/**
		 * 	The ISO 639 standard language name values for Fanti.
		 */
		public static const FAT:ISO639 = new ISO639("fat", "", "Fanti");
		
		/**
		 * 	The ISO 639 standard language name values for Fijian.
		 */
		public static const FIJ:ISO639 = new ISO639("fij", "fj", "Fijian");
		
		/**
		 * 	The ISO 639 standard language name values for Filipino.
		 */
		public static const FIL:ISO639 = new ISO639("fil", "", "Filipino");
		
		/**
		 * 	The ISO 639 standard language name values for Finnish.
		 */
		public static const FIN:ISO639 = new ISO639("fin", "fi", "Finnish");
		
		/**
		 * 	The ISO 639 standard language name values for Finno-Ugrian languages.
		 */
		public static const FIU:ISO639 = new ISO639("fiu", "", "Finno-Ugrian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Fon.
		 */
		public static const FON:ISO639 = new ISO639("fon", "", "Fon");
		
		/**
		 * 	The ISO 639 standard language name values for French.
		 */
		public static const FRE:ISO639 = new ISO639("fre", "fr", "French");
		
		/**
		 * 	The ISO 639 standard language name values for French, Middle (ca.1400-1600).
		 */
		public static const FRM:ISO639 = new ISO639("frm", "", "French, Middle (ca.1400-1600)");
		
		/**
		 * 	The ISO 639 standard language name values for French, Old (842-ca.1400).
		 */
		public static const FRO:ISO639 = new ISO639("fro", "", "French, Old (842-ca.1400)");
		
		/**
		 * 	The ISO 639 standard language name values for Northern Frisian.
		 */
		public static const FRR:ISO639 = new ISO639("frr", "", "Northern Frisian");
		
		/**
		 * 	The ISO 639 standard language name values for Eastern Frisian.
		 */
		public static const FRS:ISO639 = new ISO639("frs", "", "Eastern Frisian");
		
		/**
		 * 	The ISO 639 standard language name values for Western Frisian.
		 */
		public static const FRY:ISO639 = new ISO639("fry", "fy", "Western Frisian");
		
		/**
		 * 	The ISO 639 standard language name values for Fulah.
		 */
		public static const FUL:ISO639 = new ISO639("ful", "ff", "Fulah");
		
		/**
		 * 	The ISO 639 standard language name values for Friulian.
		 */
		public static const FUR:ISO639 = new ISO639("fur", "", "Friulian");
		
		/**
		 * 	The ISO 639 standard language name values for Ga.
		 */
		public static const GAA:ISO639 = new ISO639("gaa", "", "Ga");
		
		/**
		 * 	The ISO 639 standard language name values for Gayo.
		 */
		public static const GAY:ISO639 = new ISO639("gay", "", "Gayo");
		
		/**
		 * 	The ISO 639 standard language name values for Gbaya.
		 */
		public static const GBA:ISO639 = new ISO639("gba", "", "Gbaya");
		
		/**
		 * 	The ISO 639 standard language name values for Germanic languages.
		 */
		public static const GEM:ISO639 = new ISO639("gem", "", "Germanic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Georgian.
		 */
		public static const GEO:ISO639 = new ISO639("geo", "ka", "Georgian");
		
		/**
		 * 	The ISO 639 standard language name values for Geez.
		 */
		public static const GEZ:ISO639 = new ISO639("gez", "", "Geez");
		
		/**
		 * 	The ISO 639 standard language name values for Gilbertese.
		 */
		public static const GIL:ISO639 = new ISO639("gil", "", "Gilbertese");
		
		/**
		 * 	The ISO 639 standard language name values for Gaelic.
		 */
		public static const GLA:ISO639 = new ISO639("gla", "gd", "Gaelic");
		
		/**
		 * 	The ISO 639 standard language name values for Irish.
		 */
		public static const GLE:ISO639 = new ISO639("gle", "ga", "Irish");
		
		/**
		 * 	The ISO 639 standard language name values for Galician.
		 */
		public static const GLG:ISO639 = new ISO639("glg", "gl", "Galician");
		
		/**
		 * 	The ISO 639 standard language name values for Manx.
		 */
		public static const GLV:ISO639 = new ISO639("glv", "gv", "Manx");
		
		/**
		 * 	The ISO 639 standard language name values for German, Middle High (ca.1050-1500).
		 */
		public static const GMH:ISO639 = new ISO639("gmh", "", "German, Middle High (ca.1050-1500)");
		
		/**
		 * 	The ISO 639 standard language name values for German, Old High (ca.750-1050).
		 */
		public static const GOH:ISO639 = new ISO639("goh", "", "German, Old High (ca.750-1050)");
		
		/**
		 * 	The ISO 639 standard language name values for Gondi.
		 */
		public static const GON:ISO639 = new ISO639("gon", "", "Gondi");
		
		/**
		 * 	The ISO 639 standard language name values for Gorontalo.
		 */
		public static const GOR:ISO639 = new ISO639("gor", "", "Gorontalo");
		
		/**
		 * 	The ISO 639 standard language name values for Gothic.
		 */
		public static const GOT:ISO639 = new ISO639("got", "", "Gothic");
		
		/**
		 * 	The ISO 639 standard language name values for Grebo.
		 */
		public static const GRB:ISO639 = new ISO639("grb", "", "Grebo");
		
		/**
		 * 	The ISO 639 standard language name values for Greek, Ancient (to 1453).
		 */
		public static const GRC:ISO639 = new ISO639("grc", "", "Greek, Ancient (to 1453)");
		
		/**
		 * 	The ISO 639 standard language name values for Guarani.
		 */
		public static const GRN:ISO639 = new ISO639("grn", "gn", "Guarani");
		
		/**
		 * 	The ISO 639 standard language name values for Swiss German.
		 */
		public static const GSW:ISO639 = new ISO639("gsw", "", "Swiss German");
		
		/**
		 * 	The ISO 639 standard language name values for Gujarati.
		 */
		public static const GUJ:ISO639 = new ISO639("guj", "gu", "Gujarati");
		
		/**
		 * 	The ISO 639 standard language name values for Gwich'in.
		 */
		public static const GWI:ISO639 = new ISO639("gwi", "", "Gwich'in");
		
		/**
		 * 	The ISO 639 standard language name values for Haida.
		 */
		public static const HAI:ISO639 = new ISO639("hai", "", "Haida");
		
		/**
		 * 	The ISO 639 standard language name values for Haitian.
		 */
		public static const HAT:ISO639 = new ISO639("hat", "ht", "Haitian");
		
		/**
		 * 	The ISO 639 standard language name values for Hausa.
		 */
		public static const HAU:ISO639 = new ISO639("hau", "ha", "Hausa");
		
		/**
		 * 	The ISO 639 standard language name values for Hawaiian.
		 */
		public static const HAW:ISO639 = new ISO639("haw", "", "Hawaiian");
		
		/**
		 * 	The ISO 639 standard language name values for Hebrew.
		 */
		public static const HEB:ISO639 = new ISO639("heb", "he", "Hebrew");
		
		/**
		 * 	The ISO 639 standard language name values for Herero.
		 */
		public static const HER:ISO639 = new ISO639("her", "hz", "Herero");
		
		/**
		 * 	The ISO 639 standard language name values for Hiligaynon.
		 */
		public static const HIL:ISO639 = new ISO639("hil", "", "Hiligaynon");
		
		/**
		 * 	The ISO 639 standard language name values for Himachali languages.
		 */
		public static const HIM:ISO639 = new ISO639("him", "", "Himachali languages");
		
		/**
		 * 	The ISO 639 standard language name values for Hindi.
		 */
		public static const HIN:ISO639 = new ISO639("hin", "hi", "Hindi");
		
		/**
		 * 	The ISO 639 standard language name values for Hittite.
		 */
		public static const HIT:ISO639 = new ISO639("hit", "", "Hittite");
		
		/**
		 * 	The ISO 639 standard language name values for Hmong.
		 */
		public static const HMN:ISO639 = new ISO639("hmn", "", "Hmong");
		
		/**
		 * 	The ISO 639 standard language name values for Hiri Motu.
		 */
		public static const HMO:ISO639 = new ISO639("hmo", "ho", "Hiri Motu");
		
		/**
		 * 	The ISO 639 standard language name values for Croatian.
		 */
		public static const HRV:ISO639 = new ISO639("hrv", "hr", "Croatian");
		
		/**
		 * 	The ISO 639 standard language name values for Upper Sorbian.
		 */
		public static const HSB:ISO639 = new ISO639("hsb", "", "Upper Sorbian");
		
		/**
		 * 	The ISO 639 standard language name values for Hungarian.
		 */
		public static const HUN:ISO639 = new ISO639("hun", "hu", "Hungarian");
		
		/**
		 * 	The ISO 639 standard language name values for Hupa.
		 */
		public static const HUP:ISO639 = new ISO639("hup", "", "Hupa");
		
		/**
		 * 	The ISO 639 standard language name values for Iban.
		 */
		public static const IBA:ISO639 = new ISO639("iba", "", "Iban");
		
		/**
		 * 	The ISO 639 standard language name values for Igbo.
		 */
		public static const IBO:ISO639 = new ISO639("ibo", "ig", "Igbo");
		
		/**
		 * 	The ISO 639 standard language name values for Icelandic.
		 */
		public static const ICE:ISO639 = new ISO639("ice", "is", "Icelandic");
		
		/**
		 * 	The ISO 639 standard language name values for Ido.
		 */
		public static const IDO:ISO639 = new ISO639("ido", "io", "Ido");
		
		/**
		 * 	The ISO 639 standard language name values for Sichuan Yi.
		 */
		public static const III:ISO639 = new ISO639("iii", "ii", "Sichuan Yi");
		
		/**
		 * 	The ISO 639 standard language name values for Ijo languages.
		 */
		public static const IJO:ISO639 = new ISO639("ijo", "", "Ijo languages");
		
		/**
		 * 	The ISO 639 standard language name values for Inuktitut.
		 */
		public static const IKU:ISO639 = new ISO639("iku", "iu", "Inuktitut");
		
		/**
		 * 	The ISO 639 standard language name values for Interlingue.
		 */
		public static const ILE:ISO639 = new ISO639("ile", "ie", "Interlingue");
		
		/**
		 * 	The ISO 639 standard language name values for Iloko.
		 */
		public static const ILO:ISO639 = new ISO639("ilo", "", "Iloko");
		
		/**
		 * 	The ISO 639 standard language name values for Interlingua (International Auxiliary Language Association).
		 */
		public static const INA:ISO639 = new ISO639("ina", "ia", "Interlingua (International Auxiliary Language Association)");
		
		/**
		 * 	The ISO 639 standard language name values for Indic languages.
		 */
		public static const INC:ISO639 = new ISO639("inc", "", "Indic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Indonesian.
		 */
		public static const IND:ISO639 = new ISO639("ind", "id", "Indonesian");
		
		/**
		 * 	The ISO 639 standard language name values for Indo-European languages.
		 */
		public static const INE:ISO639 = new ISO639("ine", "", "Indo-European languages");
		
		/**
		 * 	The ISO 639 standard language name values for Ingush.
		 */
		public static const INH:ISO639 = new ISO639("inh", "", "Ingush");
		
		/**
		 * 	The ISO 639 standard language name values for Inupiaq.
		 */
		public static const IPK:ISO639 = new ISO639("ipk", "ik", "Inupiaq");
		
		/**
		 * 	The ISO 639 standard language name values for Iranian languages.
		 */
		public static const IRA:ISO639 = new ISO639("ira", "", "Iranian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Iroquoian languages.
		 */
		public static const IRO:ISO639 = new ISO639("iro", "", "Iroquoian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Italian.
		 */
		public static const ITA:ISO639 = new ISO639("ita", "it", "Italian");
		
		/**
		 * 	The ISO 639 standard language name values for Javanese.
		 */
		public static const JAV:ISO639 = new ISO639("jav", "jv", "Javanese");
		
		/**
		 * 	The ISO 639 standard language name values for Lojban.
		 */
		public static const JBO:ISO639 = new ISO639("jbo", "", "Lojban");
		
		/**
		 * 	The ISO 639 standard language name values for Japanese.
		 */
		public static const JPN:ISO639 = new ISO639("jpn", "ja", "Japanese");
		
		/**
		 * 	The ISO 639 standard language name values for Judeo-Persian.
		 */
		public static const JPR:ISO639 = new ISO639("jpr", "", "Judeo-Persian");
		
		/**
		 * 	The ISO 639 standard language name values for Judeo-Arabic.
		 */
		public static const JRB:ISO639 = new ISO639("jrb", "", "Judeo-Arabic");
		
		/**
		 * 	The ISO 639 standard language name values for Kara-Kalpak.
		 */
		public static const KAA:ISO639 = new ISO639("kaa", "", "Kara-Kalpak");
		
		/**
		 * 	The ISO 639 standard language name values for Kabyle.
		 */
		public static const KAB:ISO639 = new ISO639("kab", "", "Kabyle");
		
		/**
		 * 	The ISO 639 standard language name values for Kachin.
		 */
		public static const KAC:ISO639 = new ISO639("kac", "", "Kachin");
		
		/**
		 * 	The ISO 639 standard language name values for Kalaallisut.
		 */
		public static const KAL:ISO639 = new ISO639("kal", "kl", "Kalaallisut");
		
		/**
		 * 	The ISO 639 standard language name values for Kamba.
		 */
		public static const KAM:ISO639 = new ISO639("kam", "", "Kamba");
		
		/**
		 * 	The ISO 639 standard language name values for Kannada.
		 */
		public static const KAN:ISO639 = new ISO639("kan", "kn", "Kannada");
		
		/**
		 * 	The ISO 639 standard language name values for Karen languages.
		 */
		public static const KAR:ISO639 = new ISO639("kar", "", "Karen languages");
		
		/**
		 * 	The ISO 639 standard language name values for Kashmiri.
		 */
		public static const KAS:ISO639 = new ISO639("kas", "ks", "Kashmiri");
		
		/**
		 * 	The ISO 639 standard language name values for Kanuri.
		 */
		public static const KAU:ISO639 = new ISO639("kau", "kr", "Kanuri");
		
		/**
		 * 	The ISO 639 standard language name values for Kawi.
		 */
		public static const KAW:ISO639 = new ISO639("kaw", "", "Kawi");
		
		/**
		 * 	The ISO 639 standard language name values for Kazakh.
		 */
		public static const KAZ:ISO639 = new ISO639("kaz", "kk", "Kazakh");
		
		/**
		 * 	The ISO 639 standard language name values for Kabardian.
		 */
		public static const KBD:ISO639 = new ISO639("kbd", "", "Kabardian");
		
		/**
		 * 	The ISO 639 standard language name values for Khasi.
		 */
		public static const KHA:ISO639 = new ISO639("kha", "", "Khasi");
		
		/**
		 * 	The ISO 639 standard language name values for Khoisan languages.
		 */
		public static const KHI:ISO639 = new ISO639("khi", "", "Khoisan languages");
		
		/**
		 * 	The ISO 639 standard language name values for Central Khmer.
		 */
		public static const KHM:ISO639 = new ISO639("khm", "km", "Central Khmer");
		
		/**
		 * 	The ISO 639 standard language name values for Khotanese.
		 */
		public static const KHO:ISO639 = new ISO639("kho", "", "Khotanese");
		
		/**
		 * 	The ISO 639 standard language name values for Kikuyu.
		 */
		public static const KIK:ISO639 = new ISO639("kik", "ki", "Kikuyu");
		
		/**
		 * 	The ISO 639 standard language name values for Kinyarwanda.
		 */
		public static const KIN:ISO639 = new ISO639("kin", "rw", "Kinyarwanda");
		
		/**
		 * 	The ISO 639 standard language name values for Kirghiz.
		 */
		public static const KIR:ISO639 = new ISO639("kir", "ky", "Kirghiz");
		
		/**
		 * 	The ISO 639 standard language name values for Kimbundu.
		 */
		public static const KMB:ISO639 = new ISO639("kmb", "", "Kimbundu");
		
		/**
		 * 	The ISO 639 standard language name values for Konkani.
		 */
		public static const KOK:ISO639 = new ISO639("kok", "", "Konkani");
		
		/**
		 * 	The ISO 639 standard language name values for Komi.
		 */
		public static const KOM:ISO639 = new ISO639("kom", "kv", "Komi");
		
		/**
		 * 	The ISO 639 standard language name values for Kongo.
		 */
		public static const KON:ISO639 = new ISO639("kon", "kg", "Kongo");
		
		/**
		 * 	The ISO 639 standard language name values for Korean.
		 */
		public static const KOR:ISO639 = new ISO639("kor", "ko", "Korean");
		
		/**
		 * 	The ISO 639 standard language name values for Kosraean.
		 */
		public static const KOS:ISO639 = new ISO639("kos", "", "Kosraean");
		
		/**
		 * 	The ISO 639 standard language name values for Kpelle.
		 */
		public static const KPE:ISO639 = new ISO639("kpe", "", "Kpelle");
		
		/**
		 * 	The ISO 639 standard language name values for Karachay-Balkar.
		 */
		public static const KRC:ISO639 = new ISO639("krc", "", "Karachay-Balkar");
		
		/**
		 * 	The ISO 639 standard language name values for Karelian.
		 */
		public static const KRL:ISO639 = new ISO639("krl", "", "Karelian");
		
		/**
		 * 	The ISO 639 standard language name values for Kru languages.
		 */
		public static const KRO:ISO639 = new ISO639("kro", "", "Kru languages");
		
		/**
		 * 	The ISO 639 standard language name values for Kurukh.
		 */
		public static const KRU:ISO639 = new ISO639("kru", "", "Kurukh");
		
		/**
		 * 	The ISO 639 standard language name values for Kuanyama.
		 */
		public static const KUA:ISO639 = new ISO639("kua", "kj", "Kuanyama");
		
		/**
		 * 	The ISO 639 standard language name values for Kumyk.
		 */
		public static const KUM:ISO639 = new ISO639("kum", "", "Kumyk");
		
		/**
		 * 	The ISO 639 standard language name values for Kurdish.
		 */
		public static const KUR:ISO639 = new ISO639("kur", "ku", "Kurdish");
		
		/**
		 * 	The ISO 639 standard language name values for Kutenai.
		 */
		public static const KUT:ISO639 = new ISO639("kut", "", "Kutenai");
		
		/**
		 * 	The ISO 639 standard language name values for Ladino.
		 */
		public static const LAD:ISO639 = new ISO639("lad", "", "Ladino");
		
		/**
		 * 	The ISO 639 standard language name values for Lahnda.
		 */
		public static const LAH:ISO639 = new ISO639("lah", "", "Lahnda");
		
		/**
		 * 	The ISO 639 standard language name values for Lamba.
		 */
		public static const LAM:ISO639 = new ISO639("lam", "", "Lamba");
		
		/**
		 * 	The ISO 639 standard language name values for Lao.
		 */
		public static const LAO:ISO639 = new ISO639("lao", "lo", "Lao");
		
		/**
		 * 	The ISO 639 standard language name values for Latin.
		 */
		public static const LAT:ISO639 = new ISO639("lat", "la", "Latin");
		
		/**
		 * 	The ISO 639 standard language name values for Latvian.
		 */
		public static const LAV:ISO639 = new ISO639("lav", "lv", "Latvian");
		
		/**
		 * 	The ISO 639 standard language name values for Lezghian.
		 */
		public static const LEZ:ISO639 = new ISO639("lez", "", "Lezghian");
		
		/**
		 * 	The ISO 639 standard language name values for Limburgan.
		 */
		public static const LIM:ISO639 = new ISO639("lim", "li", "Limburgan");
		
		/**
		 * 	The ISO 639 standard language name values for Lingala.
		 */
		public static const LIN:ISO639 = new ISO639("lin", "ln", "Lingala");
		
		/**
		 * 	The ISO 639 standard language name values for Lithuanian.
		 */
		public static const LIT:ISO639 = new ISO639("lit", "lt", "Lithuanian");
		
		/**
		 * 	The ISO 639 standard language name values for Mongo.
		 */
		public static const LOL:ISO639 = new ISO639("lol", "", "Mongo");
		
		/**
		 * 	The ISO 639 standard language name values for Lozi.
		 */
		public static const LOZ:ISO639 = new ISO639("loz", "", "Lozi");
		
		/**
		 * 	The ISO 639 standard language name values for Luxembourgish.
		 */
		public static const LTZ:ISO639 = new ISO639("ltz", "lb", "Luxembourgish");
		
		/**
		 * 	The ISO 639 standard language name values for Luba-Lulua.
		 */
		public static const LUA:ISO639 = new ISO639("lua", "", "Luba-Lulua");
		
		/**
		 * 	The ISO 639 standard language name values for Luba-Katanga.
		 */
		public static const LUB:ISO639 = new ISO639("lub", "lu", "Luba-Katanga");
		
		/**
		 * 	The ISO 639 standard language name values for Ganda.
		 */
		public static const LUG:ISO639 = new ISO639("lug", "lg", "Ganda");
		
		/**
		 * 	The ISO 639 standard language name values for Luiseno.
		 */
		public static const LUI:ISO639 = new ISO639("lui", "", "Luiseno");
		
		/**
		 * 	The ISO 639 standard language name values for Lunda.
		 */
		public static const LUN:ISO639 = new ISO639("lun", "", "Lunda");
		
		/**
		 * 	The ISO 639 standard language name values for Luo (Kenya and Tanzania).
		 */
		public static const LUO:ISO639 = new ISO639("luo", "", "Luo (Kenya and Tanzania)");
		
		/**
		 * 	The ISO 639 standard language name values for Lushai.
		 */
		public static const LUS:ISO639 = new ISO639("lus", "", "Lushai");
		
		/**
		 * 	The ISO 639 standard language name values for Macedonian.
		 */
		public static const MAC:ISO639 = new ISO639("mac", "mk", "Macedonian");
		
		/**
		 * 	The ISO 639 standard language name values for Madurese.
		 */
		public static const MAD:ISO639 = new ISO639("mad", "", "Madurese");
		
		/**
		 * 	The ISO 639 standard language name values for Magahi.
		 */
		public static const MAG:ISO639 = new ISO639("mag", "", "Magahi");
		
		/**
		 * 	The ISO 639 standard language name values for Marshallese.
		 */
		public static const MAH:ISO639 = new ISO639("mah", "mh", "Marshallese");
		
		/**
		 * 	The ISO 639 standard language name values for Maithili.
		 */
		public static const MAI:ISO639 = new ISO639("mai", "", "Maithili");
		
		/**
		 * 	The ISO 639 standard language name values for Makasar.
		 */
		public static const MAK:ISO639 = new ISO639("mak", "", "Makasar");
		
		/**
		 * 	The ISO 639 standard language name values for Malayalam.
		 */
		public static const MAL:ISO639 = new ISO639("mal", "ml", "Malayalam");
		
		/**
		 * 	The ISO 639 standard language name values for Mandingo.
		 */
		public static const MAN:ISO639 = new ISO639("man", "", "Mandingo");
		
		/**
		 * 	The ISO 639 standard language name values for Maori.
		 */
		public static const MAO:ISO639 = new ISO639("mao", "mi", "Maori");
		
		/**
		 * 	The ISO 639 standard language name values for Austronesian languages.
		 */
		public static const MAP:ISO639 = new ISO639("map", "", "Austronesian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Marathi.
		 */
		public static const MAR:ISO639 = new ISO639("mar", "mr", "Marathi");
		
		/**
		 * 	The ISO 639 standard language name values for Masai.
		 */
		public static const MAS:ISO639 = new ISO639("mas", "", "Masai");
		
		/**
		 * 	The ISO 639 standard language name values for Malay.
		 */
		public static const MAY:ISO639 = new ISO639("may", "ms", "Malay");
		
		/**
		 * 	The ISO 639 standard language name values for Moksha.
		 */
		public static const MDF:ISO639 = new ISO639("mdf", "", "Moksha");
		
		/**
		 * 	The ISO 639 standard language name values for Mandar.
		 */
		public static const MDR:ISO639 = new ISO639("mdr", "", "Mandar");
		
		/**
		 * 	The ISO 639 standard language name values for Mende.
		 */
		public static const MEN:ISO639 = new ISO639("men", "", "Mende");
		
		/**
		 * 	The ISO 639 standard language name values for Irish, Middle (900-1200).
		 */
		public static const MGA:ISO639 = new ISO639("mga", "", "Irish, Middle (900-1200)");
		
		/**
		 * 	The ISO 639 standard language name values for Mi'kmaq.
		 */
		public static const MIC:ISO639 = new ISO639("mic", "", "Mi'kmaq");
		
		/**
		 * 	The ISO 639 standard language name values for Minangkabau.
		 */
		public static const MIN:ISO639 = new ISO639("min", "", "Minangkabau");
		
		/**
		 * 	The ISO 639 standard language name values for Uncoded languages.
		 */
		public static const MIS:ISO639 = new ISO639("mis", "", "Uncoded languages");
		
		/**
		 * 	The ISO 639 standard language name values for Mon-Khmer languages.
		 */
		public static const MKH:ISO639 = new ISO639("mkh", "", "Mon-Khmer languages");
		
		/**
		 * 	The ISO 639 standard language name values for Malagasy.
		 */
		public static const MLG:ISO639 = new ISO639("mlg", "mg", "Malagasy");
		
		/**
		 * 	The ISO 639 standard language name values for Maltese.
		 */
		public static const MLT:ISO639 = new ISO639("mlt", "mt", "Maltese");
		
		/**
		 * 	The ISO 639 standard language name values for Manchu.
		 */
		public static const MNC:ISO639 = new ISO639("mnc", "", "Manchu");
		
		/**
		 * 	The ISO 639 standard language name values for Manipuri.
		 */
		public static const MNI:ISO639 = new ISO639("mni", "", "Manipuri");
		
		/**
		 * 	The ISO 639 standard language name values for Manobo languages.
		 */
		public static const MNO:ISO639 = new ISO639("mno", "", "Manobo languages");
		
		/**
		 * 	The ISO 639 standard language name values for Mohawk.
		 */
		public static const MOH:ISO639 = new ISO639("moh", "", "Mohawk");
		
		/**
		 * 	The ISO 639 standard language name values for Mongolian.
		 */
		public static const MON:ISO639 = new ISO639("mon", "mn", "Mongolian");
		
		/**
		 * 	The ISO 639 standard language name values for Mossi.
		 */
		public static const MOS:ISO639 = new ISO639("mos", "", "Mossi");
		
		/**
		 * 	The ISO 639 standard language name values for Multiple languages.
		 */
		public static const MUL:ISO639 = new ISO639("mul", "", "Multiple languages");
		
		/**
		 * 	The ISO 639 standard language name values for Munda languages.
		 */
		public static const MUN:ISO639 = new ISO639("mun", "", "Munda languages");
		
		/**
		 * 	The ISO 639 standard language name values for Creek.
		 */
		public static const MUS:ISO639 = new ISO639("mus", "", "Creek");
		
		/**
		 * 	The ISO 639 standard language name values for Mirandese.
		 */
		public static const MWL:ISO639 = new ISO639("mwl", "", "Mirandese");
		
		/**
		 * 	The ISO 639 standard language name values for Marwari.
		 */
		public static const MWR:ISO639 = new ISO639("mwr", "", "Marwari");
		
		/**
		 * 	The ISO 639 standard language name values for Mayan languages.
		 */
		public static const MYN:ISO639 = new ISO639("myn", "", "Mayan languages");
		
		/**
		 * 	The ISO 639 standard language name values for Erzya.
		 */
		public static const MYV:ISO639 = new ISO639("myv", "", "Erzya");
		
		/**
		 * 	The ISO 639 standard language name values for Nahuatl languages.
		 */
		public static const NAH:ISO639 = new ISO639("nah", "", "Nahuatl languages");
		
		/**
		 * 	The ISO 639 standard language name values for North American Indian languages.
		 */
		public static const NAI:ISO639 = new ISO639("nai", "", "North American Indian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Neapolitan.
		 */
		public static const NAP:ISO639 = new ISO639("nap", "", "Neapolitan");
		
		/**
		 * 	The ISO 639 standard language name values for Nauru.
		 */
		public static const NAU:ISO639 = new ISO639("nau", "na", "Nauru");
		
		/**
		 * 	The ISO 639 standard language name values for Navajo.
		 */
		public static const NAV:ISO639 = new ISO639("nav", "nv", "Navajo");
		
		/**
		 * 	The ISO 639 standard language name values for Ndebele, South.
		 */
		public static const NBL:ISO639 = new ISO639("nbl", "nr", "Ndebele, South");
		
		/**
		 * 	The ISO 639 standard language name values for Ndebele, North.
		 */
		public static const NDE:ISO639 = new ISO639("nde", "nd", "Ndebele, North");
		
		/**
		 * 	The ISO 639 standard language name values for Ndonga.
		 */
		public static const NDO:ISO639 = new ISO639("ndo", "ng", "Ndonga");
		
		/**
		 * 	The ISO 639 standard language name values for Low German.
		 */
		public static const NDS:ISO639 = new ISO639("nds", "", "Low German");
		
		/**
		 * 	The ISO 639 standard language name values for Nepali.
		 */
		public static const NEP:ISO639 = new ISO639("nep", "ne", "Nepali");
		
		/**
		 * 	The ISO 639 standard language name values for Nepal Bhasa.
		 */
		public static const NEW:ISO639 = new ISO639("new", "", "Nepal Bhasa");
		
		/**
		 * 	The ISO 639 standard language name values for Nias.
		 */
		public static const NIA:ISO639 = new ISO639("nia", "", "Nias");
		
		/**
		 * 	The ISO 639 standard language name values for Niger-Kordofanian languages.
		 */
		public static const NIC:ISO639 = new ISO639("nic", "", "Niger-Kordofanian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Niuean.
		 */
		public static const NIU:ISO639 = new ISO639("niu", "", "Niuean");
		
		/**
		 * 	The ISO 639 standard language name values for Norwegian Nynorsk.
		 */
		public static const NNO:ISO639 = new ISO639("nno", "nn", "Norwegian Nynorsk");
		
		/**
		 * 	The ISO 639 standard language name values for Bokma, Norwegian.
		 */
		public static const NOB:ISO639 = new ISO639("nob", "nb", "Bokma, Norwegian");
		
		/**
		 * 	The ISO 639 standard language name values for Nogai.
		 */
		public static const NOG:ISO639 = new ISO639("nog", "", "Nogai");
		
		/**
		 * 	The ISO 639 standard language name values for Norse, Old.
		 */
		public static const NON:ISO639 = new ISO639("non", "", "Norse, Old");
		
		/**
		 * 	The ISO 639 standard language name values for Norwegian.
		 */
		public static const NOR:ISO639 = new ISO639("nor", "no", "Norwegian");
		
		/**
		 * 	The ISO 639 standard language name values for N'Ko.
		 */
		public static const NQO:ISO639 = new ISO639("nqo", "", "N'Ko");
		
		/**
		 * 	The ISO 639 standard language name values for Pedi.
		 */
		public static const NSO:ISO639 = new ISO639("nso", "", "Pedi");
		
		/**
		 * 	The ISO 639 standard language name values for Nubian languages.
		 */
		public static const NUB:ISO639 = new ISO639("nub", "", "Nubian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Classical Newari.
		 */
		public static const NWC:ISO639 = new ISO639("nwc", "", "Classical Newari");
		
		/**
		 * 	The ISO 639 standard language name values for Chichewa.
		 */
		public static const NYA:ISO639 = new ISO639("nya", "ny", "Chichewa");
		
		/**
		 * 	The ISO 639 standard language name values for Nyamwezi.
		 */
		public static const NYM:ISO639 = new ISO639("nym", "", "Nyamwezi");
		
		/**
		 * 	The ISO 639 standard language name values for Nyankole.
		 */
		public static const NYN:ISO639 = new ISO639("nyn", "", "Nyankole");
		
		/**
		 * 	The ISO 639 standard language name values for Nyoro.
		 */
		public static const NYO:ISO639 = new ISO639("nyo", "", "Nyoro");
		
		/**
		 * 	The ISO 639 standard language name values for Nzima.
		 */
		public static const NZI:ISO639 = new ISO639("nzi", "", "Nzima");
		
		/**
		 * 	The ISO 639 standard language name values for Occitan (post 1500).
		 */
		public static const OCI:ISO639 = new ISO639("oci", "oc", "Occitan (post 1500)");
		
		/**
		 * 	The ISO 639 standard language name values for Ojibwa.
		 */
		public static const OJI:ISO639 = new ISO639("oji", "oj", "Ojibwa");
		
		/**
		 * 	The ISO 639 standard language name values for Oriya.
		 */
		public static const ORI:ISO639 = new ISO639("ori", "or", "Oriya");
		
		/**
		 * 	The ISO 639 standard language name values for Oromo.
		 */
		public static const ORM:ISO639 = new ISO639("orm", "om", "Oromo");
		
		/**
		 * 	The ISO 639 standard language name values for Osage.
		 */
		public static const OSA:ISO639 = new ISO639("osa", "", "Osage");
		
		/**
		 * 	The ISO 639 standard language name values for Ossetian.
		 */
		public static const OSS:ISO639 = new ISO639("oss", "os", "Ossetian");
		
		/**
		 * 	The ISO 639 standard language name values for Turkish, Ottoman (1500-1928).
		 */
		public static const OTA:ISO639 = new ISO639("ota", "", "Turkish, Ottoman (1500-1928)");
		
		/**
		 * 	The ISO 639 standard language name values for Otomian languages.
		 */
		public static const OTO:ISO639 = new ISO639("oto", "", "Otomian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Papuan languages.
		 */
		public static const PAA:ISO639 = new ISO639("paa", "", "Papuan languages");
		
		/**
		 * 	The ISO 639 standard language name values for Pangasinan.
		 */
		public static const PAG:ISO639 = new ISO639("pag", "", "Pangasinan");
		
		/**
		 * 	The ISO 639 standard language name values for Pahlavi.
		 */
		public static const PAL:ISO639 = new ISO639("pal", "", "Pahlavi");
		
		/**
		 * 	The ISO 639 standard language name values for Pampanga.
		 */
		public static const PAM:ISO639 = new ISO639("pam", "", "Pampanga");
		
		/**
		 * 	The ISO 639 standard language name values for Panjabi.
		 */
		public static const PAN:ISO639 = new ISO639("pan", "pa", "Panjabi");
		
		/**
		 * 	The ISO 639 standard language name values for Papiamento.
		 */
		public static const PAP:ISO639 = new ISO639("pap", "", "Papiamento");
		
		/**
		 * 	The ISO 639 standard language name values for Palauan.
		 */
		public static const PAU:ISO639 = new ISO639("pau", "", "Palauan");
		
		/**
		 * 	The ISO 639 standard language name values for Persian, Old (ca.600-400 B.C.).
		 */
		public static const PEO:ISO639 = new ISO639("peo", "", "Persian, Old (ca.600-400 B.C.)");
		
		/**
		 * 	The ISO 639 standard language name values for Persian.
		 */
		public static const PER:ISO639 = new ISO639("per", "fa", "Persian");
		
		/**
		 * 	The ISO 639 standard language name values for Philippine languages.
		 */
		public static const PHI:ISO639 = new ISO639("phi", "", "Philippine languages");
		
		/**
		 * 	The ISO 639 standard language name values for Phoenician.
		 */
		public static const PHN:ISO639 = new ISO639("phn", "", "Phoenician");
		
		/**
		 * 	The ISO 639 standard language name values for Pali.
		 */
		public static const PLI:ISO639 = new ISO639("pli", "pi", "Pali");
		
		/**
		 * 	The ISO 639 standard language name values for Polish.
		 */
		public static const POL:ISO639 = new ISO639("pol", "pl", "Polish");
		
		/**
		 * 	The ISO 639 standard language name values for Pohnpeian.
		 */
		public static const PON:ISO639 = new ISO639("pon", "", "Pohnpeian");
		
		/**
		 * 	The ISO 639 standard language name values for Portuguese.
		 */
		public static const POR:ISO639 = new ISO639("por", "pt", "Portuguese");
		
		/**
		 * 	The ISO 639 standard language name values for Prakrit languages.
		 */
		public static const PRA:ISO639 = new ISO639("pra", "", "Prakrit languages");
		
		/**
		 * 	The ISO 639 standard language name values for Provençal, Old (to 1500).
		 */
		public static const PRO:ISO639 = new ISO639("pro", "", "Provençal, Old (to 1500)");
		
		/**
		 * 	The ISO 639 standard language name values for Pushto.
		 */
		public static const PUS:ISO639 = new ISO639("pus", "ps", "Pushto");
		
		/**
		 * 	The ISO 639 standard language name values for Reserved for local use.
		 */
		public static const QAA_QTZ:ISO639 = new ISO639("qaa-qtz", "", "Reserved for local use");
		
		/**
		 * 	The ISO 639 standard language name values for Quechua.
		 */
		public static const QUE:ISO639 = new ISO639("que", "qu", "Quechua");
		
		/**
		 * 	The ISO 639 standard language name values for Rajasthani.
		 */
		public static const RAJ:ISO639 = new ISO639("raj", "", "Rajasthani");
		
		/**
		 * 	The ISO 639 standard language name values for Rapanui.
		 */
		public static const RAP:ISO639 = new ISO639("rap", "", "Rapanui");
		
		/**
		 * 	The ISO 639 standard language name values for Rarotongan.
		 */
		public static const RAR:ISO639 = new ISO639("rar", "", "Rarotongan");
		
		/**
		 * 	The ISO 639 standard language name values for Romance languages.
		 */
		public static const ROA:ISO639 = new ISO639("roa", "", "Romance languages");
		
		/**
		 * 	The ISO 639 standard language name values for Romansh.
		 */
		public static const ROH:ISO639 = new ISO639("roh", "rm", "Romansh");
		
		/**
		 * 	The ISO 639 standard language name values for Romany.
		 */
		public static const ROM:ISO639 = new ISO639("rom", "", "Romany");
		
		/**
		 * 	The ISO 639 standard language name values for Romanian.
		 */
		public static const RUM:ISO639 = new ISO639("rum", "ro", "Romanian");
		
		/**
		 * 	The ISO 639 standard language name values for Rundi.
		 */
		public static const RUN:ISO639 = new ISO639("run", "rn", "Rundi");
		
		/**
		 * 	The ISO 639 standard language name values for Aromanian.
		 */
		public static const RUP:ISO639 = new ISO639("rup", "", "Aromanian");
		
		/**
		 * 	The ISO 639 standard language name values for Russian.
		 */
		public static const RUS:ISO639 = new ISO639("rus", "ru", "Russian");
		
		/**
		 * 	The ISO 639 standard language name values for Sandawe.
		 */
		public static const SAD:ISO639 = new ISO639("sad", "", "Sandawe");
		
		/**
		 * 	The ISO 639 standard language name values for Sango.
		 */
		public static const SAG:ISO639 = new ISO639("sag", "sg", "Sango");
		
		/**
		 * 	The ISO 639 standard language name values for Yakut.
		 */
		public static const SAH:ISO639 = new ISO639("sah", "", "Yakut");
		
		/**
		 * 	The ISO 639 standard language name values for South American Indian languages.
		 */
		public static const SAI:ISO639 = new ISO639("sai", "", "South American Indian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Salishan languages.
		 */
		public static const SAL:ISO639 = new ISO639("sal", "", "Salishan languages");
		
		/**
		 * 	The ISO 639 standard language name values for Samaritan Aramaic.
		 */
		public static const SAM:ISO639 = new ISO639("sam", "", "Samaritan Aramaic");
		
		/**
		 * 	The ISO 639 standard language name values for Sanskrit.
		 */
		public static const SAN:ISO639 = new ISO639("san", "sa", "Sanskrit");
		
		/**
		 * 	The ISO 639 standard language name values for Sasak.
		 */
		public static const SAS:ISO639 = new ISO639("sas", "", "Sasak");
		
		/**
		 * 	The ISO 639 standard language name values for Santali.
		 */
		public static const SAT:ISO639 = new ISO639("sat", "", "Santali");
		
		/**
		 * 	The ISO 639 standard language name values for Sicilian.
		 */
		public static const SCN:ISO639 = new ISO639("scn", "", "Sicilian");
		
		/**
		 * 	The ISO 639 standard language name values for Scots.
		 */
		public static const SCO:ISO639 = new ISO639("sco", "", "Scots");
		
		/**
		 * 	The ISO 639 standard language name values for Selkup.
		 */
		public static const SEL:ISO639 = new ISO639("sel", "", "Selkup");
		
		/**
		 * 	The ISO 639 standard language name values for Semitic languages.
		 */
		public static const SEM:ISO639 = new ISO639("sem", "", "Semitic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Irish, Old (to 900).
		 */
		public static const SGA:ISO639 = new ISO639("sga", "", "Irish, Old (to 900)");
		
		/**
		 * 	The ISO 639 standard language name values for Sign Languages.
		 */
		public static const SGN:ISO639 = new ISO639("sgn", "", "Sign Languages");
		
		/**
		 * 	The ISO 639 standard language name values for Shan.
		 */
		public static const SHN:ISO639 = new ISO639("shn", "", "Shan");
		
		/**
		 * 	The ISO 639 standard language name values for Sidamo.
		 */
		public static const SID:ISO639 = new ISO639("sid", "", "Sidamo");
		
		/**
		 * 	The ISO 639 standard language name values for Sinhala.
		 */
		public static const SIN:ISO639 = new ISO639("sin", "si", "Sinhala");
		
		/**
		 * 	The ISO 639 standard language name values for Siouan languages.
		 */
		public static const SIO:ISO639 = new ISO639("sio", "", "Siouan languages");
		
		/**
		 * 	The ISO 639 standard language name values for Sino-Tibetan languages.
		 */
		public static const SIT:ISO639 = new ISO639("sit", "", "Sino-Tibetan languages");
		
		/**
		 * 	The ISO 639 standard language name values for Slavic languages.
		 */
		public static const SLA:ISO639 = new ISO639("sla", "", "Slavic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Slovak.
		 */
		public static const SLO:ISO639 = new ISO639("slo", "sk", "Slovak");
		
		/**
		 * 	The ISO 639 standard language name values for Slovenian.
		 */
		public static const SLV:ISO639 = new ISO639("slv", "sl", "Slovenian");
		
		/**
		 * 	The ISO 639 standard language name values for Southern Sami.
		 */
		public static const SMA:ISO639 = new ISO639("sma", "", "Southern Sami");
		
		/**
		 * 	The ISO 639 standard language name values for Northern Sami.
		 */
		public static const SME:ISO639 = new ISO639("sme", "se", "Northern Sami");
		
		/**
		 * 	The ISO 639 standard language name values for Sami languages.
		 */
		public static const SMI:ISO639 = new ISO639("smi", "", "Sami languages");
		
		/**
		 * 	The ISO 639 standard language name values for Lule Sami.
		 */
		public static const SMJ:ISO639 = new ISO639("smj", "", "Lule Sami");
		
		/**
		 * 	The ISO 639 standard language name values for Inari Sami.
		 */
		public static const SMN:ISO639 = new ISO639("smn", "", "Inari Sami");
		
		/**
		 * 	The ISO 639 standard language name values for Samoan.
		 */
		public static const SMO:ISO639 = new ISO639("smo", "sm", "Samoan");
		
		/**
		 * 	The ISO 639 standard language name values for Skolt Sami.
		 */
		public static const SMS:ISO639 = new ISO639("sms", "", "Skolt Sami");
		
		/**
		 * 	The ISO 639 standard language name values for Shona.
		 */
		public static const SNA:ISO639 = new ISO639("sna", "sn", "Shona");
		
		/**
		 * 	The ISO 639 standard language name values for Sindhi.
		 */
		public static const SND:ISO639 = new ISO639("snd", "sd", "Sindhi");
		
		/**
		 * 	The ISO 639 standard language name values for Soninke.
		 */
		public static const SNK:ISO639 = new ISO639("snk", "", "Soninke");
		
		/**
		 * 	The ISO 639 standard language name values for Sogdian.
		 */
		public static const SOG:ISO639 = new ISO639("sog", "", "Sogdian");
		
		/**
		 * 	The ISO 639 standard language name values for Somali.
		 */
		public static const SOM:ISO639 = new ISO639("som", "so", "Somali");
		
		/**
		 * 	The ISO 639 standard language name values for Songhai languages.
		 */
		public static const SON:ISO639 = new ISO639("son", "", "Songhai languages");
		
		/**
		 * 	The ISO 639 standard language name values for Sotho, Southern.
		 */
		public static const SOT:ISO639 = new ISO639("sot", "st", "Sotho, Southern");
		
		/**
		 * 	The ISO 639 standard language name values for Spanish.
		 */
		public static const SPA:ISO639 = new ISO639("spa", "es", "Spanish");
		
		/**
		 * 	The ISO 639 standard language name values for Sardinian.
		 */
		public static const SRD:ISO639 = new ISO639("srd", "sc", "Sardinian");
		
		/**
		 * 	The ISO 639 standard language name values for Sranan Tongo.
		 */
		public static const SRN:ISO639 = new ISO639("srn", "", "Sranan Tongo");
		
		/**
		 * 	The ISO 639 standard language name values for Serbian.
		 */
		public static const SRP:ISO639 = new ISO639("srp", "sr", "Serbian");
		
		/**
		 * 	The ISO 639 standard language name values for Serer.
		 */
		public static const SRR:ISO639 = new ISO639("srr", "", "Serer");
		
		/**
		 * 	The ISO 639 standard language name values for Nilo-Saharan languages.
		 */
		public static const SSA:ISO639 = new ISO639("ssa", "", "Nilo-Saharan languages");
		
		/**
		 * 	The ISO 639 standard language name values for Swati.
		 */
		public static const SSW:ISO639 = new ISO639("ssw", "ss", "Swati");
		
		/**
		 * 	The ISO 639 standard language name values for Sukuma.
		 */
		public static const SUK:ISO639 = new ISO639("suk", "", "Sukuma");
		
		/**
		 * 	The ISO 639 standard language name values for Sundanese.
		 */
		public static const SUN:ISO639 = new ISO639("sun", "su", "Sundanese");
		
		/**
		 * 	The ISO 639 standard language name values for Susu.
		 */
		public static const SUS:ISO639 = new ISO639("sus", "", "Susu");
		
		/**
		 * 	The ISO 639 standard language name values for Sumerian.
		 */
		public static const SUX:ISO639 = new ISO639("sux", "", "Sumerian");
		
		/**
		 * 	The ISO 639 standard language name values for Swahili.
		 */
		public static const SWA:ISO639 = new ISO639("swa", "sw", "Swahili");
		
		/**
		 * 	The ISO 639 standard language name values for Swedish.
		 */
		public static const SWE:ISO639 = new ISO639("swe", "sv", "Swedish");
		
		/**
		 * 	The ISO 639 standard language name values for Classical Syriac.
		 */
		public static const SYC:ISO639 = new ISO639("syc", "", "Classical Syriac");
		
		/**
		 * 	The ISO 639 standard language name values for Syriac.
		 */
		public static const SYR:ISO639 = new ISO639("syr", "", "Syriac");
		
		/**
		 * 	The ISO 639 standard language name values for Tahitian.
		 */
		public static const TAH:ISO639 = new ISO639("tah", "ty", "Tahitian");
		
		/**
		 * 	The ISO 639 standard language name values for Tai languages.
		 */
		public static const TAI:ISO639 = new ISO639("tai", "", "Tai languages");
		
		/**
		 * 	The ISO 639 standard language name values for Tamil.
		 */
		public static const TAM:ISO639 = new ISO639("tam", "ta", "Tamil");
		
		/**
		 * 	The ISO 639 standard language name values for Tatar.
		 */
		public static const TAT:ISO639 = new ISO639("tat", "tt", "Tatar");
		
		/**
		 * 	The ISO 639 standard language name values for Telugu.
		 */
		public static const TEL:ISO639 = new ISO639("tel", "te", "Telugu");
		
		/**
		 * 	The ISO 639 standard language name values for Timne.
		 */
		public static const TEM:ISO639 = new ISO639("tem", "", "Timne");
		
		/**
		 * 	The ISO 639 standard language name values for Tereno.
		 */
		public static const TER:ISO639 = new ISO639("ter", "", "Tereno");
		
		/**
		 * 	The ISO 639 standard language name values for Tetum.
		 */
		public static const TET:ISO639 = new ISO639("tet", "", "Tetum");
		
		/**
		 * 	The ISO 639 standard language name values for Tajik.
		 */
		public static const TGK:ISO639 = new ISO639("tgk", "tg", "Tajik");
		
		/**
		 * 	The ISO 639 standard language name values for Tagalog.
		 */
		public static const TGL:ISO639 = new ISO639("tgl", "tl", "Tagalog");
		
		/**
		 * 	The ISO 639 standard language name values for Thai.
		 */
		public static const THA:ISO639 = new ISO639("tha", "th", "Thai");
		
		/**
		 * 	The ISO 639 standard language name values for Tibetan.
		 */
		public static const TIB:ISO639 = new ISO639("tib", "bo", "Tibetan");
		
		/**
		 * 	The ISO 639 standard language name values for Tigre.
		 */
		public static const TIG:ISO639 = new ISO639("tig", "", "Tigre");
		
		/**
		 * 	The ISO 639 standard language name values for Tigrinya.
		 */
		public static const TIR:ISO639 = new ISO639("tir", "ti", "Tigrinya");
		
		/**
		 * 	The ISO 639 standard language name values for Tiv.
		 */
		public static const TIV:ISO639 = new ISO639("tiv", "", "Tiv");
		
		/**
		 * 	The ISO 639 standard language name values for Tokelau.
		 */
		public static const TKL:ISO639 = new ISO639("tkl", "", "Tokelau");
		
		/**
		 * 	The ISO 639 standard language name values for Klingon.
		 */
		public static const TLH:ISO639 = new ISO639("tlh", "", "Klingon");
		
		/**
		 * 	The ISO 639 standard language name values for Tlingit.
		 */
		public static const TLI:ISO639 = new ISO639("tli", "", "Tlingit");
		
		/**
		 * 	The ISO 639 standard language name values for Tamashek.
		 */
		public static const TMH:ISO639 = new ISO639("tmh", "", "Tamashek");
		
		/**
		 * 	The ISO 639 standard language name values for Tonga (Nyasa).
		 */
		public static const TOG:ISO639 = new ISO639("tog", "", "Tonga (Nyasa)");
		
		/**
		 * 	The ISO 639 standard language name values for Tonga (Tonga Islands).
		 */
		public static const TON:ISO639 = new ISO639("ton", "to", "Tonga (Tonga Islands)");
		
		/**
		 * 	The ISO 639 standard language name values for Tok Pisin.
		 */
		public static const TPI:ISO639 = new ISO639("tpi", "", "Tok Pisin");
		
		/**
		 * 	The ISO 639 standard language name values for Tsimshian.
		 */
		public static const TSI:ISO639 = new ISO639("tsi", "", "Tsimshian");
		
		/**
		 * 	The ISO 639 standard language name values for Tswana.
		 */
		public static const TSN:ISO639 = new ISO639("tsn", "tn", "Tswana");
		
		/**
		 * 	The ISO 639 standard language name values for Tsonga.
		 */
		public static const TSO:ISO639 = new ISO639("tso", "ts", "Tsonga");
		
		/**
		 * 	The ISO 639 standard language name values for Turkmen.
		 */
		public static const TUK:ISO639 = new ISO639("tuk", "tk", "Turkmen");
		
		/**
		 * 	The ISO 639 standard language name values for Tumbuka.
		 */
		public static const TUM:ISO639 = new ISO639("tum", "", "Tumbuka");
		
		/**
		 * 	The ISO 639 standard language name values for Tupi languages.
		 */
		public static const TUP:ISO639 = new ISO639("tup", "", "Tupi languages");
		
		/**
		 * 	The ISO 639 standard language name values for Turkish.
		 */
		public static const TUR:ISO639 = new ISO639("tur", "tr", "Turkish");
		
		/**
		 * 	The ISO 639 standard language name values for Altaic languages.
		 */
		public static const TUT:ISO639 = new ISO639("tut", "", "Altaic languages");
		
		/**
		 * 	The ISO 639 standard language name values for Tuvalu.
		 */
		public static const TVL:ISO639 = new ISO639("tvl", "", "Tuvalu");
		
		/**
		 * 	The ISO 639 standard language name values for Twi.
		 */
		public static const TWI:ISO639 = new ISO639("twi", "tw", "Twi");
		
		/**
		 * 	The ISO 639 standard language name values for Tuvinian.
		 */
		public static const TYV:ISO639 = new ISO639("tyv", "", "Tuvinian");
		
		/**
		 * 	The ISO 639 standard language name values for Udmurt.
		 */
		public static const UDM:ISO639 = new ISO639("udm", "", "Udmurt");
		
		/**
		 * 	The ISO 639 standard language name values for Ugaritic.
		 */
		public static const UGA:ISO639 = new ISO639("uga", "", "Ugaritic");
		
		/**
		 * 	The ISO 639 standard language name values for Uighur.
		 */
		public static const UIG:ISO639 = new ISO639("uig", "ug", "Uighur");
		
		/**
		 * 	The ISO 639 standard language name values for Ukrainian.
		 */
		public static const UKR:ISO639 = new ISO639("ukr", "uk", "Ukrainian");
		
		/**
		 * 	The ISO 639 standard language name values for Umbundu.
		 */
		public static const UMB:ISO639 = new ISO639("umb", "", "Umbundu");
		
		/**
		 * 	The ISO 639 standard language name values for Undetermined.
		 */
		public static const UND:ISO639 = new ISO639("und", "", "Undetermined");
		
		/**
		 * 	The ISO 639 standard language name values for Urdu.
		 */
		public static const URD:ISO639 = new ISO639("urd", "ur", "Urdu");
		
		/**
		 * 	The ISO 639 standard language name values for Uzbek.
		 */
		public static const UZB:ISO639 = new ISO639("uzb", "uz", "Uzbek");
		
		/**
		 * 	The ISO 639 standard language name values for Vai.
		 */
		public static const VAI:ISO639 = new ISO639("vai", "", "Vai");
		
		/**
		 * 	The ISO 639 standard language name values for Venda.
		 */
		public static const VEN:ISO639 = new ISO639("ven", "ve", "Venda");
		
		/**
		 * 	The ISO 639 standard language name values for Vietnamese.
		 */
		public static const VIE:ISO639 = new ISO639("vie", "vi", "Vietnamese");
		
		/**
		 * 	The ISO 639 standard language name values for Volapuk.
		 */
		public static const VOL:ISO639 = new ISO639("vol", "vo", "Volapuk");
		
		/**
		 * 	The ISO 639 standard language name values for Votic.
		 */
		public static const VOT:ISO639 = new ISO639("vot", "", "Votic");
		
		/**
		 * 	The ISO 639 standard language name values for Wakashan languages.
		 */
		public static const WAK:ISO639 = new ISO639("wak", "", "Wakashan languages");
		
		/**
		 * 	The ISO 639 standard language name values for Wolaitta.
		 */
		public static const WAL:ISO639 = new ISO639("wal", "", "Wolaitta");
		
		/**
		 * 	The ISO 639 standard language name values for Waray.
		 */
		public static const WAR:ISO639 = new ISO639("war", "", "Waray");
		
		/**
		 * 	The ISO 639 standard language name values for Washo.
		 */
		public static const WAS:ISO639 = new ISO639("was", "", "Washo");
		
		/**
		 * 	The ISO 639 standard language name values for Welsh.
		 */
		public static const WEL:ISO639 = new ISO639("wel", "cy", "Welsh");
		
		/**
		 * 	The ISO 639 standard language name values for Sorbian languages.
		 */
		public static const WEN:ISO639 = new ISO639("wen", "", "Sorbian languages");
		
		/**
		 * 	The ISO 639 standard language name values for Walloon.
		 */
		public static const WLN:ISO639 = new ISO639("wln", "wa", "Walloon");
		
		/**
		 * 	The ISO 639 standard language name values for Wolof.
		 */
		public static const WOL:ISO639 = new ISO639("wol", "wo", "Wolof");
		
		/**
		 * 	The ISO 639 standard language name values for Kalmyk.
		 */
		public static const XAL:ISO639 = new ISO639("xal", "", "Kalmyk");
		
		/**
		 * 	The ISO 639 standard language name values for Xhosa.
		 */
		public static const XHO:ISO639 = new ISO639("xho", "xh", "Xhosa");
		
		/**
		 * 	The ISO 639 standard language name values for Yao.
		 */
		public static const YAO:ISO639 = new ISO639("yao", "", "Yao");
		
		/**
		 * 	The ISO 639 standard language name values for Yapese.
		 */
		public static const YAP:ISO639 = new ISO639("yap", "", "Yapese");
		
		/**
		 * 	The ISO 639 standard language name values for Yiddish.
		 */
		public static const YID:ISO639 = new ISO639("yid", "yi", "Yiddish");
		
		/**
		 * 	The ISO 639 standard language name values for Yoruba.
		 */
		public static const YOR:ISO639 = new ISO639("yor", "yo", "Yoruba");
		
		/**
		 * 	The ISO 639 standard language name values for Yupik languages.
		 */
		public static const YPK:ISO639 = new ISO639("ypk", "", "Yupik languages");
		
		/**
		 * 	The ISO 639 standard language name values for Zapotec.
		 */
		public static const ZAP:ISO639 = new ISO639("zap", "", "Zapotec");
		
		/**
		 * 	The ISO 639 standard language name values for Blissymbols.
		 */
		public static const ZBL:ISO639 = new ISO639("zbl", "", "Blissymbols");
		
		/**
		 * 	The ISO 639 standard language name values for Zenaga.
		 */
		public static const ZEN:ISO639 = new ISO639("zen", "", "Zenaga");
		
		/**
		 * 	The ISO 639 standard language name values for Zhuang.
		 */
		public static const ZHA:ISO639 = new ISO639("zha", "za", "Zhuang");
		
		/**
		 * 	The ISO 639 standard language name values for Zande languages.
		 */
		public static const ZND:ISO639 = new ISO639("znd", "", "Zande languages");
		
		/**
		 * 	The ISO 639 standard language name values for Zulu.
		 */
		public static const ZUL:ISO639 = new ISO639("zul", "zu", "Zulu");
		
		/**
		 * 	The ISO 639 standard language name values for Zuni.
		 */
		public static const ZUN:ISO639 = new ISO639("zun", "", "Zuni");
		
		/**
		 * 	The ISO 639 standard language name values for no linguistic content.
		 */
		public static const ZXX:ISO639 = new ISO639("zxx", "", "No linguistic content");
		
		/**
		 * 	The ISO 639 standard language name values for Zaza.
		 */
		public static const ZZA:ISO639 = new ISO639("zza", "", "Zaza");
	}
}