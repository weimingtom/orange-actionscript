
package com.factorylabs.orange.core.display.graphics 
{
	import flash.display.Graphics;

	/**
	 * Draws a square shape.
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
	 * @version		1.0.0 :: Jun 3, 2008
	 */
	public class FSquare
		extends FRectangle 
	{
		/**
		 * @private
		 */
		protected var _size :Number;
		
		/**
		 * Calls <code>set size</code> to keep the <code>width</code> and <code>height</code> equal.
		 * @inheritDoc
		 */
		override public function set width( $width :Number ) :void
		{
			size = $width;
		}
		
		/**
		 * Calls <code>set size</code> to keep the <code>width</code> and <code>height</code> equal.
		 * @inheritDoc
		 */
		override public function set height( $height :Number ) :void
		{
			size = $height;
		}
		
		/**
		 * Sets both the <code>width</code> and <code>height</code> equal. 
		 */
		public function get size() :Number 
		{ 
			return _size; 
		}
		public function set size( $size :Number ) :void
		{
			_size = $size;
			_width = $size;
			_height = $size;
			if( _autoRedraw )
				redraw();
		}
		
		/**
		 * Constructs and draws a square shape.
		 * @param $gfx			Reference to the <code>shape.graphics</code> where the shape will be drawn into.
		 * @param $x			A number indicating the horizontal position relative to the registration point of the parent display object.
		 * @param $y			A number indicating the vertical position relative to the registration point of the parent display object.
		 * @param $size			The <code>width</code> and <code>height</code> of the shape.
		 * @param $fill			Fill or line style to apply the shape.
		 * @param $center		Whether to draw the shape from a center registration.
		 * @param $autoRedraw	Determines if the graphic should auto redraw when a setter is called.
		 * 
		 * @example The following code creates a square.
	 	 * <listing version="3.0" >
	 	 * var sf : SolidFill = new SolidFill( 0x666666, .8 );
	 	 * var s1 : FSquare = new FSquare( _gfx.graphics, 0, 110, 200, sf );
	 	 * </listing>
		 */		
		{
			_size = $size;
			internalDraw();
		}
		
		/**
		 * @return	The string equivalent of this class.
		 */		
		override public function toString() :String 
		{
			return 'com.factorylabs.orange.core.display.graphics.FSquare';
		}
	}