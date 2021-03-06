
package com.factorylabs.orange.unit.core.utils
{
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertFalse;
  import asunit.asserts.assertTrue;

  import com.factorylabs.orange.core.utils.StringMethods;

  /**
   * Generate the test cases for the StringMethods class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Mar 16, 2009
   */
  public class StringMethodsTests
  {
    private var _wanker :String;
    private var _urlstr :String;

    [Before]
    public function runBeforeEachTest() :void
    {
      _wanker = 'gabe is a _wanker';
      _urlstr = 'http://factorylabs.com/';
    }

    [After]
    public function runAfterEachTest() :void
    {
      _wanker = '';
      _urlstr = '';
    }

    [Test]
    public function afterFirst() :void
    {
      assertEquals( StringMethods.afterFirst( _wanker, '_' ), 'wanker' );
      assertEquals( StringMethods.afterFirst( _wanker, ' ' ), 'is a _wanker' );
    }

    [Test]
    public function afterLast() :void
    {
      assertEquals( StringMethods.afterLast( _urlstr, '.' ), 'com/' );
      assertEquals( StringMethods.afterLast( _wanker, ' ' ), '_wanker' );
    }

    [Test]
    public function beginsWith() :void
    {
      assertTrue( StringMethods.beginsWith( 'XAAA', 'X' ) );
      assertTrue( StringMethods.beginsWith( 'XXAAA', 'XX' ) );
      assertTrue( StringMethods.beginsWith( 'XXXAAA', 'XX' ) );
      assertFalse( StringMethods.beginsWith( 'XX', '0' ) );
    }

    [Test]
    public function beforeFirst() :void
    {
      assertEquals( StringMethods.beforeFirst( _wanker, ' ' ), 'gabe' );
      assertEquals( StringMethods.beforeFirst( _wanker, '_' ), 'gabe is a ' );
      assertEquals( StringMethods.beforeFirst( _urlstr, '' ), '' );
    }

    [Test]
    public function beforeLast() :void
    {
      assertEquals( StringMethods.beforeLast( _wanker, '_' ), 'gabe is a ' );
      assertEquals( StringMethods.beforeLast( _urlstr, '.' ), 'http://factorylabs' );
    }

    [Test]
    public function between() :void
    {
      assertEquals( StringMethods.between( _urlstr, '//', '.' ), 'factorylabs' );
      assertEquals( StringMethods.between( _urlstr, 'h', 'p' ), 'tt' );
    }

    [Test]
    public function capitalize() :void
    {
      assertEquals( StringMethods.capitalize( _wanker ), 'Gabe is a _wanker' );
    }

    [Test]
    public function contains() :void
    {
      assertTrue( StringMethods.contains( _wanker, 'g' ) );
      assertTrue( StringMethods.contains( _wanker, 'gabe' ) );
      assertFalse( StringMethods.contains( _wanker, '3' ) );
    }

    [Test]
    public function countOf() :void
    {
      assertTrue( StringMethods.countOf( _urlstr, '/' ) == 3 );
      assertTrue( StringMethods.countOf( _urlstr, 'M' ) == 0 );
      assertTrue( StringMethods.countOf( _urlstr, 'm' ) == 1 );
    }

    [Test]
    public function endsWith() :void
    {
      assertTrue( StringMethods.endsWith( _urlstr, '/' ) );
      assertTrue( StringMethods.endsWith( _urlstr, 'com/' ) );
    }

    [Test]
    public function should_return_extension_from_file_name() :void
    {
      assertEquals( 'jpg', StringMethods.getExtension( 'image.jpg' ) );
      assertEquals( 'gif', StringMethods.getExtension( 'image.gif' ) );
    }

    [Test]
    public function should_return_extension_from_nested_file_name() :void
    {
      assertEquals( 'jpg', StringMethods.getExtension( 'somefile/image.jpg' ) );
      assertEquals( 'gif', StringMethods.getExtension( 'some/really/deep/nested/file/image.gif' ) );
    }

    [Test]
    public function hasText() :void
    {
      assertTrue( StringMethods.hasText( _urlstr ) );
      assertFalse( StringMethods.hasText( '  ' ) );
    }

    [Test]
    public function isEmpty() :void
    {
      assertFalse( StringMethods.isEmpty( _urlstr ) );
      assertTrue( StringMethods.isEmpty( '' ) );
    }

    [Test]
    public function isNumeric() :void
    {
      assertTrue( StringMethods.isNumeric( '123' ) );
      assertFalse( StringMethods.isNumeric( _urlstr ) );
      assertFalse( StringMethods.isNumeric( '  ' ) );
    }

    [Test]
    public function padLeft() :void
    {
      assertEquals( StringMethods.padLeft( 'abc', '-', 5 ), '--abc' );
    }

    [Test]
    public function padRight() :void
    {
      assertEquals( StringMethods.padRight( 'abc', '*', 10 ), 'abc*******' );
    }

    [Test]
    public function properCase() :void
    {
      assertEquals( StringMethods.properCase( _wanker), 'Gabe is a _wanker' );
    }

    [Test]
    public function quote() :void
    {
      assertEquals( StringMethods.quote( 'dog\'s' ), '"dog\'s"' );
    }

    [Test]
    public function remove() :void
    {
      assertEquals( StringMethods.remove( 'suck_er', '_', false ), 'sucker' );
      assertEquals( StringMethods.remove( 'suCk_ecr', 'C', true ), 'suk_ecr' );
    }

    [Test]
    public function removeExtraWhitespace() :void
    {
      assertEquals( StringMethods.removeExtraWhitespace( '\t\rsucker\n  ' ), 'sucker' );
    }

    [Test]
    public function replace() :void
    {
      var shred :String = 'shred the lip';
      assertEquals( 'shred the gnar', StringMethods.replace( shred, 'lip', 'gnar') );
    }

    [Test]
    public function reverse() :void
    {
      assertEquals( StringMethods.reverse( 'bargains' ), 'sniagrab' );
      assertEquals( StringMethods.reverse( 'get bargains' ), 'sniagrab teg' );
    }

    [Test]
    public function reverseWords() :void
    {
      assertEquals( StringMethods.reverseWords( 'shred the gnar' ), 'gnar the shred' );
    }

    [Test]
    public function stripTags() :void
    {
      assertEquals( StringMethods.stripTags( '<b>bold</b>' ), 'bold' );
      assertEquals( StringMethods.stripTags( '<a href="http://www.factorylabs.com/">link</a>' ), 'link' );
    }

    [Test]
    public function swapCase() :void
    {
      assertEquals( StringMethods.swapCase( 'Fugly' ), 'fugly' );
    }

    [Test]
    public function trim() :void
    {
      assertEquals( StringMethods.trim( '\t\n\rmansfield\t\n\r' ), 'mansfield' );
      assertEquals( StringMethods.trim( '   mansfield   ' ), 'mansfield' );
    }

    [Test]
    public function trimLeft() :void
    {
      assertEquals( StringMethods.trimLeft( '\t\n\rmansfield' ), 'mansfield' );
      assertEquals( StringMethods.trimLeft( '   mansfield' ), 'mansfield' );
      assertEquals( StringMethods.trimLeft( '   mansfield  ' ), 'mansfield  ' );
    }

    [Test]
    public function trimRight() :void
    {
      assertEquals( StringMethods.trimRight( 'mansfield\t\n\r' ), 'mansfield' );
      assertEquals( StringMethods.trimRight( 'mansfield   ' ), 'mansfield' );
      assertEquals( StringMethods.trimRight( '   mansfield  ' ), '   mansfield' );
    }

    [Test]
    public function wordCount() :void
    {
      assertEquals( StringMethods.wordCount( _wanker ), 4 );
    }

    [Test]
    public function truncate() :void
    {
      assertEquals( StringMethods.truncate( 'mansfield', 6, '...' ), 'man...' );
    }

    [Test]
    public function formatNumber() :void
    {
      assertEquals( StringMethods.formatNumber( 10256.434 ), '10,256' );
    }
  }
}

