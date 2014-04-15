/*==============================================================================
  Copyright 2011-2013 Robert Flesch
  All rights reserved.  This product contains computer programs, screen
  displays and printed documentation which are original works of
  authorship protected under United States Copyright Act.
  Unauthorized reproduction, translation, or display is prohibited.
==============================================================================*/

package com.voxelengine.renderer.shaders 
{
	import com.voxelengine.worldmodel.models.VoxelModel;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DTriangleFace;
	import flash.geom.Matrix3D;
	
	import com.voxelengine.Log;
	import com.voxelengine.Globals;

	import com.voxelengine.renderer.shaders.Shader;
	
	public class ShaderOxel extends Shader {

		public function ShaderOxel( $context:Context3D )
		{
			super( $context );
			createProgram( $context );
		}

		override public function update( $mvp:Matrix3D, $vm:VoxelModel, $selected:Boolean, $isChild:Boolean = false ): Boolean {
			if ( !update_texture() )
			{
				//Log.out( "ShaderOxel.update = update_texture returned false" );
				return false;
			}
			
			_context.setProgram( program3D );	
			setVertexData( $mvp, $vm );
			setFragmentData( $isChild, $vm );
			
			_context.setBlendFactors( Context3DBlendFactor.ONE, Context3DBlendFactor.ZERO);
			_context.setCulling(Context3DTriangleFace.BACK);
			
			return true;
		}
	}
}
