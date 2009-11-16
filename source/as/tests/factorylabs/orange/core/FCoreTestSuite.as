
package tests.factorylabs.orange.core 
{
	import tests.factorylabs.orange.core.collections.CollectionsTestSuite;
	import tests.factorylabs.orange.core.logging.LoggingTestSuite;

	/**
	 * Summary
	 * 
	 * <p>Description</p>
	 * 
	 * <p>Copyright 2009 by Factory Design Labs, All Rights Reserved.</p>
	 * <a href="http://www.factorylabs.com/">www.factorylabs.com</a>
	 *
	 * @author		Matthew Kitt
	 * @version		1.0.0 :: Nov 14, 2009
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FCoreTestSuite 
	{
		public var collectionsTestSuite	:CollectionsTestSuite;
		public var loggingTestSuite		:LoggingTestSuite;
	}
}