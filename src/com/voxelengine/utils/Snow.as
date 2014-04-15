package com.voxelengine.utils
{
  import com.voxelengine.Globals;
  import flash.geom.Point;  
  import flash.geom.Vector3D;
  
  import org.flintparticles.common.counters.*;
  import org.flintparticles.common.displayObjects.RadialDot;
  import org.flintparticles.common.initializers.*;
  import org.flintparticles.threeD.actions.*;
  import org.flintparticles.threeD.emitters.Emitter3D
  import org.flintparticles.threeD.initializers.*;
  import org.flintparticles.threeD.zones.*;
  
import org.flintparticles.common.actions.Age;
  import org.flintparticles.common.actions.Fade;
  import org.flintparticles.common.actions.ScaleImage;
  import org.flintparticles.common.counters.Steady;
  import org.flintparticles.common.displayObjects.RadialDot;
  import org.flintparticles.common.initializers.Lifetime;
  import org.flintparticles.common.initializers.SharedImage;
  import org.flintparticles.threeD.actions.LinearDrag;
  import org.flintparticles.threeD.actions.Move;
  import org.flintparticles.threeD.actions.RandomDrift;
  import org.flintparticles.threeD.emitters.Emitter3D;
  import org.flintparticles.threeD.initializers.Velocity;
  import org.flintparticles.threeD.zones.ConeZone;  

  public class Snow extends Emitter3D
  {
	  /*
    public function Snow()
    {
      counter = new Steady( 100 );
      
      addInitializer( new ImageClass( RadialDot, [2] ) );
      addInitializer( new Position( new LineZone( new Vector3D( -5, -5, -5 ), new Vector3D( 500, -5, -5 ) ) ) );
      addInitializer( new Velocity( new PointZone( new Vector3D( 0, 65, 0 ) ) ) );
      addInitializer( new ScaleImageInit( 0.75, 2 ) );
      
      addAction( new Move() );
      //addAction( new DeathZone( new Zone3D( -10, -10, Globals.g_renderer.width * 1.05, Globals.g_renderer.height * 1.05 ), true ) );
      addAction( new RandomDrift( 15, 15 ) );
    }
	*/
	public function Snow() // Smoke
    {
      counter = new Steady( 10 );
      
      addInitializer( new Lifetime( 11, 12 ) );
      addInitializer( new Velocity( new ConeZone( new Vector3D( 0, 0, 0 ), new Vector3D( 0, -1, 0 ), 0.5, 40, 30 ) ) );
      addInitializer( new SharedImage( new RadialDot( 6 ) ) );
      
      addAction( new Age( ) );
      addAction( new Move( ) );
      addAction( new LinearDrag( 0.01 ) );
      addAction( new ScaleImage( 1, 15 ) );
      addAction( new Fade( 0.15, 0 ) );
      addAction( new RandomDrift( 15, 15, 15 ) );
    }	
  }
}