package com.voxelengine.utils
{
  import org.flintparticles.common.actions.Age;
  import org.flintparticles.common.actions.ColorChange;
  import org.flintparticles.common.actions.ScaleImage;
  import org.flintparticles.common.counters.Steady;
  import org.flintparticles.common.initializers.Lifetime;
  import org.flintparticles.common.initializers.SharedImage;
  import org.flintparticles.threeD.actions.Accelerate;
  import org.flintparticles.threeD.actions.LinearDrag;
  import org.flintparticles.threeD.actions.Move;
  import org.flintparticles.threeD.actions.RotateToDirection;
  import org.flintparticles.threeD.emitters.Emitter3D;
  import org.flintparticles.threeD.initializers.Position;
  import org.flintparticles.threeD.initializers.Velocity;
  import org.flintparticles.threeD.zones.DiscZone;
  import org.flintparticles.common.displayObjects.RadialDot;

  import flash.geom.Vector3D;

  public class Fire extends Emitter3D
  {
    public function Fire()
    {
      counter = new Steady( 60 );

      addInitializer( new Lifetime( 2, 3 ) );
      addInitializer( new Velocity( new DiscZone( new Vector3D( 0, 0, 0 ), new Vector3D( 0, 1, 0 ), 20 ) ) );
      addInitializer( new Position( new DiscZone( new Vector3D( 0, 0, 0 ), new Vector3D( 0, 1, 0 ), 3 ) ) );
      //addInitializer( new SharedImage( new FireBlob() ) );
	  addInitializer( new SharedImage( new RadialDot() ) );
	  

      addAction( new Age( ) );
      addAction( new Move( ) );
      addAction( new LinearDrag( 1 ) );
      addAction( new Accelerate( new Vector3D( 0, -40, 0 ) ) );
      addAction( new ColorChange( 0xFFFFCC00, 0x00CC0000 ) );
      addAction( new ScaleImage( 1, 1.5 ) );
      addAction( new RotateToDirection() );
    }
  }
}