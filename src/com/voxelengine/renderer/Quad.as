/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer {

import com.voxelengine.utils.ColorUtils;
import flash.geom.Vector3D;
import flash.utils.getTimer;

import com.voxelengine.Globals
import com.voxelengine.Log;
import com.voxelengine.worldmodel.oxel.Lighting;
import com.voxelengine.worldmodel.oxel.FlowInfo;
import com.voxelengine.worldmodel.oxel.FlowScaling;
import com.voxelengine.worldmodel.TileType;
import com.voxelengine.worldmodel.TypeInfo;
import com.voxelengine.renderer.vertexComponents.Color;
import com.voxelengine.renderer.vertexComponents.ColorUINT;
import com.voxelengine.renderer.vertexComponents.XYZ;
import com.voxelengine.renderer.vertexComponents.Normal;
import com.voxelengine.renderer.vertexComponents.UV;
import com.voxelengine.renderer.vertexComponents.VertexComponent;
	
public class Quad {
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//     Static Variables
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static private const QUAD_UV_COUNT:int = 5;
	
	static private var _s_textureScale:int = 256;
	static private var _s_numArgs:Vector.<Number> = new Vector.<Number>(3, true);
	static private var _s_intArgs:Vector.<int> = new Vector.<int>(3, true);
	
	static public const COMPONENT_COUNT:int = 5;
	static public const VERTEX_PER_QUAD:int = 4;
	static public const INDICES:int = 6;
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//     Static Functions
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public static function texture_scale_set( val:int ):void { _s_textureScale = val; }
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//     Member Variables
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// These are accessed by the VertexIndexBuilder when building the Vertex and Index buffers
	public  var components:Vector.<VertexComponent> = new Vector.<VertexComponent>(COMPONENT_COUNT * VERTEX_PER_QUAD, true);
	public  var _indices:Vector.<uint> 				= new Vector.<uint>(INDICES,true);
	private var _u:Vector.<Number> 					= new Vector.<Number>(QUAD_UV_COUNT,true);
	private var _v:Vector.<Number> 					= new Vector.<Number>(QUAD_UV_COUNT, true);
	private var _data:uint;

	public function get dirty():uint { return ((_data & 0x00000001)); }
	public function set dirty( value:uint ):void { _data = ((_data & 0xfffffffe) | value); }	
	
	// Empty constuctor for QuadPool
	public function Quad():void { };
	
	public function rebuild( $type:int,						 // material type
						     $x:Number, $y:Number, $z:Number,// world location
						     $face:int,						 // which 
						     $$planeFacing:int,				 // facing
						     $scale:Number,                  // the world size of the quad 
						     $lighting:Lighting ):void			
	{
		add( $type, $x, $y, $z, $face, $$planeFacing, $scale, Globals.Info[$type], $lighting );
		dirty = 0;
	}
	
	public function build( $type:int,						// material type
						   $x:Number, $y:Number, $z:Number,	// world location
						   $face:int,						// which 
						   $$planeFacing:int,				// facing
						   $scale:Number,                   // the world size of the quad 
						   $lighting:Lighting ):Boolean			
	{
		var typeInfo:TypeInfo = Globals.Info[$type];
		if ( !calculateUV( typeInfo, $face, $scale, null, $lighting ) )
			return false;
			
		add( $type, $x, $y, $z, $face, $$planeFacing, $scale, typeInfo, $lighting );
		return true;
	}
	
	public function buildScaled( $type:int,						// material type
										$x:Number, $y:Number, $z:Number,	// world location
										$face:int,						// which 
										$$planeFacing:int,				// facing
										$scale:Number,
									    $lighting:Lighting,
										$flowInfo:FlowInfo ):Boolean			// the scaled for flow distance
	{
		var typeInfo:TypeInfo = Globals.Info[$type];
		if ( !calculateUV( typeInfo, $face, $scale, $flowInfo, $lighting ) )
			return false;
		
		addScaled( $type, $x, $y, $z, $face, $$planeFacing, $scale, typeInfo, $lighting, $flowInfo );
		return true;
	}
	
	public function print():void 
	{
		var output:String;
		var index:int = 0;
		// replace with components
		//for each ( var v:Number in _vertices )
		//{
			//Log.out( "vert[" + index + "]: " + v );
			//index++;
		//}
		index = 0;
		for each ( var i:Number in _indices )
		{
			Log.out( "indi[" + index + "]: " + i );
			index++;
		}
	}
	
	public function copyUV( rhs:Quad ):void {
		
		for ( var vindex:int = 0; vindex < QUAD_UV_COUNT; vindex++ )
		{
			_v[vindex] = rhs._v[vindex];
		}
			
		for ( var uindex:int = 0; uindex < QUAD_UV_COUNT; uindex++ )
		{
			_u[uindex] = rhs._u[uindex];
		}
	}
	
	private function randomTextureOffset( maxpix:int, scale:Number ):Number
	{
		// if the requested texture is larger then the size that can return a random texture
		// then return 0. So for a 256x256 texture, the largest random texture is 128x128
		var result:int = 0;
		if ( 0 < (maxpix - scale) )
			result = int(Math.random() * (maxpix - scale) );
			
		return result;
	}
	
	private function resetUV():void {
		for ( var i:int; i < QUAD_UV_COUNT; i++ ) {
			_u[i] = 0;
			_v[i] = 0;
		}
	}
	
	private const GLASS:String = "GLASS";
	private function calculateGlassOffset( typeInfo:TypeInfo, face:int, scale:Number, $lighting:Lighting ):void
	{
			// count the number of corners that have ambient
			var count:int;
			if ( 0 == count )
				_v[0] += 0.0078125;
	}
	
	private function calculateUV( typeInfo:TypeInfo, face:int, scale:Number, $flowInfo:FlowInfo, $lighting:Lighting ):Boolean
	{
		resetUV();
		
		const maxpix:int = typeInfo.maxpix;
		const minpix:int = typeInfo.minpix;
		var tilingType:int = TileType.TILE_FIXED;
		
		if ( 0 == maxpix || 0 == minpix )
		{
			throw new Error("Quad.calculateUV - Maxpix or Minpix is 0, Likely tried to create an AIR, PARENT, or INVALID oxel");
		}
		
		if ( null == typeInfo )
		{
			throw new Error("Quad.calculateUV - typeInfo NULL", Log.ERROR );
		}
		
		// First get the right section of the texture, and the tilingtype
		switch ( face ) 
		{
			case Globals.POSY:
			{
				tilingType = typeInfo.top;
				_u[0] = typeInfo.ut;
				_v[0] = typeInfo.vt;
				break;
			}
			case Globals.NEGY:
			{
				tilingType = typeInfo.bottom;
				_u[0] = typeInfo.ub;
				_v[0] = typeInfo.vb;
				break;
			}
			default:
			{
				tilingType = typeInfo.side;
				_u[0] = typeInfo.us;
				_v[0] = typeInfo.vs;
				break;
			}
		}
		
		if ( typeInfo.category == GLASS )
		{
			calculateGlassOffset( typeInfo, face, scale, $lighting );
		}

		// This gets a random placement of the starting corner of the texture
		// maxpix is the total size of the texture to sample from
		// scale is how many pixels the texture uses
		// texture size is the size of the overall texture
//		if ( Globals.GRASS == type && face != Globals.NEGY && face != Globals.POSY && 1 == minpix)
		//static public const TILE_FIXED:int				= 0;
		//static public const TILE_RANDOM:int 				= 1;
		//static public const TILE_RANDOM_CENTERED:int 		= 2;
		//static public const TILE_RANDOM_8_HORZ:int 		= 3;
		//static public const TILE_RANDOM_8_VERT:int 		= 4;
		//static public const TILE_RANDOM_16_BOTH:int		= 5;

		if ( TileType.TILE_NONE == tilingType )
		{
			return false; // I am not suppose to build this quad.
		}
		
		if ( TileType.TILE_RANDOM_CENTERED == tilingType )
		{
			_u[0] += randomTextureOffset( maxpix, scale )/ _s_textureScale;
			var offset:Number = ((maxpix - scale) / 2);
			_v[0] += offset / _s_textureScale;
		}
		//if ( Globals.WOOD == type && face != Globals.NEGY && face != Globals.POSY && 1 == minpix)
		else if ( TileType.TILE_RANDOM_8_HORZ == tilingType )
		{
			_u[0] += randomTextureOffset( maxpix, scale )/ _s_textureScale;
			var woffset:Number = randomTextureOffset( maxpix, scale );
			if (  8 <= scale )
				woffset = int( woffset/8 ) * 8
			_v[0] += woffset / _s_textureScale;
		}
		else if ( TileType.TILE_RANDOM_8_VERT == tilingType )
		{
			var voffset:int = randomTextureOffset( maxpix, scale );
			if (  8 <= scale )
				voffset = int( voffset/8 ) * 8
			_u[0] += voffset / _s_textureScale;
			_v[0] += randomTextureOffset( maxpix, scale )/ _s_textureScale;
		}
		//else if ( 16 < maxpix && maxpix != minpix )
		else if ( TileType.TILE_RANDOM == tilingType || TileType.TILE_RANDOM_NO_ROTATE == tilingType ) 
		{
			_u[0] += randomTextureOffset( maxpix, scale ) / _s_textureScale;
			_v[0] += randomTextureOffset( maxpix, scale )/ _s_textureScale;
		}
		else if ( TileType.TILE_RANDOM_16_BOTH == tilingType )
		{
			var soffset:Number = randomTextureOffset( maxpix, scale );
			if (  16 <= scale )
				soffset = int( soffset/16 ) * 16
			_u[0] += soffset / _s_textureScale
			soffset = randomTextureOffset( maxpix, scale );
			if (  16 <= scale )
				soffset = int( soffset/16 ) * 16
			_v[0] += soffset / _s_textureScale
		}
		
		// This is the length of the texture in pixels/length
		var tSize:Number = scale / _s_textureScale;
		tSize = Math.min( tSize, maxpix / _s_textureScale );
		tSize = Math.max( tSize, minpix / _s_textureScale );
		_u[1] = _u[0] + tSize					;		_v[1] = _v[0];			
		_u[2] = _u[0] + tSize					;		_v[2] = _v[0] + tSize;
		_u[3] = _u[0]							;		_v[3] = _v[0] + tSize;
		_u[4] = _u[0]							;		_v[4] = _v[0];
		
		// idea here was to rotate all of the water textures so that they flowed down
		// but I get tearing, so I am doing something wrong.
		//if ( TileType.TILE_FIXED == tilingType )
		//{
			//if ( Globals.WATER == typeInfo.type && face != Globals.POSY && face != Globals.NEGY )
			//{
				//for (var ii:int = 0; i < 4; i++)
				//{
					//_u[ii] = _u[ii + 1];
					//_v[ii] = _v[ii + 1];
				//}
			//}
		//}

		if ( TileType.TILE_RANDOM == tilingType && 16 < maxpix )
		{
			// 50% chance to rotate the texture
			if (Math.random() < 0.50)
			{
				rotateTexture( ROTATE_090 );
			}
		}
		// This makes the sides of water and lava oxels flow downward
		else if ( TileType.TILE_FIXED == tilingType && 16 <= maxpix && typeInfo.animated )
		{
			//if ( Globals.POSX == face ||  face == Globals.NEGX || face == Globals.POSZ || face == Globals.NEGZ )
			//{
				//rotateTexture90();
			//}
			// For top and bottom faces, adjust the texture rotation to the direction of the flow
			//else {
			if ( $flowInfo )
			{
				if ( Globals.POSY == face ||  face == Globals.NEGY )
				{
					// PosX is the default
					if ( Globals.POSZ == $flowInfo.direction ) {
						rotateTexture( ROTATE_000 );
					} else if ( Globals.POSX == $flowInfo.direction ) {
						rotateTexture( ROTATE_090 );
					} else if ( Globals.NEGZ == $flowInfo.direction ) {
						rotateTexture( ROTATE_180 );
					} else if ( Globals.NEGX == $flowInfo.direction ) {
						rotateTexture( ROTATE_270 );
					}
				}
			}
		}
		
		return true;
	}
	
	private static const ROTATE_000:int = 0;
	private static const ROTATE_090:int = 1;
	private static const ROTATE_180:int = 2;
	private static const ROTATE_270:int = 3;
	
	private function rotateTexture( rotation:int ):void {  
		var i:int = 0;
		var j:int = 0;
		if ( ROTATE_000 == rotation )
			return;
		else if ( ROTATE_090 == rotation )
		{
			for (i = 0; i < 4; i++) {
				_u[i] = _u[i + 1];
				_v[i] = _v[i + 1];
			}
		}
		else if ( ROTATE_180 == rotation )
		{
			_u[4] = _u[0];		_v[4] = _v[0];
			_u[0] = _u[2];		_v[0] = _v[2];
			_u[2] = _u[4];		_v[2] = _v[4];
			
			_u[4] = _u[1];		_v[4] = _v[1];
			_u[1] = _u[3];		_v[1] = _v[3];
			_u[3] = _u[4];		_v[3] = _v[4];			
		}
		else if ( ROTATE_270 == rotation )
		{
			for (i = 0; i < 4; i++) {
				_u[i] = _u[i + 1];
				_v[i] = _v[i + 1];
			}
			_u[4] = _u[0];		_v[4] = _v[0];
			_u[0] = _u[2];		_v[0] = _v[2];
			_u[2] = _u[4];		_v[2] = _v[4];
			
			_u[4] = _u[1];		_v[4] = _v[1];
			_u[1] = _u[3];		_v[1] = _v[3];
			_u[3] = _u[4];		_v[3] = _v[4];			
		}
	}
	
	private function buildVerticeComponents( componentIndex:int, x:Number, y:Number, z:Number, u:Number, v:Number, normalx:int, normaly:int, normalz:int, tint:uint, light:uint ):int
	{
		if ( null == components[componentIndex] )
			components[componentIndex++] = new XYZ( x, y , z );
		else {
			_s_numArgs[0] = x;
			_s_numArgs[1] = y;
			_s_numArgs[2] = z;
			components[componentIndex++].setNumArray( _s_numArgs );
		}
		
		if ( null == components[componentIndex] )
			components[componentIndex++] = new UV( u, v );
		else {
			_s_numArgs[0] = u;
			_s_numArgs[1] = v;
			components[componentIndex++].setNumArray( _s_numArgs );
		}
			
		if ( null == components[componentIndex] )
			components[componentIndex++] = new Normal( normalx, normaly, normalz );
		else {
			_s_intArgs[0] = normalx;
			_s_intArgs[1] = normaly;
			_s_intArgs[2] = normalz;
			components[componentIndex++].setIntArray( _s_intArgs );
		}

		if ( null == components[componentIndex] )
			components[componentIndex++] = new ColorUINT( tint );
		else	
			components[componentIndex++].setUint( tint );

		if ( null == components[componentIndex] )
			components[componentIndex++] = new ColorUINT( light );
		else	
			components[componentIndex++].setUint( light );
		
		return componentIndex;
	}
	
	
	private function buildIndices( facing:int ):void {
		var indiceIndex:int = 0;
		if (facing > 0) {
			// CCW
			_indices[indiceIndex++] = 0;
			_indices[indiceIndex++] = 1;
			_indices[indiceIndex++] = 2;
			
			_indices[indiceIndex++] = 2;
			_indices[indiceIndex++] = 3;
			_indices[indiceIndex++] = 0;
		} else {
			// CW
			_indices[indiceIndex++] = 0;
			_indices[indiceIndex++] = 2;
			_indices[indiceIndex++] = 1;
			
			_indices[indiceIndex++] = 2;
			_indices[indiceIndex++] = 0;
			_indices[indiceIndex++] = 3;
		}
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//     Member Functions 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static private const SCALE_FACTOR:uint = 16;
	private function addScaled( $type:int, $x:Number, $y:Number, $z:Number, $face:int, $planeFacing:int, $scale:Number, $ti:TypeInfo, $lighting:Lighting, $flowInfo:FlowInfo ):void
	{
		var sideBrightness:Number = 0.5;
		if ( $ti.lightInfo.lightSource || 1000 <= $type )
			sideBrightness = 1;
		
		var normal:int = 1;
		var vertexIndex:int = 0;
		var fs:FlowScaling = $flowInfo.flowScaling;
		var tint:uint = $lighting.color;
		switch ( $face ) 
		{
			case Globals.POSX:
				//trace( "Quad.addScaledVertices - addQuad POSX" );
				normal = -1 * $planeFacing;
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y         			 , $z			, _u[1]		, _v[3]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B100 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y + ($scale * fs.PxNz)/SCALE_FACTOR, $z			, _u[2]		, _v[0]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B110 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y + ($scale * fs.PxPz)/SCALE_FACTOR, $z + $scale	, _u[3]		, _v[1]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B111 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y         			 , $z + $scale	, _u[0]		, _v[2]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B101 ) );
				break;
				
			case Globals.NEGX:
				//trace( "Quad.addScaledVertices - addQuad NEGX" );
				normal = 1 * $planeFacing;
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y         			 , $z			, _u[3]		, _v[3]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B000 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y + ($scale * fs.NxNz)/SCALE_FACTOR, $z			, _u[0]		, _v[0]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B010 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y + ($scale * fs.NxPz)/SCALE_FACTOR, $z + $scale	, _u[1]		, _v[1]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B011 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y         			 , $z + $scale	, _u[2]		, _v[2]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B001 ) );
				break;
				
			case Globals.NEGY:
				//trace( "Quad.addStraightVertices - addQuad POSY" );
				normal = 1 * $planeFacing;
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y             	, $z			, _u[0]		, _v[0]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B000 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y             	, $z + $scale	, _u[3]		, _v[3]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B001 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y				, $z + $scale	, _u[2]		, _v[2]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B101 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y				, $z			, _u[1]		, _v[1]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B100 ) );
				break;
				
		case Globals.POSY:
				//trace( "Quad.addStraightVertices - addQuad NEGY" );
				normal = -1 * $planeFacing;
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y + ($scale * fs.NxNz)/SCALE_FACTOR	, $z			, _u[0]		, _v[0]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B010 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y + ($scale * fs.NxPz)/SCALE_FACTOR	, $z + $scale	, _u[3]		, _v[3]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B011 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y + ($scale * fs.PxPz)/SCALE_FACTOR	, $z + $scale	, _u[2]		, _v[2]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B111 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y + ($scale * fs.PxNz)/SCALE_FACTOR	, $z			, _u[1]		, _v[1]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B110 ) );
				break;

			case Globals.POSZ:
				//trace( "Quad.addScaledVertices - addQuad POSZ" );
				normal = -1 * $planeFacing;
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y						, $z + $scale	, _u[0]		, _v[2]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B001 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y						, $z + $scale	, _u[1]		, _v[3]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B101 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y + ($scale * fs.PxPz)/SCALE_FACTOR	, $z + $scale	, _u[2]		, _v[0]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B111 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y + ($scale * fs.NxPz)/SCALE_FACTOR	, $z + $scale	, _u[3]		, _v[1]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B011 ) );
				break;
				
			case Globals.NEGZ:
				//trace( "Quad.addScaledVertices - addQuad NEGZ" );
				normal = 1 * $planeFacing;
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y						, $z			, _u[2]		, _v[2]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B000 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y						, $z			, _u[3]		, _v[3]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B100 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x + $scale	, $y + ($scale * fs.PxNz)/SCALE_FACTOR	, $z			, _u[0]		, _v[0]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B110 ) );
				vertexIndex = buildVerticeComponents( vertexIndex, $x			, $y + ($scale * fs.NxNz)/SCALE_FACTOR	, $z			, _u[1]		, _v[1]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B010 ) );
				break;
				
			default:
				Log.out( "Quad.addStraightVertices - Plane INVALID", Log.ERROR );
			}
			
		buildIndices( normal );
	}
	
	private function add( $type:int, $x:Number, $y:Number, $z:Number, $face:int, $planeFacing:int, $scale:Number, $ti:TypeInfo, $lighting:Lighting ):void
	{
		//Log.out( "Quad.addStraightVerticesNew temp: " + brightness );
		//Log.out( "Quad.asvn - $planeFacing: " + $planeFacing );
		var componentIndex:int;
		var tint:uint = $lighting.color;
		
		var sideBrightness:Number = 0.5;
		var normal:int = 1;
		switch ( $face ) 
		{
			case Globals.POSX:
				//trace( "Quad.addStraightVertices - addQuad POSX" );
				normal = -1 * $planeFacing;
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y         	, $z			, _u[1]		, _v[3]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B100 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y + $scale	, $z			, _u[2]		, _v[0]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B110 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y + $scale	, $z + $scale	, _u[3]		, _v[1]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B111 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y         	, $z + $scale	, _u[0]		, _v[2]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B101 ) );
				break;
				
			case Globals.NEGX:
				//trace( "Quad.addStraightVertices - addQuad NEGX" );
				normal = 1 * $planeFacing;
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y         	, $z			, _u[3]		, _v[3]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B000 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y + $scale	, $z			, _u[0]		, _v[0]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B010 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y + $scale	, $z + $scale	, _u[1]		, _v[1]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B011 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y         	, $z + $scale	, _u[2]		, _v[2]		, normal, 0, 0, tint, $lighting.lightGetComposite( $face, Lighting.B001 ) );
				break;
				
			case Globals.NEGY:
				//trace( "Quad.addStraightVertices - addQuad POSY" );
				normal = 1 * $planeFacing;
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y            , $z			, _u[0]		, _v[0]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B000 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y            , $z + $scale	, _u[3]		, _v[3]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B001 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y			, $z + $scale	, _u[2]		, _v[2]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B101 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y			, $z			, _u[1]		, _v[1]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B100 ) );
				break;
				
			case Globals.POSY:
				//trace( "Quad.addStraightVertices - addQuad NEGY" );
				normal = -1 * $planeFacing;
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y + $scale	, $z			, _u[0]		, _v[0]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B010 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y + $scale	, $z + $scale	, _u[3]		, _v[3]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B011 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y + $scale	, $z + $scale	, _u[2]		, _v[2]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B111 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y + $scale	, $z			, _u[1]		, _v[1]		, 0, normal, 0, tint, $lighting.lightGetComposite( $face, Lighting.B110 ) );
				break;

			case Globals.POSZ:
				//trace( "Quad.addStraightVertices - addQuad POSZ" );
				normal = -1 * $planeFacing;
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y			, $z + $scale	, _u[0]		, _v[2]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B001 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y			, $z + $scale	, _u[1]		, _v[3]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B101 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y + $scale	, $z + $scale	, _u[2]		, _v[0]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B111 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y + $scale	, $z + $scale	, _u[3]		, _v[1]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B011 ) );
				break;
				
			case Globals.NEGZ:
				//trace( "Quad.addStraightVertices - addQuad NEGZ" );
				normal = 1 * $planeFacing;
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y			, $z			, _u[2]		, _v[2]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B000 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y			, $z			, _u[3]		, _v[3]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B100 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x + $scale, $y + $scale	, $z			, _u[0]		, _v[0]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B110 ) );
				componentIndex = buildVerticeComponents( componentIndex, $x			, $y + $scale	, $z			, _u[1]		, _v[1]		, 0, 0, normal, tint, $lighting.lightGetComposite( $face, Lighting.B010 ) );
				break;
				
			default:
				Log.out( "Quad.addStraightVertices - Plane INVALID", Log.ERROR );
		}
			
		buildIndices( normal );
	}
}
}

