/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer.shaders 
{
	import com.voxelengine.renderer.ShaderLight;
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.display3D.textures.Texture;

	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	import com.voxelengine.Globals;
	import com.voxelengine.Log;
	import com.voxelengine.renderer.Quad;
	
	import com.adobe.utils.AGALMiniAssembler;
	
	
	public class Shader {

		static private      var     _s_lights:Vector.<ShaderLight> = new Vector.<ShaderLight>();
		
		protected			var		_program3D:Program3D = null;	
		protected			var		_textureName:String = "assets/textures/oxel.png";
		protected			var		_textureScale:Number = 2048; 
		protected			var		_isAnimated:Boolean = false;
		protected			var		_textureOffsetU:Number = 0.0
		protected			var		_textureOffsetV:Number = 0.0
						
		protected 			var 	_offsets:Vector.<Number> = Vector.<Number>([0,0,0,0]);
		protected 			var 	_constants:Vector.<Number> = Vector.<Number>([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
		
		static public  function     lights( index:int ):ShaderLight			{ return _s_lights[ index ]; }
		static public  function     lightCount():int 						{ return _s_lights.length; }
		static public  function     lightAdd( light:ShaderLight ):void 		{ _s_lights.push( light ); }
		static public  function     lightsClear():void 						{ 
			_s_lights = new Vector.<ShaderLight>(); 
		}
		
		public function		get		textureName():String  					{ return _textureName; }
		public function		set		textureName(val:String):void 			{ _textureName = val; }
		public function		get		textureScale():Number  					{ return _textureScale; }
		public function		set		textureScale(val:Number):void 			{ _textureScale = val; }
		public function		get		program3D():Program3D 					{ return _program3D; }
		public function		get		isAnimated():Boolean  					{ return _isAnimated; }
		public function		set		isAnimated(value:Boolean):void  		{ _isAnimated = value; }
		

		
		public function Shader( $context:Context3D ) {
			Quad.texture_scale_set( textureScale );
		}
		
		public function release():void { dispose(); }
		//public function reinitialize( $context:Context3D ):void  { _context = $context; }
		public function update( mvp:Matrix3D, vm:VoxelModel, $context:Context3D, selected:Boolean, $isChild:Boolean = false ): Boolean { throw new Error( "Shader.update - NEEDS TO BE OVERRIDED" ); return true; }
		
		public function animationOffsets():void { 
			
			_textureOffsetV -= 0.000025;

			if ( _textureOffsetV < -0.953125 )
				_textureOffsetV = 0;
				
			_offsets[0] = _textureOffsetU;
			_offsets[1] = _textureOffsetV;
		}
		
		public function createProgram( $context:Context3D ):void {
			//Log.out( "Shader.createProgram" );
//			_context = $context;
			// This uses 3 peices of vertex data from - setVertexData
			// va0 holds the vertex locations
			// va1 holds the UV texture offset
			// va2 holds the normal data ( in a very ineffiencent way )
			// and two constant values
			// vc0-3 hold the transform matrix for the camera
			// vc4 holds the UV offsets for the texture
			var vertexShader:Array =
			[
				"m44 vt0, va0, vc0", // transform vertex positions (va0) by the world camera data (vc0)
				// this result has the camera angle as part of the matrix, which is not good when calculating light
				"mov op, vt0",       // move the transformed vertex data (vt0) in output position (op)

				"add v0, va1, vc12.xy",	// add in the UV offset (va1) and the animated offset (vc12) (may be 0 for non animated), and put in v0 which holds the UV offset
				"mov v1, va3",        	// pass texture color and brightness (va3) to the fragment shader via v1
				"m44 v2, va2, vc4",  	// transform vertex normal, send to fragment shader
				
				// the transformed vertices without the camera data
//				"mov v3, vt0",       	// no no no
//				"mov v3, va0",       	// works great for default. Not for translated cube
//				"m44 v3, va0, vc0",  	// works great for default. Not for translated cube
//				"m44 v3, va0, vc4",  	// works great for default. Not for translated cube
				"m44 v3, va0, vc8",  	// the transformed vertices with out the camera data, works great for default AND for translated cube, rotated cube broken still
				"mov v4, va4",        	// pass light color and brightness (va4) to the fragment shader via v4
				
				// A non working method for a generated normal
				//"nrm vt1.xyz, va0.xyz",	// normalize the vertex (va0) into vt1. we need to mask the W component as the normalize operation only work for Vector3D
				//"mov vt1.w, va0.w",		// Set the w component back to its original value from va0 into vt1
				//"mov v2, vt1"			// Interpolate the normal (vt1) into variable register v1
			];
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble(Context3DProgramType.VERTEX, vertexShader.join("\n"));
			
			// This uses 4 peices of data from vertex shader
			// v0 holds the offset UV data
			// v1 holds the texture color and brightness
			// v2 holds the rotated normal data for the triangle
			// v3 holds the transformed vertex data
			// this shader also uses 2 values pass in thru the  -setFragmentData
			// fc0 - light pos
			// fc1 - dynamic lighting values
			// fc2 - dynamic light colors
			// temp registers
			// ft0 base texture data
			// ft1 transformed vertex data minus the light position
			// ft2 lambert lighting data
			// ft3 distance calculations
			// ft4 base texture time brightness
			var fragmentShader:Array =
			[
				// Texture
				// texture dimension. Options: 2d, cube
				// mip mapping. Options: nomip (or mipnone , they are the same) , mipnearest, miplinear
				// texture filtering. Options: nearest, linear
				// texture repeat. Options: repeat, wrap, clamp
				"tex ft0, v0, fs0 <2d,clamp,mipnearest>", // v1 is passed in from vertex, UV coordinates
				// now apply the color and brightness from the vertex attirbutes
				
				/////////////////////////////////////////////////
				// TINT on base texture
				/////////////////////////////////////////////////
				"mul ft0, v1.xyz, ft0", // mutliply by texture tint - v1.xyz
				
				/////////////////////////////////////////////////
				// light from brightness
				"mul ft4, v4.xyz, ft0", // modify the texture by multipling by the light color
"mul ft4, v4.w, ft4", 	// Ambient Occlusion - multiply by texture brightness ColorUINT.w
				
				/////////////////////////////////////////////////
				// light from dynamic lights
				/////////////////////////////////////////////////
				// normalize the light position
				"sub ft1, v3, fc0",		// subtract the light position from the transformed vertex postion
				
				"nrm ft1.xyz, ft1",     // normalize the light position (ft1)
														 
				// non flat shading
				"dp3 ft2, ft1, v2",     // dot the transformed normal with light direction
				"sat ft2, ft2",     	// Clamp ft2 between 1 and 0, put result in ft2.
				"mul ft2, ft2, ft0",    // multiply colorized texture by light amount
				
				// calculate the distance from the vertex
				// ft3.w holds the total distance
				"sub ft3, v3, fc0",		// subtract the light position from the transformed vertex postion
				"mul ft3, ft3, ft3", 	// square it
				"add ft3.w, ft3.x, ft3.y", // add w = x^2 + y ^2
				"add ft3.w, ft3.w, ft3.z", // add w + z^2
				"mov ft3.xyz, fc2.w", // set other components to 0 (fc2.w)
				"sqt ft3.w, ft3.w", // take sqr root - gives us distance to this vertex
				
				// now that we have the distance to the vertex
				// we use the rEnd - distance / rEnd - rStart formula to calcuate light influence
				// ft5 holds the light value for personal light
				"sub ft5.x, fc1.z, ft3.w", // rend - distance
				"mov ft3.z, fc1.z", // have to move rend to a non constant register (ft3.z) before I can operate on it
				"sub ft5.y, ft3.z, fc1.y", // rend - rstart
				"div ft5.z, ft5.x, ft5.y",  // rend - r / rend - rstart
				"mov ft5.xyw, fc2.w", // clear out other components to 0
				"mul ft2, ft0, ft5.z",  // multiple the UNlit texture, with the attenuated light effect !Critical Change, otherwise the torch is dependant on the static texture color.
				"mul ft2.xyz, ft2.xyz, fc2.xyz",  // take result and multiple by light color
				
"mul ft2, v4.w, ft2", 	// Ambient Occlusion - take result and multiple vertex brightness - not working....
				// END light from dynamic lights
				/////////////////////////////////////////////////
				
				////////////////////////////////////////////////////////////////////////////
				// FOG
				//"mul ft6",
				// END FOG
				////////////////////////////////////////////////////////////////////////////
				"max ft3, ft2, ft4",    // take the larger value between the dynamic light and static light
				"sat ft2, ft3",     	// Clamp ft2 between 1 and 0, put result in ft2.
				// OR
				// Not sure why it seemed this method was needed. - RSF
				//"max ft3.x, ft2.x, ft4.x",    // take the larger value between the dynamic light and brightness
				//"max ft3.y, ft2.y, ft4.y",    // take the larger value between the dynamic light and brightness
				//"max ft3.z, ft2.z, ft4.z",    // take the larger value between the dynamic light and brightness
				//"max ft3.w, ft2.w, ft4.w",    // take the larger value between the dynamic light and brightness
				//"sat ft2, ft3",     	// Clamp ft2 between 1 and 0, put result in ft2.

				// mixed static and dynamic values
				"mov oc ft2"
				
				// static only values
				//"mov oc ft4"
			];
			
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT, fragmentShader.join("\n"));
			
			_program3D = $context.createProgram();
			_program3D.upload(vertexShaderAssembler.agalcode, fragmentAssembler.agalcode);
		}
		
		protected function setFragmentData( $isChild:Boolean, $vm:VoxelModel, $context:Context3D ): void {
			
			// TODO - pass in multiple lights
			var lp:Vector3D;
			var color:Vector3D;
			var light:ShaderLight;
			var nearDistance:Number;
			var endDistance:Number;
			if ( 0 < Shader.lightCount() ) {
				light = lights(0);
				lp = light.position;
				color = light.color;
				nearDistance = light.nearDistance;
				endDistance = light.endDistance;
				if ( $isChild )
				{
					// TO DO  - RSF - I think I need to handle the torch differently
					var topMost:VoxelModel = $vm.topmostControllingModel();
					lp = topMost.instanceInfo.worldToModel( light.position );
				}
				var i:int = 0;
				_constants[i++] = lp.x; // light position    |
				_constants[i++] = lp.y; //                   |
				_constants[i++] = lp.z; //                   | FC0
				_constants[i++] = lp.w; //                   |_
				_constants[i++] = 0.5; // fc1.x -not used    |
				_constants[i++] = nearDistance; // startLight|
				_constants[i++] = endDistance; // endLight;  | FC1
				_constants[i++] = 1;//                       |_
				_constants[i++] = color.x; //                |
				_constants[i++] = color.y; //                |
				_constants[i++] = color.z; //                | FC2
				_constants[i++] = 0;       //                |_
			}
			
			// This allows for moving light posision, light color
			$context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT , 0 , _constants );
		}

		protected function setVertexData( mvp:Matrix3D, $vm:VoxelModel, $context:Context3D ): void {
			// send down the view matrix
			$context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, mvp, true); // aka vc0
			
			// now the model matrix so I can get the normals
			var invmat:Matrix3D = $vm.instanceInfo.modelMatrix.clone();
			invmat.transpose();
			$context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, invmat, true); // aka vc4
			
			// and the inverted model matrix, which is world position ( free from camera data )
			var wsmat:Matrix3D = $vm.instanceInfo.worldSpaceMatrix.clone();
			$context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 8, wsmat, true); // aka vc8
			
			if ( _isAnimated ) 
			{
				animationOffsets();
			}
			
			$context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 12, _offsets);
		}
		
		public function setTextureInfo( json:Object ):void {
			if ( json.textureName )
				_textureName = json.textureName
			if ( json.textureScale )
				_textureScale = Number(json.textureScale);
		}
		
		protected function update_texture( $context:Context3D ): Boolean {
			
			var tex0:Texture = Globals.g_textureBank.getTexture( $context, textureName );
			//var tex1:Texture = Globals.g_textureBank.getTexture( "assets/textures/x.png" );
			if ( !tex0 )
			{
				//Log.out( "Shader.update_texture - not ready textureName: " + textureName );
				return false;
			}
			if ( $context )
			{
				//Log.out( "Shader.update_texture - textureName: " + textureName );
				//$context.setTextureAt( 0, null );
				//$context.setTextureAt( 1, null );
				$context.setTextureAt( 0, tex0 );
				//$context.setTextureAt( 1, tex1 );
			}
			Quad.texture_scale_set( textureScale );
			
			return true;
		}
	
		public function dispose():void {
			_textureOffsetU = 0.0;
			_textureOffsetV = 0.0;
//			_context = null;
			if ( null != _program3D ) {
				_program3D.dispose();
				_program3D = null;
			}
			//Log.out( "Shader.dispose" );
		}
	}
}
