package tests.factorylabs.orange.core.display{	import com.factorylabs.orange.core.display.FTextField;	import org.hamcrest.assertThat;	import org.hamcrest.object.equalTo;	import flash.display.Sprite;	/**	 * Generate the test cases for the FTextField class. 	 * 	 * <hr /> 	 * <p>Copyright 2004-2010 by <a href="http://www.factorylabs.com/">Factory Design Labs</a></p> 	 * 	 * Permission is hereby granted, free of charge, to any person obtaining 	 * a copy of this software and associated documentation files (the	 * "Software"), to deal in the Software without restriction, including	 * without limitation the rights to use, copy, modify, merge, publish,	 * distribute, sublicense, and/or sell copies of the Software, and to	 * permit persons to whom the Software is furnished to do so, subject to	 * the following conditions:<br /><br />	 *	 * The above copyright notice and this permission notice shall be	 * included in all copies or substantial portions of the Software.<br /><br />	 *	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 	 *	 * @author		Matthew Kitt	 * @version		1.0.0 :: Nov 28, 2009	 */	public class FTextFieldTests 	{		private var _sprite		:Sprite;		private var _ftextfield	:FTextField;				[BeforeClass]		public static function runBeforeClass() :void		{					}				[AfterClass]		public static function runAfterClass() :void		{					}				[Before(ui)]		public function runBeforeEachTest() :void		{			_sprite = new Sprite();			_ftextfield = new FTextField( _sprite, { x: 10, y: 10 } ); 		}				[After(ui)]		public function runAfterEachTest() :void		{			_sprite.removeChild( _ftextfield );			_ftextfield = null;			_sprite = null;		}				[Test]		public function constructor() :void		{			var ftxtNotOnStage :FTextField = new FTextField();			assertThat( _sprite.numChildren, equalTo( 1 ) );			assertThat( _sprite.contains( _ftextfield ), equalTo( true ) );			assertThat( _sprite.contains( ftxtNotOnStage ), equalTo( false ) );			assertThat( _ftextfield.tabEnabled, equalTo( false ) );		}				[Test]		public function setProperties() :void		{			assertThat( _ftextfield.x, equalTo( 10 ) );			assertThat( _ftextfield.y, equalTo( 10 ) );			_ftextfield.setProperties( { alpha: .5, visible: false } );			assertThat( _ftextfield.alpha, equalTo( .5 ) );			assertThat( _ftextfield.visible, equalTo( false ) );		}				[Test(expects='com.factorylabs.orange.core.errors.IllegalSetPropertiesError')]		public function setPropertiesExpectsError() :void		{			new FTextField( _sprite, { fail: true } );		}				[Test]		public function remove() :void		{			_ftextfield.remove();			assertThat( _sprite.numChildren, equalTo( 0 ) );			assertThat( _sprite.contains( _ftextfield ), equalTo( false ) );			_sprite.addChild( _ftextfield );		}				[Test]		public function multiline() :void		{			_ftextfield.multiline = true;			assertThat( _ftextfield.multiline, equalTo( true ) );			assertThat( _ftextfield.wordWrap, equalTo( true ) );						_ftextfield.multiline = false;			assertThat( _ftextfield.multiline, equalTo( false ) );			assertThat( _ftextfield.wordWrap, equalTo( false ) );		}	}}