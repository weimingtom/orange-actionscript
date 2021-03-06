
package com.factorylabs.orange.unit.core.math
{
  import asunit.asserts.assertEquals;

  import com.factorylabs.orange.core.math.PhysicsMethods;

  /**
   * Generate the test cases for the PhysicsMethods class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Nov 26, 2009
   */
  public class PhysicsMethodsTests
  {

    [Test]
    public function getAngleToTarget() :void
    {
      assertEquals( Math.round( PhysicsMethods.getAngleToTarget( 10, 20, 50, 70 ) ), 141 );
    }

    [Test]
    public function constrainAngle() :void
    {
      assertEquals( PhysicsMethods.constrainAngle( 720 ), 360 );
      assertEquals( PhysicsMethods.constrainAngle( -720 ), -360 );
    }

    [Test]
    public function getHypotenuse() :void
    {
      assertEquals( Math.round( PhysicsMethods.getHypotenuse( 10, 20, 50, 70 ) ), 64 );
    }
  }
}

