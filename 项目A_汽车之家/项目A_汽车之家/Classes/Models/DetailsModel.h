//
//  DetailsModel.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/19.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailsModel : NSObject

@property (nonatomic, strong) NSString *des;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, assign) NSInteger notallowcomment;
@property (nonatomic, strong) NSString *pagelist;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, assign) NSInteger replycount;
@property (nonatomic, assign) NSInteger serializeorders;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;

@end
