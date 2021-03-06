
package com.factorylabs.orange.unit.core.net
{
  import asunit.asserts.assertTrue;

  import com.factorylabs.orange.core.net.JSPopupWindow;

  /**
   * Generate the test cases for the JSPopupWindow class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 12, 2010
   */
  public class JSPopupWindowTests
  {
    private var _popper :JSPopupWindow;

    [Before]
    public function runBeforeEachTest() :void
    {
      _popper = new JSPopupWindow( 'http://www.factorylabs.com/', 'title' );
    }

    [After]
    public function runAfterEachTest() :void
    {
      _popper = null;
    }

    [Test]
    public function constructor() :void
    {
      assertTrue( '_popper is JSPopupWindow', _popper is JSPopupWindow );
    }

    [Test(description='Since concatenating is generally not the same result, only test that there is a length')]
    public function should_generate_default_windowArguments() :void
    {
      assertTrue( _popper.getWindowArguments().length > 30 );
    }

    [Test(description='Since concatenating is generally not the same result, only test that arguments have been added')]
    public function should_generate_windowArguments_with_additional_args() :void
    {
      var defaults :String = _popper.getWindowArguments();
      _popper.alwaysLowered = 'yes';
      _popper.alwaysRaised = 'no';
      assertTrue( _popper.getWindowArguments().length > defaults.length );
    }
  }
}

