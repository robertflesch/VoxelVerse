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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// DateUtil.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 17/11/2011 10:53
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.ComparisonResult;
	import org.flashapi.swing.constants.TZD;
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>DateUtil</code> class is a utility class that defines all-static
	 * 	methods for working with UTC offset based on time zone designation codes.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DateUtil {
		
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
		 * 				DateUtil instance.
		 */
		public function DateUtil() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Compares two <code>Date</code> objects and returns the <code>ComparisonResult</code>
		 * 	constant, depending on the comparison result.
		 * 
		 * 	@param	date1	The first date to compare.
		 * 	@param	date2	The second date to compare.
		 * 
		 * 	@return <code>ComparisonResult.FIRST_VALUE_IS_GREATER</code> if <code>date1</code>
		 * 			is greater than <code>date2</code>; <code>ComparisonResult.SECOND_VALUE_IS_GREATER</code>
		 * 			if <code>date2</code> is greater than <code>date1</code>;
		 * 			<code>ComparisonResult.VALUES_ARE_EQUALS</code> both dates are equal.
		 * 
		 * 	@see org.flashapi.swing.constants.ComparisonResult
		 */
		public function compare(date1:Date, date2:Date):int {
			var time1:Number = date1.getTime();
			var time2:Number = date2.getTime();
			var result:Number;
			if (time1 < time2) result = ComparisonResult.SECOND_VALUE_IS_GREATER;
			else if (time1 == time2) result = ComparisonResult.VALUES_ARE_EQUALS;
			else if (time1 > time2) result = ComparisonResult.FIRST_VALUE_IS_GREATER;
			return result;
		}
		
		/**
		 * 	Returns UTC offset based on time zone designation code (TZD).
		 * 	Valid values are <code>tzd</code> properties defined by <code>TZD</code>
		 * 	class constant objects.
		 * 	
		 * 	@param tzd	A <code>TZD</code> constant to indicate a specific time
		 * 				zone designation.
		 * 
		 * 	@return	A string that represents the UTC offset for the specified 
		 * 			time zone designation.
		 * 
		 * 	@see org.flashapi.swing.constants.TZD
		 */		
		public static function getUTCFromTimeZone(tzd:String):String {
			switch (tzd) {
				case TZD.UT.tzd, TZD.SLT.tzd, TZD.SLT.tzd, TZD.IST.tzd,
					TZD.EGST.tzd, TZD.GMT.tzd, TZD.WET.tzd, TZD.AZODT.tzd,
					TZD.UTC.tzd :
						return TZD.GMT.utc; //+0000
				case TZD.WAT.tzd, TZD.A.tzd, TZD.WEST.tzd, TZD.WEDT.tzd,
					TZD.IDT.tzd, TZD.SEST.tzd, TZD.MEZ.tzd, TZD.BST.tzd :
						return TZD.BST.utc; //+0100
				case TZD.SYT.tzd, TZD.SAST.tzd, TZD.WAST.tzd, TZD.EET.tzd,
					TZD.CEDT.tzd, TZD.CAT.tzd, TZD.MESZ.tzd, TZD.B.tzd, TZD.CEST.tzd :
						return TZD.CEST.utc; //+0200
				case TZD.C.tzd, TZD.SYST.tzd, TZD.MSK.tzd, TZD.MSST.tzd,
					TZD.EAT.tzd, TZD.EEST.tzd, TZD.EEDT.tzd :
						return TZD.EEDT.utc; //+0300
				case TZD.IRST.tzd :
						return TZD.IRST.utc; //+0330
				case TZD.SCT.tzd, TZD.MSDT.tzd, TZD.RET.tzd, TZD.AZT.tzd, TZD.AMST.tzd,
					TZD.GET.tzd, TZD.SAMT.tzd, TZD.D.tzd :
						return TZD.D.utc; //+0400
				case TZD.AFT.tzd, TZD.IRDT.tzd :
						return TZD.IRDT.utc; //+0430
				case TZD.KGT.tzd, TZD.PKT.tzd, TZD.AZST.tzd, TZD.E.tzd, TZD.YEKT.tzd,
					TZD.TJT.tzd, TZD.HMT.tzd, TZD.AMDT.tzd, TZD.WKST.tzd, TZD.SAMST.tzd,
					TZD.TFT.tzd, TZD.UZT.tzd, TZD.CAST.tzd, TZD.TMT.tzd :
						return TZD.TMT.utc; //+0500
				case TZD.NPT.tzd : return TZD.NPT.utc; //+0545
				case TZD.NOVT.tzd, TZD.KGST.tzd, TZD.BTT.tzd, TZD.YEKST.tzd, TZD.BIOT.tzd,
					TZD.LKT.tzd, TZD.F.tzd, TZD.EKST.tzd, TZD.OMST.tzd, TZD.VOST.tzd,
					TZD.MAWT.tzd :
						return TZD.MAWT.utc; //+0600
				case TZD.MMT.tzd, TZD.CCT.tzd :
						return TZD.CCT.utc; //+0630
				case TZD.OMSST.tzd, TZD.KRAT.tzd, TZD.CXT.tzd, TZD.WIB.tzd, TZD.NOVST.tzd,
					TZD.DAVT.tzd, TZD.G.tzd, TZD.ICT.tzd, TZD.KOVT.tzd :
						return TZD.KOVT.utc; //+0700
				case TZD.KRAST.tzd, TZD.TWT.tzd, TZD.H.tzd, TZD.HKST.tzd, TZD.MYT.tzd,
					TZD.IRKT.tzd, TZD.PHT.tzd, TZD.AWST.tzd, TZD.BDT.tzd, TZD.SIT.tzd,
					TZD.KOVST.tzd, TZD.ACIT.tzd, TZD.SGT.tzd, TZD.WITA.tzd, TZD.ULAT.tzd,
					TZD.BNT.tzd, TZD.WST.tzd :
						return TZD.WST.utc; //+0800
				case TZD.ACWST.tzd :
						return TZD.ACWST.utc; //+0845
				case TZD.MNST.tzd, TZD.JST.tzd, TZD.EIT.tzd, TZD.WDT.tzd, TZD.PWT.tzd,
					TZD.IRKST.tzd, TZD.I.tzd, TZD.AWDT.tzd, TZD.WIT.tzd, TZD.TPT.tzd,
					TZD.YAKT.tzd, TZD.KST.tzd :
						return TZD.KST.utc; //+0900
				case TZD.ACST.tzd :
						return TZD.ACST.utc; //+0930
				case TZD.ACWDT.tzd :
						return TZD.ACWDT.utc; //+0945
				case TZD.GST.tzd, TZD.AEST.tzd, TZD.DTAT.tzd, TZD.PGT.tzd, TZD.ChST.tzd,
					TZD.SAKT.tzd, TZD.TRUT.tzd, TZD.K.tzd, TZD.YAKST.tzd, TZD.YAPT.tzd,
					TZD.VLAT.tzd :
						return TZD.VLAT.utc; //+1000
				case TZD.ACDT.tzd, TZD.LHST.tzd :
						return TZD.LHST.utc; //+1030
				case TZD.L.tzd, TZD.PONT.tzd, TZD.NCT.tzd, TZD.SBT.tzd, TZD.VLAST.tzd,
					TZD.VUT.tzd, TZD.AEDT.tzd, TZD.MAGT.tzd, TZD.LHDT.tzd, TZD.KOST.tzd :
						return TZD.KOST.utc; //+1100
				case TZD.NFT.tzd :
						return TZD.NFT.utc; //+1130
				case TZD.ANAT.tzd, TZD.NRT.tzd, TZD.TVT.tzd, TZD.FJT.tzd, TZD.M.tzd,
					TZD.PETT.tzd, TZD.MAGST.tzd, TZD.MHT.tzd, TZD.SCST.tzd, TZD.WFT.tzd,
					TZD.NZST.tzd, TZD.IDLE.tzd, TZD.GILT.tzd :
						return TZD.GILT.utc; //+1200
				case TZD.CHAST.tzd : return TZD.CHAST.utc; //+1245
				case TZD.SCDT.tzd, TZD.ANAST.tzd, TZD.TOT.tzd, TZD.NZDT.tzd, TZD.PHOT.tzd,
					TZD.PETST.tzd :
						return TZD.PETST.utc; //+1300
				case TZD.CHADT.tzd :
						return TZD.CHADT.utc; //+1345
				case TZD.LINT.tzd :
						return TZD.LINT.utc; //+1400
				case TZD.AZOST.tzd, TZD.N.tzd, TZD.EGT.tzd, TZD.CVT.tzd :
						return TZD.CVT.utc; //-0100
				case TZD.PMDT.tzd, TZD.ARDT.tzd, TZD.BRST.tzd, TZD.UYST.tzd, TZD.O.tzd,
					TZD.CGST.tzd, TZD.FNT.tzd :
						return TZD.FNT.utc; //-0200
				case TZD.HAT.tzd, TZD.NDT.tzd :
						return TZD.FNT.utc; //-0230
				case TZD.HAA.tzd, TZD.FKDT.tzd, TZD.CLDT.tzd, TZD.BRT.tzd, TZD.ART.tzd,
					TZD.ADT.tzd, TZD.JFDT.tzd, TZD.CGT.tzd, TZD.UYT.tzd, TZD.GFT.tzd,
					TZD.PYST.tzd, TZD.PMST.tzd, TZD.P.tzd, TZD.SRT.tzd, TZD.ROTT.tzd :
						return TZD.ROTT.utc; //-0300
				case TZD.NST.tzd, TZD.HNT.tzd :
						return TZD.HNT.utc; //-0330
				case TZD.CLST.tzd, TZD.GYT.tzd, TZD.EDT.tzd, TZD.BOT.tzd, TZD.HNA.tzd,
					TZD.AST.tzd, TZD.FKST.tzd, TZD.HAE.tzd, TZD.AMT.tzd, TZD.Q.tzd, TZD.JFST.tzd,
					TZD.PYT.tzd :
						return TZD.PYT.utc; //-0400
				case TZD.VST.tzd :
						return TZD.VST.utc; //-0430
				case TZD.COT.tzd, TZD.EADT.tzd, TZD.R.tzd, TZD.CDT.tzd, TZD.PET.tzd,
					TZD.HNE.tzd, TZD.ACT.tzd, TZD.HAC.tzd, TZD.ECT.tzd, TZD.EST.tzd :
						return TZD.EST.utc; //-0500
				case TZD.S.tzd, TZD.CST.tzd, TZD.HAR.tzd, TZD.HNC.tzd, TZD.MDT.tzd,
					TZD.GALT.tzd, TZD.EAST.tzd, TZD.PIT.tzd :
						return TZD.PIT.utc; //-0600
				case TZD.HNR.tzd, TZD.PDT.tzd, TZD.HAP.tzd, TZD.MST.tzd, TZD.T.tzd :
						return TZD.T.utc; //-0700
				case TZD.HAY.tzd, TZD.HNP.tzd, TZD.AKDT.tzd, TZD.U.tzd, TZD.PST.tzd,
					TZD.CIST.tzd :
						return TZD.CIST.utc; //-0800
				case TZD.HADT.tzd, TZD.GIT.tzd, TZD.V.tzd, TZD.AKST.tzd, TZD.HNY.tzd :
						return TZD.HNY.utc; //-0900
				case TZD.MIT.tzd : return TZD.MIT.utc; //-0930
				case TZD.HAST.tzd, TZD.W.tzd, TZD.TKT.tzd, TZD.CKT.tzd, TZD.TAHT.tzd :
						return TZD.TAHT.utc; //-1000
				case TZD.SST.tzd, TZD.X.tzd, TZD.NUT.tzd:
						return TZD.NUT.utc; //-1100
				case TZD.BIT.tzd, TZD.Y.tzd:
						return TZD.Y.utc; //-1200
				default :
						return TZD.GMT.utc; //+0000
			}
			//throw new InvalidArgumentException("Invalid 'time zone designation':" + tzd + ".");
		}
	}
}