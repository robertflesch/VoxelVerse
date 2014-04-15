package com.voxelengine.utils 
{
	/**
	 * ...
	 * @author Ray Bornert
	  
	  
	 This class implements is a specialized form of a standard set.
	 
	 The constructor takes a single size parameter N which is the
	 maximum number of elements in the set.  The set values range
	 from 0 to N-1.
	 
	 The design goals for this class are to be able to very quickly
	 do 3 basic things
	 
		set a set member to 0 -- open
		set a set member to 1 -- used
		find an unused member
	 
	 The implementation is accomplished with a bit array that is 
	 larger than twice as long as the number of set elements needed
	 i.e. a 30 element set will require 64 bits of storage
	 
	        A
	        B
	       CD
	   EF      GH
	 IJ  KL  MN  OP
	 
	The diagram above shows the binary tree relationship for an 8 member set
	A = bit address  0
	P = bit address 15
	
	I-P are the element bits of the set
	
	E is the parent of IJ
	F is the parent of KL
	G is the parent of MN
	H is the parent of OP
	
	C is the parent of EF
	D is the parent of GH
	
	B is the parent of CD
	A is unused and should be always 0
	
	a bit value of 0 = unused
	a bit value of 1 = used
	
	Internal parent nodes should have the value of 1 (used)
	if and only if both child bits are 1 (used).
	
	Internal parent nodes should have the value of 0 (open)
	if and only if one or both child bits are 0 (open).
	
	The actual leaf members of the bit array are in the top half of the bit array
	the parent bits are in the bottom half of the bit array.
	 
	 */
	
	 
	public class Bitlist 
	{
		private var m_pbits:Vector.<int> = null;
		//private var m_pbits:Vector.<Boolean> = null;
		private var m_maxbits:int=0;

		public function Bitlist( nitems:int ) 
		{		
			m_maxbits		= get_nbits_required( nitems );

			var nbytes:int = m_maxbits / 8;
			var nuints:int = nbytes / 4;
			
			m_pbits = new Vector.<int>(nuints);
			for ( var i:int = 0; i < nuints; i++) m_pbits[i] = 0;
			/*
			m_pbits = new Vector.<Boolean>(m_maxbits);
			for ( var i:int = 0; i < m_maxbits; i++) m_pbits[i] = 0;
			*/
		}
		
		private function get_nbits_required( nitems:int ):int
		{
			var nbits:int=32;	//force minimum allocation to be 1 long

			while (nbits < nitems*2)
				nbits *= 2;

			return nbits;
		}
		
		private function setb(n:int):void
		{
			// force bit n to 1
			m_pbits[ n>>5 ] |= ( (1<<(n&31)));
		}

		private function clrb(n:int):void
		{
			// force bit n to 0
			m_pbits[ n>>5 ] &= (~(1<<(n&31)));
		}

		private function getb(n:int):Boolean
		{
			// return value is 0 or 1
			return ((m_pbits[ n>>5 ] & (1<<(n&31))) != 0);
		}
		
		/*
		private function setb(n:int):void { m_pbits[n] = true; }
		private function clrb(n:int):void { m_pbits[n] = false; }
		private function getb(n:int):Boolean { return m_pbits[n]; }
		*/
		
		private function parent(n:int):int
		{
			return (n >> 1);
		}
		private function child(n:int):int
		{
			return (n << 1);
		}
		
		private function sibling(n:int):int
		{
			return (n ^ 1);
		}
		
		private function set_leaf( root:int ):void
		{
			// set root bit to 1
			setb(root);

			// inform the ancestors
			while ( root && getb(sibling(root)) )
			{
				// both child paths are full
				setb( root = parent(root) );
			}
		}

		private function clr_leaf( root:int ):void
		{
			// inform the ancestors
			while ( root && getb(root) )
			{
				// one or both child paths are empty
				clrb(root);
				// goto parent
				root = parent(root);
			}
		}
		
		private function is_inb( n:int ):Boolean
		{
			return ( 0 <= n && n < m_maxbits / 2 );
		}
		private function is_oob( n:int ):Boolean
		{
			return ( n < 0 || m_maxbits / 2 <= n );
		}

		
		/*
		/////////////////////
		PUBLIC FUNCTIONS
			all public functions MUST check bounds
		/////////////////////
		*/
		public function is_member( leaf:int ):Boolean
		{
			// public function must check bounds
			if (is_oob(leaf))
				return false;
			return getb( leaf + m_maxbits / 2 );
		}
		
		public function add( leaf:int ):void
		{
			// public function must check bounds
			if (is_inb(leaf))
				set_leaf( leaf + m_maxbits / 2 );
		}

		public function rem( leaf:int ):void
		{
			// public function must check bounds
			if (is_inb(leaf))
				clr_leaf( leaf + m_maxbits / 2 );
		}


		public function unit_test():String
		{
			var n:int = m_maxbits / 2;
			var t:Bitlist = new Bitlist(n);
			var result0:String = "Bitlist::unit_test(" + n + ") ";
			var result:String;
			var i:int;

			result = result0 + "FAILED Constructor Erase";
			for ( i = 0; i < n; i++)
				if (t.is_member(i) == true)
					return result;

			// add all possible members
			for ( i = 0; i < n; i++) t.add(i);
			
			result = result0 + "FAILED add 1 or more members";
			for ( i = 0; i < n; i++)
				if (t.is_member(i) == false)
					return result;

			// rem all possible members
			for ( i = 0; i < n; i++) t.rem(i);
			
			result = result0 + "FAILED rem 1 or more members";
			for ( i = 0; i < n; i++)
				if (t.is_member(i) == true)
					return result;
					
			result = result0 + "SUCCESS";
			return result;
		}
	}

}