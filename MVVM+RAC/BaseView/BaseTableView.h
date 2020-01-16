//
//  BaseTableView.h
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/12/2.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseTableViewDelegate <NSObject>

@optional
/* - (NSInteger)base_numberOfSectionsInTableView:(UITableView *)tableView; */
- (NSInteger)base_numberOfSectionsInTableView:(UITableView *)tableView;
/* - (NSInteger)base_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; */
- (NSInteger)base_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
/* - (UITableViewCell *)base_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; */
- (UITableViewCell *)base_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/* - (CGFloat)base_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; */
- (CGFloat)base_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/* - (void)base_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; */
- (void)base_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableView : UIView
/* tableview */
@property (nonatomic, strong) UITableView *baseTableView;
/* 声明代理 */
@property (nonatomic, weak) id<BaseTableViewDelegate>baseDelegate;

@end

NS_ASSUME_NONNULL_END
