//
//  VideoModel.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger replycount;
@property (nonatomic, strong) NSString *smallimg;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *videoaddress;

@end
