
package com.factorylabs.orange.unit.core.display.fills
{
  import asunit.asserts.assertEqualsArrays;
  import asunit.asserts.assertEquals;

  import com.factorylabs.orange.core.display.fills.GradientFill;

  import flash.display.GradientType;
  import flash.display.InterpolationMethod;
  import flash.display.SpreadMethod;

  /**
   * Generate the test cases for the GradientFill class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Jan 11, 2010
   */
  public class GradientFillTests
  {
    private var _fill :GradientFill;

    [Before]
    public function runBeforeEachTest() :void
    {
      _fill = new GradientFill( 0, [ 0x000000, 0xff00ff ], [ 1, 1 ], [ 0, 255 ], GradientType.LINEAR, SpreadMethod.PAD, InterpolationMethod.RGB, 0 );
    }

    [After]
    public function runAfterEachTest() :void
    {
      _fill = null;
    }

    [Test]
    public function constructor() :void
    {
      assertEquals( _fill.rotation, 0 );
      assertEqualsArrays( _fill.colors, [ 0x000000, 0xff00ff ] );
      assertEqualsArrays( _fill.alphas, [ 1, 1 ] );
      assertEqualsArrays( _fill.ratios, [ 0, 255 ] );
      assertEquals( _fill.type, GradientType.LINEAR );
      assertEquals( _fill.spreadMethod, SpreadMethod.PAD );
      assertEquals( _fill.interpolationMethod, InterpolationMethod.RGB );
      assertEquals( _fill.focalPointRatio, 0 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function rotation() :void
    {
      _fill.rotation = 180;
      assertEquals( _fill.rotation, 180 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function colors() :void
    {
      _fill.colors = [ 0xffffff, 0x000000 ];
      assertEqualsArrays( _fill.colors, [ 0xffffff, 0x000000 ] );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function alphas() :void
    {
      _fill.alphas = [ 0, 0 ];
      assertEqualsArrays( _fill.alphas, [ 0, 0 ] );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function ratios() :void
    {
      _fill.ratios = [ 128, 128 ];
      assertEqualsArrays( _fill.ratios, [ 128, 128 ] );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function type() :void
    {
      _fill.type = GradientType.RADIAL;
      assertEquals( _fill.type, GradientType.RADIAL );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function spreadMethod() :void
    {
      _fill.spreadMethod = SpreadMethod.REFLECT;
      assertEquals( _fill.spreadMethod, SpreadMethod.REFLECT );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function interpolationMethod() :void
    {
      _fill.interpolationMethod = InterpolationMethod.LINEAR_RGB;
      assertEquals( _fill.interpolationMethod, InterpolationMethod.LINEAR_RGB );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function focalPointRatio() :void
    {
      _fill.focalPointRatio = 10;
      assertEquals( _fill.focalPointRatio, 10 );
    }
  }
}

