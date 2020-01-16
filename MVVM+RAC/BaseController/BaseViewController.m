//
//  BaseViewController.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/13.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BaseTableView *)listTab{
    if (!_listTab) {
        _listTab = [[BaseTableView alloc] initWithFrame:self.view.bounds];
        _listTab.baseDelegate = self;
    }
    return _listTab;
}

#pragma mark - BaseTableViewDelegate
- (NSInteger)base_numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
