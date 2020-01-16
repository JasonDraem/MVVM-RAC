//
//  HomeController.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/13.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "HomeController.h"
#import "AFSessionUtil+HomeRequest.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self home_config];
    [self home_refresh];
}

- (void)home_config{
    [self.listTab.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.listTab];
}

- (void)home_refresh{
    //刷新、加载
    [RefreshUtil refreshWithRefreshType:RefreshType_refreshAndReload isResetRefreshStatesImgs:YES tableView:self.listTab.baseTableView refreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.listTab.baseTableView.mj_header isRefreshing]) {
                [self.listTab.baseTableView.mj_header endRefreshing];
            }
        });
    } reloadBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.listTab.baseTableView.mj_footer isRefreshing]) {
                [self.listTab.baseTableView.mj_footer endRefreshing];
            }
        });
    }];
}

- (void)home_request{
    [AFSessionUtil home_requestWithTitle:@"" response:^(id  _Nonnull obj, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - BaseTableViewDelegate

- (NSInteger)base_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}
- (UITableViewCell *)base_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.listTab.baseTableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)base_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
