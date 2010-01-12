package tests.factorylabs.orange.core.display.fills{	import com.factorylabs.orange.core.display.fills.SolidFill;	import org.hamcrest.assertThat;	import org.hamcrest.object.equalTo;	/**	 * Generate the test cases for the SolidFill class.	 * 	 * <p>The <code>begin()</code> and <code>end()</code> methods are not tested since they are only hooks into native <code>Graphics</code> methods.	 * Visual tests have been performed to ensure these are working.</p> 	 * 	 * <hr /> 	 * <p>Copyright 2004-2010 by <a href="http://www.factorylabs.com/">Factory Design Labs</a></p> 	 * 	 * Permission is hereby granted, free of charge, to any person obtaining 	 * a copy of this software and associated documentation files (the	 * "Software"), to deal in the Software without restriction, including	 * without limitation the rights to use, copy, modify, merge, publish,	 * distribute, sublicense, and/or sell copies of the Software, and to	 * permit persons to whom the Software is furnished to do so, subject to	 * the following conditions:<br /><br />	 *	 * The above copyright notice and this permission notice shall be	 * included in all copies or substantial portions of the Software.<br /><br />	 *	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 	 *	 * @author		Matthew Kitt	 * @version		1.0.0 :: Dec 3, 2009	 */	public class SolidFillTests 	{		private var _fill	:SolidFill;				[BeforeClass]		public static function runBeforeClass() :void		{					}				[AfterClass]		public static function runAfterClass() :void		{					}				[Before]		public function runBeforeEachTest() :void		{			_fill = new SolidFill();		}				[After]		public function runAfterEachTest() :void		{			_fill = null;		}				[Test]		public function constructor() :void		{			assertThat( _fill.color, equalTo( 0xff00ff ) );			assertThat( _fill.alpha, equalTo( 1 ) );		}				[Test(description='Checks both the getter and setter.', tracker_id='')]		public function color() :void		{			_fill.color = 0x000000;			assertThat( _fill.color, equalTo( 0x000000 ) );		}				[Test(description='Checks both the getter and setter.', tracker_id='')]		public function alpha() :void		{			_fill.alpha = .5;			assertThat( _fill.alpha, equalTo( .5 ) );		}	}}