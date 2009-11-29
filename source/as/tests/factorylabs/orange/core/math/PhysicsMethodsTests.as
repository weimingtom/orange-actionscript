package tests.factorylabs.orange.core.math{	import org.hamcrest.object.equalTo;	import com.factorylabs.orange.core.math.PhysicsMethods;	import org.hamcrest.assertThat;	/**	 * Generate the test cases for the PhysicsMethods class. 	 * 	 * <hr /> 	 * <p>Copyright 2004-2009 by <a href="http://www.factorylabs.com/">Factory Design Labs</a></p> 	 * 	 * Permission is hereby granted, free of charge, to any person obtaining 	 * a copy of this software and associated documentation files (the	 * "Software"), to deal in the Software without restriction, including	 * without limitation the rights to use, copy, modify, merge, publish,	 * distribute, sublicense, and/or sell copies of the Software, and to	 * permit persons to whom the Software is furnished to do so, subject to	 * the following conditions:<br /><br />	 *	 * The above copyright notice and this permission notice shall be	 * included in all copies or substantial portions of the Software.<br /><br />	 *	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 	 *	 * @author		Matthew Kitt	 * @version		1.0.0 :: Nov 26, 2009	 */	public class PhysicsMethodsTests 	{				[BeforeClass]		public static function runBeforeClass() :void		{					}				[AfterClass]		public static function runAfterClass() :void		{					}				[Before]		public function runBeforeEachTest() :void		{					}				[After]		public function runAfterEachTest() :void		{					}				[Test]		public function getAngleToTarget() :void		{			assertThat( Math.round( PhysicsMethods.getAngleToTarget( 10, 20, 50, 70 ) ), equalTo( 141 ) );		}				[Test]		public function constrainAngle() :void		{			assertThat( PhysicsMethods.constrainAngle( 720 ), equalTo( 360 ) );			assertThat( PhysicsMethods.constrainAngle( -720 ), equalTo( -360 ) );		}				[Test]		public function getHypotenuse() :void		{			assertThat( Math.round( PhysicsMethods.getHypotenuse( 10, 20, 50, 70 ) ), equalTo( 64 ) );		}	}}