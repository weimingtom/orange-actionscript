
package com.factorylabs.orange.unit.core.display.graphics
{
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertFalse;
  import asunit.asserts.assertTrue;

  import com.factorylabs.orange.core.display.fills.SolidFill;
  import com.factorylabs.orange.core.display.graphics.FWedge;
  import com.factorylabs.orange.unit.helpers.MockCanvas;

  import flash.display.Shape;

  /**
   * Generate the test cases for the FWedge class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Jan 3, 2010
   */
  public class FWedgeTests
  {
    private var _canvas   :MockCanvas;
    private var _shape    :Shape;
    private var _fwedge   :FWedge;
    private var _magenta  :SolidFill;

    [Before(ui)]
    public function runBeforeEachTest() :void
    {
      _canvas = new MockCanvas();
      _shape = new Shape();
      _magenta = new SolidFill( 0xff00ff, .8 );
      _fwedge = new FWedge( _shape.graphics, 0, 0, 100, 270, _magenta, FWedge.COUNTER_CLOCKWISE, 0, false );
      _canvas.add( _shape );
    }

    [After(ui)]
    public function runAfterEachTest() :void
    {
      _shape.graphics.clear();
      _canvas.remove( _shape );
      _magenta = null;
      _fwedge = null;
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function gfx() :void
    {
      assertEquals( _fwedge.gfx, _shape.graphics );
      var tmpshape :Shape = new Shape();
      _fwedge.gfx = tmpshape.graphics;
      assertEquals( _fwedge.gfx, tmpshape.graphics );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function x() :void
    {
      assertEquals( _fwedge.x, 0 );
      _fwedge.x = 100;
      assertEquals( _fwedge.x, 100 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function y() :void
    {
      assertEquals( _fwedge.y, 0 );
      _fwedge.y = 100;
      assertEquals( _fwedge.y, 100 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function width() :void
    {
      assertEquals( _fwedge.width, 100 );
      _fwedge.width = 50;
      assertEquals( _fwedge.width, 50 );
      assertEquals( _fwedge.height, 50 );
      assertEquals( _fwedge.size, 50 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function height() :void
    {
      assertEquals( _fwedge.height, 100 );
      _fwedge.height = 10;
      assertEquals( _fwedge.height, 10 );
      assertEquals( _fwedge.width, 10 );
      assertEquals( _fwedge.size, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function size() :void
    {
      assertEquals( _fwedge.size, 100 );
      _fwedge.size = 10;
      assertEquals( _fwedge.height, 10 );
      assertEquals( _fwedge.width, 10 );
      assertEquals( _fwedge.size, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function fill() :void
    {
      assertEquals( _fwedge.fill, _magenta );
      var sf :SolidFill = new SolidFill( 0x000000, .4 );
      _fwedge.fill = sf;
      assertEquals( _fwedge.fill, sf );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function autoRedraw() :void
    {
      assertFalse( _fwedge.autoRedraw );
      _fwedge.autoRedraw = true;
      assertTrue( _fwedge.autoRedraw );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function arc() :void
    {
      assertEquals( _fwedge.arc, 270 );
      _fwedge.arc = 180;
      assertEquals( _fwedge.arc, 180 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function direction() :void
    {
      assertEquals( _fwedge.direction, FWedge.COUNTER_CLOCKWISE );
      _fwedge.direction = -1;
      assertEquals( _fwedge.direction, FWedge.CLOCKWISE );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function startAngle() :void
    {
      assertEquals( _fwedge.startAngle, 0 );
      _fwedge.startAngle = 20;
      assertEquals( _fwedge.startAngle, 20 );
    }

    [Test]
    public function draw() :void
    {
      _shape.graphics.clear();
      _fwedge.draw( { size: 25 } );
      assertEquals( _shape.width, 50 );
      assertEquals( _shape.height, 50 );
    }

    [Test]
    public function setProperties() :void
    {
      _fwedge.setProperties( { x: 100, size: 100 } );
      assertEquals( _fwedge.x, 100 );
      assertEquals( _fwedge.size, 100 );
    }

    [Test(expects='ArgumentError')]
    public function setPropertiesExpectsError() :void
    {
      _fwedge.setProperties( { fail: true } );
    }

    [Test]
    public function redraw() :void
    {
      _fwedge.autoRedraw = false;
      _fwedge.size = 25;
      assertEquals( _shape.width, 200 );
      assertEquals( _shape.height, 200 );
      _fwedge.redraw();
      assertEquals( _shape.width, 50 );
      assertEquals( _shape.height, 50 );
    }
  }
}

