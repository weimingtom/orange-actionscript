package tests.factorylabs.orange.core.gc{	import asunit.framework.TestCase;	import tests.factorylabs.orange.helpers.MockDisposableClass;	import com.factorylabs.orange.core.gc.Janitor;	import flash.display.Bitmap;	import flash.display.Loader;	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.TimerEvent;	import flash.utils.Timer;	/**	 * Test methods for the Janitor test case. 	 *  	 * <p>Copyright 2004-2009 by Factory Design Labs</p>     *      * Permission is hereby granted, free of charge, to any person obtaining     * a copy of this software and associated documentation files (the     * "Software"), to deal in the Software without restriction, including     * without limitation the rights to use, copy, modify, merge, publish,     * distribute, sublicense, and/or sell copies of the Software, and to     * permit persons to whom the Software is furnished to do so, subject to     * the following conditions:     *      * The above copyright notice and this permission notice shall be     * included in all copies or substantial portions of the Software.     *      * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,     * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF     * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND     * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE     * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION     * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION     * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 	 * <a href="http://www.factorylabs.com/">www.factorylabs.com</a> 	 *  	 * @author		Matthew Kitt 	 * @version		1.0.0 :: May 21, 2009 	 */	public class JanitorTest		extends TestCase	{		private var _janitor		:Janitor;		private var _sprite1		:Sprite;		private var _sprite2		:Sprite;		private var _timer			:Timer;				public function JanitorTest()		{			super();		}				override public function toString() :String 		{			return "tests.factorylabs.orange.core.gc.JanitorTest";		}				override protected function setUp() :void		{			_janitor = new Janitor( this );			_sprite1 = new Sprite();			_sprite2 = new Sprite();			_timer = new Timer( 100, 1 );		}				override protected function tearDown() :void		{			_timer.stop();			_timer = null;			_janitor.cleanUp();			_janitor = null;		}		public function test_addEventListener() :void		{			_janitor.addEventListener( _timer, TimerEvent.TIMER_COMPLETE, addAsync( function( event:TimerEvent ):void {				_janitor.cleanUpEventListeners();				assertSame( _timer, event.target );			}, 500,			function( event:TimerEvent ):void {				fail( '[JanitorTest].handleEventFailedTrace()' );			}));			assertNotNull( _janitor.listeners[ _timer ][ TimerEvent.TIMER_COMPLETE ] );			_timer.start();		}				public function test_removeEventListener() :void		{			_janitor.addEventListener( _sprite1, Event.COMPLETE, fauxEventListener );			_janitor.removeEventListener( _sprite1, Event.COMPLETE, fauxEventListener );			assertNull( _janitor.listeners[ _sprite1 ][ Event.COMPLETE ] );		}				public function test_cleanUpEventListeners() :void		{			_janitor.addEventListener( _sprite1, Event.COMPLETE, fauxEventListener );			_janitor.addEventListener( _sprite2, Event.COMPLETE, fauxEventListener );						_janitor.removeEventListener( _sprite1, Event.COMPLETE, fauxEventListener );			_janitor.removeEventListener( _sprite2, Event.COMPLETE, fauxEventListener );			assertNull( _janitor.listeners[ _sprite1 ][ Event.COMPLETE ] );			assertNull( _janitor.listeners[ _sprite2 ][ Event.COMPLETE ] );		}				public function test_cleanUpChildren() :void		{						var container	:Sprite = new Sprite();			var sweeper		:Janitor = new Janitor( container );			var sprite1		:Sprite = new Sprite();			var sprite2		:Sprite = new Sprite();						container.addChild( sprite1 );			container.addChild( sprite2 );			assertEquals( container.numChildren, 2 );			sweeper.cleanUpChildren();			assertEquals( container.numChildren, 0 );						sweeper.cleanUp();			sweeper = null;		}				public function test_recurseCleanChildren() :void		{			var container	:Sprite = new Sprite();			var child_spr	:Sprite = new Sprite();			var child_mc 	:MovieClip = new MovieClip();			var child_bmp	:Bitmap = new Bitmap();			var child_ld 	:Loader = new Loader();			var gchild_spr	:Sprite = new Sprite();			var gchild_mc 	:MovieClip = new MovieClip();			var gchild_bmp	:Bitmap = new Bitmap();			var gchild_ld 	:Loader = new Loader();			var ggchild_spr	:Sprite = new Sprite();						// formatting denotes nesting of symbols.			container.addChild( child_spr );				child_spr.addChild( gchild_spr );					gchild_spr.addChild( ggchild_spr );				child_spr.addChild( gchild_mc );				child_spr.addChild( gchild_bmp );				child_spr.addChild( gchild_ld );			container.addChild( child_mc );			container.addChild( child_bmp );			container.addChild( child_ld );						assertEquals( container.numChildren, 4 );			assertEquals( child_spr.numChildren, 4 );			assertEquals( child_mc.numChildren, 0 );			assertEquals( gchild_spr.numChildren, 1 );						_janitor.recurseCleanChildren( container );						assertEquals( container.numChildren, 0 );			assertEquals( child_spr.numChildren, 0 );			assertEquals( child_mc.numChildren, 0 );			assertEquals( gchild_spr.numChildren, 0 );		}				public function test_addDisposable() :void		{			var disposer1 :MockDisposableClass = new MockDisposableClass();			_janitor.addDisposable( disposer1 );			assertNotNull( _janitor.disposables[ disposer1 ] );			_janitor.removeDisposable( disposer1 );		}				public function test_addDisposables() :void		{			var disposer1 :MockDisposableClass = new MockDisposableClass();			var disposer2 :MockDisposableClass = new MockDisposableClass();			var disposer3 :MockDisposableClass = new MockDisposableClass();						_janitor.addDisposables( disposer1, disposer2, disposer3 );						assertNotNull( _janitor.disposables[ disposer1 ] );			assertNotNull( _janitor.disposables[ disposer2 ] );			assertNotNull( _janitor.disposables[ disposer3 ] );						_janitor.removeDisposable( disposer1 );			_janitor.removeDisposable( disposer2 );			_janitor.removeDisposable( disposer3 );		}				[Test(description="Will only remove the iDisposable from the Janitor, it now becomes the duty of the class to dispose of the object.", tracker_id="")]		public function test_removeDisposable() :void		{			var disposer1 :MockDisposableClass = new MockDisposableClass();			_janitor.addDisposable( disposer1 );			_janitor.removeDisposable( disposer1 );			assertNull( _janitor.disposables[ disposer1 ] );		}				[Test(description="The Janitor does not null out the iDisposable after calling dispose(), it is the duty of the class who instantiated it to handle this.", tracker_id="")]		public function test_cleanUpDisposables() :void		{			var disposer1 :MockDisposableClass = new MockDisposableClass();			var disposer2 :MockDisposableClass = new MockDisposableClass();			var disposer3 :MockDisposableClass = new MockDisposableClass();						_janitor.addDisposables( disposer1, disposer2, disposer3 );						assertFalse( disposer1.isDisposed );			assertNotNull( _janitor.disposables[ disposer1 ] );			assertNotNull( _janitor.disposables[ disposer2 ] );			assertNotNull( _janitor.disposables[ disposer3 ] );						_janitor.cleanUpDisposables();						assertTrue( disposer1.isDisposed );			assertNull( _janitor.disposables[ disposer1 ] );			assertNull( _janitor.disposables[ disposer2 ] );			assertNull( _janitor.disposables[ disposer3 ] );		}		private function fauxEventListener( e :Event ) :void {}				private function handleEventVerified( e :TimerEvent, passThroughData :Object ) :void		{			_janitor.cleanUpEventListeners();			assertEquals( passThroughData[ 'message' ], '[Janitor].test_addEventListener()' );		}		private function handleEventFailed( data :Object ) :void		{			fail( '[JanitorTest].handleEventFailedTrace()' + data );		}	}}