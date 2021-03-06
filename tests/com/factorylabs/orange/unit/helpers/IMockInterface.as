
package com.factorylabs.orange.unit.helpers
{
  import flash.display.Sprite;

  /**
   * Basic necessities to mock an interface.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: May 26, 2009
   */
  public interface IMockInterface
  {
    function method( $param1 :Number = NaN, $param2 :Sprite = null, $param3 :Array = null ) :void;
  }
}

