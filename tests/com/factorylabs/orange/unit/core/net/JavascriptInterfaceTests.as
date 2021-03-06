
package com.factorylabs.orange.unit.core.net
{
  import asunit.asserts.assertEqualsArrays;
  import asunit.asserts.assertEquals;

  import asunit4.async.addAsync;

  import com.factorylabs.orange.core.net.JavascriptInterface;

  /**
   * Generate the test cases for the Klass class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    grantdavis
   * @version   1.0.0 :: Feb 17, 2010
   */
  public class JavascriptInterfaceTests
  {
    private var _returnSequence :Array;

    [Before]
    public function runBeforeEachTest() :void
    {
    }

    [After]
    public function runAfterEachTest() :void
    {
    }

    [Test(async)]
    public function should_call_function_and_return_value() :void
    {
      var jsCall : XML = <javascript><![CDATA[function( value ){ return value; }]]></javascript>;
      JavascriptInterface.call( jsCall, 0, addAsync( handleReturnedValue, 1000 ), "orange" );
    }
    private function handleReturnedValue( value : String ) :void
    {
      assertEquals( "orange", value );
    }

    [Test(async)]
    public function should_execute_calls_by_priority() :void
    {
      _returnSequence = [];
      var jsCallA : XML = <javascript><![CDATA[function( value ){ return value; }]]></javascript>;
      var jsCallB : XML = <javascript><![CDATA[function( value ){ return value; }]]></javascript>;
      var jsCallC : XML = <javascript><![CDATA[function( value ){ return value; }]]></javascript>;
      JavascriptInterface.call(jsCallC, 2, addAsync( handleCallC, 1000 ), "first" );
      JavascriptInterface.call(jsCallB, 1, addAsync( handleCallB, 2000 ), "second" );
      JavascriptInterface.call(jsCallA, 0, addAsync( handleCallA, 3000 ), "third" );
    }
    private function handleCallA( $value : String ) :void
    {
      assertEquals( "third", $value );
      _returnSequence.push( $value );
      assertEqualsArrays( ["first","second","third"], _returnSequence );
    }

    private function handleCallB( $value : String ) :void
    {
      assertEquals( "second", $value );
      _returnSequence.push( $value );
    }
    private function handleCallC( $value : String ) :void
    {
      assertEquals( "first", $value );
      _returnSequence.push( $value );
    }

    [Test(async)]
    public function should_call_function_and_pass_mulitple_arugments() :void
    {
      var jsCall : XML = <javascript><![CDATA[function( a, b, c ){ return ( a + b ) * c; }]]></javascript>;
      JavascriptInterface.call(jsCall, 0, addAsync( handleMultipleArgs, 500 ), 1, 2, 5 );
    }
    private function handleMultipleArgs( $value :Number ) :void
    {
      assertEquals( 15, $value );
    }

    [Ignore('Figure out how to test opening popup windows.')]
    [Test]
    public function should_pop_window() :void
    {
      JavascriptInterface.openPopup( "http://google.com", "google", "toolbars=no" );
    }
  }
}

