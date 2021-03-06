
package com.factorylabs.orange.unit.core.net
{
  import asunit.asserts.assertEquals;
  import asunit.asserts.assertNotNull;
  import asunit.asserts.assertNull;
  import asunit.asserts.assertSame;
  import asunit.asserts.assertTrue;

  import asunit4.async.addAsync;

  import com.factorylabs.orange.core.net.LoadItem;
  import com.factorylabs.orange.core.net.LoaderManager;

  import flash.net.URLRequest;

  /**
   * Generate the test cases for the LoaderManager class.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Davis
   * @version   1.0.0 :: Feb 19, 2010
   */
  public class LoaderManagerTests
  {
    private var _imageUrl       :String = 'http://betas.factorylabs.com/Interactive/tests/image.gif';
    private var _brokenUrl      :String = 'http://betas.factorylabs.com/file-does-not-exist.jpg';
    private var _loaderMgr      :LoaderManager;
    private var _loader       :LoadItem;
    private var _handler      :Function;
    private var _loadCount      :uint;

    [Before]
    public function runBeforeEachTest() :void
    {
      _loadCount = 0;
      _loaderMgr = new LoaderManager( 1 );
    }

    [After]
    public function runAfterEachTest() :void
    {
      _loaderMgr.dispose();
      _loaderMgr = null;
    }

    [Test]
    public function constructor() :void
    {
      assertTrue( '_loaderMgr is LoaderManager', _loaderMgr is LoaderManager );
    }

    [Test]
    public function should_dispose_and_remove_references() :void
    {
      _loaderMgr.dispose();
      assertNull( _loaderMgr.allCompleteSignal );
      assertNull( _loaderMgr.completeSignal );
      assertNull( _loaderMgr.loadStartSignal );
      assertNull( _loaderMgr.itemAddedSignal );
      assertNull( _loaderMgr.pausedSignal );
      assertNull( _loaderMgr.progressSignal );
      assertNull( _loaderMgr.overallProgressSignal );
      assertNull( _loaderMgr.errorSignal );
      // recreate so the finish method doesn't freak
      _loaderMgr = new LoaderManager();
    }

    [Test]
    public function should_create_signal_references() :void
    {
      assertNotNull( _loaderMgr.allCompleteSignal );
      assertNotNull( _loaderMgr.completeSignal );
      assertNotNull( _loaderMgr.loadStartSignal );
      assertNotNull( _loaderMgr.itemAddedSignal );
      assertNotNull( _loaderMgr.pausedSignal );
      assertNotNull( _loaderMgr.progressSignal );
      assertNotNull( _loaderMgr.overallProgressSignal );
      assertNotNull( _loaderMgr.errorSignal );
    }

    [Test]
    public function should_set_max_connections() :void
    {
      _loaderMgr.dispose();
      _loaderMgr = new LoaderManager( 3 );
      assertEquals( _loaderMgr.maxConnections, 3 );
    }

    /* Item Adding/Removing/Retrieving Tests */

    [Test]
    public function should_add_and_return_item_by_key() :void
    {
      _loader = new LoadItem( new URLRequest( _imageUrl ));
      _loaderMgr.add( "a", _loader );
      var returned : LoadItem = _loaderMgr.getLoadItem( "a" );
      assertSame( returned, _loader );
    }

    [Test]
    public function should_add_and_return_key_by_load_item() :void
    {
      _loader = new LoadItem( new URLRequest( _imageUrl ));
      _loaderMgr.add( "a", _loader );
      var returned : * = _loaderMgr.getKeyByLoadItem( _loader );
      assertSame( returned, "a" );
    }


    [Test]
    public function should_return_true_for_having_idle_items() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      assertTrue( _loaderMgr.hasIdleItems() );
    }

    [Test(async)]
    public function should_add_load_items_and_return_true() :void
    {
      _loaderMgr.itemAddedSignal.add( addAsync( handleItemAdded, 10));
      var itemOne : LoadItem = new LoadItem( new URLRequest());
      var itemTwo : LoadItem = new LoadItem( new URLRequest());
      var itemOneAdded : Boolean = _loaderMgr.add( "one", itemOne );
      var itemTwoAdded : Boolean = _loaderMgr.add( "two", itemTwo );
      assertTrue( itemOneAdded );
      assertTrue( itemTwoAdded );
    }
    private function handleItemAdded( $loader :LoadItem ) :void
    {
      assertNotNull( $loader );
    }

    [Test]
    public function should_add_and_set_total() :void
    {
      _loaderMgr.add( "one", new LoadItem( new URLRequest()));
      _loaderMgr.add( "two", new LoadItem( new URLRequest()));
      assertEquals( _loaderMgr.total, 2 );
    }

    [Test]
    public function should_add_and_set_remaining() :void
    {
      _loaderMgr.add( "one", new LoadItem( new URLRequest()));
      _loaderMgr.add( "two", new LoadItem( new URLRequest()));
      assertEquals( _loaderMgr.remaining, 2 );
    }

    [Test]
    public function should_add_and_set_highest_priority() :void
    {
      _loaderMgr.add( "one", new LoadItem( new URLRequest()), 1001 );
      _loaderMgr.add( "two", new LoadItem( new URLRequest()), 1002 );
      assertEquals( _loaderMgr.highestPriority, 1002 );
    }


    [Test]
    public function should_add_and_return_same_item() :void
    {
      var itemOne : LoadItem = new LoadItem( new URLRequest());
      var itemTwo : LoadItem = new LoadItem( new URLRequest());
      _loaderMgr.add( "one", itemOne, 1001 );
      _loaderMgr.add( "two", itemTwo, 1002 );
      assertSame( _loaderMgr.getLoadItem("one"), itemOne );
      assertSame( _loaderMgr.getLoadItem("two"), itemTwo );
    }


    [Test(expects='Error')]
    public function should_throw_error_adding_the_same_key_twice() :void
    {
      _loaderMgr.add( "one", new LoadItem( new URLRequest()));
      _loaderMgr.add( "one", new LoadItem( new URLRequest()));
    }





    /* Loading Tests */

    [Test(async)]
    public function should_load_highest_priority_first_with_success() :void
    {
      _loader = new LoadItem( new URLRequest( _imageUrl ));
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )), 1001 );
      _loaderMgr.add( "highest", _loader, 1005 );
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )), 1002 );
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 3000 ));
      _handler = addAsync( handleCompleteAndMatchLoaders, 1000 );
      _loaderMgr.completeSignal.add( _handler );
      _loaderMgr.start();
    }
    private function handleCompleteAndMatchLoaders( $loader : LoadItem ) :void
    {
      _loaderMgr.completeSignal.remove( _handler );
      assertSame( _loader, $loader );
      assertNotNull( $loader.displayContent );
    }
    private function handleAllLoaded() :void
    {
      assertEquals( _loaderMgr.ratioLoaded, 1 );
      assertEquals( _loaderMgr.percentLoaded, 1 );
      assertEquals( _loaderMgr.loaded, _loaderMgr.total );
      assertEquals( _loaderMgr.remaining, 0 );
      assertTrue( _loaderMgr.isFinished );
      assertEquals( _loadCount, _loaderMgr.loaded );
    }


    [Test(async)]
    public function should_load_now() :void
    {
      _loader = new LoadItem( new URLRequest(  _imageUrl ));
      _handler = addAsync( handleCompleteAndMatchLoaders, 1000 );
      _loaderMgr.completeSignal.add( _handler );
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 2000 ));
      _loaderMgr.loadNow( "now", _loader, true );
    }

    [Test(async)]
    public function should_load_now_by_key() :void
    {
      _loader = new LoadItem( new URLRequest(  _imageUrl ));
      _loaderMgr.add( "a", _loader, 1001 );
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _handler = addAsync( handleCompleteAndMatchLoaders, 1000 );
      _loaderMgr.completeSignal.add( _handler );
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 2000 ));
      _loaderMgr.loadNowByKey( "a" );
    }


    [Test(async)]
    public function should_load_now_and_pause_others() :void
    {
      _loader = new LoadItem( new URLRequest( _imageUrl ));
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 3000 ));
      _handler = addAsync( handleCompleteAndMatchLoaders, 1000 );
      _loaderMgr.completeSignal.add( _handler );
      _loaderMgr.start();
      _loaderMgr.loadNow( "now", _loader, true );
    }

    [Test(async)]
    public function should_load_now_by_key_and_pause_others() :void
    {
      _loader = new LoadItem( new URLRequest( _imageUrl ));
      _loaderMgr.add( "a", _loader, 1001 );
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 3000 ));
      _loaderMgr.pausedSignal.add( addAsync( handleAllPaused, 3000 ));
      _handler = addAsync( handleCompleteAndMatchLoaders, 1000 );
      _loaderMgr.completeSignal.add( _handler );
      _loaderMgr.start();
      _loaderMgr.loadNowByKey( "a", true );
    }

    [Test(async)]
    public function should_load_all_items_added_after_start() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.completeSignal.add( handleLoadCount );
      _handler = addAsync( handleAllLoadedWhenAddedAfterStart, 1000 );
      _loaderMgr.allCompleteSignal.add( _handler );
      _loaderMgr.start();
      _loaderMgr.add( "d", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "e", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "f", new LoadItem( new URLRequest( _imageUrl )));
    }

    private function handleLoadCount( $loader : LoadItem ) :void
    {
      _loadCount++;
    }
    private function handleAllLoadedWhenAddedAfterStart() :void
    {
      handleAllLoaded();
      assertEquals( _loaderMgr.loaded, 6 );
      assertEquals( _loaderMgr.total, 6 );
      assertEquals( _loadCount, 6 );
    }

    [Test(async)]
    public function should_dispatch_individual_progress_when_loading() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.progressSignal.add( addAsync( handleIndividualProgress, 3000 ));
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 3000 ));
      _loaderMgr.start();
    }
    private function handleIndividualProgress( $loader : LoadItem, $loaded : uint, $total : uint ) :void
    {
      assertNotNull( $loader );
      assertEquals( $loaded, $loader.loader.bytesLoaded );
      assertEquals( $total, $loader.loader.bytesTotal );
    }

    [Test(async)]
    public function should_dispatch_overall_progress_when_loading() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.overallProgressSignal.add( addAsync( handleOverallProgress, 3000 ));
      _loaderMgr.start();
    }
    private function handleOverallProgress( $percent : Number ) :void
    {
      assertEquals( $percent, _loaderMgr.ratioLoaded );
    }





    /* Cancel Tests */

    [Test(async)]
    public function should_cancel_load() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )), 1001 );
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )), 1002 );
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )), 1003 );
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 3000 ) );
      _loaderMgr.start();
      _loaderMgr.cancel( "c" );
      assertEquals( _loaderMgr.total, 2 );
      assertEquals( _loaderMgr.loadItems.length, 2 );
      assertEquals( _loaderMgr.highestPriority, 1002 );
    }

    [Test]
    public function should_cancell_all_loads() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.start();
      _loaderMgr.cancelAll();
      assertEquals( _loaderMgr.total, 0 );
      assertEquals( _loaderMgr.loadItems.length, 0 );
      assertEquals( _loaderMgr.highestPriority, int.MIN_VALUE );
    }

    [Test(async)]
    public function should_cancel_failed_loads() :void
    {
      _loaderMgr.dispose();
      _loaderMgr = new LoaderManager( 3 );
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )), 1001 );
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )), 1002 );
      _loader = new LoadItem( new URLRequest( _brokenUrl ));
      _loaderMgr.add( "c", _loader, 1003 );
      _handler = addAsync( handleAllDoneAndRemoveFailed, 3000 );
      _loaderMgr.allCompleteSignal.add( _handler );
      _loaderMgr.start();
    }
    private function handleAllDoneAndRemoveFailed() :void
    {
      _loaderMgr.cancelFailedItems();
      assertEquals( _loaderMgr.total, 2 );
      assertEquals( _loaderMgr.loadItems.length, 2 );
      assertEquals( _loaderMgr.highestPriority, 1002 );
    }

    [Test(async)]
    public function should_dispatch_error_signal_on_bad_url() :void
    {
      _loader = new LoadItem( new URLRequest( _brokenUrl ));
      _loaderMgr.add( "a", _loader, 1003 );
      _loaderMgr.errorSignal.add( addAsync( handleLoadErrorFromBadUrl, 500 ));
      _loaderMgr.start();
    }
    private function handleLoadErrorFromBadUrl( $loader : LoadItem, $error : String ) :void
    {
      assertSame( _loader, $loader );
      assertNotNull( $error );
    }



    /* Pause Tests */

    [Test(async)]
    public function should_pause_by_key_and_dispatch_signal() :void
    {
      _loader = new LoadItem( new URLRequest( _imageUrl ));
      _loaderMgr.add( "a", _loader );
      _loaderMgr.pausedSignal.add( addAsync( handlePause, 3000 ));
      _loaderMgr.start();
      _loaderMgr.pause("a");
    }
    private function handlePause() :void
    {
      assertTrue( _loader.paused );
      assertEquals( _loader.state, LoadItem.STATE_PAUSED );
    }

    [Test(async)]
    public function should_pause_all_and_dispatch_signal() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.pausedSignal.add( addAsync( handleAllPaused, 3000 ));
      _loaderMgr.start();
      _loaderMgr.pauseAll();
    }
    private function handleAllPaused() :void
    {
      // test all loaders that aren't in an idle state (meaning they haven't been started,
      // and thus cannot be paused) and see if they're in a paused state.
      var dl : int = _loaderMgr.loadItems.length;
      var loader : LoadItem;
      for (var i : int = 0; i < dl; i++)
      {
        loader = _loaderMgr.loadItems[ i ];
        if ( loader.state != LoadItem.STATE_IDLE )
        {
          assertTrue( loader.paused );
          assertEquals( loader.state, LoadItem.STATE_PAUSED );
        }
      }
    }

    [Test(async)]
    public function should_pause_and_resume() :void
    {
      _loader = new LoadItem( new URLRequest( _imageUrl ));
      _loaderMgr.add( "a", _loader );
      _loaderMgr.pausedSignal.add( addAsync( handlePause, 500 ));
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 3000 ));
      _loaderMgr.start();
      _loaderMgr.pause("a");
      _loaderMgr.resume("a");
    }

    [Test(async)]
    public function should_pause_all_and_resume_all() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.completeSignal.add( handleLoadCount );
      _loaderMgr.pausedSignal.add( addAsync( handleAllPaused, 1000 ));
      _loaderMgr.allCompleteSignal.add( addAsync( handleAllLoaded, 3000 ));
      _loaderMgr.start();
      _loaderMgr.pauseAll();
      _loaderMgr.resumeAll();
    }

    [Test]
    public function should_return_true_for_having_paused_items() :void
    {
      _loaderMgr.add( "a", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "b", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.add( "c", new LoadItem( new URLRequest( _imageUrl )));
      _loaderMgr.start();
      _loaderMgr.pauseAll();
      assertTrue( _loaderMgr.hasPausedItems());
    }


  }
}

