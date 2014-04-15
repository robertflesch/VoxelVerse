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
	// TCB.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 12/01/2011 22:56
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>TCB</code> class creates convenient object to help developers to
	 * 	remember tacking care of business.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TCB extends Object {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>TCB</code> instance.
		 */
		public function TCB(){
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the string representation of the <code>TCB</code> object.
		 * 
		 * 	@return A string representation of the object.
		 */
		public function toString():String {
			return _data;
		}
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _data:String = "                                   ..                                                               \n                            . EM@MM#.:.Ynt@MMzYYSbMMWc.i:     .i:. .                                \n                   .YA7.i   BM.zMMMM.    .  @M2c.   ... :Q7         ..  .                           \n                 t  0Mi      A  vM@MW .t E   QZit i   .c  2@Y           .. .                        \n               v;Q. 9MMMMMEtSMMb@MMMMMMMEMM8 .Mn$EYM,ECb@b:MM@2BU,v;c,.vI2Atn;.                     \n            tU#MMM0@MMMMMMMMMMMMMMMMMMMMMMMM@oM@$MMM@M00MM0bMM@@M$UM9E07z07bQoW; i                  \n        .:S$MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMtMMMMMMMM@@MMM1MMMWMM#@M1EMoZ@7E6;Z@;7:                \n        i#@MMMbMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@@MMMMMMMM$AMM#MMM@MMMMM@z0@Zb#z0z7t0o7 .              \n     cn CM7@MMtMMMMMMMMM@MM$@MM@$MMMMMEMM0MMMMMMMMB#MMM0MMMMMMM$MQ@M@M@W@#9Q@o$IX.i9; .             \n    iMMQW,.MMM #MMMMMM$UMMIB@#1E$MMMMnMM9MMMWMMMM@MM@$QMMMQM#@MB$oEM#@$M@Q#MME807 cWczSz            \n   7iE@M. tMM$ oMMMMMMI#M$@M#EM@MMMMWMMBMMM6MM@@6MMUA6MMMtMM@@YSc6M$WB@MM0@MM8E07.;z2.Y:v2          \n  :c 2o7 .X2Z$ AMMMMM#@MW0MM0MMMMM@CMMBMMZitM#v0SMb UMMbBM#@@i.;t$CEM0@@@b$0211@0i,X;   t0C         \n  .  1M  .W:AM vM@MMM@MM@@M@MMMMMM$MMMMMBiY#MAM@ME.oMMb@@Az, .QQA1QMMQQQWC:,7Yz@Zi,.nc.  cEc        \n     ,@   ;YzMtiMMMM$MMMMMMMMMMMMMMMMMMMQMMMMMMM#2MMM@@Sic.c@MI1@MMbt@Wi::;Q86tt.. it    76W.       \n   .  c.  cXCM@$BMMM#MMMMMMMMMMMMMMMMMMMMMMMMMM##MMM##WA$BMM$o#MMQQvtZi709WI7Yv...iv    bMMM.       \n   i    . ,;iM0M#@MMMMMMMMMMMMMMMMMMMMMMMMMMMM#@MM@M@@MMMM@B#MMM6EA26S6M$QE2tt,iXc,.:v.C8@E.        \n    z     .A0@@MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@MMMMM@M@MM#E#MM@@WQ#WW@@@##Q$$8S0A7:X7;izSv.,         \n    i  ,.2v#@0QMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@#E8bocvv16QWBbbIz1IU6UUS2A8A67i..     ,.. o        \n    o  zIE@U@M@WMMMMMMMMMMMMMMMMMMMMMMMMMMMM@WQSci...    .;iY;,   ..,,:i;iYYtYv,. .:cvi.  #1   ,    \n    ti,vM0@MQMMMMMMMMMMMMMMMMMMMMMMMMMMM#08z;.                         ..,,i:vYcv7Cci...7M@;  :,    \n    ..:YMMMMMMMMMMMMMMMMMMMMMMMMMMMM@0EIoi.                               ...:;ii,:.i7IzQQEob1. .   \n       QQMMMMMMMMMMMMMMMMMMM@M@#W$$Qo7,                                  ....,::.,iictX9E#9@M8      \n    i. Q@0MMMMMMMMMMMMM@M@@WW89117Yi,                                     ..:,,,ivY7IU0B@BMMM.      \n    vz.Z0E$@MM@#@MMM@@@#W0ASYc:,..                                         ... .:;vA0$W#$MMB;  iY   \n    i@E$MW##$E0U7I@#@$#Zo7v,...                                            ....:;vA6Z6E0@M@77Z bA   \n    i@M@MMM@nic: X$@#BU1iii:.... .                                           ...,vtS1A0#@@9SWtBM1:  \n    1Q$ZM@@@Ei:  i0M@QZ7vii,..... .                                          ., .:toQ$#$@WW@WW$i;   \n    .MM@#M#MU:1. S@M##I7vvi,.... . .                                         .,. .vo9#@@@##@M#c; .  \n     QM@M@MMS Y. ;WMMB8t1;:,,....   .                                         ..,..vZQ$$$W@@M#; :0i \n     .$M@@@Mz.;. i#MMMEU1Yi,.... .                                              ,i.:YI0@MM@@$v tW$;.\n      t@MW0@1.cZYc$MM@$8oYv.,,...                                                ...ctoEWQ$@IY#BWz. \n      Y8CzSE;.:QUc2MM#0Enci,.,..,....                                               iU1Q$#W000AzXc, \n      ,t7i7Yc..t0B@MM$@6t;:,,...:....                                                ;tt###BEt7.:v; \n       cc..,.. ,Q@QE@$QQtY,..:.....                                                   iiU@#$17. ... \n       ,X.  ,.  zUbW@@#8ovi......                                                     .YtB$ZUv:     \n         .   .  itC$$@WEtc:i,,..                                .:..:vYozoc;.          :iS@#9EC.    \n                 .Z$@@Q9Ucvii...                          iSbE$M@WQ69SCYY;c7i           :iB@AY7t,   \n                 :QM@@0927;i,....                  ..,:iXWMMMM@0otv:                     :YMQ. .,.  \n                 :;$#B02Uv,,,.:.,.         .. . ..;7X7172zItv.        ..,..              iYS#c  .   \n                 .cWW$E88Etc;;.,.:..       ....,:;YtYcvciiivct1bzo2b9EACYi.               Y;Xb:     \n                 t@MMMMMMMMMM@Qo27c..     ....,,,..,,,ii7UQ#MMMMMMMMn@M#o.                v7Yci     \n                0MMMMMMMMMMMMMMMMM@@Eti..,.          .iSA82t iMMMMz  :7t.                 .7::ii    \n               ,MMMMMMMMM@M@MMMMMMMMMM#U;::            .7i:.  .,      .                   .cc.:     \n                ,#@M@@@@MMMMMMMMMMMMMMMMQv.              .Yn77i,..                        :YcY.:    \n                 i$@MMMMMMMMMMMMMMB$MMMM@oi               .i;ii,:,.                       ,v7ti;    \n                 2MM@MMMM@ISQM@Boz#MMMMMMQi                                               ,;vIi     \n                 tMM$zC.@@#8z7i.,v$@MMMMMQ;                                               ;1Z0     .\n                 .#M@W6.IM@W6zXCXUQ@@M@MM#;.                                             .9MMQ    c1\n                  iC#MM@@MM@#E6SU6Q$@@@@M@S.                                              o8SM2  z$X\n                    EMMMM@0QUzt1tIb#@@@@@MA.                                                 .   t@0\n                    Y0#08nnoXc7Ytt8W@#M#@M0.                                                     cM@\n                    ;AQ0ttXXcYCtCz2W$@#@@@b;                                               ..    i$M\n                   .E0$#EStt11zCnnU0$#@#M@Q7.                                              .,    i$M\n                    Z@#M#0oIA2SoYt1QW$W@MMQS.                                              ..    .o@\n                     tMMM$QEbIS77YUQBQ$MM$US:                                             ..,    .oM\n                     tQ@@@B@Q09U1SAQE0#M$77o:                  .                           ..    7MM\n                      o#M@@##WW2oz0Q0ZzS126Y.           ...     ..                  ...    .:    @MM\n                      ;9@M@@@#E08EQQEEB@#@$7        ,79MMQ:      ..                ... .   .:   .MMM\n                       t@MM@@##WWW$0QEW#@@@Bz16U1c1ni ...          .              ...     .,;   6MMM\n                       :QMMM@@##B$QQb0WBQBW@MMMM0IC.                                     ..c,   MMMM\n                        Y0M@@@@$$0B0WB#$#W##MMB;..;.                              .     . it.  .MMMM\n                         c@MMM@@$BQB$@#@###@$Z.   .v                             .   . ...cX   MMMMM\n                          1@MMM@@#$####Q#@M@8c                                        ...Y2   iMMMMM\n                           UQ@MM@@#@BW0Q@M@#EEE1i, ..:.;vSzztYi;1#9:                   :Sb,   MMMMMM\n                            SE@MM@@@$2Z0M@@@MMMMMMM@#0QQQWBAz7ci;iCzc               ..;90i   #MMMMMM\n                             Z0@MM@M0Io$MMMMMMMMM@0ni:..             .           . ..706.   cMMMMMMM\n                              E8@MMM#oIWMMMMMBZ;.                               ....7En.    MMMMMMMM\n                               tbMMM@EtI8$@MM@6i     .       .                 ...,Sb1:.   @MMMMMMMM\n                                i6MMMW9S60@@MMM#UcYi..iv7XYi,                  .,:A27i.   #MMMMMMMMM\n                                  tMMM@#W##@@M@MMMMM@@Q0AS;,                   ,v81i..   EMMMMMMMMMM\n                                   cMMM@@@@#@##WQ9A17:,.                     .i1Zc,..   0MMMMMMMMMMM\n                                 :obc#MMMM@$WW8nYc::.                      ..Y8Ai,..   z@MMMMMMMMMMM\n                             1MMMMMMMXZMMMM@@W0nzSci,..                   .iA0Y.,..   Y$MMMMMMMMMMMM\n                           MMMMMMMMMMM#IMMMM@MB$ZAc:....                 .cW9i....   cW@MMMMMMMMMMMM\n                         MMMMMMMMMMMMMMM@BMMMMM@02Y....                 ,10C:,:..   cB$MMMMMMMMMMMMM\n               .v0MMMMMMMMMMMMMMMMMMMMMMMM@@MMMM#6c:.....             .C09i:,,..   i0BMMMMMMMMMMMMMM\n           1MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@@MMM#Zc:.,:;,. .     ..inW$1,:,,,,.  ;0$MMMMMMMMMMMMMMM\n        0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@M@$67v7tCi:,::;vtz#@$1i.:::.:...vE$MMMMMMMMMMMMMMMM\n      BMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM##B@@@$@@MMMM@0z;vi;:i:,...70$@MMMMMMMMMMMMMMMM\n     MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@0IC77C77Yci,..,S0@MMMMMMMMMMMMMMMMMM\n    0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMU#MM#BEbzUnI1ztSCXc;,:io#MMMMMMMMMMMMMMMMMMMM\n   .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMAWMMB0Z6I6I6zzt1Xc;;vEMMMMMMMMMMMMMMMMMMMMMM\n  tMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMQbMMM@B$0EUAoS1nXtoMMMMMMMMMMMMMMMMMMMMMMMM\n WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWMMMM@@$BbE9E6A9MMMMMMMMMMMMMMMMMMMMMMMMM\nWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@@##W#WW#MMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@M@@@#$MMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM@MMMMMMMMMMMMMMMMMMMMMMMMMMMM";
	}
}