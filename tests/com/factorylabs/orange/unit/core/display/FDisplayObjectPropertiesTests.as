
package com.factorylabs.orange.unit.core.display
{
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertNotNull;
  import asunit.asserts.assertTrue;

  import com.factorylabs.orange.core.display.FDisplayObjectProperties;
  import com.factorylabs.orange.core.display.FSprite;

  import flash.display.Sprite;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  /**
   * Generate the test cases for the FDisplayObjectExtended class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Nov 29, 2009
   */
  public class FDisplayObjectPropertiesTests
  {
    private var _sprite     :Sprite;
    private var _fmock      :FDisplayObjectProperties;

    [Before(ui)]
    public function runBeforeEachTest() :void
    {
      _sprite = new Sprite();
      var fsprite :FSprite = new FSprite( _sprite, { x: 0, y: 0 } );
      _fmock = new FDisplayObjectProperties( fsprite );
    }

    [After(ui)]
    public function runAfterEachTest() :void
    {
      _sprite.removeChild( FSprite( _fmock.displayObject ) );
      _fmock = null;
      _sprite = null;
    }

    [Test]
    public function constructor() :void
    {
      assertTrue( _sprite.contains( FSprite( _fmock.displayObject ) ) );
      assertNotNull( _fmock );
      assertEquals( _fmock.bounds.x, 0 );
      assertEquals( _fmock.bounds.y, 0 );
      assertEquals( _fmock.bounds.width, 0 );
      assertEquals( _fmock.bounds.height, 0 );
      assertEquals( _fmock.offset.x, 0 );
      assertEquals( _fmock.offset.y, 0 );
    }

    [Test]
    public function displayObject() :void
    {
      assertNotNull( _fmock.displayObject );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function bounds() :void
    {
      assertNotNull( _fmock.bounds );
      _fmock.bounds = new Rectangle( 10, 10, 10, 10 );
      var xv :Number = _fmock.bounds.x;
      var yv :Number = _fmock.bounds.y;
      var wv :Number = _fmock.bounds.width;
      var hv :Number = _fmock.bounds.height;
      assertEquals( xv, 10 );
      assertEquals( yv, 10 );
      assertEquals( wv, 10 );
      assertEquals( hv, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function offset() :void
    {
      assertNotNull( _fmock.offset );
      _fmock.offset = new Point( 10, 10 );
      var xv :Number = _fmock.offset.x;
      var yv :Number = _fmock.offset.y;
      assertEquals( xv, 10 );
      assertEquals( yv, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function x() :void
    {
      assertEquals( _fmock.x, 0 );
      _fmock.offset = new Point( 10, 10 );
      assertEquals( _fmock.x, 10 );
      _fmock.x = 10;
      assertEquals( _fmock.x, 20 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function y() :void
    {
      assertEquals( _fmock.y, 0 );
      _fmock.offset = new Point( 10, 10 );
      assertEquals( _fmock.y, 10 );
      _fmock.y = 10;
      assertEquals( _fmock.y, 20 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function width() :void
    {
      assertEquals( _fmock.width, 0 );
      _fmock.width = 20;
      assertEquals( _fmock.width, 20 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function coordinates() :void
    {
      assertEquals( _fmock.x, 0 );
      assertEquals( _fmock.y, 0 );
      _fmock.coordinates = new Point( 10, 10 );
      assertEquals( _fmock.coordinates.x,  10 );
      assertEquals( _fmock.coordinates.y, 10 );
    }

    [Test(description='This is a read only property.', tracker_id='')]
    public function left() :void
    {
      assertEquals( _fmock.x, 0 );
      _fmock.offset = new Point( 10, 10 );
      assertEquals( _fmock.x, 10 );
      _fmock.x = 10;
      assertEquals( _fmock.left, 20 );
    }

    [Test(description='This is a read only property.', tracker_id='')]
    public function right() :void
    {
      assertEquals( _fmock.x, 0 );
      _fmock.offset = new Point( 10, 10 );
      _fmock.x = 10;
      _fmock.width = 20;
      assertEquals( _fmock.right, 40 );
    }

    [Test(description='This is a read only property.', tracker_id='')]
    public function top() :void
    {
      assertEquals( _fmock.y, 0 );
      _fmock.offset = new Point( 10, 10 );
      assertEquals( _fmock.y, 10 );
      _fmock.y = 10;
      assertEquals( _fmock.top, 20 );
    }

    [Test(description='This is a read only property.', tracker_id='')]
    public function bottom() :void
    {
      assertEquals( _fmock.y, 0 );
      _fmock.offset = new Point( 10, 10 );
      _fmock.y = 10;
      _fmock.height = 20;
      assertEquals( _fmock.bottom, 40 );
    }

    [Test(description='This is a read only property.', tracker_id='')]
    public function horizontalCenter() :void
    {
      _fmock.x = 10;
      _fmock.offset = new Point( 10, 0 );
      _fmock.width = 40;
      assertEquals( _fmock.horizontalCenter, 10 );
    }

    [Test(description='This is a read only property.', tracker_id='')]
    public function verticalCenter() :void
    {
      _fmock.y = 10;
      _fmock.offset = new Point( 0, 10 );
      _fmock.height = 40;
      assertEquals( _fmock.verticalCenter, 10 );
    }

    [Test(description='This is a read only property.', tracker_id='')]
    public function center() :void
    {
      _fmock.x = 10;
      _fmock.y = 10;
      _fmock.offset = new Point( 10, 10 );
      _fmock.width = 40;
      _fmock.height = 40;
      assertEquals( _fmock.center.x, 10 );
      assertEquals( _fmock.center.y, 10 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function globalX() :void
    {
      _fmock.x = 20;
      _fmock.offset = new Point( 20, 0 );
      _fmock.globalX = 20;
      assertEquals( _fmock.globalX, 40 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function globalY() :void
    {
      _fmock.y = 20;
      _fmock.offset = new Point( 0, 20 );
      _fmock.globalY = 20;
      assertEquals( _fmock.globalY, 40 );
    }

    [Test(description='Checks both the getter and setter.', tracker_id='')]
    public function globalCoordinates() :void
    {
      _fmock.x = 20;
      _fmock.y = 20;
      _fmock.offset = new Point( 20, 20 );
      _fmock.globalCoordinates = new Point( 20, 20 );
      assertEquals( _fmock.globalCoordinates.x, 40 );
      assertEquals( _fmock.globalCoordinates.y, 40 );
    }
  }
}

