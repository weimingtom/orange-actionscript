
package com.factorylabs.orange.unit.core.signals
{
  import asunit.asserts.assertEquals;

  import com.factorylabs.orange.core.signals.BeaconSignal;
  import com.factorylabs.orange.unit.helpers.MockAsynchronous;

  /**
   * Generate the test cases for the BeaconSignal class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 4, 2010
   */
  public class BeaconSignalTests
  {
    private var _beacon :BeaconSignal;
    private var _mock :MockAsynchronous;
    private var _count  :uint;

    [Before]
    public function runBeforeEachTest() :void
    {
      _count = 0;
      _beacon = new BeaconSignal( new TwoFrame() );
      _beacon.add( incrementCounter );
      _mock = new MockAsynchronous();
    }

    [After]
    public function runAfterEachTest() :void
    {
      _beacon.removeAll();
      _beacon = null;
      _mock = null;
    }

    [Test]
    public function beacon_has_a_single_listener() :void
    {
      assertEquals( _beacon.numListeners, 1 );
    }

    private function incrementCounter() :void
    {
      _count ++;
    }
  }
}

