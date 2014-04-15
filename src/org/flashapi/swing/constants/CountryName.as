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
	// CountryName.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 02/03/2011 02:40
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	import org.flashapi.swing.localization.ISO3166;
	
	/**
	 * 	The <code>CountryName</code> class is an enumeration of constant values that
	 * 	you can use to set all information about a country name, according to the ISO
	 * 	3166 standard.
	 * 
	 * 	@see org.flashapi.swing.localization.ISO3166
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class CountryName {
		
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
		 * 				CountryName instance.
		 */
		public function CountryName() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The ISO 3166 standard country name values for Afghanistan.
		 */
		public static const AFG:ISO3166 = new ISO3166("Afghanistan", "AF", "AFG", "004");
		
		/**
		 * 	The ISO 3166 standard country name values for Åland Islands.
		 */
		public static const ALA:ISO3166 = new ISO3166("Åland Islands", "AX", "ALA", "248");
		
		/**
		 * 	The ISO 3166 standard country name values for Albania.
		 */
		public static const ALB:ISO3166 = new ISO3166("Albania", "AL", "ALB", "008");
		
		/**
		 * 	The ISO 3166 standard country name values for Algeria.
		 */
		public static const DZA:ISO3166 = new ISO3166("Algeria", "DZ", "DZA", "012");
		
		/**
		 * 	The ISO 3166 standard country name values for American Samoa.
		 */
		public static const ASM:ISO3166 = new ISO3166("American Samoa", "AS", "ASM", "016");
		
		/**
		 * 	The ISO 3166 standard country name values for Andorra.
		 */
		public static const AND:ISO3166 = new ISO3166("Andorra", "AD", "AND", "020");
		
		/**
		 * 	The ISO 3166 standard country name values for Angola.
		 */
		public static const AGO:ISO3166 = new ISO3166("Angola", "AO", "AGO", "024");
		
		/**
		 * 	The ISO 3166 standard country name values for Anguilla.
		 */
		public static const AIA:ISO3166 = new ISO3166("Anguilla", "AI", "AIA", "660");
		
		/**
		 * 	The ISO 3166 standard country name values for Antarctica.
		 */
		public static const ATA:ISO3166 = new ISO3166("Antarctica", "AQ", "ATA", "010");
		
		/**
		 * 	The ISO 3166 standard country name values for Antigua and Barbuda.
		 */
		public static const ATG:ISO3166 = new ISO3166("Antigua and Barbuda", "AG", "ATG", "028");
		
		/**
		 * 	The ISO 3166 standard country name values for Argentina.
		 */
		public static const ARG:ISO3166 = new ISO3166("Argentina", "AR", "ARG", "032");
		
		/**
		 * 	The ISO 3166 standard country name values for Armenia.
		 */
		public static const ARM:ISO3166 = new ISO3166("Armenia", "AM", "ARM", "051");
		
		/**
		 * 	The ISO 3166 standard country name values for Aruba.
		 */
		public static const ABW:ISO3166 = new ISO3166("Aruba", "AW", "ABW", "533");
		
		/**
		 * 	The ISO 3166 standard country name values for Australia.
		 */
		public static const AUS:ISO3166 = new ISO3166("Australia", "AU", "AUS", "036");
		
		/**
		 * 	The ISO 3166 standard country name values for Austria.
		 */
		public static const AUT:ISO3166 = new ISO3166("Austria", "AT", "AUT", "040");
		
		/**
		 * 	The ISO 3166 standard country name values for Azerbaijan.
		 */
		public static const AZE:ISO3166 = new ISO3166("Azerbaijan", "AZ", "AZE", "031");
		
		/**
		 * 	The ISO 3166 standard country name values for Bahamas.
		 */
		public static const BHS:ISO3166 = new ISO3166("Bahamas", "BS", "BHS", "044");
		
		/**
		 * 	The ISO 3166 standard country name values for Bahrain.
		 */
		public static const BHR:ISO3166 = new ISO3166("Bahrain", "BH", "BHR", "048");
		
		/**
		 * 	The ISO 3166 standard country name values for Bangladesh.
		 */
		public static const BGD:ISO3166 = new ISO3166("Bangladesh", "BD", "BGD", "050");
		
		/**
		 * 	The ISO 3166 standard country name values for Barbados.
		 */
		public static const BRB:ISO3166 = new ISO3166("Barbados", "BB", "BRB", "052");
		
		/**
		 * 	The ISO 3166 standard country name values for Belarus.
		 */
		public static const BLR:ISO3166 = new ISO3166("Belarus", "BY", "BLR", "112");
		
		/**
		 * 	The ISO 3166 standard country name values for Belgium.
		 */
		public static const BEL:ISO3166 = new ISO3166("Belgium", "BE", "BEL", "056");
		
		/**
		 * 	The ISO 3166 standard country name values for Belize.
		 */
		public static const BLZ:ISO3166 = new ISO3166("Belize", "BZ", "BLZ", "084");
		
		/**
		 * 	The ISO 3166 standard country name values for Benin.
		 */
		public static const BEN:ISO3166 = new ISO3166("Benin", "BJ", "BEN", "204");
		
		/**
		 * 	The ISO 3166 standard country name values for Bermuda.
		 */
		public static const BMU:ISO3166 = new ISO3166("Bermuda", "BM", "BMU", "060");
		
		/**
		 * 	The ISO 3166 standard country name values for Bhutan.
		 */
		public static const BTN:ISO3166 = new ISO3166("Bhutan", "BT", "BTN", "064");
		
		/**
		 * 	The ISO 3166 standard country name values for Bolivia (Plurinational State of).
		 */
		public static const BOL:ISO3166 = new ISO3166("Bolivia, Plurinational State of", "BO", "BOL", "068");
		
		/**
		 * 	The ISO 3166 standard country name values for Bonaire (Saint Eustatius and Saba).
		 */
		public static const BES:ISO3166 = new ISO3166("Bonaire, Saint Eustatius and Saba", "BQ", "BES", "535");
		
		/**
		 * 	The ISO 3166 standard country name values for Bosnia and Herzegovina".
		 */
		public static const BIH:ISO3166 = new ISO3166("Bosnia and Herzegovina", "BA", "BIH", "070");
		
		/**
		 * 	The ISO 3166 standard country name values for Botswana.
		 */
		public static const BWA:ISO3166 = new ISO3166("Botswana", "BW", "BWA", "072");
		
		/**
		 * 	The ISO 3166 standard country name values for Bouvet Island.
		 */
		public static const BVT:ISO3166 = new ISO3166("Bouvet Island", "BV", "BVT", "074");
		
		/**
		 * 	The ISO 3166 standard country name values for Brazil.
		 */
		public static const BRA:ISO3166 = new ISO3166("Brazil", "BR", "BRA", "076");
		
		/**
		 * 	The ISO 3166 standard country name values for British Indian Ocean Territory.
		 */
		public static const IOT:ISO3166 = new ISO3166("British Indian Ocean Territory", "IO", "IOT", "086");
		
		/**
		 * 	The ISO 3166 standard country name values for Brunei Darussalam.
		 */
		public static const BRN:ISO3166 = new ISO3166("Brunei Darussalam", "BN", "BRN", "096");
		
		/**
		 * 	The ISO 3166 standard country name values for Bulgaria.
		 */
		public static const BGR:ISO3166 = new ISO3166("Bulgaria", "BG", "BGR", "100");
		
		/**
		 * 	The ISO 3166 standard country name values for Burkina Faso.
		 */
		public static const BFA:ISO3166 = new ISO3166("Burkina Faso", "BF", "BFA", "854");
		
		/**
		 * 	The ISO 3166 standard country name values for Burundi.
		 */
		public static const BDI:ISO3166 = new ISO3166("Burundi", "BI", "BDI", "108");
		
		/**
		 * 	The ISO 3166 standard country name values for Cambodia.
		 */
		public static const KHM:ISO3166 = new ISO3166("Cambodia", "KH", "KHM", "116");
		
		/**
		 * 	The ISO 3166 standard country name values for Cameroon.
		 */
		public static const CMR:ISO3166 = new ISO3166("Cameroon", "CM", "CMR", "120");
		
		/**
		 * 	The ISO 3166 standard country name values for Canada.
		 */
		public static const CAN:ISO3166 = new ISO3166("Canada", "CA", "CAN", "124");
		
		/**
		 * 	The ISO 3166 standard country name values for Cape Verde.
		 */
		public static const CPV:ISO3166 = new ISO3166("Cape Verde", "CV", "CPV", "132");
		
		/**
		 * 	The ISO 3166 standard country name values for Cayman Islands.
		 */
		public static const CYM:ISO3166 = new ISO3166("Cayman Islands", "KY", "CYM", "136");
		
		/**
		 * 	The ISO 3166 standard country name values for Central African Republic.
		 */
		public static const CAF:ISO3166 = new ISO3166("Central African Republic", "CF", "CAF", "140");
		
		/**
		 * 	The ISO 3166 standard country name values for Chad.
		 */
		public static const TCD:ISO3166 = new ISO3166("Chad", "TD", "TCD", "148");
		
		/**
		 * 	The ISO 3166 standard country name values for Chile.
		 */
		public static const CHL:ISO3166 = new ISO3166("Chile", "CL", "CHL", "152");
		
		/**
		 * 	The ISO 3166 standard country name values for China.
		 */
		public static const CHN:ISO3166 = new ISO3166("China", "CN", "CHN", "156");
		
		/**
		 * 	The ISO 3166 standard country name values for Christmas Island.
		 */
		public static const CXR:ISO3166 = new ISO3166("Christmas Island", "CX", "CXR", "162");
		
		/**
		 * 	The ISO 3166 standard country name values for Cocos (Keeling) Islands.
		 */
		public static const CCK:ISO3166 = new ISO3166("Cocos (Keeling) Islands", "CC", "CCK", "166");
		
		/**
		 * 	The ISO 3166 standard country name values for Colombia.
		 */
		public static const COL:ISO3166 = new ISO3166("Colombia", "CO", "COL", "170");
		
		/**
		 * 	The ISO 3166 standard country name values for Comoros.
		 */
		public static const COM:ISO3166 = new ISO3166("Comoros", "KM", "COM", "174");
		
		/**
		 * 	The ISO 3166 standard country name values for Congo.
		 */
		public static const COG:ISO3166 = new ISO3166("Congo", "CG", "COG", "178");
		
		/**
		 * 	The ISO 3166 standard country name values for Congo (the Democratic Republic of the).
		 */
		public static const COD:ISO3166 = new ISO3166("Congo, the Democratic Republic of the", "CD", "COD", "180");
		
		/**
		 * 	The ISO 3166 standard country name values for Antarctica.
		 */
		public static const COK:ISO3166 = new ISO3166("Cook Islands", "CK", "COK", "184");
		
		/**
		 * 	The ISO 3166 standard country name values for Costa Rica.
		 */
		public static const CRI:ISO3166 = new ISO3166("Costa Rica", "CR", "CRI", "188");
		
		/**
		 * 	The ISO 3166 standard country name values for Côte d'Ivoire.
		 */
		public static const CIV:ISO3166 = new ISO3166("Côte d'Ivoire", "CI", "CIV", "384");
		
		/**
		 * 	The ISO 3166 standard country name values for Croatia.
		 */
		public static const HRV:ISO3166 = new ISO3166("Croatia", "HR", "HRV", "191");
		
		/**
		 * 	The ISO 3166 standard country name values for Cuba.
		 */
		public static const CUB:ISO3166 = new ISO3166("Cuba", "CU", "CUB", "192");
		
		/**
		 * 	The ISO 3166 standard country name values for Curaçao.
		 */
		public static const CUW:ISO3166 = new ISO3166("Curaçao", "CW", "CUW", "531");
		
		/**
		 * 	The ISO 3166 standard country name values for Cyprus.
		 */
		public static const CYP:ISO3166 = new ISO3166("Cyprus", "CY", "CYP", "196");
		
		/**
		 * 	The ISO 3166 standard country name values for Czech Republic.
		 */
		public static const CZE:ISO3166 = new ISO3166("Czech Republic", "CZ", "CZE", "203");
		
		/**
		 * 	The ISO 3166 standard country name values for Denmark.
		 */
		public static const DNK:ISO3166 = new ISO3166("Denmark", "DK", "DNK", "208");
		
		/**
		 * 	The ISO 3166 standard country name values for Djibouti.
		 */
		public static const DJI:ISO3166 = new ISO3166("Djibouti", "DJ", "DJI", "262");
		
		/**
		 * 	The ISO 3166 standard country name values for Dominica.
		 */
		public static const DMA:ISO3166 = new ISO3166("Dominica", "DM", "DMA", "212");
		
		/**
		 * 	The ISO 3166 standard country name values for Dominican Republic.
		 */
		public static const DOM:ISO3166 = new ISO3166("Dominican Republic", "DO", "DOM", "214");
		
		/**
		 * 	The ISO 3166 standard country name values for Ecuador.
		 */
		public static const ECU:ISO3166 = new ISO3166("Ecuador", "EC", "ECU", "218");
		
		/**
		 * 	The ISO 3166 standard country name values for Egypt.
		 */
		public static const EGY:ISO3166 = new ISO3166("Egypt", "EG", "EGY", "818");
		
		/**
		 * 	The ISO 3166 standard country name values for El Salvador.
		 */
		public static const SLV:ISO3166 = new ISO3166("El Salvador", "SV", "SLV", "222");
		
		/**
		 * 	The ISO 3166 standard country name values for Equatorial Guinea.
		 */
		public static const GNQ:ISO3166 = new ISO3166("Equatorial Guinea", "GQ", "GNQ", "226");
		
		/**
		 * 	The ISO 3166 standard country name values for Eritrea.
		 */
		public static const ERI:ISO3166 = new ISO3166("Eritrea", "ER", "ERI", "232");
		
		/**
		 * 	The ISO 3166 standard country name values for Estonia.
		 */
		public static const EST:ISO3166 = new ISO3166("Estonia", "EE", "EST", "233");
		
		/**
		 * 	The ISO 3166 standard country name values for Ethiopia.
		 */
		public static const ETH:ISO3166 = new ISO3166("Ethiopia", "ET", "ETH", "231");
		
		/**
		 * 	The ISO 3166 standard country name values for Falkland Islands (Malvinas).
		 */
		public static const FLK:ISO3166 = new ISO3166("Falkland Islands (Malvinas)", "FK", "FLK", "238");
		
		/**
		 * 	The ISO 3166 standard country name values for Faroe Islands.
		 */
		public static const FRO:ISO3166 = new ISO3166("Faroe Islands", "FO", "FRO", "234");
		
		/**
		 * 	The ISO 3166 standard country name values for Fiji.
		 */
		public static const FJI:ISO3166 = new ISO3166("Fiji", "FJ", "FJI", "242");
		
		/**
		 * 	The ISO 3166 standard country name values for Finland.
		 */
		public static const FIN:ISO3166 = new ISO3166("Finland", "FI", "FIN", "246");
		
		/**
		 * 	The ISO 3166 standard country name values for France.
		 */
		public static const FRA:ISO3166 = new ISO3166("France", "FR", "FRA", "250");
		
		/**
		 * 	The ISO 3166 standard country name values for French Guiana.
		 */
		public static const GUF:ISO3166 = new ISO3166("French Guiana", "GF", "GUF", "254");
		
		/**
		 * 	The ISO 3166 standard country name values for French Polynesia.
		 */
		public static const PYF:ISO3166 = new ISO3166("French Polynesia", "PF", "PYF", "258");
		
		/**
		 * 	The ISO 3166 standard country name values for French Southern Territories.
		 */
		public static const ATF:ISO3166 = new ISO3166("French Southern Territories", "TF", "ATF", "260");
		
		/**
		 * 	The ISO 3166 standard country name values for Gabon.
		 */
		public static const GAB:ISO3166 = new ISO3166("Gabon", "GA", "GAB", "266");
		
		/**
		 * 	The ISO 3166 standard country name values for Gambia.
		 */
		public static const GMB:ISO3166 = new ISO3166("Gambia", "GM", "GMB", "270");
		
		/**
		 * 	The ISO 3166 standard country name values for Georgia.
		 */
		public static const GEO:ISO3166 = new ISO3166("Georgia", "GE", "GEO", "268");
		
		/**
		 * 	The ISO 3166 standard country name values for Germany.
		 */
		public static const DEU:ISO3166 = new ISO3166("Germany", "DE", "DEU", "276");
		
		/**
		 * 	The ISO 3166 standard country name values for Ghana.
		 */
		public static const GHA:ISO3166 = new ISO3166("Ghana", "GH", "GHA", "288");
		
		/**
		 * 	The ISO 3166 standard country name values for Gibraltar.
		 */
		public static const GIB:ISO3166 = new ISO3166("Gibraltar", "GI", "GIB", "292");
		
		/**
		 * 	The ISO 3166 standard country name values for Greece.
		 */
		public static const GRC:ISO3166 = new ISO3166("Greece", "GR", "GRC", "300");
		
		/**
		 * 	The ISO 3166 standard country name values for Greenland.
		 */
		public static const GRL:ISO3166 = new ISO3166("Greenland", "GL", "GRL", "304");
		
		/**
		 * 	The ISO 3166 standard country name values for Grenada.
		 */
		public static const GRD:ISO3166 = new ISO3166("Grenada", "GD", "GRD", "308");
		
		/**
		 * 	The ISO 3166 standard country name values for Guadeloupe.
		 */
		public static const GLP:ISO3166 = new ISO3166("Guadeloupe", "GP", "GLP", "312");
		
		/**
		 * 	The ISO 3166 standard country name values for Guam.
		 */
		public static const GUM:ISO3166 = new ISO3166("Guam", "GU", "GUM", "316");
		
		/**
		 * 	The ISO 3166 standard country name values for Guatemala.
		 */
		public static const GTM:ISO3166 = new ISO3166("Guatemala", "GT", "GTM", "320");
		
		/**
		 * 	The ISO 3166 standard country name values for Guernsey.
		 */
		public static const GGY:ISO3166 = new ISO3166("Guernsey", "GG", "GGY", "831");
		
		/**
		 * 	The ISO 3166 standard country name values for Guinea.
		 */
		public static const GIN:ISO3166 = new ISO3166("Guinea", "GN", "GIN", "324");
		
		/**
		 * 	The ISO 3166 standard country name values for Guinea-Bissau.
		 */
		public static const GNB:ISO3166 = new ISO3166("Guinea-Bissau", "GW", "GNB", "624");
		
		/**
		 * 	The ISO 3166 standard country name values for Guyana.
		 */
		public static const GUY:ISO3166 = new ISO3166("Guyana", "GY", "GUY", "328");
		
		/**
		 * 	The ISO 3166 standard country name values for Haiti.
		 */
		public static const HTI:ISO3166 = new ISO3166("Haiti", "HT", "HTI", "332");
		
		/**
		 * 	The ISO 3166 standard country name values for Heard Island and McDonald Islands.
		 */
		public static const HMD:ISO3166 = new ISO3166("Heard Island and McDonald Islands", "HM", "HMD", "334");
		
		/**
		 * 	The ISO 3166 standard country name values for Holy See (Vatican City State).
		 */
		public static const VAT:ISO3166 = new ISO3166("Holy See (Vatican City State)", "VA", "VAT", "336");
		
		/**
		 * 	The ISO 3166 standard country name values for Honduras.
		 */
		public static const HND:ISO3166 = new ISO3166("Honduras", "HN", "HND", "340");
		
		/**
		 * 	The ISO 3166 standard country name values for Hong Kong.
		 */
		public static const HKG:ISO3166 = new ISO3166("Hong Kong", "HK", "HKG", "344");
		
		/**
		 * 	The ISO 3166 standard country name values for Hungary.
		 */
		public static const HUN:ISO3166 = new ISO3166("Hungary", "HU", "HUN", "348");
		
		/**
		 * 	The ISO 3166 standard country name values for Iceland.
		 */
		public static const ISL:ISO3166 = new ISO3166("Iceland", "IS", "ISL", "352");
		
		/**
		 * 	The ISO 3166 standard country name values for India.
		 */
		public static const IND:ISO3166 = new ISO3166("India", "IN", "IND", "356");
		
		/**
		 * 	The ISO 3166 standard country name values for Indonesia.
		 */
		public static const IDN:ISO3166 = new ISO3166("Indonesia", "ID", "IDN", "360");
		
		/**
		 * 	The ISO 3166 standard country name values for Iran (Islamic Republic of).
		 */
		public static const IRN:ISO3166 = new ISO3166("Iran, Islamic Republic of", "IR", "IRN", "364");
		
		/**
		 * 	The ISO 3166 standard country name values for Iraq.
		 */
		public static const IRQ:ISO3166 = new ISO3166("Iraq", "IQ", "IRQ", "368");
		
		/**
		 * 	The ISO 3166 standard country name values for Ireland.
		 */
		public static const IRL:ISO3166 = new ISO3166("Ireland", "IE", "IRL", "372");
		
		/**
		 * 	The ISO 3166 standard country name values for Isle of Man.
		 */
		public static const IMN:ISO3166 = new ISO3166("Isle of Man", "IM", "IMN", "833");
		
		/**
		 * 	The ISO 3166 standard country name values for Israel.
		 */
		public static const ISR:ISO3166 = new ISO3166("Israel", "IL", "ISR", "376");
		
		/**
		 * 	The ISO 3166 standard country name values for Italy.
		 */
		public static const ITA:ISO3166 = new ISO3166("Italy", "IT", "ITA", "380");
		
		/**
		 * 	The ISO 3166 standard country name values for Jamaica.
		 */
		public static const JAM:ISO3166 = new ISO3166("Jamaica", "JM", "JAM", "388");
		
		/**
		 * 	The ISO 3166 standard country name values for Japan.
		 */
		public static const JPN:ISO3166 = new ISO3166("Japan", "JP", "JPN", "392");
		
		/**
		 * 	The ISO 3166 standard country name values for Jersey.
		 */
		public static const JEY:ISO3166 = new ISO3166("Jersey", "JE", "JEY", "832");
		
		/**
		 * 	The ISO 3166 standard country name values for Jordan.
		 */
		public static const JOR:ISO3166 = new ISO3166("Jordan", "JO", "JOR", "400");
		
		/**
		 * 	The ISO 3166 standard country name values for Kazakhstan.
		 */
		public static const KAZ:ISO3166 = new ISO3166("Kazakhstan", "KZ", "KAZ", "398");
		
		/**
		 * 	The ISO 3166 standard country name values for Kenya.
		 */
		public static const KEN:ISO3166 = new ISO3166("Kenya", "KE", "KEN", "404");
		
		/**
		 * 	The ISO 3166 standard country name values for Kiribati.
		 */
		public static const KIR:ISO3166 = new ISO3166("Kiribati", "KI", "KIR", "296");
		
		/**
		 * 	The ISO 3166 standard country name values for Korea (Democratic People's Republic of).
		 */
		public static const PRK:ISO3166 = new ISO3166("Korea, Democratic People's Republic of", "KP", "PRK", "408");
		
		/**
		 * 	The ISO 3166 standard country name values for Korea (Republic of).
		 */
		public static const KOR:ISO3166 = new ISO3166("Korea, Republic of", "KR", "KOR", "410");
		
		/**
		 * 	The ISO 3166 standard country name values for Kuwait.
		 */
		public static const KWT:ISO3166 = new ISO3166("Kuwait", "KW", "KWT", "414");
		
		/**
		 * 	The ISO 3166 standard country name values for Kyrgyzstan.
		 */
		public static const KGZ:ISO3166 = new ISO3166("Kyrgyzstan", "KG", "KGZ", "417");
		
		/**
		 * 	The ISO 3166 standard country name values for Lao People's Democratic Republic.
		 */
		public static const LAO:ISO3166 = new ISO3166("Lao People's Democratic Republic", "LA", "LAO", "418");
		
		/**
		 * 	The ISO 3166 standard country name values for Latvia.
		 */
		public static const LVA:ISO3166 = new ISO3166("Latvia", "LV", "LVA", "428");
		
		/**
		 * 	The ISO 3166 standard country name values for Lebanon.
		 */
		public static const LBN:ISO3166 = new ISO3166("Lebanon", "LB", "LBN", "422");
		
		/**
		 * 	The ISO 3166 standard country name values for Lesotho.
		 */
		public static const LSO:ISO3166 = new ISO3166("Lesotho", "LS", "LSO", "426");
		
		/**
		 * 	The ISO 3166 standard country name values for Liberia.
		 */
		public static const LBR:ISO3166 = new ISO3166("Liberia", "LR", "LBR", "430");
		
		/**
		 * 	The ISO 3166 standard country name values for Libyan Arab Jamahiriya.
		 */
		public static const LBY:ISO3166 = new ISO3166("Libyan Arab Jamahiriya", "LY", "LBY", "434");
		
		/**
		 * 	The ISO 3166 standard country name values for Liechtenstein.
		 */
		public static const LIE:ISO3166 = new ISO3166("Liechtenstein", "LI", "LIE", "438");
		
		/**
		 * 	The ISO 3166 standard country name values for Lithuania.
		 */
		public static const LTU:ISO3166 = new ISO3166("Lithuania", "LT", "LTU", "440");
		
		/**
		 * 	The ISO 3166 standard country name values for Luxembourg.
		 */
		public static const LUX:ISO3166 = new ISO3166("Luxembourg", "LU", "LUX", "442");
		
		/**
		 * 	The ISO 3166 standard country name values for Macao.
		 */
		public static const MAC:ISO3166 = new ISO3166("Macao", "MO", "MAC", "446");
		
		/**
		 * 	The ISO 3166 standard country name values for Macedonia (the former Yugoslav Republic of).
		 */
		public static const MKD:ISO3166 = new ISO3166("Macedonia, the former Yugoslav Republic of", "MK", "MKD", "807");
		
		/**
		 * 	The ISO 3166 standard country name values for Madagascar.
		 */
		public static const MDG:ISO3166 = new ISO3166("Madagascar", "MG", "MDG", "450");
		
		/**
		 * 	The ISO 3166 standard country name values for Malawi.
		 */
		public static const MWI:ISO3166 = new ISO3166("Malawi", "MW", "MWI", "454");
		
		/**
		 * 	The ISO 3166 standard country name values for Malaysia.
		 */
		public static const MYS:ISO3166 = new ISO3166("Malaysia", "MY", "MYS", "458");
		
		/**
		 * 	The ISO 3166 standard country name values for Maldives.
		 */
		public static const MDV:ISO3166 = new ISO3166("Maldives", "MV", "MDV", "462");
		
		/**
		 * 	The ISO 3166 standard country name values for Mali.
		 */
		public static const MLI:ISO3166 = new ISO3166("Mali", "ML", "MLI", "466");
		
		/**
		 * 	The ISO 3166 standard country name values for Malta.
		 */
		public static const MLT:ISO3166 = new ISO3166("Malta", "MT", "MLT", "470");
		
		/**
		 * 	The ISO 3166 standard country name values for Marshall Islands.
		 */
		public static const MHL:ISO3166 = new ISO3166("Marshall Islands", "MH", "MHL", "584");
		
		/**
		 * 	The ISO 3166 standard country name values for Martinique.
		 */
		public static const MTQ:ISO3166 = new ISO3166("Martinique", "MQ", "MTQ", "474");
		
		/**
		 * 	The ISO 3166 standard country name values for Mauritania.
		 */
		public static const MRT:ISO3166 = new ISO3166("Mauritania", "MR", "MRT", "478");
		
		/**
		 * 	The ISO 3166 standard country name values for Mauritius.
		 */
		public static const MUS:ISO3166 = new ISO3166("Mauritius", "MU", "MUS", "480");
		
		/**
		 * 	The ISO 3166 standard country name values for Mayotte.
		 */
		public static const MYT:ISO3166 = new ISO3166("Mayotte", "YT", "MYT", "175");
		
		/**
		 * 	The ISO 3166 standard country name values for Mexico.
		 */
		public static const MEX:ISO3166 = new ISO3166("Mexico", "MX", "MEX", "484");
		
		/**
		 * 	The ISO 3166 standard country name values for Micronesia (Federated States of).
		 */
		public static const FSM:ISO3166 = new ISO3166("Micronesia, Federated States of", "FM", "FSM", "583");
		
		/**
		 * 	The ISO 3166 standard country name values for Moldova (Republic of).
		 */
		public static const MDA:ISO3166 = new ISO3166("Moldova, Republic of", "MD", "MDA", "498");
		
		/**
		 * 	The ISO 3166 standard country name values for Monaco.
		 */
		public static const MCO:ISO3166 = new ISO3166("Monaco", "MC", "MCO", "492");
		
		/**
		 * 	The ISO 3166 standard country name values for Mongolia.
		 */
		public static const MNG:ISO3166 = new ISO3166("Mongolia", "MN", "MNG", "496");
		
		/**
		 * 	The ISO 3166 standard country name values for Montenegro.
		 */
		public static const MNE:ISO3166 = new ISO3166("Montenegro", "ME", "MNE", "499");
		
		/**
		 * 	The ISO 3166 standard country name values for Montserrat.
		 */
		public static const MSR:ISO3166 = new ISO3166("Montserrat", "MS", "MSR", "500");
		
		/**
		 * 	The ISO 3166 standard country name values for Morocco.
		 */
		public static const MAR:ISO3166 = new ISO3166("Morocco", "MA", "MAR", "504");
		
		/**
		 * 	The ISO 3166 standard country name values for Mozambique.
		 */
		public static const MOZ:ISO3166 = new ISO3166("Mozambique", "MZ", "MOZ", "508");
		
		/**
		 * 	The ISO 3166 standard country name values for Myanmar.
		 */
		public static const MMR:ISO3166 = new ISO3166("Myanmar", "MM", "MMR", "104");
		
		/**
		 * 	The ISO 3166 standard country name values for Namibia.
		 */
		public static const NAM:ISO3166 = new ISO3166("Namibia", "NA", "NAM", "516");
		
		/**
		 * 	The ISO 3166 standard country name values for Nauru.
		 */
		public static const NRU:ISO3166 = new ISO3166("Nauru", "NR", "NRU", "520");
		
		/**
		 * 	The ISO 3166 standard country name values for Nepal.
		 */
		public static const NPL:ISO3166 = new ISO3166("Nepal", "NP", "NPL", "524");
		
		/**
		 * 	The ISO 3166 standard country name values for Netherlands.
		 */
		public static const NLD:ISO3166 = new ISO3166("Netherlands", "NL", "NLD", "528");
		
		/**
		 * 	The ISO 3166 standard country name values for New Caledonia.
		 */
		public static const NCL:ISO3166 = new ISO3166("New Caledonia", "NC", "NCL", "540");
		
		/**
		 * 	The ISO 3166 standard country name values for New Zealand.
		 */
		public static const NZL:ISO3166 = new ISO3166("New Zealand", "NZ", "NZL", "554");
		
		/**
		 * 	The ISO 3166 standard country name values for Nicaragua.
		 */
		public static const NIC:ISO3166 = new ISO3166("Nicaragua", "NI", "NIC", "558");
		
		/**
		 * 	The ISO 3166 standard country name values for Niger.
		 */
		public static const NER:ISO3166 = new ISO3166("Niger", "NE", "NER", "562");
		
		/**
		 * 	The ISO 3166 standard country name values for Nigeria.
		 */
		public static const NGA:ISO3166 = new ISO3166("Nigeria", "NG", "NGA", "566");
		
		/**
		 * 	The ISO 3166 standard country name values for Niue.
		 */
		public static const NIU:ISO3166 = new ISO3166("Niue", "NU", "NIU", "570");
		
		/**
		 * 	The ISO 3166 standard country name values for Norfolk Island.
		 */
		public static const NFK:ISO3166 = new ISO3166("Norfolk Island", "NF", "NFK", "574");
		
		/**
		 * 	The ISO 3166 standard country name values for Northern Mariana Islands.
		 */
		public static const MNP:ISO3166 = new ISO3166("Northern Mariana Islands", "MP", "MNP", "580");
		
		/**
		 * 	The ISO 3166 standard country name values for Norway.
		 */
		public static const NOR:ISO3166 = new ISO3166("Norway", "NO", "NOR", "578");
		
		/**
		 * 	The ISO 3166 standard country name values for Oman.
		 */
		public static const OMN:ISO3166 = new ISO3166("Oman", "OM", "OMN", "512");
		
		/**
		 * 	The ISO 3166 standard country name values for Pakistan.
		 */
		public static const PAK:ISO3166 = new ISO3166("Pakistan", "PK", "PAK", "586");
		
		/**
		 * 	The ISO 3166 standard country name values for Palau.
		 */
		public static const PLW:ISO3166 = new ISO3166("Palau", "PW", "PLW", "585");
		
		/**
		 * 	The ISO 3166 standard country name values for Palestinian Territory (Occupied).
		 */
		public static const PSE:ISO3166 = new ISO3166("Palestinian Territory, Occupied", "PS", "PSE", "275");
		
		/**
		 * 	The ISO 3166 standard country name values for Panama.
		 */
		public static const PAN:ISO3166 = new ISO3166("Panama", "PA", "PAN", "591");
		
		/**
		 * 	The ISO 3166 standard country name values for Papua New Guinea.
		 */
		public static const PNG:ISO3166 = new ISO3166("Papua New Guinea", "PG", "PNG", "598");
		
		/**
		 * 	The ISO 3166 standard country name values for Paraguay.
		 */
		public static const PRY:ISO3166 = new ISO3166("Paraguay", "PY", "PRY", "600");
		
		/**
		 * 	The ISO 3166 standard country name values for Peru.
		 */
		public static const PER:ISO3166 = new ISO3166("Peru", "PE", "PER", "604");
		
		/**
		 * 	The ISO 3166 standard country name values for Philippines.
		 */
		public static const PHL:ISO3166 = new ISO3166("Philippines", "PH", "PHL", "608");
		
		/**
		 * 	The ISO 3166 standard country name values for Pitcairn.
		 */
		public static const PCN:ISO3166 = new ISO3166("Pitcairn", "PN", "PCN", "612");
		
		/**
		 * 	The ISO 3166 standard country name values for Poland.
		 */
		public static const POL:ISO3166 = new ISO3166("Poland", "PL", "POL", "616");
		
		/**
		 * 	The ISO 3166 standard country name values for Portugal.
		 */
		public static const PRT:ISO3166 = new ISO3166("Portugal", "PT", "PRT", "620");
		
		/**
		 * 	The ISO 3166 standard country name values for Puerto Rico.
		 */
		public static const PRI:ISO3166 = new ISO3166("Puerto Rico", "PR", "PRI", "630");
		
		/**
		 * 	The ISO 3166 standard country name values for Qatar.
		 */
		public static const QAT:ISO3166 = new ISO3166("Qatar", "QA", "QAT", "634");
		
		/**
		 * 	The ISO 3166 standard country name values for Réunion.
		 */
		public static const REU:ISO3166 = new ISO3166("Réunion", "RE", "REU", "638");
		
		/**
		 * 	The ISO 3166 standard country name values for Romania.
		 */
		public static const ROU:ISO3166 = new ISO3166("Romania", "RO", "ROU", "642");
		
		/**
		 * 	The ISO 3166 standard country name values for Russian Federation.
		 */
		public static const RUS:ISO3166 = new ISO3166("Russian Federation", "RU", "RUS", "643");
		
		/**
		 * 	The ISO 3166 standard country name values for Rwanda.
		 */
		public static const RWA:ISO3166 = new ISO3166("Rwanda", "RW", "RWA", "646");
		
		/**
		 * 	The ISO 3166 standard country name values for Saint Barthélemy.
		 */
		public static const BLM:ISO3166 = new ISO3166("Saint Barthélemy", "BL", "BLM", "652");
		
		/**
		 * 	The ISO 3166 standard country name values for Saint Helena (Ascension and Tristan da Cunha).
		 */
		public static const SHN:ISO3166 = new ISO3166("Saint Helena, Ascension and Tristan da Cunha", "SH", "SHN", "654");
		
		/**
		 * 	The ISO 3166 standard country name values for Saint Kitts and Nevis.
		 */
		public static const KNA:ISO3166 = new ISO3166("Saint Kitts and Nevis", "KN", "KNA", "659");
		
		/**
		 * 	The ISO 3166 standard country name values for Saint Lucia.
		 */
		public static const LCA:ISO3166 = new ISO3166("Saint Lucia", "LC", "LCA", "662");
		
		/**
		 * 	The ISO 3166 standard country name values for Saint Martin (French part).
		 */
		public static const MAF:ISO3166 = new ISO3166("Saint Martin (French part)", "MF", "MAF", "663");
		
		/**
		 * 	The ISO 3166 standard country name values for Saint Pierre and Miquelon.
		 */
		public static const SPM:ISO3166 = new ISO3166("Saint Pierre and Miquelon", "PM", "SPM", "666");
		
		/**
		 * 	The ISO 3166 standard country name values for Saint Vincent and the Grenadines.
		 */
		public static const VCT:ISO3166 = new ISO3166("Saint Vincent and the Grenadines", "VC", "VCT", "670");
		
		/**
		 * 	The ISO 3166 standard country name values for Samoa.
		 */
		public static const WSM:ISO3166 = new ISO3166("Samoa", "WS", "WSM", "882");
		
		/**
		 * 	The ISO 3166 standard country name values for San Marino.
		 */
		public static const SMR:ISO3166 = new ISO3166("San Marino", "SM", "SMR", "674");
		
		/**
		 * 	The ISO 3166 standard country name values for Sao Tome and Principe.
		 */
		public static const STP:ISO3166 = new ISO3166("Sao Tome and Principe", "ST", "STP", "678");
		
		/**
		 * 	The ISO 3166 standard country name values for Saudi Arabia.
		 */
		public static const SAU:ISO3166 = new ISO3166("Saudi Arabia", "SA", "SAU", "682");
		
		/**
		 * 	The ISO 3166 standard country name values for Senegal.
		 */
		public static const SEN:ISO3166 = new ISO3166("Senegal", "SN", "SEN", "686");
		
		/**
		 * 	The ISO 3166 standard country name values for Serbia.
		 */
		public static const SRB:ISO3166 = new ISO3166("Serbia", "RS", "SRB", "688");
		
		/**
		 * 	The ISO 3166 standard country name values for Seychelles.
		 */
		public static const SYC:ISO3166 = new ISO3166("Seychelles", "SC", "SYC", "690");
		
		/**
		 * 	The ISO 3166 standard country name values for Sierra Leone.
		 */
		public static const SLE:ISO3166 = new ISO3166("Sierra Leone", "SL", "SLE", "694");
		
		/**
		 * 	The ISO 3166 standard country name values for Singapore.
		 */
		public static const SGP:ISO3166 = new ISO3166("Singapore", "SG", "SGP", "702");
		
		/**
		 * 	The ISO 3166 standard country name values for Sint Maarten (Dutch part).
		 */
		public static const SXM:ISO3166 = new ISO3166("Sint Maarten (Dutch part)", "SX", "SXM", "534");
		
		/**
		 * 	The ISO 3166 standard country name values for Slovakia.
		 */
		public static const SVK:ISO3166 = new ISO3166("Slovakia", "SK", "SVK", "703");
		
		/**
		 * 	The ISO 3166 standard country name values for Slovenia.
		 */
		public static const SVN:ISO3166 = new ISO3166("Slovenia", "SI", "SVN", "705");
		
		/**
		 * 	The ISO 3166 standard country name values for Solomon Islands.
		 */
		public static const SLB:ISO3166 = new ISO3166("Solomon Islands", "SB", "SLB", "090");
		
		/**
		 * 	The ISO 3166 standard country name values for Somalia.
		 */
		public static const SOM:ISO3166 = new ISO3166("Somalia", "SO", "SOM", "706");
		
		/**
		 * 	The ISO 3166 standard country name values for South Africa.
		 */
		public static const ZAF:ISO3166 = new ISO3166("South Africa", "ZA", "ZAF", "710");
		
		/**
		 * 	The ISO 3166 standard country name values for South Georgia and the South Sandwich Islands.
		 */
		public static const SGS:ISO3166 = new ISO3166("South Georgia and the South Sandwich Islands", "GS", "SGS", "239");
		
		/**
		 * 	The ISO 3166 standard country name values for Spain.
		 */
		public static const ESP:ISO3166 = new ISO3166("Spain", "ES", "ESP", "724");
		
		/**
		 * 	The ISO 3166 standard country name values for Sri Lanka.
		 */
		public static const LKA:ISO3166 = new ISO3166("Sri Lanka", "LK", "LKA", "144");
		
		/**
		 * 	The ISO 3166 standard country name values for Sudan.
		 */
		public static const SDN:ISO3166 = new ISO3166("Sudan", "SD", "SDN", "736");
		
		/**
		 * 	The ISO 3166 standard country name values for Suriname.
		 */
		public static const SUR:ISO3166 = new ISO3166("Suriname", "SR", "SUR", "740");
		
		/**
		 * 	The ISO 3166 standard country name values for Svalbard and Jan Mayen.
		 */
		public static const SJM:ISO3166 = new ISO3166("Svalbard and Jan Mayen", "SJ", "SJM", "744");
		
		/**
		 * 	The ISO 3166 standard country name values for Swaziland.
		 */
		public static const SWZ:ISO3166 = new ISO3166("Swaziland", "SZ", "SWZ", "748");
		
		/**
		 * 	The ISO 3166 standard country name values for Sweden.
		 */
		public static const SWE:ISO3166 = new ISO3166("Sweden", "SE", "SWE", "752");
		
		/**
		 * 	The ISO 3166 standard country name values for Switzerland.
		 */
		public static const CHE:ISO3166 = new ISO3166("Switzerland", "CH", "CHE", "756");
		
		/**
		 * 	The ISO 3166 standard country name values for Syrian Arab Republic.
		 */
		public static const SYR:ISO3166 = new ISO3166("Syrian Arab Republic", "SY", "SYR", "760");
		
		/**
		 * 	The ISO 3166 standard country name values for Taiwan (Province of China).
		 */
		public static const TWN:ISO3166 = new ISO3166("Taiwan, Province of China", "TW", "TWN", "158");
		
		/**
		 * 	The ISO 3166 standard country name values for Tajikistan.
		 */
		public static const TJK:ISO3166 = new ISO3166("Tajikistan", "TJ", "TJK", "762");
		
		/**
		 * 	The ISO 3166 standard country name values for Tanzania (United Republic of).
		 */
		public static const TZA:ISO3166 = new ISO3166("Tanzania, United Republic of", "TZ", "TZA", "834");
		
		/**
		 * 	The ISO 3166 standard country name values for Thailand.
		 */
		public static const THA:ISO3166 = new ISO3166("Thailand", "TH", "THA", "764");
		
		/**
		 * 	The ISO 3166 standard country name values for Timor-Leste.
		 */
		public static const TLS:ISO3166 = new ISO3166("Timor-Leste", "TL", "TLS", "626");
		
		/**
		 * 	The ISO 3166 standard country name values for Togo.
		 */
		public static const TGO:ISO3166 = new ISO3166("Togo", "TG", "TGO", "768");
		
		/**
		 * 	The ISO 3166 standard country name values for Tokelau.
		 */
		public static const TKL:ISO3166 = new ISO3166("Tokelau", "TK", "TKL", "772");
		
		/**
		 * 	The ISO 3166 standard country name values for Tonga.
		 */
		public static const TON:ISO3166 = new ISO3166("Tonga", "TO", "TON", "776");
		
		/**
		 * 	The ISO 3166 standard country name values for Trinidad and Tobago.
		 */
		public static const TTO:ISO3166 = new ISO3166("Trinidad and Tobago", "TT", "TTO", "780");
		
		/**
		 * 	The ISO 3166 standard country name values for Tunisia.
		 */
		public static const TUN:ISO3166 = new ISO3166("Tunisia", "TN", "TUN", "788");
		
		/**
		 * 	The ISO 3166 standard country name values for Turkey.
		 */
		public static const TUR:ISO3166 = new ISO3166("Turkey", "TR", "TUR", "792");
		
		/**
		 * 	The ISO 3166 standard country name values for Turkmenistan.
		 */
		public static const TKM:ISO3166 = new ISO3166("Turkmenistan", "TM", "TKM", "795");
		
		/**
		 * 	The ISO 3166 standard country name values for Turks and Caicos Islands.
		 */
		public static const TCA:ISO3166 = new ISO3166("Turks and Caicos Islands", "TC", "TCA", "796");
		
		/**
		 * 	The ISO 3166 standard country name values for Tuvalu.
		 */
		public static const TUV:ISO3166 = new ISO3166("Tuvalu", "TV", "TUV", "798");
		
		/**
		 * 	The ISO 3166 standard country name values for Uganda.
		 */
		public static const UGA:ISO3166 = new ISO3166("Uganda", "UG", "UGA", "800");
		
		/**
		 * 	The ISO 3166 standard country name values for Ukraine.
		 */
		public static const UKR:ISO3166 = new ISO3166("Ukraine", "UA", "UKR", "804");
		
		/**
		 * 	The ISO 3166 standard country name values for United Arab Emirates.
		 */
		public static const ARE:ISO3166 = new ISO3166("United Arab Emirates", "AE", "ARE", "784");
		
		/**
		 * 	The ISO 3166 standard country name values for United Kingdom.
		 */
		public static const GBR:ISO3166 = new ISO3166("United Kingdom", "GB", "GBR", "826");
		
		/**
		 * 	The ISO 3166 standard country name values for United States.
		 */
		public static const USA:ISO3166 = new ISO3166("United States", "US", "USA", "840");
		
		/**
		 * 	The ISO 3166 standard country name values for United States Minor Outlying Islands.
		 */
		public static const UMI:ISO3166 = new ISO3166("United States Minor Outlying Islands", "UM", "UMI", "581");
		
		/**
		 * 	The ISO 3166 standard country name values for Uruguay.
		 */
		public static const URY:ISO3166 = new ISO3166("Uruguay", "UY", "URY", "858");
		
		/**
		 * 	The ISO 3166 standard country name values for Uzbekistan.
		 */
		public static const UZB:ISO3166 = new ISO3166("Uzbekistan", "UZ", "UZB", "860");
		
		/**
		 * 	The ISO 3166 standard country name values for Vanuatu.
		 */
		public static const VUT:ISO3166 = new ISO3166("Vanuatu", "VU", "VUT", "548");
		
		/**
		 * 	The ISO 3166 standard country name values for Venezuela (Bolivarian Republic of).
		 */
		public static const VEN:ISO3166 = new ISO3166("Venezuela, Bolivarian Republic of", "VE", "VEN", "862");
		
		/**
		 * 	The ISO 3166 standard country name values for Viet Nam.
		 */
		public static const VNM:ISO3166 = new ISO3166("Viet Nam", "VN", "VNM", "704");
		
		/**
		 * 	The ISO 3166 standard country name values for Virgin Islands (British).
		 */
		public static const VGB:ISO3166 = new ISO3166("Virgin Islands, British", "VG", "VGB", "092");
		
		/**
		 * 	The ISO 3166 standard country name values for Virgin Islands (U.S.).
		 */
		public static const VIR:ISO3166 = new ISO3166("Virgin Islands, U.S.", "VI", "VIR", "850");
		
		/**
		 * 	The ISO 3166 standard country name values for Wallis and Futuna.
		 */
		public static const WLF:ISO3166 = new ISO3166("Wallis and Futuna", "WF", "WLF", "876");
		
		/**
		 * 	The ISO 3166 standard country name values for Western Sahara.
		 */
		public static const ESH:ISO3166 = new ISO3166("Western Sahara", "EH", "ESH", "732");
		
		/**
		 * 	The ISO 3166 standard country name values for Yemen.
		 */
		public static const YEM:ISO3166 = new ISO3166("Yemen", "YE", "YEM", "887");
		
		/**
		 * 	The ISO 3166 standard country name values for Zambia.
		 */
		public static const ZMB:ISO3166 = new ISO3166("Zambia", "ZM", "ZMB", "894");
		
		/**
		 * 	The ISO 3166 standard country name values for Zimbabwe.
		 */
		public static const ZWE:ISO3166 = new ISO3166("Zimbabwe", "ZW", "ZWE", "716");
	}
}