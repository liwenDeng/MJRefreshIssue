# MJRefreshIssue
MJRefresh 使用中碰到的问题
在CollectionView中，如果设置了collectionView的左右边距，那么在下拉回弹的过程中，会出现collectionView向左偏移的情况。如下图：

![](https://cloud.githubusercontent.com/assets/12794697/17611706/399567d2-607c-11e6-9bed-c3c5398c6b64.gif)

定位到代码MJRefreshHeader.m 第128行 - (void)setState:(MJRefreshState)state 方法中：

````
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
                // 增加滚动区域top
                self.scrollView.mj_insetT = top;
                // 设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
````
个人分析可能是在执行动画过程中，修改了scrollView的contentInset导致的，当我把self.scrollView.mj_insetT = top 放到completion: 中执行的话就不存有问题如下：

````
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
                
                // 1.在动画过程中设置top，在动画过程中，会向左移
                // 增加滚动区域top
                //self.scrollView.mj_insetT = top;
                
                // 设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                //fix-1:在动画完成后再设置top则不会有问题
                
                CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
                self.scrollView.mj_insetT = top;
                
                [self executeRefreshingCallback];
            }];
````
