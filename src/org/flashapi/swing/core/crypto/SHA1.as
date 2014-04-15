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

package org.flashapi.swing.core.crypto {
	
	// -----------------------------------------------------------
	// SHA1.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @author Geoffrey WILLIAMS
	* @author Paul JOHNSTON, Greg HOLT, Andrew KEPERT, YDNAR, LOSTINET
	* @license BSD License
	* @version 3.0.0, 22/03/2011 17:10
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.util.StringUtil;
	
	/**
	 * 	The <code>SHA1</code> class (for Secure Hash Algorithm 1) provides full-static
	 * 	methods for manipulating a 160-bit hash function which resembles the earlier
	 * 	MD5 algorithm. This class is internally used by the SPAS 3.0 API to generate
	 * 	Genuine Unique IDentifiers (GUIDs) and may not be used for <code>SHA1</code>
	 * 	encryption.
	 * 
	 * 	<p>The current version of the <code>SHA1</code> class (<code>3.0.0</code>) is 
	 * 	derivated from codes in public domain or licensed under the BSD License.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.5
	 */
	public class SHA1 {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	<strong>FOR DEVELOPERS ONLY.</strong>
		 */
		public function SHA1() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/*
		 * Configurable variables. You may need to tweak these to be compatible with
		 * the server-side, but the defaults work in most cases.
		 */
		
		//public static const HEX_FORMAT_LOWERCASE:uint = 0;
		//public static const HEX_FORMAT_UPPERCASE:uint = 1;
		
		/**
		 * @private
		 */
		public static const BASE64_PAD_CHARACTER_DEFAULT_COMPLIANCE:String = "";
		
		/**
		 * @private
		 */
		public static const BASE64_PAD_CHARACTER_RFC_COMPLIANCE:String = "=";
		
		/**
		 * @private
		 */
		public static const BITS_PER_CHAR_ASCII:uint = 8;
		
		/**
		 * @private
		 */
		public static const BITS_PER_CHAR_UNICODE:uint = 8;
		
		//public static var hexcase:uint = 0; // hex output format. 0 - lowercase; 1 - uppercase
		
		/**
		 * @private
		 */
		public static var b64pad:String = ""; // base-64 pad character. "=" for strict RFC compliance
		
		/**
		 * @private
		 */
		public static var chrsz:uint = 8; // bits per input character. 8 - ASCII; 16 - Unicode
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Calculates and returns the SHA1 checksum based on the <code>src</code>
		 * 	string parameter.
		 * 
		 * 	@param src
		 * 	@param isANSI
		 * 
		 * 	@return	The SHA1 checksum based on the specified string parameter.
		 */
		public static function encrypt(src:String, isANSI:Boolean = false):String {
			var s:String = isANSI ? StringUtil.ansiToUFT8(src) : src;
			return hex_sha1(s);
		}
		
		/*
		 * These are the functions you'll usually want to call
		 * They take string arguments and return either hex or base-64 encoded strings
		 */
		/**
		 * @private
		 */
		public static function hex_sha1(string:String):String {
			return binb2hex(getSha1Array( str2binb(string), string.length * chrsz));
		}
		
		/**
		 * @private
		 */
		public static function b64_sha1(string:String):String {
			return binb2b64(getSha1Array(str2binb(string), string.length * chrsz));
		}
		
		/**
		 * @private
		 */
		public static function str_sha1(string:String):String {
			return binb2str(getSha1Array(str2binb(string), string.length * chrsz));
		}
		
		/**
		 * @private
		 */
		public static function hex_hmac_sha1(key:String, data:String):String {
			return binb2hex(getHmacArray(key, data));
		}
		
		/**
		 * @private
		 */
		public static function b64_hmac_sha1(key:String, data:String):String {
			return binb2b64(getHmacArray(key, data));
		}
		
		/**
		 * @private
		 */
		public static function str_hmac_sha1(key:String, data:String):String {
			return binb2str(getHmacArray(key, data));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const HEXTAB_LOWCASE:String = "0123456789abcdef";
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Calculate the SHA-1 of an array of big-endian words, and a bit length.
		 */
		private static function getSha1Array(x:Array, len:Number):Array {
			/* append padding */
			x[len >> 5] |= 0x80 << (24 - len % 32);
			x[((len + 64 >> 9) << 4) + 15] = len;
			var w:Array = new Array(80);
			var a:int = 1732584193;
			var b:int = -271733879;
			var c:int = -1732584194;
			var d:int = 271733878;
			var e:int = -1009589776;
			var oldA:int;
			var oldB:int;
			var oldC:int;
			var oldD:int;
			var oldE:int;
			var j:int;
			var i:int = 0;
			var l:int = x.length;
			var t:int;
			for(; i < l; i += 16) {
				oldA = a;
				oldB = b;
				oldC = c;
				oldD = d;
				oldE = e;
				j = 0;
				for(; j < 80; ++j) {
					if(j < 16) w[j] = x[i + j];
					else w[j] = rol(w[j - 3] ^ w[j - 8] ^ w[j - 14] ^ w[j - 16], 1);
					t = safeAdd(safeAdd(rol(a, 5), sha1_ft(j, b, c, d)), safeAdd(safeAdd(e, w[j]), sha1_kt(j)));
					e = d;
					d = c;
					c = rol(b, 30);
					b = a;
					a = t;
				}
				a = safeAdd(a, oldA);
				b = safeAdd(b, oldB);
				c = safeAdd(c, oldC);
				d = safeAdd(d, oldD);
				e = safeAdd(e, oldE);
			}
			return [a, b, c, d, e];
		}
		
		/**
		 * 	Perform the appropriate triplet combination function for the current
		 * 	iteration.
		 */
		private static function sha1_ft(t:int, b:int, c:int, d:int):int {
			if(t < 20) return(b & c) | ((~b) & d);
			if(t < 40) return b ^ c ^ d;
			if(t < 60) return(b & c) | (b & d) | (c & d);
			return b ^ c ^ d;
		}
		
		/**
		 * 	Determine the appropriate additive constant for the current iteration
		 */
		private static function sha1_kt(t:int):int {
			return(t < 20) ? 1518500249 : (t < 40) ? 1859775393 : (t < 60) ? -1894007588 : -899497514;
		}
		
		/**
		 * 	Calculate the HMAC-SHA1 of a key and some data.
		 */
		private static function getHmacArray(key:String, data:String):Array {
			var bkey:Array = str2binb(key);
			if(bkey.length > 16) bkey = getSha1Array(bkey, key.length * chrsz);
			
			var ipad:Array = new Array(16);
			var opad:Array = new Array(16);
			var i:int = 0;
			for(; i < 16; ++i) {
				ipad[i] = bkey[i] ^ 0x36363636;
				opad[i] = bkey[i] ^ 0x5C5C5C5C;
			}
			
			var hash:Array = getSha1Array(ipad.concat(str2binb(data)), 512 + data.length * chrsz);
			return getSha1Array(opad.concat(hash), 512 + 160);
		}
		
		/**
		 * 	Add integers, wrapping at 2^32. This uses 16-bit operations internally
		 * 	to work around bugs in some JS interpreters.
		 */
		private static function safeAdd(x:int, y:int):int {
			var lsw:int = (x & 0xFFFF) + (y & 0xFFFF);
			var msw:int = (x >> 16) + (y >> 16) + (lsw >> 16);
			return(msw << 16) | (lsw & 0xFFFF);
		}
		
		/**
		 * 	Bitwise rotate a 32-bit number to the left.
		 */
		private static function rol(num:int, cnt:int):int {
			return(num << cnt) | (num >>> (32 - cnt));
		}
		
		/**
		 * 	Convert an 8-bit or 16-bit string to an array of big-endian words
		 * 	In 8-bit function, characters >255 have their hi-byte silently ignored.
		 */
		private static function str2binb(str:String):Array {
			var bin:Array = [];
			var mask:int = (1 << chrsz) - 1;
			var i:int = 0;
			var l:int = str.length * chrsz;
			for (; i < l; i += chrsz)
				bin[i >> 5] |= (str.charCodeAt(i / chrsz) & mask) << (32 - chrsz - i % 32);
			return bin;
		}
		
		/**
		 * 	Convert an array of big-endian words to a string
		 */
		private static function binb2str(bin:Array):String {
			var str:String = "";
			var mask:int = (1 << chrsz) - 1;
			var i:int = 0;
			var l:int = bin.length * 32;
			for (; i < l; i += chrsz)
				str += String.fromCharCode((bin[i >> 5] >>> (32 - chrsz - i % 32)) & mask);
			return str;
		}
		
		/**
		 * 	Convert an array of big-endian words to a hex string.
		 */
		private static function binb2hex(binArray:Array):String {
			//var hexTab:String = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
			var str:String = "";
			var i:int = 0;
			var l:int = binArray.length * 4;
			for(; i < l; ++i) {
			str += HEXTAB_LOWCASE.charAt((binArray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
				HEXTAB_LOWCASE.charAt((binArray[i>>2] >> ((3 - i%4)*8)) & 0xF);
			}
			return str;
		}
		
		/**
		 * 	Convert an array of big-endian words to a base-64 string
		 */
		private static function binb2b64(binArray:Array):String {
			var tab:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
			var str:String = "";
			var i:int = 0;
			var len:int = binArray.length;
			var il:int = len * 4;
			var jl:int = len * 32;
			var j:int;
			var triplet:int;
			for(; i < il; i += 3) {
				triplet =
					(((binArray[i >> 2] >> 8 * (3 - i % 4)) & 0xFF) << 16)
					| (((binArray[i+1 >> 2] >> 8 * (3 - (i+1)%4)) & 0xFF) << 8)
					| ((binArray[i + 2 >> 2] >> 8 * (3 - (i + 2) % 4)) & 0xFF);
				j = 0;
				for(; j < 4; ++j) {
					if (i * 8 + j * 6 > jl) str += b64pad;
					else str += tab.charAt((triplet >> 6 * (3 - j)) & 0x3F);
				}
			}
			return str;
		}		
	}
}