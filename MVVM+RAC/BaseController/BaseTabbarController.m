//
//  BaseTabbarController.m
//  MVVM+RAC
//
//  Created by 许须耀 on 2019/11/13.
//  Copyright © 2019 许须耀. All rights reserved.
//

#import "BaseTabbarController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tabbarAction];
}

- (void)tabbarAction{
    NSArray *tabbarGroups = @[
        @[@"Home", @"home", @"首页"],
        @[@"Message", @"message", @"消息"],
        @[@"Time", @"time", @"番茄⏰"],
        @[@"Shop",  @"shopping", @"商城"]];
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSInteger i = 0; i < tabbarGroups.count; i ++){
        NSString *cla = [NSString stringWithFormat:@"%@Controller", tabbarGroups[i][0]];
        Class vcName = NSClassFromString(cla);
        BaseViewController *baseVC = [[vcName alloc] init];
        BaseNaviController *baseNvc = [[BaseNaviController alloc] initWithRootViewController:baseVC];
        NSString *iconName = [NSString stringWithFormat:@"%@", tabbarGroups[i][1]];
        NSString *itemTitle = [NSString stringWithFormat:@"%@", tabbarGroups[i][2]];
        UIImage *tabbarIcon_normal = [[UIImage imageNamed:[NSString stringWithFormat:@"%@1", iconName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//normal
        UIImage *tabbarIcon_selected = [[UIImage imageNamed:[NSString stringWithFormat:@"%@2", iconName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//selected
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:itemTitle image:tabbarIcon_normal selectedImage:tabbarIcon_selected];
        baseVC.tabBarItem = item;
        baseVC.navigationItem.title = itemTitle;
        [controllers addObject:baseNvc];
    }
    self.viewControllers = controllers;
}

@end
