//
//  RefreshUtil.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/12/2.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "RefreshUtil.h"

//#define Image(fileName) [UIImage imageNamed:fileName]
@interface RefreshUtil ()

@property (nonatomic, strong) NSArray *normalImgs;              //普通状态下imgs
@property (nonatomic, strong) NSArray *pullImgs;                //松开就可以进行刷新imgs
@property (nonatomic, strong) NSArray *refreshImgs;             //正在刷新imgs
@property (nonatomic, strong) NSArray *reloadImgs;              //正在加载imgs

@end

@implementation RefreshUtil
#pragma mark - public action
+ (void)refreshWithRefreshType:(RefreshType)refreshType
      isResetRefreshStatesImgs:(BOOL)isResetRefreshStatesImgs
                     tableView:(UITableView *)tableView
                  refreshBlock:(RefreshUtilBlock)refreshBlock
                   reloadBlock:(ReloadUtilBlock)reloadBlock{
    RefreshUtil *refresh;
    if (isResetRefreshStatesImgs) {/* 自定义刷新、加载动画 */
        refresh = [RefreshUtil shareInstanceRefreshStateImgs];
    }
    if (!isResetRefreshStatesImgs) {/* 默认动画 */
        refresh = [RefreshUtil shareInstance];
    }
    refresh.refreshUtilBlock = refreshBlock;
    refresh.reloadUtilBlock = reloadBlock;
    
    if (RefreshType_refresh == refreshType) {//只刷新
        if (!isResetRefreshStatesImgs) {
            [refresh refreshConfigWithWithTableView:tableView];
        }
        if (isResetRefreshStatesImgs) {
            [refresh refreshGifConfigWithWithTableView:tableView];
        }
    }
    if (RefreshType_reload == refreshType) {//只加载
        if (!isResetRefreshStatesImgs) {
            [refresh reloadConfigWithTableView:tableView];
        }
        if (isResetRefreshStatesImgs) {
            [refresh reloadGifConfigWithTableView:tableView];
        }
    }
    if (RefreshType_refreshAndReload == refreshType) {//刷新、加载
        if (isResetRefreshStatesImgs) {
            [refresh refreshGifConfigWithWithTableView:tableView];
            [refresh reloadGifConfigWithTableView:tableView];
        }
        if (!isResetRefreshStatesImgs) {
            [refresh refreshConfigWithWithTableView:tableView];
            [refresh reloadConfigWithTableView:tableView];
        }
    }
}

+ (void)refreshWithRefreshType:(RefreshType)refreshType isResetRefreshStatesImgs:(BOOL)isResetRefreshStatesImgs collectionView:(UICollectionView *)collectionView refreshBlock:(RefreshUtilBlock)refreshBlock reloadBlock:(ReloadUtilBlock)reloadBlock{
    RefreshUtil *refresh;
    if (isResetRefreshStatesImgs) {/* 自定义刷新、加载动画 */
        refresh = [RefreshUtil shareInstanceRefreshStateImgs];
    }
    if (!isResetRefreshStatesImgs) {/* 默认动画 */
        refresh = [RefreshUtil shareInstance];
    }
    refresh.refreshUtilBlock = refreshBlock;
    refresh.reloadUtilBlock = reloadBlock;
    
    if (RefreshType_refresh == refreshType) {//只刷新
        if (!isResetRefreshStatesImgs) {
            [refresh refreshConfigWithCollectionView:collectionView];
        }
        if (isResetRefreshStatesImgs) {
            [refresh refreshGifConfigWithCollectionView:collectionView];
        }
    }
    if (RefreshType_reload == refreshType) {//只加载
        if (!isResetRefreshStatesImgs) {
            [refresh reloadConfigWithCollectionView:collectionView];
        }
        if (isResetRefreshStatesImgs) {
            [refresh reloadGifConfigWithCollectionView:collectionView];
        }
    }
    if (RefreshType_refreshAndReload == refreshType) {//刷新、加载
        if (isResetRefreshStatesImgs) {
            [refresh refreshGifConfigWithCollectionView:collectionView];
            [refresh reloadGifConfigWithCollectionView:collectionView];
        }
        if (!isResetRefreshStatesImgs) {
            [refresh refreshConfigWithCollectionView:collectionView];
            [refresh reloadConfigWithCollectionView:collectionView];
        }
    }
}

#pragma mark - pravite 🔒

+ (instancetype)shareInstance{
    static RefreshUtil *refreshUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        refreshUtil = [[RefreshUtil alloc] init];
    });
    return refreshUtil;
}
/* 自定义刷新状态动画 */
+ (instancetype)shareInstanceRefreshStateImgs{
    static RefreshUtil *refreshUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        refreshUtil = [[RefreshUtil alloc] initWithRefreshStatesImgs];
    });
    return refreshUtil;
}

- (instancetype)initWithRefreshStatesImgs{
    self = [super init];
    if (self) {
        //此gif为逐帧动画由多张图片组成
        //闲置状态下的gif(就是拖动的时候变化的gif)
        _normalImgs = [[NSArray alloc] initWithObjects:Image(@"Image"), Image(@"01"), Image(@"02"), Image(@"03"), Image(@"04"), Image(@"05"), nil];
        //已经到达偏移量的gif(就是已经到达偏移量的时候的gif)
        _pullImgs = [[NSArray alloc] initWithObjects:Image(@"Image"), Image(@"01"), Image(@"02"), Image(@"03"), Image(@"04"), Image(@"05"), nil];
        //正在刷新的时候的gif
        _refreshImgs = [[NSArray alloc] initWithObjects:Image(@"Image"), Image(@"01"), Image(@"02"), Image(@"03"), Image(@"04"), Image(@"05"), nil];
    }
    return self;
}
/* 刷新 */
- (void)refreshConfigWithWithTableView:(UITableView *)tableView{
    MJRefreshNormalHeader *refresh_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh_refreshAction];
    }];
    tableView.mj_header = refresh_header;
    [tableView.mj_header beginRefreshing];
    tableView.mj_header.automaticallyChangeAlpha = YES;         //透明度渐变
}
- (void)refreshConfigWithCollectionView:(UICollectionView *)collectionView{
    MJRefreshNormalHeader *refresh_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh_refreshAction];
    }];
    collectionView.mj_header = refresh_header;
    [collectionView.mj_header beginRefreshing];
    collectionView.mj_header.automaticallyChangeAlpha = YES;         //透明度渐变
}
/* 刷新(自定义刷新动画) */
- (void)refreshGifConfigWithWithTableView:(UITableView *)tableView{
    MJRefreshGifHeader *refresh_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self refresh_refreshAction];
    }];
    if (_normalImgs.count > 0) {
        [refresh_header setImages:_normalImgs forState:MJRefreshStateIdle];
    }
    if (_pullImgs) {
        [refresh_header setImages:_pullImgs forState:MJRefreshStatePulling];
    }
    if (_refreshImgs.count > 0) {
        [refresh_header setImages:_refreshImgs forState:MJRefreshStateRefreshing];
    }
    tableView.mj_header = refresh_header;
    [tableView.mj_header beginRefreshing];
    tableView.mj_header.automaticallyChangeAlpha = YES;         //透明度渐变
}
- (void)refreshGifConfigWithCollectionView:(UICollectionView *)collectionView{
    MJRefreshGifHeader *refresh_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self refresh_refreshAction];
    }];
    if (_normalImgs.count > 0) {
        [refresh_header setImages:_normalImgs forState:MJRefreshStateIdle];
    }
    if (_pullImgs) {
        [refresh_header setImages:_pullImgs forState:MJRefreshStatePulling];
    }
    if (_refreshImgs.count > 0) {
        [refresh_header setImages:_refreshImgs forState:MJRefreshStateRefreshing];
    }
    collectionView.mj_header = refresh_header;
    [collectionView.mj_header beginRefreshing];
    collectionView.mj_header.automaticallyChangeAlpha = YES;         //透明度渐变
}
/* 加载 */
- (void)reloadConfigWithTableView:(UITableView *)tableView{
    MJRefreshBackNormalFooter *reload_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refresh_reloadAction];
    }];
    tableView.mj_footer = reload_footer;
    tableView.mj_footer.automaticallyChangeAlpha = YES;         //透明度渐变
}
- (void)reloadConfigWithCollectionView:(UICollectionView *)collectionView{
    MJRefreshBackNormalFooter *reload_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refresh_reloadAction];
    }];
    collectionView.mj_footer = reload_footer;
    collectionView.mj_footer.automaticallyChangeAlpha = YES;         //透明度渐变
}
/* 加载(自定义加载动画) */
- (void)reloadGifConfigWithTableView:(UITableView *)tableView{
    MJRefreshBackGifFooter *reload_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [self refresh_reloadAction];
    }];
    if (_reloadImgs) {
        [reload_footer setImages:_reloadImgs forState:MJRefreshStateRefreshing];//正在刷新
    }
    tableView.mj_footer = reload_footer;
    tableView.mj_footer.automaticallyChangeAlpha = YES;         //透明度渐变
}
- (void)reloadGifConfigWithCollectionView:(UICollectionView *)collectionView{
    MJRefreshBackGifFooter *reload_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [self refresh_reloadAction];
    }];
    if (_reloadImgs) {
        [reload_footer setImages:_reloadImgs forState:MJRefreshStateRefreshing];//正在刷新
    }
    collectionView.mj_footer = reload_footer;
    collectionView.mj_footer.automaticallyChangeAlpha = YES;         //透明度渐变
}
- (void)refresh_refreshAction{
    if (self.refreshUtilBlock) {
        self.refreshUtilBlock();
    }
}
- (void)refresh_reloadAction{
    if (self.reloadUtilBlock) {
        self.reloadUtilBlock();
    }
}

/**
/ 普通闲置状态
MJRefreshStateIdle = 1,
松开就可以进行刷新的状态
MJRefreshStatePulling,
正在刷新中的状态
MJRefreshStateRefreshing,
即将刷新的状态
MJRefreshStateWillRefresh,
所有数据加载完毕，没有更多的数据了
MJRefreshStateNoMoreData
*/

@end
