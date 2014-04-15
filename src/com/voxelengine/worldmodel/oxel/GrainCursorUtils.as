/*
	author		:		Ray E. Bornert II and Robert Flesch
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
	import com.voxelengine.Globals;
	import com.voxelengine.utils.Plane;
	import flash.geom.Vector3D;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName

public class GrainCursorUtils
{
	/*
	static public function debug_macro( gc:GrainCursor, m:String, root:Oxel ):Boolean
	{
		var len:int = m.length;
		var i:int;
		for (i = 0; i < len; )
		{
			var c:String = m.charAt(i++);
			if (c == "N")	{if(!gc.move_posy())return false;}
			if (c == "S")	{if(!gc.move_negy())return false;}
			if (c == "E")	{if(!gc.move_posx())return false;}
			if (c == "W")	{if(!gc.move_negx())return false;}
			if (c == "U")	{if(!gc.move_posz())return false;}
			if (c == "D")	{if(!gc.move_negz())return false;}
			if (c == "C")	{ gc.become_child	(); }
			if (c == "P")	{ gc.become_parent	(); }
			if (c == "+")	{ root.write( gc, int(m.charAt(i++)) ); }
			if (c == "-")	{ root.write( gc, Globals.AIR		 ); }
		}
		return true;
	}
	*/
	
	/*
	 * This funciton is fast because it does not actually perform a square root call
	 * It is intended for use by callers that need to find the min or max of a set of 3d points
	 */
	static public function fast_distance( x0:int, y0:int, z0:int,
										  x1:int, y1:int, z1:int ):Number
	{
		var dx:Number = x1 - x0;
		var dy:Number = y1 - y0;
		var dz:Number = z1 - z0;
		return dx * dx + dy * dy + dz * dz;
	}
		
	/*
	 * Return the distance
	 * 	from the paramter point (g0 units)
	 *	to the nearest of the 8 corner points (g0 units)
	 * for this grain
	 */
	static public function get_near_distance( gc:GrainCursor, x:int, y:int, z:int ):Number
	{
		var best:Number = Math.pow(2, 1000);
		var K:int = gc.size()-1;
		var d:Number;
		
		var X:int = gc.getModelX();
		var Y:int = gc.getModelY();
		var Z:int = gc.getModelZ();
		
		// origin
		d = fast_distance( x, y, z,		X	, Y		, Z		);  if (d < best) best = d;
		
		// axis steps
		d = fast_distance( x, y, z,		X+K	, Y		, Z		);  if (d < best) best = d;
		d = fast_distance( x, y, z,		X	, Y+K	, Z		);  if (d < best) best = d;
		d = fast_distance( x, y, z,		X	, Y		, Z+K	);  if (d < best) best = d;

		// diagonal steps
		d = fast_distance( x, y, z,		X	, Y+K	, Z+K	);  if (d < best) best = d;
		d = fast_distance( x, y, z,		X+K	, Y		, Z+K	);  if (d < best) best = d;
		d = fast_distance( x, y, z,		X+K	, Y+K	, Z		);  if (d < best) best = d;

		// triagonal step
		d = fast_distance( x, y, z,		X+K	, Y+K	, Z+K	);  if (d < best) best = d;
		
		var result:Number = Math.sqrt( best );
		
		return result;
	}
	
	/*
	 * Return the distance
	 * 	from the paramter point (g0 units)
	 *	to the farthest of the 8 corner points (g0 units)
	 * for this grain
	 */
	static public function get_far_distance( gc:GrainCursor, x:int, y:int, z:int ):Number
	{
		var best:Number = 0;
		var K:int = gc.size()-1;
		var d:Number;
		
		var X:int = gc.getModelX();
		var Y:int = gc.getModelY();
		var Z:int = gc.getModelZ();
		
		// origin
		d = fast_distance( x, y, z,		X	, Y		, Z		);  if (d > best) best = d;
		
		// axis steps
		d = fast_distance( x, y, z,		X+K	, Y		, Z		);  if (d > best) best = d;
		d = fast_distance( x, y, z,		X	, Y+K	, Z		);  if (d > best) best = d;
		d = fast_distance( x, y, z,		X	, Y		, Z+K	);  if (d > best) best = d;

		// diagonal steps
		d = fast_distance( x, y, z,		X	, Y+K	, Z+K	);  if (d > best) best = d;
		d = fast_distance( x, y, z,		X+K	, Y		, Z+K	);  if (d > best) best = d;
		d = fast_distance( x, y, z,		X+K	, Y+K	, Z		);  if (d > best) best = d;

		// triagonal step
		d = fast_distance( x, y, z,		X+K	, Y+K	, Z+K	);  if (d > best) best = d;
		
		return best;
	}
	
	static public function fast_distance_2d( a0:int, b0:int, a1:int, b1:int ):Number
	{
		var da:Number = a1 - a0;
		var db:Number = b1 - b0;
		
		return da * da + db * db;
	}

	static private function getFar2D( a:int, b:int, a1:int, b1:int, K:int ):Number
	{
		var longest:Number = 0;
		var dist:Number;
		
		dist = fast_distance_2d( a, b, a1    , b1     );                      longest = dist;
		dist = fast_distance_2d( a, b, a1 + K, b1     );  if (dist > longest) longest = dist;
		dist = fast_distance_2d( a, b, a1    , b1 + K );  if (dist > longest) longest = dist;
		dist = fast_distance_2d( a, b, a1 + K, b1 + K );  if (dist > longest) longest = dist;
		
		return longest;
	}
	
	static public function getFarDistance2D( gc:GrainCursor, x:int, y:int, z:int, axis:int ):Number
	{
		var longest:Number = 0;
		var K:int = gc.size()-1;
		var d:Number;
		
		const X:int = gc.getModelX();
		const Y:int = gc.getModelY();
		const Z:int = gc.getModelZ();
		
		switch( axis )
		{
			case 0: // x
				longest = getFar2D( y, z, Y, Z, K );
				break;
			case 1: // y
				longest = getFar2D( x, z, X, Z, K );
				break;
			case 2: // z
				longest = getFar2D( x, y, X, Y, K );
				break;
		}
		
		return longest;
	}
	
	static private function getNear2D( a:int, b:int, a1:int, b1:int, K:int ):Number
	{
		var closest:Number = 0;
		var dist:Number;
		
		dist = fast_distance_2d( a, b, a1    , b1     );                      closest = dist;
		dist = fast_distance_2d( a, b, a1 + K, b1     );  if (dist < closest) closest = dist;
		dist = fast_distance_2d( a, b, a1    , b1 + K );  if (dist < closest) closest = dist;
		dist = fast_distance_2d( a, b, a1 + K, b1 + K );  if (dist < closest) closest = dist;
		
		return closest;
	}
	
	static public function getNearDistance2D( gc:GrainCursor, x:int, y:int, z:int, axis:int ):Number
	{
		var closest:Number = 0;
		var K:int = gc.size()-1;
		var d:Number;
		
		const X:int = gc.getModelX();
		const Y:int = gc.getModelY();
		const Z:int = gc.getModelZ();
		
		switch( axis )
		{
			case 0: // x
				closest = getNear2D( y, z, Y, Z, K );
				break;
			case 1: // y
				closest = getNear2D( x, z, X, Z, K );
				break;
			case 2: // z
				closest = getNear2D( x, y, X, Y, K );
				break;
		}
		
		return closest;
	}
	
	static public function classify_from_plane( gc:GrainCursor, p:Plane ):int
	{
		
		var K:int = gc.size() - 1;
		
		var X:int = gc.getModelX();
		var Y:int = gc.getModelY();
		var Z:int = gc.getModelZ();
			
		var o:uint;
		var d:uint;
		
		// origin
		d = p.testPoint(	X	, Y		, Z		);
		o = d;
		
		// axis steps
		d = p.testPoint(	X+K	, Y		, Z		);  if (d != o) return 0;
		d = p.testPoint(	X	, Y+K	, Z		);  if (d != o) return 0;
		d = p.testPoint(	X	, Y		, Z+K	);  if (d != o) return 0;

		// diagonal steps
		d = p.testPoint(	X	, Y+K	, Z+K	);  if (d != o) return 0;
		d = p.testPoint(	X+K	, Y		, Z+K	);  if (d != o) return 0;
		d = p.testPoint(	X+K	, Y+K	, Z		);  if (d != o) return 0;

		// triagonal step
		d = p.testPoint(	X+K	, Y+K	, Z+K	);  if (d != o) return 0;

		if (d == Plane.POINT_BEHIND		) return -1;
		if (d == Plane.POINT_INFRONT	) return +1;
		
		return 0;
		
	}
	
	static public function is_inside_square( gc:GrainCursor, x:int, y:int, z:int, bound:int ):Boolean
	{
		trace( "is_inside_square x: " + x + "  bound: " + bound + "  world_x: " + gc.getModelX());
		
		if (  gc.getModelX() >= x - bound 
		   && gc.getModelX() + gc.size() <= x + bound
		   && gc.getModelY() >= y - bound 
		   && gc.getModelY() + gc.size() <= y + bound
		   && gc.getModelZ() >= x - bound 
		   && gc.getModelZ() + gc.size() <= y + bound )
			return true;
		
		return false;
	}
	
	static public function is_outside_square( gc:GrainCursor, x:int, y:int, z:int, bound:int ):Boolean
	{
		trace( "is_outside_square x: " + x + "  bound: " + bound + "  world_x: " + gc.getModelX());

		if (  gc.getModelX() > x + bound 
		   && gc.getModelX() + gc.size() < x - bound
		   && gc.getModelY() > y + bound 
		   && gc.getModelY() + gc.size() <= y - bound
		   && gc.getModelZ() > z + bound 
		   && gc.getModelZ() + gc.size() <= z - bound )
			return true;
		
		return false;
	}
	
	static public function is_inside_circle( gc:GrainCursor, x:int, y:int, z:int,  rad:int ):Boolean
	{
		throw new Error( "GrainCursorUtils.is_inside_circle - NOT IMPLEMENTED" );
		return true;
	}
	
	static public function is_inside_sphere( gc:GrainCursor, x:int, y:int, z:int,  rad:int ):Boolean
	{
		// find the farthest distance amongst the grain corners
		// from the center of the sphere
		var dSquared:Number = get_far_distance( gc, x, y, z );
		
		// for the grain to be entirely inside the sphere
		// it's far distance from center must be less than the radius of the sphere
		return dSquared < (rad * rad);
	}
	
	static public function is_outside_sphere( gc:GrainCursor, x:int, y:int, z:int,  rad:int ):Boolean
	{		
		var K:int = rad;

		// for this grain to be entirely outside of the sphere
		// all of the major sphere endpoints must be outside the grain
		
		// ok so test all of the major sphere endpoints to see if any are inside this grain
		// if we find any inside we can immediately return false
		
		// sphere origin
		if (true == gc.contains_g0_point( x	, y		, z		)) return false;

		// tangents on the x axis
		if (true == gc.contains_g0_point( x+K	, y		, z		)) return false;
		if (true == gc.contains_g0_point( x-K	, y		, z		)) return false;
		
		// tangents on the y axis
		if (true == gc.contains_g0_point( x	, y+K	, z		)) return false;
		if (true == gc.contains_g0_point( x	, y-K	, z		)) return false;
		
		// tangents on the z axis
		if (true == gc.contains_g0_point( x	, y		, z+K	)) return false;
		if (true == gc.contains_g0_point( x	, y		, z - K	)) return false;

		// ok so none of the major sphere axis points are inside the grain
		// so we have covered the case where a large grain encloses the sphere
		// but the sphere could be positioned very near to the corner of the grain
		// such that it passes all the tests above but still cuts the corner of the grain
		//  (or we could say that the tip of the corner of the grain pierces the sphere)
		// so we need to test the near distance of the grain
		// to be sure none of the grain corners are inside the sphere
		
		// find the near distance from the center of the sphere
		var d:Number = get_near_distance( gc, x, y, z );

		// for the grain to be entirely outside the sphere,
		// the distance from the center of the sphere
		// to the nearest corner of the grain
		// must be more than the radius of the sphere
		return d > rad;
	}

	static public function contains_sphere( gc:GrainCursor, x:int, y:int, z:int,  rad:int ):Boolean
	{
		// we want to know if the sphere described by the params
		// is completely inside this grain
		
		var K:int = rad;

		// for this grain to completely enclose the sphere
		// all of the major sphere endpoints must be inside the grain
		
		// ok so test all of the major sphere endpoints to see if any are outside this grain
		// if we find any outside we can immediately return false
		
		// sphere origin
		if (false == gc.contains_g0_point( x	, y		, z		)) return false;

		// tangents on the x axis
		if (false == gc.contains_g0_point( x+K	, y		, z		)) return false;
		if (false == gc.contains_g0_point( x-K	, y		, z		)) return false;
		
		// tangents on the y axis
		if (false == gc.contains_g0_point( x	, y+K	, z		)) return false;
		if (false == gc.contains_g0_point( x	, y-K	, z		)) return false;
		
		// tangents on the z axis
		if (false == gc.contains_g0_point( x	, y		, z+K	)) return false;
		if (false == gc.contains_g0_point( x	, y		, z-K	)) return false;

		// far corner
		if (false == gc.contains_g0_point( x+K	, y+K	, z+K	)) return false;
		
		// the sphere is entirely inside the grain
		return true;

	}
	
	static public function isInsideCircle( gc:GrainCursor, x:int, y:int, z:int, rad:int, axis:int ):Boolean
	{
		// find the farthest distance amongst the grain corners
		// from the center of the sphere
		var d:Number = getFarDistance2D( gc, x, y, z, axis );
		
		// for the grain to be entirely inside the sphere
		// it's far distance from center must be less than the radius of the sphere
		// faster to square radius then take square root
		return d < rad * rad;
	}
	
	static public function isOutsideCircle( gc:GrainCursor, x:int, y:int, z:int, rad:int, axis:int ):Boolean
	{
		// find the farthest distance amongst the grain corners
		// from the center of the sphere
		var d:Number = getNearDistance2D( gc, x, y, z, axis );
		
		// for the grain to be entirely inside the sphere
		// it's far distance from center must be less than the radius of the sphere
		// faster to square radius then take square root
		return d > rad * rad;
	}
	
	
}
}