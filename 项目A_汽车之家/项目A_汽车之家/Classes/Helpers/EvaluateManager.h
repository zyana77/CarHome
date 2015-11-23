//
//  EvaluateManager.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/17.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Evaluate.h"
// block
typedef void (^upDataUI)();

@interface EvaluateManager : NSObject

@property (nonatomic, copy) upDataUI myUpDataUI;
@property (nonatomic, strong) NSArray *allNews;

// 单例
+ (EvaluateManager *) sharedManager;

/**
 *  根据cell的索引返回一个model
 *
 *  @param index 索引值
 *
 *  @return model
 */
- (Evaluate *) evaluateWithIndex:(NSInteger) index;


@end
