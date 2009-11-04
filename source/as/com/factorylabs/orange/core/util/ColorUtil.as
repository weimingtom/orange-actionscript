package com.factorylabs.orange.core.util{	/**	 * Special functions for common color conversion needs.	 * 	 * <p>Copyright 2004-2009 by Factory Design Labs</p>	 * 	 * Permission is hereby granted, free of charge, to any person obtaining	 * a copy of this software and associated documentation files (the	 * "Software"), to deal in the Software without restriction, including	 * without limitation the rights to use, copy, modify, merge, publish,	 * distribute, sublicense, and/or sell copies of the Software, and to	 * permit persons to whom the Software is furnished to do so, subject to	 * the following conditions:	 * 	 * The above copyright notice and this permission notice shall be	 * included in all copies or substantial portions of the Software.	 * 	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.	 * <a href="http://www.factorylabs.com/">www.factorylabs.com</a>	 * 	 * @author Justin Gitlin	 * @version 0.1	 */	public final class ColorUtil	{		/**		 *	Convert a string hex number to the native flash numbers that hex automatically get set to.		 *	@param	$hex	the, uh, hex string.		 *	@return			the flash Number representation of the hex color.		 */		public static function hexToFlashColorNumber( $hex :String ) :Number 		{			return Number( $hex );		}			/**		 *	Convert a native flash number to a string string hex number.		 *	@param	$flashColorNumber		the, native flash color Number.		 *	@return			the flash Number representation of the hex color.		 */		public static function flashColorNumberToHexString( $flashColorNumber:Number ):String 		{			return '0x' + $flashColorNumber.toString( 16 );		}				/**		 * Converts rgb color values to hex.		 * @param	$r		red		 * @param	$g		green		 * @param	$b		blue		 * @return	hex color number		 * @use		{@code var vHex:Number = ColorUtil.rgbToHex( 255, 70, 55 );}		 */		public static function rgbToHex( $r :Number, $g :Number, $b :Number ) :Number		{	        return ( $r << 16 | $g << 8 | $b );		}				/**		 * Converts argb color values to hex.		 * @param	$a		alpha		 * @param	$r		red		 * @param	$g		green		 * @param	$b		blue		 * @return	hex color number		 * @use		{@code var vHex:Number = ColorUtil.argbToHex( 30, 255, 70, 55 );}		 */		public static function argbToHex( $a :Number, $r :Number, $g :Number, $b :Number ) :Number		{		    return ( $a << 24 | $r << 16 | $g << 8 | $b );		}				/**		 * Converts a hex color number to an object with r, g, b properties.		 * @param	$hex	the hex color number.		 * @return 	an object with r, g, and b color numbers.		 * @use		{@code var vRgb:Number = ColorUtil.hexToRGB( 0xffffff );}		 */		public static function hexToRGB( $hex:Number ):Object		{			// bitwise shift the hex numbers.	        var red :Number = $hex >> 16;	        var grnBlu :Number = $hex - ( red << 16 );	        var grn :Number = grnBlu >> 8;	        var blu :Number = grnBlu - ( grn << 8 );	        	        // return the new object	        return( { r: red, g: grn, b: blu } );		}				/**		 * Converts a hex color number to an object with a, r, g, b properties.		 * @param	$hex	the hex color number.		 * @return 	an object with r, g, and b color numbers.		 * @use		{@code var vRgb:Number = ColorUtil.hexToARGB( 0x00ffffff );}		 */		public static function hexToARGB( $hex :Number ) :Object		{			var a :Number = ( $hex >> 24 ) & 0xFF;			var r :Number = ( $hex >> 16 ) & 0xFF;			var g :Number = ( $hex >> 8 ) & 0xFF;			var b :Number = ( $hex ) & 0xFF;		    return { a: a, r: r, b: b, g: g };		}			}}