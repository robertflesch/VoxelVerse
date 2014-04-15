/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship public     under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.oxel
{
	import com.voxelengine.Globals;
	/**
	 * ...
	 * @author Robert Flesch RSF hides the bit masking of the raw data
	 */
	public class OxelData
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     Static Variables
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		private static const OXEL_DATA_CLEAR:uint					= 0x00000000;
		private static const OXEL_DATA_FACE_BITS_CLEAR:uint  		= 0x8181ffff;

		private static const OXEL_DATA_ADDITIONAL_CLEAR:uint  		= 0x7fffffff; // used if oxel has flow or light data
		private static const OXEL_DATA_ADDITIONAL:uint  			= 0x80000000; // used if oxel has flow or light data

		private static const OXEL_DATA_FACES_CLEAR:uint				= 0x81ffffff;
		private static const OXEL_DATA_FACES:uint  					= 0x7e000000;

		private static const OXEL_DATA_FACES_POSX:uint				= 0x40000000;
		private static const OXEL_DATA_FACES_NEGX:uint				= 0x20000000;
		private static const OXEL_DATA_FACES_POSY:uint				= 0x10000000;
		private static const OXEL_DATA_FACES_NEGY:uint				= 0x08000000;
		private static const OXEL_DATA_FACES_POSZ:uint				= 0x04000000;
		private static const OXEL_DATA_FACES_NEGZ:uint				= 0x02000000;

		private static const OXEL_DATA_FACES_POSX_CLEAR:uint		= 0xbfffffff;
		private static const OXEL_DATA_FACES_NEGX_CLEAR:uint		= 0xdfffffff;
		private static const OXEL_DATA_FACES_POSY_CLEAR:uint		= 0xefffffff;
		private static const OXEL_DATA_FACES_NEGY_CLEAR:uint		= 0xf7ffffff;
		private static const OXEL_DATA_FACES_POSZ_CLEAR:uint		= 0xfbffffff;
		private static const OXEL_DATA_FACES_NEGZ_CLEAR:uint		= 0xfdffffff;
		
		private static const OXEL_DATA_DIRTY_CLEAR:uint  			= 0xfeffffff;
		private static const OXEL_DATA_DIRTY:uint  					= 0x01000000;
		
		private static const OXEL_DATA_ADD_VERTEX_CLEAR:uint  		= 0xff7fffff;
		private static const OXEL_DATA_ADD_VERTEX:uint  			= 0x00800000;
		
		private static const OXEL_DATA_FACES_DIRTY_CLEAR:uint		= 0xff81ffff;
		private static const OXEL_DATA_FACES_DIRTY:uint  			= 0x007e0000;
		
		private static const OXEL_DATA_FACES_DIRTY_POSX:uint 		= 0x00400000;
		private static const OXEL_DATA_FACES_DIRTY_NEGX:uint		= 0x00200000;
		private static const OXEL_DATA_FACES_DIRTY_POSY:uint		= 0x00100000;
		private static const OXEL_DATA_FACES_DIRTY_NEGY:uint		= 0x00080000;
		private static const OXEL_DATA_FACES_DIRTY_POSZ:uint		= 0x00040000;
		private static const OXEL_DATA_FACES_DIRTY_NEGZ:uint		= 0x00020000;

		private static const OXEL_DATA_PARENT_MASK:uint 			= 0xfffffbff;
		private static const OXEL_DATA_PARENT:uint					= 0x00000400;

		private static const OXEL_DATA_TYPE_MASK_CLEAR:uint 		= 0xfffffc00;
		private static const OXEL_DATA_TYPE_MASK:uint  				= 0x000003ff;
		private static const OXEL_DATA_TYPE_MASK_TEMP:uint			= 0xfe7fffff;
		
		private var _data:uint = 0;					// holds type and face data
		
		public function get dirty():Boolean 					{ return 0 < (_data & OXEL_DATA_DIRTY); }
		public function set dirty( $val:Boolean ):void { 
			_data &= OXEL_DATA_DIRTY_CLEAR;
			if ( $val )
				_data |= OXEL_DATA_DIRTY; 
		}

		protected  function get added_to_vertex():Boolean 		{ return 0 < (_data & OXEL_DATA_ADD_VERTEX); }
		protected  function set added_to_vertex( $val:Boolean ):void { 
			_data &= OXEL_DATA_ADD_VERTEX_CLEAR;
			if ( $val )
				_data |= OXEL_DATA_ADD_VERTEX; 
		}
		
		// Type is stored in the lower 2 bytes ( or 1 ) of the _data variable
		// TODO, I am using 16 bits here, I think the dirty faces are using some of these already.
		// need to reduce it down to 10 bits
		public function get type():int 							{ return (_data & OXEL_DATA_TYPE_MASK); }
		public function set type( val:int ):void { 
			_data &= OXEL_DATA_TYPE_MASK_CLEAR;
			_data |= (val & OXEL_DATA_TYPE_MASK); 
		}
		
		// this is needed to initialize from byteArray
		public function set dataRaw(value:uint):void 			{ _data = value; }
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//     operations
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		protected	function resetData():void 					{ _data &= OXEL_DATA_CLEAR; }
		public 		function faces_clean_all_face_bits():void 	{ _data &= OXEL_DATA_FACE_BITS_CLEAR; } //  doesnt touch dirty;
		// faces marked as dirty that need re-evaluation to determine if a face exists there.
		protected	function faces_has_dirty():Boolean 			{ return 0 < (_data & OXEL_DATA_FACES_DIRTY); }
		public		function faces_mark_all_clean():void 		{ _data &= OXEL_DATA_FACES_DIRTY_CLEAR; dirty = true; }
		public		function faces_set_all():void 				{ _data |= OXEL_DATA_FACES;  dirty = true;}
		public		function faces_clear_all():void 			{ _data &= OXEL_DATA_FACES_CLEAR;  dirty = true;	 }
		protected	function faces_mark_all_dirty():void 		{ 
			_data |= OXEL_DATA_FACES_DIRTY;
			dirty = true; 
		}
		// these bits tell engine if the oxel has a face at that location
		// that information is then used to clear out OR build the quads
		protected  	function face_mark_dirty( $guid:String, $face:uint ):void {
			switch( $face ) {
				case Globals.POSX:
					_data |= OXEL_DATA_FACES_DIRTY_POSX; break;
				case Globals.NEGX:
					_data |= OXEL_DATA_FACES_DIRTY_NEGX; break;
				case Globals.POSY:
					_data |= OXEL_DATA_FACES_DIRTY_POSY; break;
				case Globals.NEGY:
					_data |= OXEL_DATA_FACES_DIRTY_NEGY; break;
				case Globals.POSZ:
					_data |= OXEL_DATA_FACES_DIRTY_POSZ; break;
				case Globals.NEGZ:
					_data |= OXEL_DATA_FACES_DIRTY_NEGZ; break;
			}
			dirty = true;
		}
		
		public  	function facesHas():Boolean					{  return 0 < (_data & OXEL_DATA_FACES);  }
		protected  	function face_is_dirty( $face:uint ):Boolean {
			switch( $face ) {
				case Globals.POSX:
					return 0 < ( _data & OXEL_DATA_FACES_DIRTY_POSX ); break;
				case Globals.NEGX:
					return 0 < ( _data & OXEL_DATA_FACES_DIRTY_NEGX ); break;
				case Globals.POSY:
					return 0 < ( _data & OXEL_DATA_FACES_DIRTY_POSY ); break;
				case Globals.NEGY:
					return 0 < ( _data & OXEL_DATA_FACES_DIRTY_NEGY ); break;
				case Globals.POSZ:
					return 0 < ( _data & OXEL_DATA_FACES_DIRTY_POSZ ); break;
				case Globals.NEGZ:
					return 0 < ( _data & OXEL_DATA_FACES_DIRTY_NEGZ ); break;
			}
			return false;
		}
		public 		function face_set( $face:uint ):void {
			switch( $face ) {
				case Globals.POSX:
					_data |= OXEL_DATA_FACES_POSX;
					break;
				case Globals.NEGX:
					_data |= OXEL_DATA_FACES_NEGX;
					break;
				case Globals.POSY:
					_data |= OXEL_DATA_FACES_POSY;
					break;
				case Globals.NEGY:
					_data |= OXEL_DATA_FACES_NEGY;
					break;
				case Globals.POSZ:
					_data |= OXEL_DATA_FACES_POSZ;
					break;
				case Globals.NEGZ:
					_data |= OXEL_DATA_FACES_NEGZ;
					break;
			}
			dirty = true;
		}
		protected  	function face_clear( $face:uint ):void {
			switch( $face ) {
				case Globals.POSX:
					_data &= OXEL_DATA_FACES_POSX_CLEAR;
					break;
				case Globals.NEGX:
					_data &= OXEL_DATA_FACES_NEGX_CLEAR;
					break;
				case Globals.POSY:
					_data &= OXEL_DATA_FACES_POSY_CLEAR;
					break;
				case Globals.NEGY:
					_data &= OXEL_DATA_FACES_NEGY_CLEAR;
					break;
				case Globals.POSZ:
					_data &= OXEL_DATA_FACES_POSZ_CLEAR;
					break;
				case Globals.NEGZ:
					_data &= OXEL_DATA_FACES_NEGZ_CLEAR;
					break;
			}
			dirty = true;
		}
		public  	function faceHas( $face:uint ):Boolean {
			switch( $face ) {
				case Globals.POSX:
					return 0 < ( _data & OXEL_DATA_FACES_POSX );
					break;
				case Globals.NEGX:
					return 0 < ( _data & OXEL_DATA_FACES_NEGX );
					break;
				case Globals.POSY:
					return 0 < ( _data & OXEL_DATA_FACES_POSY );
					break;
				case Globals.NEGY:
					return 0 < ( _data & OXEL_DATA_FACES_NEGY );
					break;
				case Globals.POSZ:
					return 0 < ( _data & OXEL_DATA_FACES_POSZ );
					break;
				case Globals.NEGZ:
					return 0 < ( _data & OXEL_DATA_FACES_NEGZ );
					break;
			}
			return false;
		}
		
		protected   function parentMarkAs():void 					{ _data |= OXEL_DATA_PARENT;  }
		protected   function parentClear():void 					{ _data &= OXEL_DATA_PARENT_MASK; }
		
		public      function additionalDataMark():void				{ _data |= OXEL_DATA_ADDITIONAL;  }
		public      function additionalDataHas():Boolean			{ return 0 < ( _data & OXEL_DATA_ADDITIONAL );  }
		public      function additionalDataClear():void 			{ _data &= OXEL_DATA_ADDITIONAL_CLEAR; }

		protected 	function maskTempData():uint 					{ return _data & OXEL_DATA_TYPE_MASK_TEMP; }
		
		static public function typeFromData( $data:uint ):uint 			{ return $data & OXEL_DATA_TYPE_MASK; }
		static public function data_is_parent( $data:uint ):Boolean 	{ return 0 < ($data & OXEL_DATA_PARENT); }
		static public function dataHasAdditional( $data:uint ):Boolean 	
		{ 
			var t:uint = ($data & OXEL_DATA_ADDITIONAL);
			t = t >> 1;
			return 0 < t; 
			}
	}
}
		
		