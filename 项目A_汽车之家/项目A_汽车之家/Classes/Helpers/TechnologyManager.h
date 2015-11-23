//
//  TechnologyManager.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Technology.h"

// block
typedef void(^upDataUI)();

@interface TechnologyManager : NSObject

@property (nonatomic, copy) upDataUI myUpDataUI;
@property (nonatomic, strong) NSArray *allNews;

// 单例
+ (TechnologyManager *) sharedManager;

- (Technology *) technologyWithIndex:(NSInteger) index;

@end
