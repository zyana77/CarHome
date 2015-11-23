//
//  VideoViewController.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "PlayVideoModel.h"

typedef void (^myblock)();

@interface VideoViewController : UIViewController

@property (nonatomic, strong) VideoModel *videoModel;
@property (nonatomic, strong) PlayVideoModel *playVideo;
//@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic, copy) myblock block;

@end
