package com.factorylabs.barebones{	import com.factorylabs.orange.core.IDisposable;	import com.factorylabs.orange.core.display.fills.SolidFill;	import com.factorylabs.orange.core.display.graphics.FRectangle;	import flash.display.MovieClip;	import flash.display.Stage;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	/**	 * Generates a basic hello world class.	 *	 * <hr />	 * <p>Copyright 2004-2010 by <a href="http://www.factorylabs.com/">Factory Design Labs</a></p>	 *	 * Permission is hereby granted, free of charge, to any person obtaining	 * a copy of this software and associated documentation files (the	 * "Software"), to deal in the Software without restriction, including	 * without limitation the rights to use, copy, modify, merge, publish,	 * distribute, sublicense, and/or sell copies of the Software, and to	 * permit persons to whom the Software is furnished to do so, subject to	 * the following conditions:<br /><br />	 *	 * The above copyright notice and this permission notice shall be	 * included in all copies or substantial portions of the Software.<br /><br />	 *	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.	 *	 * @author		Sean Dougherty	 * @version		1.0.0 :: Oct 22, 2009	 */	public class Main		extends MovieClip			implements IDisposable 	{		private var _testtxt	:TextField;			public function Main()		{			super();			stop();			if ( parent is Stage )				initialize();			else 				addEventListener( Event.ADDED_TO_STAGE, onStageAdd );		}				override public function toString() :String 		{			return 'com.factorylabs.barebones.Main';		}				public function dispose() :void		{			removeEventListener( Event.REMOVED_FROM_STAGE, onStageRemoval );			removeChild( _testtxt );		}				protected function initialize() :void		{			addEventListener( Event.REMOVED_FROM_STAGE, onStageRemoval );			setStageModes();			startup();		}				protected function setStageModes() :void		{			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;		}				protected function startup() :void		{			trace( '[Main].startup() => starting application' );			createTextField();			drawTestGraphic();		}				private function drawTestGraphic() :void		{			var fill :SolidFill = new SolidFill( 0x000000 );			var shape :FRectangle = new FRectangle( graphics, 100, 100, 500, 250, fill );		}				private function createTextField() :void		{			_testtxt = new TextField();			_testtxt.width = 500;			_testtxt.autoSize = TextFieldAutoSize.LEFT;			_testtxt.multiline = true;			_testtxt.wordWrap = true;			_testtxt.border = true;			_testtxt.text = 'Everything is orange.';			addChild( _testtxt );		}				private function onStageAdd( $e :Event ) :void		{			removeEventListener( Event.ADDED_TO_STAGE, onStageAdd );			initialize();		}				private function onStageRemoval( $e :Event ) :void		{			dispose();		}	}}