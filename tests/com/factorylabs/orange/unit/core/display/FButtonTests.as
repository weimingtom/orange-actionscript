package com.factorylabs.orange.unit.core.display{	import asunit.asserts.assertFalse;	import asunit.asserts.assertTrue;	import com.factorylabs.orange.core.display.FButton;	import com.factorylabs.orange.unit.helpers.MockFButtonStyle;	/**	 * Generate the test cases for the FButton class. 	 * 	 * <hr />	 * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>	 * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>	 * 	 * <p>Permission is hereby granted to use, modify, and distribute this file 	 * in accordance with the terms of the license agreement accompanying it.</p> 	 *	 * @author		Matthew Kitt	 * @version		1.0.0 :: Feb 8, 2010	 */	public class FButtonTests 	{		private var _button	:FButton;		private var _style	:MockFButtonStyle;				[Before]		public function runBeforeEachTest() :void		{			_style = new MockFButtonStyle();			_button = new FButton( _style );		}				[After]		public function runAfterEachTest() :void		{			_button = null;		}				[Test]		public function constructor() :void		{			assertTrue( '_button is FButton', _button is FButton );		}				[Test]		public function should_have_defaults_set() :void		{			assertFalse( _button.mouseChildren );			assertTrue( _button.mouseEnabled );			assertTrue( _button.buttonMode );			assertTrue( _button.useHandCursor );		}				[Test]		public function should_have_defaults_overridden_by_init() :void		{			var btn :FButton = new FButton( _style, null, { 													mouseChildren: true, 													mouseEnabled: false, 													buttonMode: false, 													useHandCursor: false } );			assertTrue( btn.mouseChildren );			assertFalse( btn.mouseEnabled );			assertFalse( btn.buttonMode );			assertFalse( btn.useHandCursor );		}				[Test]		public function should_handleInteraction() :void		{//			fail( 'should just fail' );//			_button.handleInteraction();		}		//		[Test]//		public function button_has_over_method() :void//		{//			assertNotNull( _button[ 'over' ] );//		}			}}/*- FButton should know it's state (over/highlight?, down, normal, selected, enabled, disabled)  - FButton should have a way to store random bits of data for convenience  - FButton should be able to have a style object injected  - FButton styles should not be a display object  - FButton styling should work on callbacks  - FButton should dispatch signals instead of events  - FButton's states should be testable  - FButton styles should be testable*/