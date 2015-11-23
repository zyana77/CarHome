//
//  UserController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/23.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "UserController.h"

@interface UserController ()
@property (strong, nonatomic) IBOutlet UITextField *user4text;
@property (strong, nonatomic) IBOutlet UITextField *password4text;

- (IBAction)signIn4btn:(UIButton *)sender;
- (IBAction)signUp4btn:(UIButton *)sender;


@end

@implementation UserController

- (instancetype) init{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"nav_icon_my_f.png"] selectedImage:[UIImage imageNamed:@"nav_icon_my_p.png"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)signIn4btn:(UIButton *)sender {
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//    if ([accountDefaults boolForKey:]) {
//        <#statements#>
//    }
}

- (IBAction)signUp4btn:(UIButton *)sender {
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
