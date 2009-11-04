package tests.factorylabs.orange.core.util
{
	import asunit.framework.TestSuite;
	
	/**
 	 * Runs all of the tests in the util package
	 *
 	 * <p>Copyright 2004-2009 by Factory Design Labs</p>
     * 
     * Permission is hereby granted, free of charge, to any person obtaining
     * a copy of this software and associated documentation files (the
     * "Software"), to deal in the Software without restriction, including
     * without limitation the rights to use, copy, modify, merge, publish,
     * distribute, sublicense, and/or sell copies of the Software, and to
     * permit persons to whom the Software is furnished to do so, subject to
     * the following conditions:
     * 
     * The above copyright notice and this permission notice shall be
     * included in all copies or substantial portions of the Software.
     * 
     * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
     * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
     * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
     * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
     * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
     * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
     * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 	 * <a href="http://www.factorylabs.com/">www.factorylabs.com</a>
 	 * 
 	 * @author		Sean Dougherty
 	 * @version		1.0.0 :: Oct 26, 2009
 	 */
	public class AllTests 
		extends TestSuite
	{
		public function AllTests()
		{
			addTest( new ArrayUtilTest() );
			addTest( new ColorUtilTest() );
			addTest( new ConvertTest() );
			addTest( new LocaleTest() );
			addTest( new ValidateUtilTest() );
			addTest( new StringUtilTest() );
		}

		
		override public function toString() :String 
		{
			return 'tests.factorylabs.orange.core.logger.AllTests';
		}
	}
}