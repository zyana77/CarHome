//
//  PlayVideoModel.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayVideoModel : NSObject

@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, assign) NSInteger playcount;
@property (nonatomic, assign) NSInteger replycount;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *weburl;

@end
