
package com.factorylabs.orange.unit.core.display.stage
{
  import flash.display.Stage;
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertEqualsArraysIgnoringOrder;
  import asunit.asserts.assertTrue;

  import com.factorylabs.orange.core.display.fills.SolidFill;
  import com.factorylabs.orange.core.display.graphics.FRectangle;
  import com.factorylabs.orange.core.display.stage.StageAlignment;
  import com.factorylabs.orange.core.signals.StageSignal;
  import com.factorylabs.orange.unit.helpers.MockCanvas;

  import flash.display.Sprite;
  import flash.display.StageAlign;

  /**
   * Generate the test cases for the StageAlignment class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 10, 2010
   */
  public class StageAlignmentTests
  {
    private var _canvas   :MockCanvas;

    private var _document :Sprite;
    private var _view   :Sprite;
    private var _stage    :Stage;

    private var _stagealign :StageAlignment;
    private var _viewalign  :StageAlignment;

    private var _signal   :StageSignal;

    [Before]
    public function runBeforeEachTest() :void
    {
      _canvas = new MockCanvas();
      _document = new Sprite();
      _view = new Sprite();
      _document.addChild( _view );
      _canvas.add( _document );
      _stage = _document.stage;

      new FRectangle( _view.graphics, 0, 0, 500, 100, new SolidFill( 0xFF00FF, 1 ) );

      _signal = new StageSignal(_document.stage);

      _stagealign = new StageAlignment( _document, _signal, 980, 580, StageAlign.TOP );
      _viewalign = new StageAlignment( _view, _signal );
    }

    [After]
    public function runAfterEachTest() :void
    {
      _signal.removeAll();
      _stagealign = null;
      _viewalign = null;
      _view.graphics.clear();
      _document.removeChild( _view );
      _canvas.remove( _document );
    }

    [Test]
    public function constructor() :void
    {
      assertTrue( '_stagealign is StageAlignment', _stagealign is StageAlignment );
      assertTrue( '_viewalign is StageAlignment', _viewalign is StageAlignment );
    }

    [Test]
    public function should_have_container() :void
    {
      assertEquals( _document, _stagealign.container );
    }

    [Test]
    public function containerWidth_should_be_equal_to_initial_widths() :void
    {
      assertEquals( _stagealign.containerWidth, 980 );
      assertEquals( _viewalign.containerWidth, 500 );
    }

    [Test]
    public function containerHeight_should_be_equal_to_initial_heights() :void
    {
      assertEquals( _stagealign.containerHeight, 580 );
      assertEquals( _viewalign.containerHeight, 100 );
    }

    [Test]
    public function setSize_with_params_should_set_containerWidth_containerHeight() :void
    {
      _viewalign.setSize( 1000, 200 );
      assertEquals( _viewalign.containerWidth, 1000 );
      assertEquals( _viewalign.containerHeight, 200 );
    }

    [Test]
    public function setSize_without_params_should_set_containerWidth_containerHeight_to_containers_width_height() :void
    {
      _view.graphics.clear();
      new FRectangle( _view.graphics, 0, 0, 100, 25, new SolidFill( 0xFF00FF, 1 ) );

      _viewalign.setSize();
      assertEquals( _viewalign.containerWidth, 100 );
      assertEquals( _viewalign.containerHeight, 25 );
    }

    [Test]
    public function should_have_default_position() :void
    {
      assertEquals( _stagealign.position, StageAlign.TOP );
      assertEquals( _viewalign.position, StageAlign.TOP_LEFT );
    }

    [Test]
    public function should_setPosition() :void
    {
      _stagealign.setPosition( StageAlign.BOTTOM );
      _viewalign.setPosition( StageAlign.TOP_RIGHT );
      assertEquals( _stagealign.position, StageAlign.BOTTOM );
      assertEquals( _viewalign.position, StageAlign.TOP_RIGHT );
    }

    [Test]
    public function should_have_default_padding_of_zeros() :void
    {
      assertEqualsArraysIgnoringOrder( _stagealign.padding, [0,0,0,0] );
    }

    [Test]
    public function should_setPadding_with_new_values() :void
    {
      _viewalign.setPadding( [10,20,30,40] );
      assertEqualsArraysIgnoringOrder( _viewalign.padding, [10,20,30,40] );
    }

    [Test(expects='ArgumentError')]
    public function should_throw_ArgumentError_on_invalid_padding_length() :void
    {
      _viewalign.setPadding( [0,10] );
    }

    [Test]
    public function should_force_onResize() :void
    {
      _viewalign.setPosition( StageAlign.BOTTOM );
      assertEquals( _view.x, ( _stage.stageWidth * .5 ) - 250 );
      assertEquals( _view.y, _stage.stageHeight - 100 );
      _viewalign.onResize();
    }

    [Test]
    public function should_move_container() :void
    {
      _viewalign.move( 100, 100 );
      assertEquals( _view.x, 100 );
      assertEquals( _view.y, 100 );
    }

    [Test]
    public function should_stop_responding_to_onResize_by_calling_dispose() :void
    {
      _viewalign.dispose();
      _stagealign.dispose();
      assertEquals( _signal.numListeners, 0 );
    }

//    The following Tests also evaluate the protected calculate, and aligning methods.

    [Test]
    public function should_align_to_top() :void
    {
      _viewalign.setPosition( StageAlign.TOP );
      assertEquals( _view.x, ( _stage.stageWidth * .5 ) - 250 );
      assertEquals( _view.y, 0 );
    }

    [Test]
    public function should_align_to_top_left() :void
    {
      _viewalign.setPosition( StageAlign.TOP_LEFT );
      assertEquals( _view.x, 0 );
      assertEquals( _view.y, 0 );
    }

    [Test]
    public function should_align_to_center() :void
    {
      _viewalign.setPosition( 'CENTER' );
      assertEquals( _view.x, ( _stage.stageWidth * .5 ) - 250 );
      assertEquals( _view.y, ( _stage.stageHeight * .5 ) - 50 );
    }

    [Test]
    public function should_align_to_bottom() :void
    {
      _viewalign.setPosition( StageAlign.BOTTOM );
      assertEquals( _view.x, ( _stage.stageWidth * .5 ) - 250 );
      assertEquals( _view.y, _stage.stageHeight - 100 );
    }

    [Test]
    public function should_align_to_left() :void
    {
      _viewalign.setPosition( StageAlign.LEFT );
      assertEquals( _view.x, 0 );
      assertEquals( _view.y, ( _stage.stageHeight * .5 ) - 50 );
    }

    [Test]
    public function should_align_to_right() :void
    {
      _viewalign.setPosition( StageAlign.RIGHT );
      assertEquals( _view.x, _stage.stageWidth - 500 );
      assertEquals( _view.y, ( _stage.stageHeight * .5 ) - 50 );
    }

    [Test]
    public function should_align_to_top_right() :void
    {
      _viewalign.setPosition( StageAlign.TOP_RIGHT );
      assertEquals( _view.x, _stage.stageWidth - 500 );
      assertEquals( _view.y, 0 );
    }

    [Test]
    public function should_align_to_bottom_left() :void
    {
      _viewalign.setPosition( StageAlign.BOTTOM_LEFT );
      assertEquals( _view.x, 0 );
      assertEquals( _view.y, _stage.stageHeight - 100 );
    }

    [Test]
    public function should_align_to_bottom_right() :void
    {
      _viewalign.setPosition( StageAlign.BOTTOM_RIGHT );
      assertEquals( _view.x, _stage.stageWidth - 500 );
      assertEquals( _view.y, _stage.stageHeight - 100 );
    }

    [Test]
    public function should_align_to_top_if_default_is_hit_on_switch_statement() :void
    {
      _viewalign.setPosition( StageAlign.TOP );
      assertEquals( _view.x, ( _stage.stageWidth * .5 ) - 250 );
      assertEquals( _view.y, 0 );
    }
  }
}

