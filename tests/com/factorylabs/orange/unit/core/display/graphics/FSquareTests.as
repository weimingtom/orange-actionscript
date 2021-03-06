
package com.factorylabs.orange.unit.core.display.graphics
{
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertFalse;
  import asunit.asserts.assertTrue;

  import com.factorylabs.orange.core.display.fills.SolidFill;
  import com.factorylabs.orange.core.display.graphics.FSquare;
  import com.factorylabs.orange.unit.helpers.MockCanvas;

  import flash.display.Shape;

  /**
   * Generate the test cases for the FSquare class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Dec 6, 2009
   */
  public class FSquareTests
  {
    private var _canvas   :MockCanvas;
    private var _shape    :Shape;
    private var _fsquare  :FSquare;
    private var _magenta  :SolidFill;

    [Before(ui)]
    public function runBeforeEachTest() :void
    {
      _canvas = new MockCanvas();
      _shape = new Shape();
      _magenta = new SolidFill( 0xff00ff, .8 );
      _fsquare = new FSquare( _shape.graphics, 0, 0, 100, _magenta, false, false );
      _canvas.add( _shape );
    }

    [After(ui)]
    public function runAfterEachTest() :void
    {
      _shape.graphics.clear();
      _canvas.remove( _shape );
      _magenta = null;
      _fsquare = null;
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function gfx() :void
    {
      assertEquals( _fsquare.gfx, _shape.graphics );
      var tmpshape :Shape = new Shape();
      _fsquare.gfx = tmpshape.graphics;
      assertEquals( _fsquare.gfx, tmpshape.graphics );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function x() :void
    {
      assertEquals( _fsquare.x, 0 );
      _fsquare.x = 100;
      assertEquals( _fsquare.x, 100 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function y() :void
    {
      assertEquals( _fsquare.y, 0 );
      _fsquare.y = 100;
      assertEquals( _fsquare.y, 100 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function width() :void
    {
      assertEquals( _fsquare.width, 100 );
      _fsquare.width = 50;
      assertEquals( _fsquare.width, 50 );
      assertEquals( _fsquare.height, 50 );
      assertEquals( _fsquare.size, 50 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function height() :void
    {
      assertEquals( _fsquare.height, 100 );
      _fsquare.height = 10;
      assertEquals( _fsquare.height, 10 );
      assertEquals( _fsquare.width, 10 );
      assertEquals( _fsquare.size, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function size() :void
    {
      assertEquals( _fsquare.size, 100 );
      _fsquare.size = 10;
      assertEquals( _fsquare.height, 10 );
      assertEquals( _fsquare.width, 10 );
      assertEquals( _fsquare.size, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function fill() :void
    {
      assertEquals( _fsquare.fill, _magenta );
      var sf :SolidFill = new SolidFill( 0x000000, .4 );
      _fsquare.fill = sf;
      assertEquals( _fsquare.fill, sf );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function center() :void
    {
      _fsquare.center = true;
      assertTrue( _fsquare.center );
      assertEquals( _fsquare.x, 50 );
      assertEquals( _fsquare.y, 50 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function autoRedraw() :void
    {
      assertFalse( _fsquare.autoRedraw );
      _fsquare.autoRedraw = true;
      assertTrue( _fsquare.autoRedraw );
    }

    [Test]
    public function draw() :void
    {
      _shape.graphics.clear();
      _fsquare.draw( { size: 500 } );
      assertEquals( _fsquare.width, 500 );
      assertEquals( _fsquare.height, 500 );
      assertEquals( _shape.width, 500 );
      assertEquals( _shape.height, 500 );
    }

    [Test]
    public function setProperties() :void
    {
      _fsquare.setProperties( { size: 500, x: 100 } );
      assertEquals( _fsquare.x, 100 );
      assertEquals( _fsquare.size, 500 );
    }

    [Test(expects='ArgumentError')]
    public function setPropertiesExpectsError() :void
    {
      _fsquare.setProperties( { fail: true } );
    }

    [Test]
    public function redraw() :void
    {
      _fsquare.autoRedraw = false;
      _fsquare.size = 25;
      assertEquals( _shape.width, 100 );
      assertEquals( _shape.height, 100 );
      _fsquare.redraw();
      assertEquals( _shape.width, 25 );
      assertEquals( _shape.height, 25 );
    }
  }
}

