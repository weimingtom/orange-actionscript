package tests.factorylabs.orange.core.utils{	import com.factorylabs.orange.core.utils.Convert;	import org.hamcrest.assertThat;	import org.hamcrest.object.equalTo;	/**	 * Generate the test cases for the Convert class. 	 * 	 * <hr /> 	 * <p>Copyright 2004-2010 by <a href="http://www.factorylabs.com/">Factory Design Labs</a></p> 	 * 	 * Permission is hereby granted, free of charge, to any person obtaining 	 * a copy of this software and associated documentation files (the	 * "Software"), to deal in the Software without restriction, including	 * without limitation the rights to use, copy, modify, merge, publish,	 * distribute, sublicense, and/or sell copies of the Software, and to	 * permit persons to whom the Software is furnished to do so, subject to	 * the following conditions:<br /><br />	 *	 * The above copyright notice and this permission notice shall be	 * included in all copies or substantial portions of the Software.<br /><br />	 *	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 	 *	 * @author		Matthew Kitt	 * @version		1.0.0 :: Mar 15, 2009	 */	public class ConvertTests 	{		[BeforeClass]		public static function runBeforeClass() :void		{					}				[AfterClass]		public static function runAfterClass() :void		{					}				[Before]		public function runBeforeEachTest() :void		{					}				[After]		public function runAfterEachTest() :void		{					}				[Test]		public function toBoolean() :void		{			assertThat( Convert.toBoolean( 'true' ), equalTo( true ) );			assertThat( Convert.toBoolean( 1 ), equalTo( true ) );			assertThat( Convert.toBoolean( 'false' ), equalTo( false ) );			assertThat( Convert.toBoolean( 0 ), equalTo( false ) );		}				[Test(expects='Error')]		public function toBooleanShouldFail() :void		{			Convert.toBoolean( {} );		}				[Test]		public function convertTime() :void		{			assertThat( Convert.convertTime( 5000 ),  equalTo( '00:05' )  );			assertThat( Convert.convertTime( 65000 ),  equalTo( '01:05' )  );			assertThat( Convert.convertTime( NaN ),  equalTo( '' )  );		}	}}