
        self.timer = None
        s = objc.selector(self.threadedFunc,signature='v@:')

        #self.aThread = NSThread.alloc().initWithTarget_selector_object_(self, s, None)
        #self.aThread.start()
        #NSThread.detachNewThreadSelector_toTarget_withObject_(s, self, None)
        #self.threadedFunc()

    '''
    def threadedFunc(self):
        print 'thread'
        if self.timer is not None:
            self.timer.invalidate()
        s = objc.selector(self.advertise,signature='v@:')
        self.timer = NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats_(3.0, self, s, None, True)

    def advertise(self):
        print "Don'cha wanna buy something?"
        NSLog('bla')
    '''

