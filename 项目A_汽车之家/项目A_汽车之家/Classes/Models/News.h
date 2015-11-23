//
//  News.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/17.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, assign) NSInteger dbid;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *indexdetail;
@property (nonatomic, strong) NSString *intacttime;
@property (nonatomic, assign) int jumppage;
@property (nonatomic, strong) NSString *lasttime;
@property (nonatomic, assign) int mediatype;
@property (nonatomic, assign) int pagecount;
@property (nonatomic, assign) NSInteger replycount;
@property (nonatomic, strong) NSString *smallpic;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;

@end
