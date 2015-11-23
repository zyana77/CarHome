//
//  TabBarViewController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/16.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "TabBarViewController.h"
#import "RecommendedViewController.h"
#import "VideoController.h"
#import "SearchController.h"
#import "UserController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RecommendedViewController *recommendedVC = [[RecommendedViewController alloc] init];
    UINavigationController *recommendedNav = [[UINavigationController alloc] initWithRootViewController:recommendedVC];
    recommendedNav.navigationBar.translucent = NO;
    
    VideoController *bbsVC = [[VideoController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *bbsNav = [[UINavigationController alloc] initWithRootViewController:bbsVC];
    bbsNav.navigationBar.translucent = NO;
    
    SearchController *searchVC = [[SearchController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    searchNav.navigationBar.translucent = NO;
    
    UserController *userVC = [[UserController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:userVC];
    userNav.navigationBar.translucent = NO;
    
    self.viewControllers = @[recommendedNav, bbsNav, searchNav, userNav];
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBarController.selectedIndex = 0;
    self.tabBar.translucent = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
