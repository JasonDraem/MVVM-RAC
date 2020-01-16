//
//  RefreshUtil.h
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/12/2.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshType_refresh = 0,            //只支持下拉刷新
    RefreshType_reload,                 //只支持上拉加载更多
    RefreshType_refreshAndReload        //刷新、加载
};

typedef void(^RefreshUtilBlock)(void);      //刷新
typedef void(^ReloadUtilBlock)(void);       //加载

@interface RefreshUtil : NSObject

@property (nonatomic, copy) RefreshUtilBlock refreshUtilBlock;  //刷新
@property (nonatomic, copy) ReloadUtilBlock reloadUtilBlock;    //加载

/// 刷新、加载
+ (void)refreshWithRefreshType:(RefreshType)refreshType
      isResetRefreshStatesImgs:(BOOL)isResetRefreshStatesImgs
                     tableView:(UITableView *)tableView
                  refreshBlock:(RefreshUtilBlock)refreshBlock
                   reloadBlock:(ReloadUtilBlock)reloadBlock;


@end

NS_ASSUME_NONNULL_END
