﻿package com.factorylabs.orange.core.gc{	import com.factorylabs.orange.core.IDisposable;	import flash.display.Bitmap;	import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;	import flash.display.Loader;	import flash.display.MovieClip;	import flash.events.IEventDispatcher;	import flash.utils.Dictionary;	/**	 * The janitor is used for garbage collection. 	 *  	 * <p>Janitor has methods within it to add and remove various objects that need to be removed from memory. There is also a one off clean method to collect everything.</p> 	 *  	 *  <p>The following people are credited with originating all or parts of this code:	 *	Grant Skinner :: www.gskinner.com	 *	 	 * <p>Copyright 2004-2009 by Factory Design Labs</p>     *      * Permission is hereby granted, free of charge, to any person obtaining     * a copy of this software and associated documentation files (the     * "Software"), to deal in the Software without restriction, including     * without limitation the rights to use, copy, modify, merge, publish,     * distribute, sublicense, and/or sell copies of the Software, and to     * permit persons to whom the Software is furnished to do so, subject to     * the following conditions:     *      * The above copyright notice and this permission notice shall be     * included in all copies or substantial portions of the Software.     *      * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,     * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF     * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND     * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE     * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION     * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION     * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 	 * <a href="http://www.factorylabs.com/">www.factorylabs.com</a> 	 *  	 * TODO It might be more convenient to change the Dictionary's to Maps, this way we we can access disposables and listeners via Keys.. ? 	 *  	 * @author		Ryan Boyajian 	 * @author		Grant Skinner 	 * @author		Matthew Kitt 	 * @version		1.0.0 :: Aug 19, 2008 	 * @version		1.5.0 :: March 6, 2009 :: Removed SoundChannel, Intervals, Timeouts, Timers, and Connections to lighten the load, implemented an interface for cleanUp. 	 */	public class Janitor		implements IJanitor	{/* * PROPERTIES**************************************************************************************************** */				/**		 * The object that instantiated this Janitor instance.		 */		private var _target			:Object;				/**		 * The collection of event listeners		 */		private var _listeners		:Dictionary;				/**		 * The collection of disposable objects.		 */		private var _disposables	:Dictionary;				/**		 * @private		 */		public function get listeners() :Dictionary { return _listeners; }				/**		 * @private		 */		public function get disposables() :Dictionary { return _disposables; }/* * CONSTRUCTOR**************************************************************************************************** */			/**		 * Create an instance of a Janitor and add it to the JanitorManager for cleanup.		 * @param target	who needs cleaning.		 */		public function Janitor( target :Object )		{			_target = target;			JanitorManager.instance.addJanitor( this );		}				/**		 * @return	string equivalent of this class.		 */		public function toString() :String 		{			return "com.factorylabs.orange.core.gc.Janitor";		}/* * PUBLIC ACCESS**************************************************************************************************** */		/**		 * Cleans those dirty little event listeners, children, disposables, the target and itself out of the manager.		 */		public function cleanUp() :void 		{			cleanUpEventListeners();			cleanUpChildren();			cleanUpDisposables();			cleanUpTarget();			JanitorManager.instance.removeJanitor( this );		}// Event Listeners ............................................................................. //		/**		 * Adds an event listener for forwarding from the Janitor object.		 * skinner note: useWeakReference is always true, this is a bit convoluted, but we don't want to maintain strong references back to event dispatchers.		 * @param dispatcher	The object sending out the event.		 * @param type			The Event.type		 * @param listener		The callback function		 * @param useCapture	Determines whether the listener works in the capture phase or the target and bubbling phases.		 * @param add			Whether to actually listen or not.		 * @param priority		The level of priority, the higher the number the greater the priority.		 */		public function addEventListener( dispatcher :IEventDispatcher, type :String, listener :Function, useCapture :Boolean = false, add :Boolean = true, priority :int = 0 ) :void 		{			if( add ) dispatcher.addEventListener( type, listener, useCapture, priority, true );			if ( !_listeners ) _listeners = new Dictionary( true );						var hash :Object = _listeners[ dispatcher ];			if( !hash ) hash = _listeners[ dispatcher ] = {};						var arr :Array = hash[ type ];			if( !arr ) hash[ type ] = arr = [];			var dl :uint = arr.length;			for( var i :uint = 0; i < dl; i++ ) 			{				var obj	:Object = arr[ i ];				if( obj[ 'listener' ] == listener && obj[ 'useCapture' ] == useCapture ) return;			}			arr.push( { listener: listener, useCapture: useCapture } );		}				/**		 * Removes an event listener via the Janitor object.		 * @param dispatcher	The object sending out the event.		 * @param type			The Event.type		 * @param listener		The callback function		 * @param useCapture	Determines whether the listener works in the capture phase or the target and bubbling phases.		 * @param remove		Whether to remove it from the dispatcher or just the janitor.		 */		public function removeEventListener( dispatcher :IEventDispatcher, type :String, listener :Function, useCapture :Boolean = false, remove :Boolean = true ) :void 		{			if( remove ) dispatcher.removeEventListener( type, listener, useCapture );			if( !_listeners || !_listeners[ dispatcher ] || !_listeners[ dispatcher ][ type ] ) return;						var arr :Array = _listeners[ dispatcher ][ type ];			var dl  :uint = arr.length;						for( var i :uint = 0; i < dl; i++ ) 			{				var obj :Object = arr[ i ];				if( obj[ 'listener' ] == listener && obj[ 'useCapture' ] == useCapture ) 				{					arr.splice( i, 1 );					delete _listeners[ dispatcher ][ type ];					return;				}			}		}				/**		 * Cleans up event listeners that have been added through this Janitor object.		 */		public function cleanUpEventListeners() :void		{			for( var dispatcher :Object in _listeners ) 			{				var hash :Object = _listeners[ dispatcher ];				for( var type :String in hash ) 				{					var arr :Array = hash[ type ];					while( arr.length > 0 ) 					{						var obj :Object = arr.pop();						try 						{							removeEventListener( ( dispatcher as IEventDispatcher ), type, ( obj[ 'listener' ] as Function ), Boolean( obj[ 'useCapture' ] ) );						} catch (e:*) {}					}				}			}		}		// Children ...................................................................................... //		/**		 * Modified gSkinner's function to recursively remove children from the bottom up.		 */		public function cleanUpChildren() :void 		{			recurseCleanChildren( _target );		}		/**		 * Added recursive display object removal, just to be sure everything's removed from the end leaf on up the display list.		 * @param dispObj	the display object getting swept in the loop.		 */		public function recurseCleanChildren( dispObj :* ) :void		{			if( !( dispObj is DisplayObjectContainer ) ) return;			var doc :DisplayObjectContainer = dispObj as DisplayObjectContainer;						while ( doc.numChildren > 0 ) 			{				var obj :DisplayObject = doc.getChildAt( 0 );								if( obj is MovieClip ) MovieClip( obj ).stop();								if( obj is Bitmap && Bitmap( obj ).bitmapData ) Bitmap( obj ).bitmapData.dispose();								if( obj is Loader ) 				{					cleanUpConnection( obj as Loader );					doc.removeChild( obj );					return;				}				else				{					recurseCleanChildren( obj );					doc.removeChild( obj );				}				// use try/catch instead of IDisposable so that we can define dispose in timeline code: if( !( obj is IDisposable ) ) { try { ( obj as Object ).dispose(); } catch ( err:* ) {} }			}		}				/**		 * Cleans up a connection using a series of try catch statements.		 * skinner note: because we're unsure what type of connection we have, and what it's status is, we have to use try catch.		 * @param connection	an open connection.		 */		public function cleanUpConnection( connection :Object ) :void 		{			try 			{				var content :Object = connection[ 'content' ];				if( content is IDisposable ) IDisposable( content ).dispose();			} catch( e1:* ) {}			try 			{//				connection.close();				connection[ 'close' ].apply( connection );			} catch( e2:* ) {}			try 			{//				connection.unload();				connection[ 'unload' ].apply( connection );			} catch( e3:* ) {}			try 			{//				connection.cancel();				connection[ 'cancel' ].apply( connection );			} catch( e4:* ) {}		}// Disposables .................................................................................. //				/**		 * Adds the arguments of IDisposables to the Dictionary.		 * @param disposables	an "n" number of disposables.		 */		public function addDisposables( ...disposables ) :void		{			var da :Array = disposables;			var dl :uint = da.length;			for( var i :uint = 0; i < dl; i++ )			{				var disposable:IDisposable = da[ i ] as IDisposable;				addDisposable( disposable );			}		}				/**		 * Adds an IDisposable to it's Dictionary.		 */		public function addDisposable( disposable :IDisposable ) :void 		{			if( !_disposables ) _disposables = new Dictionary( true );			_disposables[ disposable ] = true;		}				/**		 * Removes an IDisposable from it's Dictionary.		 */		public function removeDisposable( disposable :IDisposable ) :void 		{			if( !_disposables ) return;			delete( _disposables[ disposable ] );		}				/**		 * Cleans up all IDisposables in it's Dictionary by calling dispose on them.		 */		public function cleanUpDisposables() :void 		{			for( var disposable :Object in _disposables )			{				( disposable as IDisposable ).dispose();				removeDisposable( disposable as IDisposable );			}		}// Target ......................................................................................... //				/**		 * If the target is a movie clip, halt the timeline.		 */		public function cleanUpTarget() :void		{			if( _target is MovieClip ) MovieClip( _target ).stop();		}	}}