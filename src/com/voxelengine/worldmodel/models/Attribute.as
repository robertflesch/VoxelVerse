/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.Log;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * Idea is to encapsulate the attribute data, this will allow us to add obfuscation to attributes in the future.
	 * Goal is to make it hard for cheat engine to let user change these numbers.
	 * However reading of the numbers must be quick, writing them can be a bit slower.
	 * Choosen method is to place the number in a random array, 
	 * in which all of the numbers in the array change each time attribute is changed.
	 * The one downside to this class is that if you do 
	 * var someAttrib:Attribute = new Attribute( 3.14 );
	 * var someVal:Number = someAttrib + 1.23;
	 * Best way to protect against this in as3 is to wrap the Attribute in a setter and getter
	 */
	public class Attribute
	{
		private const VECTOR_SIZE:int = 16;
		private const RANDOM_NUMBER_RANGE:int = 256;
		
		private var _index:int = 0;
		private var _vec:Vector.<Number> = new Vector.<Number>(VECTOR_SIZE);
		
		// the $ sign is a style used to differeinate function params from local vars
		public function Attribute( $value:Number = 1 ):void
		{
			val = $value;
		}
		
		// get allows the function to use a speed = attribute.val style
		public function get val():Number 
		{
			return _vec[_index];
		}
		
		// set allows the function to use a attribute.val = 5 style
		// changes all of the values in the vector then set the true value
		// to a random location
		public function set val( $value:Number ):void 
		{
			if ( isNaN( $value ) )
			{
				// Could this be exploited?
				Log.out( "Attribute.set - value is NaN: " + $value + " setting to 1", Log.ERROR );
				_vec[_index] = 1;
			}
			else
			{
				generateNewRandomIndex();
				randomizeVectorValues();
				_vec[_index] = $value;
			}
			
			// This is an internal function only used by this function
			// Create a new index value which is not equal to the old index
			function generateNewRandomIndex():void 
			{
				var newIndex:int = int( Math.random() * VECTOR_SIZE );
				if ( newIndex != _index )
					_index = newIndex;
				else
					generateNewRandomIndex();
			}
			
			// Randomize all of the values in the array
			function randomizeVectorValues():void
			{
				for ( var i:int = 0; i < VECTOR_SIZE; i++ )
				{
					_vec[i] = Math.random() * RANDOM_NUMBER_RANGE;
				}
			}
		}
			
		// For testing 
		public function printAllVectorValues():void
		{
			Log.out( "Attribute.printAllVectorValues ---------- index: " + _index );
			for ( var i:int = 0; i < VECTOR_SIZE; i++ )
			{
				Log.out( "value of index: " + i + " at: " + _vec[i] );
			}
			Log.out( "Attribute.printAllVectorValues ----------" );
		}
	}
}
