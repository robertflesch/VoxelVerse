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
	// TZD.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 08/02/2008 17:44
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 *	The <code>TZD</code> class (for Time Zone Designator) provides enumeration
	 * 	of constant objects to manipulate UTC time zone information.
	 * 	Each <code>TZD</code> constant object has the following properties:
	 * 	<ul>
	 * 		<li><code>tzd</code>, a string,</li>
	 * 		<li><code>name</code>, a string,</li>
	 * 		<li><code>location</code>, a string,</li>
	 * 		<li><code>utc</code>, a string.</li>
	 * 	</ul>
	 * 
	 * 	@see http://www.w3.org/International/core/2005/09/timezone.html
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TZD {
		
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
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new TZD
		 * 				instance.
		 */
		public function TZD() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The time zone object for the "Alpha Time Zone".
		 * 	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>A</td>
		 * 			<td>Alpha Time Zone</td>
		 * 			<td>Military</td>
		 * 			<td>UTC+0100</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const A:Object = { tzd:"A", name:"Alpha Time Zone", location:"Military", utc:"UTC+0100" };
		
		/**
		 * 	The time zone object for the "Australian Central Daylight Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>ACDT</td>
		 * 			<td>Australian Central Daylight Time</td>
		 * 			<td>Australia</td>
		 * 			<td>UTC+1030</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const ACDT:Object = { tzd:"ACDT", name:"Australian Central Daylight Time", location:"Australia", utc:"UTC+1030" };
		
		/**
		 * 	The time zone object for the "Ashmore and Cartier Islands Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>ACIT</td>
		 * 			<td>Ashmore and Cartier Islands Time</td>
		 * 			<td>Indian Ocean</td>
		 * 			<td>UTC+0800</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const ACIT:Object = { tzd:"ACIT", name:"Ashmore and Cartier Islands Time", location:"Indian Ocean", utc:"UTC+0800" };
		
		/**
		 * 	The time zone object for the "Acre Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>ACT</td>
		 * 			<td>Acre Time</td>
		 * 			<td>South America</td>
		 * 			<td>UTC-0500</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const ACT:Object = { tzd:"ACT", name:"Acre Time", location:"South America", utc:"UTC-0500" };
		
		/**
		 * 	The time zone object for the "Australian Central Standard Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>ACST</td>
		 * 			<td>Australian Central Standard Time</td>
		 * 			<td>Australia</td>
		 * 			<td>UTC+0930</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const ACST:Object = { tzd:"ACST", name:"Australian Central Standard Time", location:"Australia", utc:"UTC+0930" };
		
		/**
		 * 	The time zone object for the "Atlantic Daylight Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>ADT</td>
		 * 			<td>Atlantic Daylight Time</td>
		 * 			<td>North America</td>
		 * 			<td>UTC-0300</td>
		 * 		</tr>
		 * 	</table></p>
		 * 	<p><strong>Note:</strong> this TDZ overwrite the "Arabia Daylight Time" TDZ.</p>
		 */
		public static const ADT:Object = { tzd:"ADT", name:"Atlantic Daylight Time", location:"North America", utc:"UTC-0300" };
		//public static const ADT:Object = { tzd:"ADT", name:"Arabia Daylight Time", location:"", utc:"UTC+0400" };
		
		/**
		 * 	The time zone object for the "Australian Eastern Daylight Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>AEDT</td>
		 * 			<td>Australian Eastern Daylight Time</td>
		 * 			<td>Australia</td>
		 * 			<td>UTC+1100</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const AEDT:Object = { tzd:"AEDT", name:"Australian Eastern Daylight Time", location:"Australia", utc:"UTC+1100" };
		
		/**
		 * 	The time zone object for the "Australian Eastern Standard Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>AEST</td>
		 * 			<td>Australian Eastern Standard Time</td>
		 * 			<td>Australia</td>
		 * 			<td>UTC+1000</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const AEST:Object = { tzd:"AEST", name:"Australian Eastern Standard Time", location:"Australia", utc:"UTC+1000" };
		
		/**
		 * 	The time zone object for the "Afghanistan Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>AFT</td>
		 * 			<td>Afghanistan Time</td>
		 * 			<td>Asia</td>
		 * 			<td>UTC+0430</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const AFT:Object = { tzd:"AFT", name:"Afghanistan Time", location:"Asia", utc:"UTC+0430" };
		
		/**
		 * 	The time zone object for the "Alaska Daylight Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>AKDT</td>
		 * 			<td>Alaska Daylight Time</td>
		 * 			<td>North America</td>
		 * 			<td>UTC-0800</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const AKDT:Object = { tzd:"AKDT", name:"Alaska Daylight Time", location:"North America", utc:"UTC-0800" };
		
		/**
		 * 	The time zone object for the "Alaska Standard Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>AKST</td>
		 * 			<td>Alaska Standard Time</td>
		 * 			<td>North America</td>
		 * 			<td>UTC-0900</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const AKST:Object = { tzd:"AKST", name:"Alaska Standard Time", location:"North America", utc:"UTC-0900" };
		
		/**
		 * 	The time zone object for the "Armenia Daylight Time".
		 *	<p>This object has the following properties:
		 * 	<table class="innertable"> 
		 * 		<tr>
		 * 			<th>tzd</th>
		 * 			<th>name</th>
		 * 			<th>location</th>
		 * 			<th>utc</th>
		 * 		</tr> 
		 * 		<tr>
		 * 			<td>AMDT</td>
		 * 			<td>Armenia Daylight Time</td>
		 * 			<td>Asia</td>
		 * 			<td>UTC+0500</td>
		 * 		</tr>
		 * 	</table></p>
		 */
		public static const AMDT:Object = { tzd:"AMDT", name:"Armenia Daylight Time", location:"Asia", utc:"UTC+0500" };
		
		//public static const AMST:Object = { tzd:"AMST", name:"Amazon Standard Time", location:"", utc:"UTC-0300" };
		public static const AMST:Object = { tzd:"AMST", name:"Armenia Standard Time", location:"", utc:"UTC+0400" };
		
		
		public static const AMT:Object = { tzd:"AMT", name:"Amazon Time", location:"", utc:"UTC-0400" };
		public static const ANAST:Object = { tzd:"ANAST", name:"Anadyr' Summer Time", location:"", utc:"UTC+1300" };
		public static const ANAT:Object = { tzd:"ANAT", name:"Anadyr' Time", location:"", utc:"UTC+1200" };
		public static const ART:Object = { tzd:"ART", name:"Argentina Time", location:"", utc:"UTC-0300" };
		public static const ARDT:Object = { tzd:"ARDT", name:"Argentina Daylight Time", location:"", utc:"UTC-0200" };
		//public static const AST:Object = { tzd:"AST", name:"Al Manamah Standard Time", location:"", utc:"UTC+0300" };
		//public static const AST:Object = { tzd:"AST", name:"Arabia Standard Time", location:"", utc:"UTC+0300" };
		//public static const AST:Object = { tzd:"AST", name:"Arabic Standard Time", location:"", utc:"UTC+0300" };
		public static const AST:Object = { tzd:"AST", name:"Atlantic Standard Time", location:"North America", utc:"UTC-0400" };
		public static const ACWDT:Object = { tzd:"ACWDT", name:"Australian Central Western Daylight Time", location:"", utc:"UTC+0945" };
		public static const ACWST:Object = { tzd:"ACWST", name:"Australian Central Western Standard Time", location:"", utc:"UTC+0845" };
		public static const AWDT:Object = { tzd:"AWDT", name:"Australian Western Daylight Time", location:"Australia", utc:"UTC+0900" };
		public static const AWST:Object = { tzd:"AWST", name:"Australian Western Standard Time", location:"Australia", utc:"UTC+0800" };
		public static const AZODT:Object = { tzd:"AZODT", name:"Azores Daylight Time", location:"", utc:"UTC+0000" };
		public static const AZOST:Object = { tzd:"AZOST", name:"Azores Standard Time", location:"", utc:"UTC-0100" };
		public static const AZST:Object = { tzd:"AZST", name:"Azerbaijan Summer Time", location:"", utc:"UTC+0500" };
		public static const AZT:Object = { tzd:"AZT", name:"Azerbaijan Time", location:"", utc:"UTC+0400" };
		public static const B:Object = { tzd:"B", name:"Bravo Time Zone", location:"Military", utc:"UTC+0200" };
		public static const BNT:Object = { tzd:"BNT", name:"Brunei Darussalam Time", location:"Asia", utc:"UTC+0800" };
		public static const BIT:Object = { tzd:"BIT", name:"Baker Island Time", location:"", utc:"UTC-1200" };
		//public static const BDT:Object = { tzd:"BDT", name:"Bangladesh Time", location:"", utc:"UTC+0600" };
		public static const BDT:Object = { tzd:"BDT", name:"Brunei Time", location:"", utc:"UTC+0800" };
		public static const BIOT:Object = { tzd:"BIOT", name:"British Indian Ocean Time", location:"", utc:"UTC+0600" };
		public static const BOT:Object = { tzd:"BOT", name:"Bolivia Time", location:"", utc:"UTC-0400" };
		public static const BRST:Object = { tzd:"BRST", name:"Brazilia Summer Time", location:"", utc:"UTC-0200" };
		public static const BRT:Object = { tzd:"BRT", name:"Brazilia Time", location:"", utc:"UTC-0300" };
		public static const BST:Object = { tzd:"BST", name:"British Summer Time", location:"Europe", utc:"UTC+0100" };
		public static const BTT:Object = { tzd:"BTT", name:"Bhutan Time", location:"", utc:"UTC+0600" };
		public static const C:Object = { tzd:"C", name:"Charlie Time Zone", location:"Military", utc:"UTC+0300" };
		public static const CAST:Object = { tzd:"CAST", name:"Chinese Antarctic Standard Time", location:"", utc:"UTC+0500" };
		public static const CAT:Object = { tzd:"CAT", name:"Central Africa Time", location:"", utc:"UTC+0200" };
		public static const CCT:Object = { tzd:"CCT", name:"Cocos Islands Time", location:"", utc:"UTC+0630" };
		public static const CDT:Object = { tzd:"CDT", name:"Central Daylight Time", location:"North America", utc:"UTC-0500" };
		//public static const CDT:Object = { tzd:"CDT", name:"Central Daylight Time", location:"Australia", utc:"UTC+1030" };
		public static const CEDT:Object = { tzd:"CEDT", name:"Central European Daylight Time", location:"Europe", utc:"UTC+0200" };
		public static const CET:Object = { tzd:"CET", name:"Central European Time", location:"Europe", utc:"UTC+0100" };
		public static const CEST:Object = { tzd:"CEST", name:"Central European Summer Time", location:"Europe", utc:"UTC+0200" };
		public static const CGST:Object = { tzd:"CGST", name:"Central Greenland Summer Time", location:"", utc:"UTC-0200" };
		public static const CGT:Object = { tzd:"CGT", name:"Central Greenland Time", location:"", utc:"UTC-0300" };
		public static const CHADT:Object = { tzd:"CHADT", name:"Chatham Island Daylight Time", location:"", utc:"UTC+1345" };
		public static const CHAST:Object = { tzd:"CHAST", name:"Chatham Island Standard Time", location:"", utc:"UTC+1245" };
		public static const ChST:Object = { tzd:"ChST", name:"Chamorro Standard Time", location:"", utc:"UTC+1000" };
		public static const CIST:Object = { tzd:"CIST", name:"Clipperton Island Standard Time", location:"", utc:"UTC-0800" };
		public static const CKT:Object = { tzd:"CKT", name:"Cook Island Time", location:"", utc:"UTC-1000" };
		public static const CLDT:Object = { tzd:"CLDT", name:"Chile Daylight Time", location:"", utc:"UTC-0300" };
		public static const CLST:Object = { tzd:"CLST", name:"Chile Standard Time", location:"", utc:"UTC-0400" };
		public static const COT:Object = { tzd:"COT", name:"Colombia Time", location:"", utc:"UTC-0500" };
		//public static const CST:Object = { tzd:"CST", name:"Central Summer Time", location:"Australia", utc:"UTC+1030" };
		//public static const CST:Object = { tzd:"CST", name:"Central Standard Time", location:"Australia", utc:"UTC+0930" };
		public static const CST:Object = { tzd:"CST", name:"Central Standard Time", location:"North America", utc:"UTC-0600" };
		public static const CVT:Object = { tzd:"CVT", name:"Cape Verde Time", location:"", utc:"UTC-0100" };
		public static const CXT:Object = { tzd:"CST", name:"Christmas Island Time", location:"Australia", utc:"UTC+0700" };
		public static const D:Object = { tzd:"D", name:"Delta Time Zone", location:"Military", utc:"UTC+0400" };
		public static const DAVT:Object = { tzd:"DAVT", name:"Davis Time", location:"", utc:"UTC+0700" };
		public static const DTAT:Object = { tzd:"DTAT", name:"District de Terre Adélie Time", location:"", utc:"UTC+1000" };
		public static const E:Object = { tzd:"E", name:"Echo Time Zone", location:"Military", utc:"UTC+0500" };
		public static const EADT:Object = { tzd:"EADT", name:"Easter Island Daylight Time", location:"", utc:"UTC-0500" };
		public static const EAST:Object = { tzd:"EAST", name:"Easter Island Standard Time", location:"", utc:"UTC-0600" };
		public static const EAT:Object = { tzd:"EAT", name:"East Africa Time", location:"", utc:"UTC+0300" };
		public static const ECT:Object = { tzd:"ECT", name:"Ecuador Time", location:"", utc:"UTC-0500" };
		//public static const EDT:Object = { tzd:"EDT", name:"Eastern Daylight Time", location:"Australia", utc:"UTC+1100" };
		public static const EDT:Object = { tzd:"EDT", name:"Eastern Daylight Time", location:"North America", utc:"UTC-0400" };
		public static const EEDT:Object = { tzd:"EEDT", name:"Eastern European Daylight Time", location:"Europe", utc:"UTC+0300" };
		public static const EEST:Object = { tzd:"EEST", name:"Eastern European Summer Time", location:"Europe", utc:"UTC+0300" };
		public static const EET:Object = { tzd:"EET", name:"Eastern European Time", location:"Europe", utc:"UTC+0200" };
		public static const EGT:Object = { tzd:"EGT", name:"Eastern Greenland Time", location:"", utc:"UTC-0100" };
		public static const EGST:Object = { tzd:"EGST", name:"Eastern Greenland Summer Time", location:"", utc:"UTC+0000" };
		public static const EKST:Object = { tzd:"EKST", name:"East Kazakhstan Standard Time", location:"", utc:"UTC+0600" };
		public static const EIT:Object = { tzd:"EIT", name:"Estearn Indonesia Time", location:"Asia", utc:"UTC+0900" };
		//public static const EST:Object = { tzd:"EST", name:"Eastern Summer Time", location:"Australia", utc:"UTC+1100" };
		//public static const EST:Object = { tzd:"EST", name:"Eastern Standard Time", location:"Australia", utc:"UTC+1000" };
		public static const EST:Object = { tzd:"EST", name:"Eastern Standard Time", location:"North America", utc:"UTC-0500" };
		public static const F:Object = { tzd:"F", name:"Foxtrot Time Zone", location:"Military", utc:"UTC+0600" };
		public static const FJT:Object = { tzd:"FJT", name:"Fiji Time", location:"", utc:"UTC+1200" };
		public static const FKDT:Object = { tzd:"FKDT", name:"Falkland Island Daylight Time", location:"", utc:"UTC-0300" };
		public static const FKST:Object = { tzd:"FKST", name:"Falkland Island Standard Time", location:"", utc:"UTC-0400" };
		public static const FNT:Object = { tzd:"FNT", name:"Fernando de Noronha Time", location:"", utc:"UTC-0200" };
		public static const G:Object = { tzd:"G", name:"Golf Time Zone", location:"Military", utc:"UTC+0700" };
		public static const GALT:Object = { tzd:"GALT", name:"Galapagos Time", location:"", utc:"UTC-0600" };
		public static const GET:Object = { tzd:"GET", name:"Georgia Standard Time", location:"", utc:"UTC+0400" };
		public static const GFT:Object = { tzd:"GFT", name:"French Guiana Time", location:"", utc:"UTC-0300" };
		public static const GILT:Object = { tzd:"GILT", name:"Gilbert Island Time", location:"", utc:"UTC+1200" };
		public static const GIT:Object = { tzd:"GIT", name:"Gambier Island Time", location:"", utc:"UTC-0900" };
		public static const GMT:Object = { tzd:"GMT", name:"Greenwich Mean Time", location:"Europe", utc:"UTC+0000" };
		//public static const GST:Object = { tzd:"GST", name:"Gulf Standard Time", location:"", utc:"UTC+0400" };
		//public static const GST:Object = { tzd:"GST", name:"South Georgia and the South Sandwich Islands", location:"", utc:"UTC-0200" };
		public static const GST:Object = { tzd:"GST", name:"Guam Standard Time", location:"", utc:"UTC+1000" };
		public static const GYT:Object = { tzd:"GYT", name:"Guyana Time", location:"", utc:"UTC-0400" };
		public static const H:Object = { tzd:"GMT", name:"Hotel Time Zone", location:"Military", utc:"UTC+0800" };
		public static const HAA:Object = { tzd:"HAA", name:"Heure Avancée de l'Atlantique", location:"North America", utc:"UTC-0300" };
		public static const HAC:Object = { tzd:"HAC", name:"Heure Avancée du Centre", location:"North America", utc:"UTC-0500" };
		public static const HADT:Object = { tzd:"HADT", name:"Hawaii-Aleutian Daylight Time", location:"North America", utc:"UTC-0900" };
		public static const HAE:Object = { tzd:"HAE", name:"Heure Avancée de l'Est", location:"North America", utc:"UTC-0400" };
		public static const HAP:Object = { tzd:"HAP", name:"Heure Avancée du Pacifique", location:"North America", utc:"UTC-0700" };
		public static const HAR:Object = { tzd:"HAR", name:"Heure Avancée des Rocheuses", location:"North America", utc:"UTC-0600" };
		public static const HAST:Object = { tzd:"HAST", name:"Hawaii-Aleutian Standard Time", location:"North America", utc:"UTC-1000" };
		public static const HAT:Object = { tzd:"HAT", name:"Heure Avancée de Terre-Neuve", location:"North America", utc:"UTC-0230" };
		public static const HAY:Object = { tzd:"HAY", name:"Heure Avancée du Yukon", location:"North America", utc:"UTC-0800" };
		public static const HKST:Object = { tzd:"HKST", name:"Hong Kong Standard Time", location:"", utc:"UTC+0800" };
		public static const HNA:Object = { tzd:"HNA", name:"Heure Normale de l'Atlantique", location:"North America", utc:"UTC-0400" };
		public static const HNC:Object = { tzd:"HNC", name:"Heure Normale du Centre", location:"North America", utc:"UTC-0600" };
		public static const HNE:Object = { tzd:"HNE", name:"Heure Normale de l'Est", location:"North America", utc:"UTC-0500" };
		public static const HNP:Object = { tzd:"HNP", name:"Heure Normale du Pacifique", location:"North America", utc:"UTC-0800" };
		public static const HNR:Object = { tzd:"HNR", name:"Heure Normale des Rocheuses", location:"North America", utc:"UTC-0700" };
		public static const HNT:Object = { tzd:"HNT", name:"Heure Normale de Terre-Neuve", location:"North America", utc:"UTC-0330" };
		public static const HNY:Object = { tzd:"HNY", name:"Heure Normale du Yukon", location:"North America", utc:"UTC-0900" };
		public static const HMT:Object = { tzd:"HMT", name:"Heard and McDonald Islands Time", location:"", utc:"UTC+0500" };
		public static const I:Object = { tzd:"I", name:"India Time Zone", location:"Military", utc:"UTC+0900" };
		//public static const ICT:Object = { tzd:"ICT", name:"Îles Crozet Time", location:"", utc:"UTC+0400" };
		public static const ICT:Object = { tzd:"ICT", name:"Indochina Time", location:"Asia", utc:"UTC+0700" };
		public static const IDLE:Object = { tzd:"IDLE", name:"Internation Date Line East", location:"", utc:"UTC+1200" };
		

		public static const IDT:Object = { tzd:"IDT", name:"Ireland Daylight Time", location:"Europe", utc:"UTC+0100" };
		//public static const IDT:Object = { tzd:"IDT", name:"Israel Daylight Time", location:"", utc:"UTC+0300" };
		public static const IRKST:Object = { tzd:"IRKST", name:"Irkutsk Summer Time", location:"", utc:"UTC+0900" };
		public static const IRKT:Object = { tzd:"IRKT", name:"Irkutsk Time", location:"", utc:"UTC+0800" };
		public static const IRT:Object = { tzd:"IRT", name:"Îran Time", location:"Asia", utc:"UTC+0330" };
		public static const IRDT:Object = { tzd:"IRDT", name:"Îran Daylight Time", location:"Asia", utc:"UTC+0430" };
		public static const IRST:Object = { tzd:"IRST", name:"Îran Standard Time", location:"Asia", utc:"UTC+0330" };
		//public static const IST:Object = { tzd:"IST", name:"Irish Summer Time", location:"Europe", utc:"UTC+0100" };
		//public static const IST:Object = { tzd:"IST", name:"Indian Standard Time", location:"", utc:"UTC+0530" };
		public static const IST:Object = { tzd:"IST", name:"Ireland Standard Time", location:"Europe", utc:"UTC+0000" };
		//public static const IST:Object = { tzd:"IST", name:"Israel Standard Time", location:"", utc:"UTC+0200" };
		public static const JFDT:Object = { tzd:"JFDT", name:"Juan Fernandez Islands Daylight Time", location:"", utc:"UTC-0300" };
		public static const JFST:Object = { tzd:"JFST", name:"Juan Fernandez Islands Standard Time", location:"", utc:"UTC-0400" };
		public static const JST:Object = { tzd:"JST", name:"Japan Standard Time", location:"", utc:"UTC+0900" };
		public static const K:Object = { tzd:"K", name:"Kilo Time Zone", location:"Military", utc:"UTC+1000" };
		public static const KGST:Object = { tzd:"KGST", name:"Kyrgyzstan Summer Time", location:"Asia", utc:"UTC+0600" };
		public static const KGT:Object = { tzd:"KGT", name:"Kyrgyzstan Time", location:"Asia", utc:"UTC+0500" };
		public static const KRAST:Object = { tzd:"KRAST", name:"Krasnoyarsk Summer Time", location:"Asia", utc:"UTC+0800" };
		public static const KRAT:Object = { tzd:"KRAT", name:"Krasnoyarsk Time Zone", location:"Asia", utc:"UTC+0700" };
		public static const KOST:Object = { tzd:"KOST", name:"Kosrae Standard Time", location:"", utc:"UTC+1100" };
		public static const KOVT:Object = { tzd:"KOVT", name:"Khovd Time", location:"", utc:"UTC+0700" };
		public static const KOVST:Object = { tzd:"KOVST", name:"Khovd Summer Time", location:"", utc:"UTC+0800" };
		public static const KST:Object = { tzd:"KST", name:"Korea Standard Time", location:"Asia", utc:"UTC+0900" };
		public static const L:Object = { tzd:"L", name:"Lima Time Zone", location:"Military", utc:"UTC+1100" };
		public static const LHDT:Object = { tzd:"LHDT", name:"Lord Howe Daylight Time", location:"", utc:"UTC+1100" };
		public static const LHST:Object = { tzd:"LHST", name:"Lord Howe Standard Time", location:"", utc:"UTC+1030" };
		public static const LINT:Object = { tzd:"LINT", name:"Line Island Time", location:"", utc:"UTC+1400" };
		public static const LKT:Object = { tzd:"LKT", name:"Sri Lanka Time", location:"Asia", utc:"UTC+0600" };
		public static const M:Object = { tzd:"M", name:"Mike Time Zone", location:"Military", utc:"UTC+1200" };
		public static const MAGST:Object = { tzd:"MAGST", name:"Magadan Island Summer Time", location:"", utc:"UTC+1200" };
		public static const MAGT:Object = { tzd:"MAGT", name:"Magadan Island Time", location:"", utc:"UTC+1100" };
		public static const MDT:Object = { tzd:"MDT", name:"Mountain Daylight Time", location:"North America", utc:"UTC-0600" };
		public static const MESZ:Object = { tzd:"MESZ", name:"Mitteleuroäische Sommerzeit", location:"Europe", utc:"UTC+0200" };
		public static const MEZ:Object = { tzd:"MEZ", name:"Mitteleuropäische Zeit", location:"Europe", utc:"UTC+0100" };
		public static const MIT:Object = { tzd:"MIT", name:"Marquesas Islands Time", location:"", utc:"UTC-0930" };
		public static const MHT:Object = { tzd:"MHT", name:"Marshall Islands Time", location:"", utc:"UTC+1200" };
		public static const MAWT:Object = { tzd:"MAWT", name:"Mawson Time", location:"", utc:"UTC+0600" };
		public static const MNST:Object = { tzd:"MNST", name:"Mongolia Summer Time", location:"Asia", utc:"UTC+0900" };
		public static const MMT:Object = { tzd:"MMT", name:"Myanmar Time", location:"Asia", utc:"UTC+0630" };
		//public static const MNT:Object = { tzd:"MNT", name:"Mongolia Time", location:"Asia", utc:"UTC+0800" };
		public static const MSDT:Object = { tzd:"MSDT", name:"Moscow Daylight Time", location:"Europe", utc:"UTC+0400" };
		public static const MSK:Object = { tzd:"MSK", name:"Moskow Standard Time", location:"Europe", utc:"UTC+0300" };
		public static const MSST:Object = { tzd:"MSST", name:"Moscow Standard Time", location:"Europe", utc:"UTC+0300" };
		public static const MST:Object = { tzd:"MST", name:"Mountain Standard Time", location:"North America", utc:"UTC-0700" };
		//public static const MUT:Object = { tzd:"MUT", name:"Mauritius Time", location:"", utc:"UTC+0400" };
		//public static const MVT:Object = { tzd:"MVT", name:"Maldives Time", location:"", utc:"UTC+0500" };
		public static const MYT:Object = { tzd:"MYT", name:"Malaysia Time", location:"Asia", utc:"UTC+0800" };
		public static const N:Object = { tzd:"N", name:"November Time Zone", location:"Military", utc:"UTC-0100" };
		public static const NCT:Object = { tzd:"NCT", name:"New Caledonia Time", location:"", utc:"UTC+1100" };
		public static const NDT:Object = { tzd:"NDT", name:"Newfoundland Daylight Time", location:"North America", utc:"UTC-0230" };
		public static const NFT:Object = { tzd:"NFT", name:"Norfolk (Island) Time", location:"Australia", utc:"UTC+1130" };
		public static const NPT:Object = { tzd:"NPT", name:"Nepal Time", location:"", utc:"UTC+0545" };
		public static const NRT:Object = { tzd:"NRT", name:"Nauru Time", location:"", utc:"UTC+1200" };
		public static const NOVST:Object = { tzd:"NOVST", name:"Novosibirsk Summer Time", location:"Asia", utc:"UTC+0700" };
		public static const NOVT:Object = { tzd:"NOVT", name:"Novosibirsk Time", location:"Asia", utc:"UTC+0600" };
		public static const NST:Object = { tzd:"NST", name:"Newfoundland Standard Time", location:"North America", utc:"UTC-0330" };
		public static const NUT:Object = { tzd:"NUT", name:"Niue Time", location:"", utc:"UTC-1100" };
		public static const NZDT:Object = { tzd:"NZDT", name:"New Zealand Daylight Time", location:"", utc:"UTC+1300" };
		public static const NZST:Object = { tzd:"NZST", name:"New Zealand Standard Time", location:"", utc:"UTC+1200" };
		public static const O:Object = { tzd:"O", name:"Oscar Time Zone", location:"Military", utc:"UTC-0200" };
		public static const OMSST:Object = { tzd:"OMSST", name:"Omsk Summer Time", location:"Asia", utc:"UTC+0700" };
		public static const OMST:Object = { tzd:"OMST", name:"Omsk Time Zone", location:"Asia", utc:"UTC+0600" };
		public static const P:Object = { tzd:"P", name:"Papa Time Zone", location:"Military", utc:"UTC-0300" };
		public static const PDT:Object = { tzd:"PDT", name:"Pacific Daylight Time", location:"North America", utc:"UTC-0700" };
		public static const PETST:Object = { tzd:"PETST", name:"Petropavlovsk Summer Time", location:"", utc:"UTC+1300" };
		public static const PET:Object = { tzd:"PET", name:"Peru Time", location:"", utc:"UTC-0500" };
		public static const PETT:Object = { tzd:"PETT", name:"Petropavlovsk Time", location:"", utc:"UTC+1200" };
		public static const PGT:Object = { tzd:"PGT", name:"Papua New Guinea Time", location:"", utc:"UTC+1000" };
		public static const PHOT:Object = { tzd:"PHOT", name:"Phoenix Island Time", location:"", utc:"UTC+1300" };
		public static const PHT:Object = { tzd:"PHT", name:"Philippines Time", location:"", utc:"UTC+0800" };
		//public static const PIT:Object = { tzd:"PIT", name:"Paracel Islands Time", location:"", utc:"UTC+0800" };
		public static const PIT:Object = { tzd:"PIT", name:"Peter Island Time", location:"", utc:"UTC-0600" };
		public static const PKT:Object = { tzd:"PKT", name:"Pakistan Time", location:"", utc:"UTC+0500" };
		public static const PMDT:Object = { tzd:"PMDT", name:"Pierre & Miquelon Daylight Time", location:"", utc:"UTC-0200" };
		public static const PMST:Object = { tzd:"PMST", name:"Pierre & Miquelon Standard Time", location:"", utc:"UTC-0300" };
		public static const PONT:Object = { tzd:"PONT", name:"Pohnpei Standard Time", location:"", utc:"UTC+1100" };
		public static const PST:Object = { tzd:"PST", name:"Pacific Standard Time", location:"North America", utc:"UTC-0800" };
		//public static const PST:Object = { tzd:"PST", name:"Pitcairn Standard Time", location:"", utc:"UTC-0800" };
		public static const PWT:Object = { tzd:"PWT", name:"Palau Time", location:"", utc:"UTC+0900" };
		public static const PYST:Object = { tzd:"PYST", name:"Paraguay Summer Time", location:"", utc:"UTC-0300" };
		public static const PYT:Object = { tzd:"PYT", name:"Paraguay Time", location:"", utc:"UTC-0400" };
		public static const Q:Object = { tzd:"Q", name:"Quebec Time Zone", location:"Military", utc:"UTC-0400" };
		public static const R:Object = { tzd:"R", name:"Romeo Time Zone", location:"Military", utc:"UTC-0500" };
		public static const RET:Object = { tzd:"RET", name:"Réunion Time", location:"", utc:"UTC+0400" };
		public static const ROTT:Object = { tzd:"ROTT", name:"Rothera Time", location:"", utc:"UTC-0300" };
		public static const S:Object = { tzd:"S", name:"Sierra Time Zone", location:"Military", utc:"UTC-0600" };
		public static const SAKT:Object = { tzd:"SAKT", name:"Sakhalin Island Time", location:"Asia", utc:"UTC+1000" };
		public static const SAMST:Object = { tzd:"SAMST", name:"Samara Summer Time", location:"Europe", utc:"UTC+0500" };
		public static const SAMT:Object = { tzd:"SAMT", name:"Samara Time", location:"Europe", utc:"UTC+0400" };
		public static const SAST:Object = { tzd:"SAST", name:"South Africa Standard Time", location:"", utc:"UTC+0200" };
		public static const SBT:Object = { tzd:"SBT", name:"Solomon Island Time", location:"", utc:"UTC+1100" };
		public static const SCDT:Object = { tzd:"SCDT", name:"Santa Claus Delivery Time", location:"", utc:"UTC+1300" };
		public static const SCST:Object = { tzd:"SCST", name:"Santa Claus Standard Time", location:"", utc:"UTC+1200" };
		public static const SCT:Object = { tzd:"SCT", name:"Seychelles Time", location:"", utc:"UTC+0400" };
		public static const SEST:Object = { tzd:"SEST", name:"Swedish Standard Time", location:"", utc:"UTC+0100" };
		public static const SGT:Object = { tzd:"SGT", name:"Singapore Time", location:"", utc:"UTC+0800" };
		public static const SIT:Object = { tzd:"SIT", name:"Spratly Islands Time", location:"", utc:"UTC+0800" };
		public static const SLT:Object = { tzd:"SLT", name:"Sierra Leone Time", location:"", utc:"UTC+0000" };
		public static const SRT:Object = { tzd:"SRT", name:"Suriname Time", location:"", utc:"UTC-0300" };
		public static const SST:Object = { tzd:"SST", name:"Samoa Standard Time", location:"", utc:"UTC-1100" };
		public static const SYST:Object = { tzd:"SYST", name:"Syrian Summer Time", location:"", utc:"UTC+0300" };
		public static const SYT:Object = { tzd:"SYT", name:"Syrian Standard Time", location:"", utc:"UTC+0200" };
		public static const T:Object = { tzd:"T", name:"Tango Time Zone", location:"Military", utc:"UTC-0700" };
		public static const TAHT:Object = { tzd:"TAHT", name:"Tahiti Time", location:"", utc:"UTC-1000" };
		public static const TFT:Object = { tzd:"TFT", name:"French Southern and Antarctic Time", location:"", utc:"UTC+0500" };
		public static const TJT:Object = { tzd:"TJT", name:"Tajikistan Time", location:"Asia", utc:"UTC+0500" };
		public static const TKT:Object = { tzd:"TKT", name:"Tokelau Time", location:"", utc:"UTC-1000" };
		public static const TMT:Object = { tzd:"TMT", name:"Turkmenistan Time", location:"Asia", utc:"UTC+0500" };
		public static const TOT:Object = { tzd:"TOT", name:"Tonga Time", location:"", utc:"UTC+1300" };
		public static const TPT:Object = { tzd:"TPT", name:"East Timor Time", location:"", utc:"UTC+0900" };
		public static const TRUT:Object = { tzd:"TRUT", name:"Truk Time", location:"", utc:"UTC+1000" };
		public static const TVT:Object = { tzd:"TVT", name:"Tuvalu Time", location:"", utc:"UTC+1200" };
		public static const TWT:Object = { tzd:"TWT", name:"Taiwan Time", location:"Asia", utc:"UTC+0800" };
		public static const U:Object = { tzd:"U", name:"Uniform Time Zone", location:"Military", utc:"UTC-0800" };
		public static const ULAT:Object = { tzd:"ULAT", name:"Ulaanbaatar Time", location:"Asia", utc:"UTC+0800" };
		public static const UT:Object = { tzd:"UT", name:"Universal Time", location:"Europe", utc:"UTC+0000" };
		public static const UTC:Object = { tzd:"UTC", name:"Universal Coordinated Time", location:"Europe", utc:"UTC+0000" };
		public static const UYT:Object = { tzd:"UYT", name:"Uruguay Standard Time", location:"", utc:"UTC-0300" };
		public static const UYST:Object = { tzd:"UYST", name:"Uruguay Summer Time", location:"", utc:"UTC-0200" };
		public static const UZT:Object = { tzd:"UZT", name:"Uzbekistan Time", location:"", utc:"UTC+0500" };
		public static const V:Object = { tzd:"V", name:"Victor Time Zone", location:"Military", utc:"UTC-0900" };
		public static const VLAST:Object = { tzd:"VLAST", name:"Vladivostok Summer Time", location:"", utc:"UTC+1100" };
		public static const VLAT:Object = { tzd:"VLAT", name:"Vladivostok Time", location:"", utc:"UTC+1000" };
		public static const VOST:Object = { tzd:"VOST", name:"Vostok Time", location:"", utc:"UTC+0600" };
		public static const VST:Object = { tzd:"VST", name:"Venezuela Standard Time", location:"", utc:"UTC-0430" };
		public static const VUT:Object = { tzd:"VUT", name:"Vanuatu Time", location:"", utc:"UTC+1100" };
		public static const W:Object = { tzd:"W", name:"Whiskey Time Zone", location:"Military", utc:"UTC-1000" };
		public static const WAST:Object = { tzd:"WAST", name:"West Africa Summer Time", location:"Africa", utc:"UTC+0200" };
		public static const WAT:Object = { tzd:"WAT", name:"Western Africa Time", location:"", utc:"UTC+0100" };
		public static const WEST:Object = { tzd:"WEST", name:"Western Europe Summer Time", location:"Europe", utc:"UTC+0100" };
		public static const WET:Object = { tzd:"WET", name:"Western Europe Time", location:"Europe", utc:"UTC+0000" };
		public static const WFT:Object = { tzd:"WFT", name:"Wallis and Futuna Time", location:"", utc:"UTC+1200" };
		public static const WKST:Object = { tzd:"WKST", name:"West Kazakhstan Standard Time", location:"", utc:"UTC+0500" };
		public static const WDT:Object = { tzd:"WDT", name:"Western Australia Daylight Time", location:"Australia", utc:"UTC+0900" };
		public static const WEDT:Object = { tzd:"WEDT", name:"Western European Daylight Time", location:"Europe", utc:"UTC+0100" };
		//public static const WST:Object = { tzd:"WST", name:"Western Summer Time", location:"Australia", utc:"UTC+0900" };
		public static const WST:Object = { tzd:"WST", name:"Western Standard Time", location:"Australia", utc:"UTC+0800" };
		public static const WIB:Object = { tzd:"WIB", name:"Waktu Indonesia Bagian Barat", location:"", utc:"UTC+0700" };
		public static const WITA:Object = { tzd:"WITA", name:"Waktu Indonesia Bagian Tengah", location:"Asia", utc:"UTC+0800" };
		public static const WIT:Object = { tzd:"WIT", name:"Waktu Indonesia Bagian Timur", location:"Asia", utc:"UTC+0900" };
		public static const X:Object = { tzd:"X", name:"X-ray Time Zone", location:"Military", utc:"UTC-1100" };
		public static const Y:Object = { tzd:"Y", name:"Yankee Time Zone", location:"Military", utc:"UTC-1200" };
		public static const YAKST:Object = { tzd:"YAKST", name:"Yakutsk Summer Time", location:"", utc:"UTC+1000" };
		public static const YAKT:Object = { tzd:"YAKT", name:"Yakutsk Time", location:"", utc:"UTC+0900" };
		public static const YAPT:Object = { tzd:"YAPT", name:"Yap Time", location:"", utc:"UTC+1000" };
		public static const YEKST:Object = { tzd:"YEKST", name:"Yekaterinburg Summer Time", location:"Asia", utc:"UTC+0600" };
		public static const YEKT:Object = { tzd:"YEKT", name:"Yekaterinburg Time", location:"Asia", utc:"UTC+0500" };
		public static const Z:Object = { tzd:"Z", name:"Zulu Time Zone", location:"Military", utc:"UTC+0000" };
	}
}