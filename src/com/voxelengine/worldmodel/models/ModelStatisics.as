/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/
package com.voxelengine.worldmodel.models
{
	import com.voxelengine.pools.LightingPool;
	import com.voxelengine.worldmodel.oxel.Lighting;
	import com.voxelengine.worldmodel.oxel.FlowInfo;
	import flash.utils.ByteArray;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;
	import com.voxelengine.worldmodel.oxel.OxelData;
	import com.voxelengine.worldmodel.oxel.Oxel;
	
	/**
	 * ...
	 * @author Robert Flesch - RSF 
	 * how many and what type
	 */
	public class ModelStatisics 
	{
		private   var 	_rootGrain:int 					= -1;
		private   var	_count:Number					= -1;
		private   var 	_stats:Array 					= new Array(256);				// INSTANCE NOT EXPORTED
		private   const GRAINS_PER_SQUARE_METER:int		= 16 * 16 * 16;
		
		private var _x_max:int = 0;
		private var _x_min:int = 2048;
		private var _y_max:int = 0;
		private var _y_min:int = 2048;
		private var _z_max:int = 0;
		private var _z_min:int = 2048;
		private var _solid_max:int = 0;
		private var _solid_min:int = 31;

		public function get rootSize():int { return _rootGrain };
		public function get largest():int { return _solid_max };
		public function get smallest():int { return _solid_min };
		public function get range():int { return _solid_max - _solid_min };
		public function get count():int { return _count };
		public function get countInMeters():int { return _count/GRAINS_PER_SQUARE_METER };
		
		static private var _TempFlowInfo:FlowInfo = new FlowInfo();
		static private var _TempBrightness:Lighting = LightingPool.poolGet();

		private function initialize():void
		{
			_x_max = 0;
			_x_min = 2048;
			_y_max = 0;
			_y_min = 2048;
			_z_max = 0;
			_z_min = 2048;
			_solid_max = 0;
			_solid_min = 31;
			_rootGrain = -1;
			_count = 0;
			_stats = new Array(256);				// INSTANCE NOT EXPORTED
		}
		
		public function gather( $version:String, $ba:ByteArray, $rootGrain:int ):void
		{
			if ( !$ba )
				throw new Error( "ModelStatisics.gather - NO ByteArray found" );
				
			if ( 8 >= $ba.bytesAvailable )
				return; //empty
				
			var orginalPosition:int  = $ba.position;
			initialize();
			_rootGrain = $rootGrain;
			process( $version, $ba, _rootGrain );
			$ba.position = orginalPosition;
			
			for ( var key:* in _stats )
			{
				if ( !isNaN( key ) )
				{
					if ( Globals.Info[key] )
						_count += _stats[key];
					else
						Log.out( "ModelStatisics.gather - key not found key: " + key, Log.WARN );
				}
			}
			
			statsPrint();
//			trace( "ModelStatisics.grather - old count: " + count );
//			trace( "ModelStatisics.grather - meter count: " + countInMeters );

		}
		
		private function process( $version:String, $ba:ByteArray, currentGrain:int ):ByteArray
		{
			var data:int = $ba.readUnsignedInt();
			if ( OxelData.dataHasAdditional( data ) )
			{
				$ba = _TempFlowInfo.fromByteArray( $version, $ba );
				$ba = _TempBrightness.fromByteArray( $version, $ba, 0 );
			}
			
			if ( OxelData.data_is_parent( data ) )
			{

				currentGrain--;
				for ( var i:int = 0; i < 8; i++ )
				{
					process( $version, $ba, currentGrain );
				}
				currentGrain++;
			}
			else 
			{
				var type:int = OxelData.typeFromData( data );
				statAdd( type, currentGrain );
				if ( currentGrain < _solid_min && Globals.AIR != type )
					_solid_min = currentGrain
				if ( currentGrain > _solid_max && Globals.AIR != type )
					_solid_max = currentGrain
			}
			
			return $ba;
		}
		
		public function statAdd( type:int, grain:int ):void
		{
			if ( type < 100 )
				Log.out( "ModelStatisics.statAdd - Where does this come from?" );
			if ( isNaN( _stats[type] ) )
				_stats[type]  = 0;
			var count:int = Math.pow( Math.pow( 2, grain ), 3 );			
			_stats[type] = _stats[type] + count;

		}

		public function statRemove( type:int, grain:int ):void
		{
			if ( isNaN( _stats[type] ) )
				_stats[type]  = 0;
			var count:int = Math.pow( Math.pow( 2, grain ), 3 );			
			_stats[type] = _stats[type] - count;
		}
		
		public function	statsPrint():void
		{
			trace( "---------------------" );
			trace( "root grain: " + _rootGrain );
			trace( "largest solid grain: " + _solid_max );
			trace( "smallest solid grain: " + _solid_min );
			for ( var key:* in _stats )
			{
				if ( !isNaN( key ) )
				{
					if ( Globals.Info[key] )
						trace( "Contains " + _stats[key]/GRAINS_PER_SQUARE_METER + " cubic meters of " + Globals.Info[key].name);
					else	
						trace( "ModelStatisics.statsPrint - unknown key: " + key );
				}
			}
		}
		
	}
}

