
package com.factorylabs.orange.unit.core.display.graphics
{
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertFalse;
  import asunit.asserts.assertTrue;

  import com.factorylabs.orange.core.display.fills.SolidFill;
  import com.factorylabs.orange.core.display.graphics.FCircle;
  import com.factorylabs.orange.unit.helpers.MockCanvas;

  import flash.display.Shape;

  /**
   * Generate the test cases for the FCircle class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Dec 28, 2009
   */
  public class FCircleTests
  {
    private var _canvas   :MockCanvas;
    private var _shape    :Shape;
    private var _fcircle  :FCircle;
    private var _magenta  :SolidFill;

    [Before(ui)]
    public function runBeforeEachTest() :void
    {
      _canvas = new MockCanvas();
      _shape = new Shape();
      _magenta = new SolidFill( 0xff00ff, .8 );
      _fcircle = new FCircle( _shape.graphics, 0, 0, 100, _magenta, false, false );
      _canvas.add( _shape );
    }

    [After(ui)]
    public function runAfterEachTest() :void
    {
      _shape.graphics.clear();
      _canvas.remove( _shape );
      _magenta = null;
      _fcircle = null;
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function gfx() :void
    {
      assertEquals( _fcircle.gfx, _shape.graphics );
      var tmpshape :Shape = new Shape();
      _fcircle.gfx = tmpshape.graphics;
      assertEquals( _fcircle.gfx, tmpshape.graphics );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function x() :void
    {
      assertEquals( _fcircle.x, 0 );
      _fcircle.x = 100;
      assertEquals( _fcircle.x, 100 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function y() :void
    {
      assertEquals( _fcircle.y, 0 );
      _fcircle.y = 100;
      assertEquals( _fcircle.y, 100 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function width() :void
    {
      assertEquals( _fcircle.width, 100 );
      _fcircle.width = 50;
      assertEquals( _fcircle.width, 50 );
      assertEquals( _fcircle.height, 50 );
      assertEquals( _fcircle.size, 50 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function height() :void
    {
      assertEquals( _fcircle.height, 100 );
      _fcircle.height = 10;
      assertEquals( _fcircle.height, 10 );
      assertEquals( _fcircle.width, 10 );
      assertEquals( _fcircle.size, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function size() :void
    {
      assertEquals( _fcircle.size, 100 );
      _fcircle.size = 10;
      assertEquals( _fcircle.height, 10 );
      assertEquals( _fcircle.width, 10 );
      assertEquals( _fcircle.size, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function fill() :void
    {
      assertEquals( _fcircle.fill, _magenta );
      var sf :SolidFill = new SolidFill( 0x000000, .4 );
      _fcircle.fill = sf;
      assertEquals( _fcircle.fill, sf );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function center() :void
    {
      _fcircle.center = true;
      assertTrue( _fcircle.center );
      assertEquals( _fcircle.x, 50 );
      assertEquals( _fcircle.y, 50 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function autoRedraw() :void
    {
      assertFalse( _fcircle.autoRedraw );
      _fcircle.autoRedraw = true;
      assertTrue( _fcircle.autoRedraw );
    }

    [Test]
    public function draw() :void
    {
      _shape.graphics.clear();
      _fcircle.draw( { size: 25 } );
      assertEquals( _fcircle.width, 25 );
      assertEquals( _fcircle.height, 25 );
      assertEquals( _shape.width, 25 );
      assertEquals( _shape.height, 25 );
    }

    [Test]
    public function setProperties() :void
    {
      _fcircle.setProperties( { x: 100, width: 100 } );
      assertEquals( _fcircle.x, 100 );
      assertEquals( _fcircle.width, 100 );
    }

    [Test(expects='ArgumentError')]
    public function setPropertiesExpectsError() :void
    {
      _fcircle.setProperties( { fail: true } );
    }


    [Test]
    public function redraw() :void
    {
      _fcircle.autoRedraw = false;
      _fcircle.size = 25;
      assertEquals( _shape.width, 100 );
      assertEquals( _shape.height, 100 );
      _fcircle.redraw();
      assertEquals( _shape.width, 25 );
      assertEquals( _shape.height, 25 );
    }
  }
}

