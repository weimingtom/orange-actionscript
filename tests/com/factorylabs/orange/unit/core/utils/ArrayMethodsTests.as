
package com.factorylabs.orange.unit.core.utils
{
  import asunit.asserts.assertEqualsArraysIgnoringOrder;
  import asunit.asserts.assertNotNull;
  import asunit.asserts.assertTrue;
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertFalse;

  import com.factorylabs.orange.core.utils.ArrayMethods;

  /**
   * Generate the test cases for the ArrayMethods class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: March 16, 2008
   */
  public class ArrayMethodsTests
  {
    private var _array    :Array;
    private var _first    :int;
    private var _end    :int;
    private var _middle   :int;

    [Before]
    public function runBeforeEachTest() :void
    {
      _array = [ 0, 1, 2, 3, 4, 5, 6 ];
      _first = 0;
      _end = _array.length - 1;
      _middle = Math.round( _end * .5 );
    }

    [After]
    public function runAfterEachTest() :void
    {
      _array = null;
      _first = NaN;
      _end = NaN;
      _middle = NaN;
    }

    [Test]
    public function clone() :void
    {
      assertFalse( ArrayMethods.clone( _array ) == _array );
      assertEquals( ArrayMethods.clone( _array )[ _first ], _array[ _first ] );
      assertEquals( ArrayMethods.clone( _array )[ _middle ], _array[ _middle ] );
      assertEquals( ArrayMethods.clone( _array )[ _end ], _array[ _end ] );
    }

    [Test]
    public function contains() :void
    {
      assertEquals( ArrayMethods.contains( _array, 1 ), true );
      assertEquals( ArrayMethods.contains( _array, 666 ), false );
    }

    [Test]
    public function loop() :void
    {
      assertEquals( ArrayMethods.loop( _array, _end + 1 ), 0 );
      assertEquals( ArrayMethods.loop( _array, _middle ), _middle );
      assertEquals( ArrayMethods.loop( _array, -1 ), _end );
    }

    [Test]
    public function random() :void
    {
      var random :int = int( ArrayMethods.random( _array ) );
      assertTrue( hasItem(_array, random) );
      assertNotNull( random );
    }

    [Test]
    public function remove() :void
    {
      var clone :Array = ArrayMethods.clone( _array );
      ArrayMethods.remove( clone, 5 );
      assertEquals( clone == _array, false );
      assertEquals( ArrayMethods.contains( clone, 5 ), false );
    }

    [Test]
    public function search() :void
    {
      assertEquals( ArrayMethods.search( _array, 0 ), _first );
      assertEquals( ArrayMethods.search( _array, 3 ), _middle );
      assertEquals( ArrayMethods.search( _array, 6 ), _end );
    }

    [Test]
    public function shuffle() :void
    {
      var clone :Array = ArrayMethods.clone( _array );
      assertTrue( hasItem( _array, clone[ _end ] ) );
      assertEqualsArraysIgnoringOrder( _array, ArrayMethods.shuffle( clone, false ) );
      assertFalse( ArrayMethods.shuffle( clone, true ) == _array );
    }

    protected function hasItem( $array :Array, $item :int  ) :Boolean
    {
      var len :int = $array.length;
      for( var i :int = 0; i < len; ++i )
      {
        if( $array[ i ] == $item )
          return true;
      }
      return false;
    }
  }
}

