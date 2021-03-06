
package com.factorylabs.orange.unit.core.display
{
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertFalse;
  import asunit.asserts.assertTrue;

  import com.factorylabs.orange.core.display.FBitmap;

  import flash.display.Sprite;

  /**
   * Generate the test cases for the FBitmap class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Nov 27, 2009
   */
  public class FBitmapTests
  {
    private var _sprite   :Sprite;
    private var _fbitmap  :FBitmap;

    [Before(ui)]
    public function runBeforeEachTest() :void
    {
      _sprite = new Sprite();
      _fbitmap = new FBitmap( _sprite, null, { x: 10, y: 10 } );
    }

    [After(ui)]
    public function runAfterEachTest() :void
    {
      _sprite.removeChild( _fbitmap );
      _fbitmap = null;
      _sprite = null;
    }

    [Test]
    public function constructor() :void
    {
      var fbitmapNotOnStage :FBitmap = new FBitmap( );
      assertEquals( _sprite.numChildren, 1 );
      assertTrue( _sprite.contains( _fbitmap ) );
      assertFalse( _sprite.contains( fbitmapNotOnStage ) );
    }

    [Test]
    public function setProperties() :void
    {
      assertEquals( _fbitmap.x, 10 );
      assertEquals( _fbitmap.y, 10 );
      _fbitmap.setProperties( { alpha: .5, visible: false } );
      assertEquals( _fbitmap.alpha, .5 );
      assertFalse( _fbitmap.visible );
    }

    [Test(expects='ArgumentError')]
    public function setPropertiesExpectsError() :void
    {
      new FBitmap( _sprite, null, { fail: true } );
    }

    [Test]
    public function remove() :void
    {
      _fbitmap.remove();
      assertEquals( _sprite.numChildren, 0 );
      assertFalse( _sprite.contains( _fbitmap ) );
      _sprite.addChild( _fbitmap );
    }
  }
}

