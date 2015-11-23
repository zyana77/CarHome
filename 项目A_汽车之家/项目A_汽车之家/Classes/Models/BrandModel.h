//
//  BrandModel.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/20.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, assign) NSInteger levelid;
@property (nonatomic, strong) NSString *levelname;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *url;

//@property (nonatomic, strong) NSString *NAME;

@end
