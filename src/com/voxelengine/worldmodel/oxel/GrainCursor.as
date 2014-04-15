/*
	author		:		Ray E. Bornert II
	date		:		2012-JAN-22 SUN
	copyright	:		(c) 2012-present
	comments	:
		
		A generic grain cursor class
		within the unsigned int 32 bit space.
		
		The object can be manipulated with 
		various useful primitives and then 
		used and a spatial reference within
		a grain tree object
		
*/
package com.voxelengine.worldmodel.oxel
{
	//import com.voxelengine.Log;
	import flash.geom.Vector3D;
	import com.voxelengine.Globals;

public class GrainCursor
{
	protected var _gx:uint = 0;
	protected var _gy:uint = 0;
	protected var _gz:uint = 0;
	protected var _data:uint = 0;

	public static var v3_static:Vector3D = new Vector3D;
	public static var gc_static:GrainCursor = new GrainCursor();	

	public function get grain( ):uint { return _data & 0x0000ffff; }
//	public function set grain( val:uint ):void { _data &= 0xffff0000; _data |= val; }
	public function set grain( val:uint ):void 
	{ 
		if ( bound < val )
			throw new Error( "GrainCursor.grain - trying to set grain to larger size then bound, or negative. new value:" + val );
		_data &= 0xffff0000; 
		_data |= val; 
	}

	public function get bound():uint { return (_data & 0xffff0000)>>16; }
	public function set bound(val:uint):void { _data &= 0x0000ffff; _data |= val << 16; }
	
	public function get grainX( ):uint { return _gx; }
	public function set grainX( val:uint ):void { _gx = val; }
	public function get grainY( ):uint { return _gy; }
	public function set grainY( val:uint ):void { _gy = val; }
	public function get grainZ( ):uint { return _gz; }
	public function set grainZ( val:uint ):void { _gz = val; }
	
	private static var _s_axes:Vector.<int> = null;
	////////////////////////////////////////////////////////////////////
	// Static functions
	////////////////////////////////////////////////////////////////////

	public static function two_to_the_g( g:uint ):uint
	{
		// 2 raised to the power of g
		// 2^8 = 256
		return (1 << g);
	}

	public static function two_to_the_g_minus_1( g:uint ):uint
	{
		// 2 raised to the power of g minus 1
		// 2^8-1 = 255
		return ((1 << g) - 1);
	}
	
	public static function get_the_g0_size_for_grain( g:uint ):uint
	{
		// the size of any grain g in g0 units is:
		// 2 raised to the power of g
		return two_to_the_g(g);
	}
	public static function get_the_g0_edge_for_grain( g:uint ):uint
	{
		// the edge of any grain g in g0 units is:
		// 2 raised to the power of g - 1
		return two_to_the_g_minus_1(g);
	}
	
	////////////////////////////////////////////////////////////////////
	// Member functions
	////////////////////////////////////////////////////////////////////
	
	public function GrainCursor( gx:uint=0, gy:uint=0, gz:uint=0, g:uint=0 )
	{
		// keeps you from creating root...
		//if ( g >= s_max_grain ) {
			//trace("GrainCursor - ERROR - grain is over max grain size, desired: " + g + " max: " + s_max_grain );
			//g = s_max_grain - 1;
		//}
		_gx = gx;
		_gy = gy;
		_gz = gz;
		grain = g;
		
		// initialize this static
		if ( !_s_axes )
		{
			_s_axes = new Vector.<int>(3);
			_s_axes[0] = 0;
			_s_axes[1] = 1;
			_s_axes[2] = 2;
		}
	}
	
	public static function getFromPoint( x:Number, y:Number, z:Number, gct:GrainCursor ):void
	{
		// This is where it intersects with a grain 0
		gct.grainX = int( x );
		gct.grainY = int( y );
		gct.grainZ = int( z );
	}
	
	public static function getGrainFromPoint( x:Number, y:Number, z:Number, gct:GrainCursor, desiredGrain:int ):Boolean
	{
		// This is where it intersects with a grain 0
		gct.grainX = int( x );
		gct.grainY = int( y );
		gct.grainZ = int( z );
		gct.grain = 0;
		return gct.become_ancestor( desiredGrain );
	}

	public function getGrainFromVector( $pos:Vector3D, $desiredGrain:int ):Boolean
	{
		// This is where it intersects with a grain 0
		grainX = int( $pos.x );
		grainY = int( $pos.y );
		grainZ = int( $pos.z );
		grain = 0;
		return become_ancestor( $desiredGrain );
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// http://stackoverflow.com/questions/3106666/intersection-of-line-segment-with-axis-aligned-box-in-c-sharp
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public static function GetCoordinate(  vector:Vector3D,  axis:int ):Number
	{
		switch (axis)
		{
			case 0:
				return vector.x;
			case 1:
				return vector.y;
			case 2:
				return vector.z;
			default:
				throw new Error("GrainCursor.GetCoordinate - Axis Value not found");
		}
	}	
	
	public static function SetCoordinate(  vector:Vector3D,  axis:int,  adjustment:Number ):void
	{
		switch (axis)
		{
			case 0:
				vector.x -= adjustment;
				break;
			case 1:
				vector.y -= adjustment;
				break;
			case 2:
				vector.z -= adjustment;
				break;
			default:
				throw new Error("GrainCursor.SetCoordinate - Axis Value not found");
		}
	}	
	
	public function GetDistance( v:Vector3D ):Number 
	{
		var dist:Vector3D = new Vector3D();
		var pos:int = getModelX()
		dist.x = v.x - pos;
		pos = getModelY()
		dist.y = v.y - pos;
		pos = getModelZ()
		dist.z = v.z - pos;
		
		return dist.length;
	}
	
	public function GetWorldCoordinate( axis:int ):int 
	{
		switch (axis)
		{
			case Globals.AXIS_X:
				return getModelX();
			case Globals.AXIS_Y:
				return getModelY();
			case Globals.AXIS_Z:
				return getModelZ();
			default:
				throw new Error("GrainCursor.GetWorldCoordinate - Axis Value not found");
		}
		
	}

	private function RoundNumber( numIn:Number, decimalPlaces:int ):Number 
	{
		var nExp:int = Math.pow(10,decimalPlaces) ;
		return Math.round(numIn * nExp) / nExp;
	} 
	
	public function RoundVector( v:Vector3D, places:int = 4 ):void
	{
		v.x = RoundNumber(v.x,places);
		v.y = RoundNumber(v.y,places);
		v.z = RoundNumber(v.z,places);
		
		//return v;
	}
	
	public function lineIntersect( modelSpaceStartPoint:Vector3D, modelSpaceEndPoint:Vector3D, modelSpaceIntersections:Vector.<GrainCursorIntersection> ):Boolean
	{
		var beginToEnd:Vector3D = modelSpaceEndPoint.subtract( modelSpaceStartPoint );
		var min:Vector3D = new Vector3D(0,0,0);
		var max:Vector3D = new Vector3D(size(),size(),size());
		var beginToMin:Vector3D = min.subtract( modelSpaceStartPoint );
		beginToMin.x += getModelX();
		beginToMin.y += getModelY();
		beginToMin.z += getModelZ();
		var beginToMax:Vector3D = max.subtract( modelSpaceStartPoint );
		beginToMax.x += getModelX();
		beginToMax.y += getModelY();
		beginToMax.z += getModelZ();
		var tNear:Number = -10000000;
		var tFar:Number = 10000000;
		var tNearAxis:int = -1;
		var tFarAxis:int = -1;
		for each ( var axis:int in _s_axes )
		{
			if ( GetCoordinate(beginToEnd, axis) == 0) // parallel
			{
				if ( GetCoordinate( beginToMin, axis) > 0 || GetCoordinate(beginToMax,axis) < 0)
					return false; // segment is not between planes, return empty set
			}
			else
			{
				var t1:Number = GetCoordinate(beginToMin, axis) / (GetCoordinate(beginToEnd,axis));
				var t2:Number = GetCoordinate(beginToMax, axis) / (GetCoordinate(beginToEnd,axis));
				var tMin:Number = Math.min(t1, t2);
				var tMax:Number = Math.max(t1, t2);
				if (tMin > tNear)
				{
					tNear = tMin;
					tNearAxis = axis;
				}
				if (tMax < tFar) 
				{
					tFar = tMax;
					tFarAxis = axis;
				}
				if (tNear > tFar || tFar < 0) 
					return false; // empty set
			}
		}
		
		if (tNear >= 0 && tNear <= 1) 
		{
			var gciNear:GrainCursorIntersection = new GrainCursorIntersection();
			gciNear.point.copyFrom( beginToEnd );
			gciNear.point.scaleBy( tNear );
			gciNear.point = modelSpaceStartPoint.add( gciNear.point );
			RoundVector( gciNear.point );
			gciNear.gc.copyFrom( this );
			gciNear.near = true;
			gciNear.axis = tNearAxis;
			var ipoint:Number = GrainCursor.GetCoordinate( gciNear.point, gciNear.axis );
			if ( ((1 << gciNear.gc.grain) + GetWorldCoordinate( gciNear.axis)) == GrainCursor.GetCoordinate( gciNear.point, gciNear.axis ) )
			{
				GrainCursor.SetCoordinate( gciNear.point, gciNear.axis, 0.001 );
			}
			if ( GetWorldCoordinate( gciNear.axis) == GrainCursor.GetCoordinate( gciNear.point, gciNear.axis ) )
			{
				GrainCursor.SetCoordinate( gciNear.point, gciNear.axis, -0.001 );
			}
			modelSpaceIntersections.push( gciNear );
			
// TODO - does this work? if we have near one, thats all we need.
//return true;
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//trace( "GrainCursor.lineIntersectTest3 - intersection near " + gciNear.toString() );
		}
		
		// RSF 07.04.12 If tFar compared to 1, then there is a dead zone where it doesnt intersect with model correctly
		//if (tFar >= 0 && tFar <= 1) 
//		if (tFar >= 0 && tFar <= 32) 
// tFar = 0 occurs when starting point is on face of oxel
		if (tFar > 0 && tFar <= 32) 
		{	
			var gciFar:GrainCursorIntersection = new GrainCursorIntersection();
			gciFar.point.copyFrom( beginToEnd );
			gciFar.point.scaleBy( tFar );
			gciFar.point = modelSpaceStartPoint.add( gciFar.point );
			RoundVector( gciFar.point );
			gciFar.gc.copyFrom( this );
			gciFar.near = false;
			gciFar.axis = tFarAxis;
			if ( ((1 << gciFar.gc.grain) + GetWorldCoordinate( gciFar.axis)) == GrainCursor.GetCoordinate( gciFar.point, gciFar.axis ) )
			{
				// test for add vs subtract...
				GrainCursor.SetCoordinate( gciFar.point, gciFar.axis, 0.001 );
			}
			if ( GetWorldCoordinate( gciFar.axis) == GrainCursor.GetCoordinate( gciFar.point, gciFar.axis ) )
			{
				// test for add vs subtract...
				GrainCursor.SetCoordinate( gciFar.point, gciFar.axis, -0.001 );
			}
			modelSpaceIntersections.push( gciFar );
			//trace( "GrainCursor.lineIntersectTest3 - intersection far " + gciFar.toString() );
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		}
		return true;
	}	

	public function childId():int {
		var x:int = grainX % 2; // ?? grainX >> (grain - 1);
		var y:int = grainY % 2;
		var z:int = grainZ % 2;
		
		// This number scheme is back asswards!
		var c:int = 0;
		if ( z ) c += 4;
		if ( y ) c += 2;
		if ( x ) c += 1;
		
		return c;
	}
	
	public function child_inc():void {
		if ( !move_posx() )
		{
			set_values( 0, grainY, grainZ, grain )
			if ( !move_posz() )
			{
				set_values( 0, grainY, 0, grain )
				if ( !move_posy() )
					return;
			}
		}
	}
	
	public function reset():void
	{
		_gx = 0;
		_gy = 0;
		_gz = 0;
		_data = 0;
	}

	public function size():uint { return get_the_g0_size_for_grain(grain); }

	public function getModelX():uint { return _gx << grain; }
	public function getModelY():uint { return _gy << grain; }
	public function getModelZ():uint { return _gz << grain; }
	public function getModelVector():Vector3D
	{
		return new Vector3D( getModelX(), getModelY(), getModelZ() );
	}
	
	public function copyFrom( param_gc:GrainCursor ):void
	{
		_gx = param_gc._gx;
		_gy = param_gc._gy;
		_gz = param_gc._gz;
		_data = param_gc._data;
	}

	public function g0_edgeval():uint
	{
		/*
				 max coord in g0 space
			---------------------------------------
			   7    F    F    F    F    F    F    F
			0111 1111 1111 1111 1111 1111 1111 1111
			---------------------------------------
		*/
		return get_the_g0_edge_for_grain( bound );
	}
	
	public function gn_edgeval( g:uint ):uint
	{
		/*
			example for g=7 and max grain 30
			
				g7 edge value
			---------------------------------------
			   7    F    F    F    F    F    F    F
			0000 0000 1111 1111 1111 1111 1111 1111
			---------------------------------------
		*/
		return (g0_edgeval() >> g);
	}
	
	public function edgeval():uint
	{
		// need to know the edge coord for this grain
		return gn_edgeval(grain );
	}

	public function is_oob( val:uint ):Boolean
	{
		// the edgeval is in bounds
		return ( val > edgeval() );
	}

	public function is_inb( val:uint ):Boolean
	{
		//trace( "GrainCursor.is_inb val: " + val + " bg: " +bg + " edgeval( bg ): " + edgeval( bg ) );
		// the edgeval is in bounds
		return ( val <= edgeval() );
	}
	
	public function is_edge( val:uint ):Boolean
	{
		// the edgeval is in bounds
		return ( val == edgeval() );
	}
		
	public function become_ancestor( k:uint ):Boolean
	{
		//trace( "become_ancestor: - was \t" + this.toString() );
		_gx >>= k;
		_gy >>= k;
		_gz >>= k;

		if ( grain + k > bound ) 
		{
			trace( "GrainCursor.become_ancestor: - ERROR trying to make ancestor larger then bound grain: " + grain + " change: " + k + " bound: " + bound + " this: " + this.toString() );
			return false;
		}
		grain += k;

		//trace( "become_ancestor: - now \t" + this.toString() );
		return true;
	}

	public function become_decendant( k:uint ):Boolean
	{
		if ( grain - k < 0) 
		{ 
			trace( "GrainCursor.become_decendant - Error - trying to make a child of grain0" );
			return false; 
		} // null operation
		
		_gx <<= k;
		_gy <<= k;
		_gz <<= k;

		grain -= k;
		return true;
	}

	public function become_parent():void
	{
		become_ancestor(1);
	}

	// values from 0-7 specifies which child to become
	public function become_child( n:uint = 0 ):Boolean
	{
		//trace( "become_child: - was \t" + this.toString() );
		if (grain == 0) 
		{ 
			trace( "GrainCursor.become_child - Error - trying to make a child of grain0" );
			return false; 
		} // null operation
		
		_gx <<= 1;
		_gy <<= 1;
		_gz <<= 1;
		grain -= 1;

		if (n > 0)
		{
			_gx += ((n>>0)&1);
			_gy += ((n>>1)&1);
			_gz += ((n>>2)&1);
		}
		//trace( "become_child: - now \t" + this.toString() );
		return true;
	}
	
	public function get_ancestor( k:uint ):GrainCursor
	{
		gc_static.copyFrom(this);
		gc_static.become_ancestor( k );
		return gc_static;
	}	

	public function is_inside( param_gc:GrainCursor ):Boolean
	{
		///////////////////////////////
		// true if this inside gc
		///////////////////////////////
		
		// we cannot be inside of param_gc if we are larger
		if (grain > param_gc.grain) 		return false;
		if ( is_equal( param_gc ) ) return true;
		
		gc_static.copyFrom(this);
		gc_static.become_ancestor( param_gc.grain - gc_static.grain );
		return param_gc.is_equal(gc_static);
	}
	
	public function is_point_inside( point:Vector3D ):Boolean
	{
		///////////////////////////////
		// true if this inside gc
		///////////////////////////////
		getGrainFromPoint( point.x, point.y, point.z, gc_static, 0 );
		gc_static.become_ancestor( grain - gc_static.grain );
		return gc_static.is_equal(this);
	}
	
	public function move( face:int ):Boolean
	{
		if ( Globals.POSX == face )
			return move_posx();
		else if ( Globals.NEGX == face )
			return move_negx();
		else if ( Globals.POSY == face )
			return move_posy();
		else if ( Globals.NEGY == face )
			return move_negy();
		else if ( Globals.POSZ == face )
			return move_posz();
		else if ( Globals.NEGZ == face )
			return move_negz();
			
		throw new Error( "GrainCursor.move - INVALID FACE" );
		return false;
	}
	
	public function move_posz():Boolean	
	{ 
		if (is_inb( _gz + 1 )) 
		{
			_gz += 1; 
			return true;
		}
		return false;
	}
	
	public function move_negz():Boolean	
	{ 
		if (is_inb( _gz - 1 )) 
		{
			_gz -= 1; 
			return true;
		}
		return false;
	}
	
	public function move_posx():Boolean	
	{ 
		if (is_inb( _gx + 1 )) 
		{
			_gx += 1; 
			return true;
		}
		return false;
	}
	
	public function move_negx():Boolean	
	{ 
		if (is_inb( _gx - 1 )) 
		{
			_gx -= 1; 
			return true;
		}
		return false;
	}
	
	public function move_posy():Boolean	
	{ 
		if (is_inb( _gy + 1 ))
		{
			_gy += 1; 
			return true;
		}
		return false;
	}
	
	public function move_negy():Boolean	
	{ 
		if (is_inb( _gy - 1 ))
		{
			_gy -= 1; 
			return true;
		}
		return false;
	}
	
	public function is_equal( param_gc:GrainCursor ):Boolean
	{
		//trace( "is_equal: g: " + grain + " = " + param_gc.grain  + "  x: " + _gx + " = " + param_gc._gx + "  y: "  + _gy + " = " + param_gc._gy + "  z: "  + _gz + " = " + param_gc._gz   );

		return ( true
			&& grain == param_gc.grain
			&& _gx == param_gc._gx
			&& _gy == param_gc._gy
			&& _gz == param_gc._gz
		);
	}

	public function is_outside( param_gc:GrainCursor ):Boolean
	{
		///////////////////////////////
		// true if this outside param_gc
		///////////////////////////////
		return(true
			&& is_inside( param_gc )	== false
			&& param_gc.is_inside( this )	== false
		);
	}

	public function toString():String { return " x: " + _gx + "\t y: " + _gy + "\t z: "  + _gz + "\t grain: " + grain + " (" + size() + ")" + " bound: " + bound; }
	public function toID():String { return ((String(_gx) + _gy) + _gz) + grain; }
	
	public function set_values( x:uint, y:uint, z:uint, g:uint ):GrainCursor
	{
		_gx = x;
		_gy = y;
		_gz = z;
		grain  = g;
		
		return this;
	}

	public function contains_g0_point( x:int, y:int, z:int ):Boolean
	{
		// return true if the parameter point (g0 units) is inside this grain
		return(true
			&& _gx == (x >> grain)
			&& _gy == (y >> grain)
			&& _gz == (z >> grain)
		);
	}
	
	public function containsModelSpacePoint( point:Vector3D ):Boolean
	{
		// return true if the parameter point (g0 units) is inside this grain
		return(true
			&& _gx == ( point.x >> grain)
			&& _gy == ( point.y >> grain)
			&& _gz == ( point.z >> grain)
		);
	}
	
	public function eval( $grain:int, $x:int, $y:int, $z:int ):Boolean {
		if ( grain == $grain && grainY == $y && grainX == $x && grainZ == $z )
			return true;
		else
			return false;
	}


	
}
}