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
		
		protected			var		_context:Context3D = null;
		protected			var		_program3D:Program3D = null;	
		protected			var		_textureName:String = "assets/textures/oxel.png";
		protected			var		_textureScale:Number = 2048; 
		protected			var		_isAnimated:Boolean = false;
		protected			var		_textureOffsetU:Number = 0.0
		protected			var		_textureOffsetV:Number = 0.0
						
		protected 			var 	_offsets:Vector.<Number> = Vector.<Number>([0,0,0,0]);
		protected 			var 	_constants:Vector.<Number> = Vector.<Number>([0, 0, 0, 0, 0, 0, 0, 0]);
		
		static public  function     lights( index:int ):ShaderLight			{ return _s_lights[ index ]; }
		static public  function     lightCount():int 						{ return _s_lights.length; }
		static public  function     lightAdd( light:ShaderLight ):void 		{ _s_lights.push( light ); }
		static public  function     lightsClear():void 						{ _s_lights.length = 0; }
		
		public function		get		textureName():String  					{ return _textureName; }
		public function		set		textureName(val:String):void 			{ _textureName = val; }
		public function		get		textureScale():Number  					{ return _textureScale; }
		public function		set		textureScale(val:Number):void 			{ _textureScale = val; }
		public function		get		program3D():Program3D 					{ return _program3D; }
		public function		get		isAnimated():Boolean  					{ return _isAnimated; }
		public function		set		isAnimated(value:Boolean):void  		{ _isAnimated = value; }
		

		
		public function Shader( context:Context3D ) {
			_context = context;
			Quad.texture_scale_set( textureScale );
		}
		
		public function release():void { dispose(); }
		public function reinitialize( $context:Context3D ):void  { _context = $context; }
		public function update( mvp:Matrix3D, vm:VoxelModel, selected:Boolean, $isChild:Boolean = false ): Boolean { throw new Error( "Shader.update - NEEDS TO BE OVERRIDED" ); return true; }
		
		public function animationOffsets():void { 
			
			_textureOffsetV -= 0.000025;

			if ( _textureOffsetV < -0.953125 )
				_textureOffsetV = 0;
				
			_offsets[0] = _textureOffsetU;
			_offsets[1] = _textureOffsetV;
		}
		
		public function createProgram( $context:Context3D ):void {
			_context = $context;
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
				// base texture
				/////////////////////////////////////////////////
				"mul ft0, v1.xyz, ft0", // texture color - v3.xyz
				
				/////////////////////////////////////////////////
				// light from brightness
				"mul ft4, ft0, v1.w",   // add to base texture brightness - v3.w
				
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
				"add ft3.w, ft3.x, ft3.y", // add x^2 + y ^2 + z^2
				"add ft3.w, ft3.w, ft3.z",
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
				"mul ft2, ft2, ft5.z",  // multiple the lit texture, with the attenuated light effect
				"mul ft2.xyz, ft2.xyz, fc2.xyz",  // take result and multiple by light color
				// END light from dynamic lights
				/////////////////////////////////////////////////
				// nothing, just use light from the torch
				// OR
				//"max ft2, ft2, ft4",    // take the larger value between the dynamic light and brightness
				// OR
				//"add ft2, ft2, ft4",    // add the dynamic light and brightness
				//"sat ft2, ft2",     	// Clamp ft2 between 1 and 0, put result in ft2.
				// OR
				"max ft3.x, ft2.x, ft4.x",    // take the larger value between the dynamic light and brightness
				"max ft3.y, ft2.y, ft4.y",    // take the larger value between the dynamic light and brightness
				"max ft3.z, ft2.z, ft4.z",    // take the larger value between the dynamic light and brightness
				"max ft3.w, ft2.w, ft4.w",    // take the larger value between the dynamic light and brightness
				"sat ft2, ft3",     	// Clamp ft2 between 1 and 0, put result in ft2.

				"mov oc ft2"
			];
			
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT, fragmentShader.join("\n"));
			
			_program3D = _context.createProgram();
			_program3D.upload(vertexShaderAssembler.agalcode, fragmentAssembler.agalcode);
		}
		
		protected function setFragmentData( $isChild:Boolean, $vm:VoxelModel ): void {
			
			// TODO - pass in multiple lights
			var light:ShaderLight = lights(0);

			var lp:Vector3D = light.position;
			if ( $isChild )
			{
				// TO DO  - RSF - I think I need to handle the torch differently
				var topMost:VoxelModel = $vm.topmostControllingModel();
				lp = topMost.instanceInfo.worldToModel( light.position );
			}
			
			var i:int = 0;
			_constants[i++] = lp.x; // fc0
			_constants[i++] = lp.y;
			_constants[i++] = lp.z;
			_constants[i++] = lp.w; 
			_constants[i++] = 0.5; // fc1 - x is not used, could be light intensity
			_constants[i++] = light.nearDistance; // startLight;
			_constants[i++] = light.endDistance; // endLight;
			_constants[i++] = 1;
			_constants[i++] = light.color.x; // fc2
			_constants[i++] = light.color.y;
			_constants[i++] = light.color.z;
			_constants[i++] = 0;
			// This allows for moving light posision, light color
			_context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT , 0 , _constants );
		}

		protected function setVertexData( mvp:Matrix3D, $vm:VoxelModel ): void {
			// send down the view matrix
			_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, mvp, true); // aka vc0
			
			// now the model matrix so I can get the normals
			var invmat:Matrix3D = $vm.instanceInfo.modelMatrix.clone();
			invmat.transpose();
			_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, invmat, true); // aka vc4
			
			// and the inverted model matrix, which is world position ( free from camera data )
			var wsmat:Matrix3D = $vm.instanceInfo.worldSpaceMatrix.clone();
			_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 8, wsmat, true); // aka vc8
			
			if ( _isAnimated ) 
			{
				animationOffsets();
			}
			
			_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 12, _offsets);
		}
		
		public function setTextureInfo( json:Object ):void {
			if ( json.textureName )
				_textureName = json.textureName
			if ( json.textureScale )
				_textureScale = Number(json.textureScale);
		}
		
		protected function update_texture(): Boolean {
			
			var tex0:Texture = Globals.g_textureBank.getTexture( textureName );
			//var tex1:Texture = Globals.g_textureBank.getTexture( "assets/textures/x.png" );
			if ( !tex0 )
			{
				//Log.out( "Shader.update_texture - not ready textureName: " + textureName );
				return false;
			}
			if ( _context )
			{
				//Log.out( "Shader.update_texture - textureName: " + textureName );
				//_context.setTextureAt( 0, null );
				//_context.setTextureAt( 1, null );
				_context.setTextureAt( 0, tex0 );
				//_context.setTextureAt( 1, tex1 );
			}
			Quad.texture_scale_set( textureScale );
			
			return true;
		}
	
		public function dispose():void {
			_textureOffsetU = 0.0;
			_textureOffsetV = 0.0;
			_context = null;
			_program3D.dispose();
			_program3D = null;
			//Log.out( "Shader.dispose" );
		}
	}
}
