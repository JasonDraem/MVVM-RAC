//
//  BaseTableView.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/12/2.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation BaseTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self baseTableviewConfigWithFrame:CGRectZero];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseTableviewConfigWithFrame:frame];
    }
    return self;
}
- (void)baseTableviewConfigWithFrame:(CGRect)frame{
    self.baseTableView.frame = frame;
    [self addSubview:self.baseTableView];
}
- (UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc] init];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.backgroundColor = [UIColor whiteColor];
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _baseTableView;
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.baseDelegate base_numberOfSectionsInTableView:self.baseTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.baseDelegate base_tableView:self.baseTableView numberOfRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.baseDelegate base_tableView:self.baseTableView cellForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(base_tableView:didSelectRowAtIndexPath:)]) {
        [self.baseDelegate base_tableView:self.baseTableView didSelectRowAtIndexPath:indexPath];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.baseDelegate base_tableView:self.baseTableView heightForRowAtIndexPath:indexPath];
}

@end
