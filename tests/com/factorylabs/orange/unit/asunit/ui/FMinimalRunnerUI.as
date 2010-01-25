
package com.factorylabs.orange.unit.asunit.ui 
{
	import asunit4.framework.IResult;
	import asunit4.framework.Result;
	import asunit4.runners.BaseRunner;

	import com.factorylabs.orange.unit.asunit.printers.ConsolePrinter;
	import com.factorylabs.orange.unit.asunit.printers.FMinimalPrinter;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.fscommand;

	/**
	 * Summary.
	 * 
	 * <p>Description.</p>
	 *
	 * <hr />
	 * <p>Copyright 2004-2010 by <a href="http://www.factorylabs.com/">Factory Design Labs</a></p>
	 *
	 * Permission is hereby granted, free of charge, to any person obtaining
	 * a copy of this software and associated documentation files (the
	 * "Software"), to deal in the Software without restriction, including
	 * without limitation the rights to use, copy, modify, merge, publish,
	 * distribute, sublicense, and/or sell copies of the Software, and to
	 * permit persons to whom the Software is furnished to do so, subject to
	 * the following conditions:<br /><br />
	 *
	 * The above copyright notice and this permission notice shall be
	 * included in all copies or substantial portions of the Software.<br /><br />
	 *
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	 *
	 * @author		Matthew Kitt
	 * @version		1.0.0 :: Jan 21, 2010
	 */
	public class FMinimalRunnerUI extends MovieClip 
	{		
		protected var printer	:FMinimalPrinter;
		protected var runner	:BaseRunner;
		protected var result	:IResult;
		
		public function FMinimalRunnerUI()
		{
			if (stage) 
			{
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
		}
		
		public function run( suite :Class ) :void
		{
			result = new Result();
			
			
			result.addListener( new ConsolePrinter() );
			
			printer = new FMinimalPrinter();
			printer.addEventListener( Event.COMPLETE, onRunnerComplete );
			result.addListener( printer );
			addChild( printer );
			
			runner = new BaseRunner();
			runner.run(suite, result);
		}
		
		protected function onRunnerComplete( $e :Event ) :void
		{
			fscommand('quit');
		}
	}
}