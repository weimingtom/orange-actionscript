
package com.factorylabs.orange.unit.core.net
{
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertNotNull;
  import asunit.asserts.assertTrue;

  import asunit4.async.addAsync;

  import com.factorylabs.orange.core.net.FLoader;

  import org.osflash.signals.Signal;

  import flash.display.LoaderInfo;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import flash.net.URLRequest;

  /**
   * Generate the test cases for the FLoader class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 15, 2010
   */
  public class FLoaderTests
  {
    private var _floader  :FLoader;
    private var _signal   :Signal;
    private var _image    :String = 'http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif';
    private var _broken   :String = 'http://www.adobe.com/images/shared/download_buttons/get_shockwave_player.gif';
    private var _handler  :Function;

    [Before]
    public function runBeforeEachTest() :void
    {
      _floader = new FLoader( _broken );
      _signal = _floader.signal;
    }

    [After]
    public function runAfterEachTest() :void
    {
      _floader = null;
    }

    [Test]
    public function constructor() :void
    {
      assertTrue( '_floader is FLoader', _floader is FLoader );
      assertEquals( _broken, _floader.brokenImage );
    }

    [Test]
    public function should_have_created_a_reference_to_a_dispatcher() :void
    {
      assertTrue( '_floader.dispatcher is IEventDispatcher', _floader.dispatcher is IEventDispatcher );
    }

    [Test]
    public function should_have_created_a_reference_to_a_signal() :void
    {
      assertEquals( _signal, _floader.signal );
    }

    [Test]
    public function should_get_and_set_location_of_broken_image() :void
    {
      var loc :String = 'http://www.factorylabs.com/orange.jpg';
      _floader.brokenImage = loc;
      assertEquals( loc, _floader.brokenImage );
    }

    [Test(async)]
    public function should_load_with_success() :void
    {
      _handler = addAsync( onSignal, 100 );
      _signal.add( _handler );
      _floader.load( new URLRequest( _image ) );
    }

    private function onSignal( $type :String, $loaderInfo :LoaderInfo ) :void
    {
      assertEquals( Event.OPEN, $type );
      assertNotNull( $loaderInfo );
      _signal.remove( _handler );
    }
  }
}

