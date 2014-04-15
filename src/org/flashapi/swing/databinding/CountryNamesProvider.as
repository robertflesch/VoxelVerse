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
	//  CountryNamesProvider.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 1.0.0, 02/03/2011 02:58
	 *  @see http://www.flashapi.org/
	 */
	
	import org.flashapi.swing.constants.CountryName;
	
	/**
	 * 	The <code>CountryNamesProvider</code> class creates a <code>DataProviderObject</code>
	 * 	that contains all information about standard names of countries, according
	 * 	to the
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class CountryNamesProvider extends AbstractDataProvider {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>CountryNamesProvider</code> instance.
		 */
		public function CountryNamesProvider() {
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
				{ label:"Afghanistan", data:CountryName.AFG },
				{ label:"Åland Islands", data:CountryName.ALA },
				{ label:"Albania", data:CountryName.ALB },
				{ label:"Algeria", data:CountryName.DZA },
				{ label:"American Samoa", data:CountryName.ASM },
				{ label:"Andorra", data:CountryName.AND },
				{ label:"Angola", data:CountryName.AGO },
				{ label:"Anguilla", data:CountryName.AIA },
				{ label:"Antarctica", data:CountryName.ATA },
				{ label:"Antigua and Barbuda", data:CountryName.ATG },
				{ label:"Argentina", data:CountryName.ARG },
				{ label:"Armenia", data:CountryName.ARM },
				{ label:"Aruba", data:CountryName.ABW },
				{ label:"Australia", data:CountryName.AUS },
				{ label:"Austria", data:CountryName.AUT },
				{ label:"Azerbaijan", data:CountryName.AZE },
				{ label:"Bahamas", data:CountryName.BHS },
				{ label:"Bahrain", data:CountryName.BHR },
				{ label:"Bangladesh", data:CountryName.BGD },
				{ label:"Barbados", data:CountryName.BRB },
				{ label:"Belarus", data:CountryName.BLR },
				{ label:"Belgium", data:CountryName.BEL },
				{ label:"Belize", data:CountryName.BLZ },
				{ label:"Benin", data:CountryName.BEN },
				{ label:"Bermuda", data:CountryName.BMU },
				{ label:"Bhutan", data:CountryName.BTN },
				{ label:"Bolivia, Plurinational State of", data:CountryName.BOL },
				{ label:"Bonaire, Saint Eustatius and Saba", data:CountryName.BES },
				{ label:"Bosnia and Herzegovina", data:CountryName.BIH },
				{ label:"Botswana", data:CountryName.BWA },
				{ label:"Bouvet Island", data:CountryName.BVT },
				{ label:"Brazil", data:CountryName.BRA },
				{ label:"British Indian Ocean Territory", data:CountryName.IOT },
				{ label:"Brunei Darussalam", data:CountryName.BRN },
				{ label:"Bulgaria", data:CountryName.BGR },
				{ label:"Burkina Faso", data:CountryName.BFA },
				{ label:"Burundi", data:CountryName.BDI },
				{ label:"Cambodia", data:CountryName.KHM },
				{ label:"Cameroon", data:CountryName.CMR },
				{ label:"Canada", data:CountryName.CAN },
				{ label:"Cape Verde", data:CountryName.CPV },
				{ label:"Cayman Islands", data:CountryName.CYM },
				{ label:"Central African Republic", data:CountryName.CAF },
				{ label:"Chad", data:CountryName.TCD },
				{ label:"Chile", data:CountryName.CHL },
				{ label:"China", data:CountryName.CHN },
				{ label:"Christmas Island", data:CountryName.CXR },
				{ label:"Cocos (Keeling) Islands", data:CountryName.CCK },
				{ label:"Colombia", data:CountryName.COL },
				{ label:"Comoros", data:CountryName.COM },
				{ label:"Congo", data:CountryName.COG },
				{ label:"Congo, the Democratic Republic of the", data:CountryName.COD },
				{ label:"Cook Islands", data:CountryName.COK },
				{ label:"Costa Rica", data:CountryName.CRI },
				{ label:"Côte d'Ivoire", data:CountryName.CIV },
				{ label:"Croatia", data:CountryName.HRV },
				{ label:"Cuba", data:CountryName.CUB },
				{ label:"Curaçao", data:CountryName.CUW },
				{ label:"Cyprus", data:CountryName.CYP },
				{ label:"Czech Republic", data:CountryName.CZE },
				{ label:"Denmark", data:CountryName.DNK },
				{ label:"Djibouti", data:CountryName.DJI },
				{ label:"Dominica", data:CountryName.DMA },
				{ label:"Dominican Republic", data:CountryName.DOM },
				{ label:"Ecuador", data:CountryName.ECU },
				{ label:"Egypt", data:CountryName.EGY },
				{ label:"El Salvador", data:CountryName.SLV },
				{ label:"Equatorial Guinea", data:CountryName.GNQ },
				{ label:"Eritrea", data:CountryName.ERI },
				{ label:"Estonia", data:CountryName.EST },
				{ label:"Ethiopia", data:CountryName.ETH },
				{ label:"Falkland Islands (Malvinas)", data:CountryName.FLK },
				{ label:"Faroe Islands", data:CountryName.FRO },
				{ label:"Fiji", data:CountryName.FJI },
				{ label:"Finland", data:CountryName.FIN },
				{ label:"France", data:CountryName.FRA },
				{ label:"French Guiana", data:CountryName.GUF },
				{ label:"French Polynesia", data:CountryName.PYF },
				{ label:"French Southern Territories", data:CountryName.ATF },
				{ label:"Gabon", data:CountryName.GAB },
				{ label:"Gambia", data:CountryName.GMB },
				{ label:"Georgia", data:CountryName.GEO },
				{ label:"Germany", data:CountryName.DEU },
				{ label:"Ghana", data:CountryName.GHA },
				{ label:"Gibraltar", data:CountryName.GIB },
				{ label:"Greece", data:CountryName.GRC },
				{ label:"Greenland", data:CountryName.GRL },
				{ label:"Grenada", data:CountryName.GRD },
				{ label:"Guadeloupe", data:CountryName.GLP },
				{ label:"Guam", data:CountryName.GUM },
				{ label:"Guatemala", data:CountryName.GTM },
				{ label:"Guernsey", data:CountryName.GGY },
				{ label:"Guinea", data:CountryName.GIN },
				{ label:"Guinea-Bissau", data:CountryName.GNB },
				{ label:"Guyana", data:CountryName.GUY },
				{ label:"Haiti", data:CountryName.HTI },
				{ label:"Heard Island and McDonald Islands", data:CountryName.HMD },
				{ label:"Holy See (Vatican City State)", data:CountryName.VAT },
				{ label:"Honduras", data:CountryName.HND },
				{ label:"Hong Kong", data:CountryName.HKG },
				{ label:"Hungary", data:CountryName.HUN },
				{ label:"Iceland", data:CountryName.ISL },
				{ label:"India", data:CountryName.IND },
				{ label:"Indonesia", data:CountryName.IDN },
				{ label:"Iran, Islamic Republic of", data:CountryName.IRN },
				{ label:"Iraq", data:CountryName.IRQ },
				{ label:"Ireland", data:CountryName.IRL },
				{ label:"Isle of Man", data:CountryName.IMN },
				{ label:"Israel", data:CountryName.ISR },
				{ label:"Italy", data:CountryName.ITA },
				{ label:"Jamaica", data:CountryName.JAM },
				{ label:"Japan", data:CountryName.JPN },
				{ label:"Jersey", data:CountryName.JEY },
				{ label:"Jordan", data:CountryName.JOR },
				{ label:"Kazakhstan", data:CountryName.KAZ },
				{ label:"Kenya", data:CountryName.KEN },
				{ label:"Kiribati", data:CountryName.KIR },
				{ label:"Korea, Democratic People's Republic of", data:CountryName.PRK },
				{ label:"Korea, Republic of", data:CountryName.KOR },
				{ label:"Kuwait", data:CountryName.KWT },
				{ label:"Kyrgyzstan", data:CountryName.KGZ },
				{ label:"Lao People's Democratic Republic", data:CountryName.LAO },
				{ label:"Latvia", data:CountryName.LVA },
				{ label:"Lebanon", data:CountryName.LBN },
				{ label:"Lesotho", data:CountryName.LSO },
				{ label:"Liberia", data:CountryName.LBR },
				{ label:"Libyan Arab Jamahiriya", data:CountryName.LBY },
				{ label:"Liechtenstein", data:CountryName.LIE },
				{ label:"Lithuania", data:CountryName.LTU },
				{ label:"Luxembourg", data:CountryName.LUX },
				{ label:"Macao", data:CountryName.MAC },
				{ label:"Macedonia, the former Yugoslav Republic of", data:CountryName.MKD },
				{ label:"Madagascar", data:CountryName.MDG },
				{ label:"Malawi", data:CountryName.MWI },
				{ label:"Malaysia", data:CountryName.MYS },
				{ label:"Maldives", data:CountryName.MDV },
				{ label:"Mali", data:CountryName.MLI },
				{ label:"Malta", data:CountryName.MLT },
				{ label:"Marshall Islands", data:CountryName.MHL },
				{ label:"Martinique", data:CountryName.MTQ },
				{ label:"Mauritania", data:CountryName.MRT },
				{ label:"Mauritius", data:CountryName.MUS },
				{ label:"Mayotte", data:CountryName.MYT },
				{ label:"Mexico", data:CountryName.MEX },
				{ label:"Micronesia, Federated States of", data:CountryName.FSM },
				{ label:"Moldova, Republic of", data:CountryName.MDA },
				{ label:"Monaco", data:CountryName.MCO },
				{ label:"Mongolia", data:CountryName.MNG },
				{ label:"Montenegro", data:CountryName.MNE },
				{ label:"Montserrat", data:CountryName.MSR },
				{ label:"Morocco", data:CountryName.MAR },
				{ label:"Mozambique", data:CountryName.MOZ },
				{ label:"Myanmar", data:CountryName.MMR },
				{ label:"Namibia", data:CountryName.NAM },
				{ label:"Nauru", data:CountryName.NRU },
				{ label:"Nepal", data:CountryName.NPL },
				{ label:"Netherlands", data:CountryName.NLD },
				{ label:"New Caledonia", data:CountryName.NCL },
				{ label:"New Zealand", data:CountryName.NZL },
				{ label:"Nicaragua", data:CountryName.NIC },
				{ label:"Niger", data:CountryName.NER },
				{ label:"Nigeria", data:CountryName.NGA },
				{ label:"Niue", data:CountryName.NIU },
				{ label:"Norfolk Island", data:CountryName.NFK },
				{ label:"Northern Mariana Islands", data:CountryName.MNP },
				{ label:"Norway", data:CountryName.NOR },
				{ label:"Oman", data:CountryName.OMN },
				{ label:"Pakistan", data:CountryName.PAK },
				{ label:"Palau", data:CountryName.PLW },
				{ label:"Palestinian Territory, Occupied", data:CountryName.PSE },
				{ label:"Panama", data:CountryName.PAN },
				{ label:"Papua New Guinea", data:CountryName.PNG },
				{ label:"Paraguay", data:CountryName.PRY },
				{ label:"Peru", data:CountryName.PER },
				{ label:"Philippines", data:CountryName.PHL },
				{ label:"Pitcairn", data:CountryName.PCN },
				{ label:"Poland", data:CountryName.POL },
				{ label:"Portugal", data:CountryName.PRT },
				{ label:"Puerto Rico", data:CountryName.PRI },
				{ label:"Qatar", data:CountryName.QAT },
				{ label:"Réunion", data:CountryName.REU },
				{ label:"Romania", data:CountryName.ROU },
				{ label:"Russian Federation", data:CountryName.RUS },
				{ label:"Rwanda", data:CountryName.RWA },
				{ label:"Saint Barthélemy", data:CountryName.BLM },
				{ label:"Saint Helena, Ascension and Tristan da Cunha", data:CountryName.SHN },
				{ label:"Saint Kitts and Nevis", data:CountryName.KNA },
				{ label:"Saint Lucia", data:CountryName.LCA },
				{ label:"Saint Martin (French part)", data:CountryName.MAF },
				{ label:"Saint Pierre and Miquelon", data:CountryName.SPM },
				{ label:"Saint Vincent and the Grenadines", data:CountryName.VCT },
				{ label:"Samoa", data:CountryName.WSM },
				{ label:"San Marino", data:CountryName.SMR },
				{ label:"Sao Tome and Principe", data:CountryName.STP },
				{ label:"Saudi Arabia", data:CountryName.SAU },
				{ label:"Senegal", data:CountryName.SEN },
				{ label:"Serbia", data:CountryName.SRB },
				{ label:"Seychelles", data:CountryName.SYC },
				{ label:"Sierra Leone", data:CountryName.SLE },
				{ label:"Singapore", data:CountryName.SGP },
				{ label:"Sint Maarten (Dutch part)", data:CountryName.SXM },
				{ label:"Slovakia", data:CountryName.SVK },
				{ label:"Slovenia", data:CountryName.SVN },
				{ label:"Solomon Islands", data:CountryName.SLB },
				{ label:"Somalia", data:CountryName.SOM },
				{ label:"South Africa", data:CountryName.ZAF },
				{ label:"South Georgia and the South Sandwich Islands", data:CountryName.SGS },
				{ label:"Spain", data:CountryName.ESP },
				{ label:"Sri Lanka", data:CountryName.LKA },
				{ label:"Sudan", data:CountryName.SDN },
				{ label:"Suriname", data:CountryName.SUR },
				{ label:"Svalbard and Jan Mayen", data:CountryName.SJM },
				{ label:"Swaziland", data:CountryName.SWZ },
				{ label:"Sweden", data:CountryName.SWE },
				{ label:"Switzerland", data:CountryName.CHE },
				{ label:"Syrian Arab Republic", data:CountryName.SYR },
				{ label:"Taiwan, Province of China", data:CountryName.TWN },
				{ label:"Tajikistan", data:CountryName.TJK },
				{ label:"Tanzania, United Republic of", data:CountryName.TZA },
				{ label:"Thailand", data:CountryName.THA },
				{ label:"Timor-Leste", data:CountryName.TLS },
				{ label:"Togo", data:CountryName.TGO },
				{ label:"Tokelau", data:CountryName.TKL },
				{ label:"Tonga", data:CountryName.TON },
				{ label:"Trinidad and Tobago", data:CountryName.TTO },
				{ label:"Tunisia", data:CountryName.TUN },
				{ label:"Turkey", data:CountryName.TUR },
				{ label:"Turkmenistan", data:CountryName.TKM },
				{ label:"Turks and Caicos Islands", data:CountryName.TCA },
				{ label:"Tuvalu", data:CountryName.TUV },
				{ label:"Uganda", data:CountryName.UGA },
				{ label:"Ukraine", data:CountryName.UKR },
				{ label:"United Arab Emirates", data:CountryName.ARE },
				{ label:"United Kingdom", data:CountryName.GBR },
				{ label:"United States", data:CountryName.USA },
				{ label:"United States Minor Outlying Islands", data:CountryName.UMI },
				{ label:"Uruguay", data:CountryName.URY },
				{ label:"Uzbekistan", data:CountryName.UZB },
				{ label:"Vanuatu", data:CountryName.VUT },
				{ label:"Venezuela, Bolivarian Republic of", data:CountryName.VEN },
				{ label:"Viet Nam", data:CountryName.VNM },
				{ label:"Virgin Islands, British", data:CountryName.VGB },
				{ label:"Virgin Islands, U.S.", data:CountryName.VIR },
				{ label:"Wallis and Futuna", data:CountryName.WLF },
				{ label:"Western Sahara", data:CountryName.ESH },
				{ label:"Yemen", data:CountryName.YEM },
				{ label:"Zambia", data:CountryName.ZMB },
				{ label:"Zimbabwe", data:CountryName.ZWE }		
			]);
		}
	}
}