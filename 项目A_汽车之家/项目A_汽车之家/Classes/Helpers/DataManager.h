//
//  DataManager.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/19.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^myDetailsBlock)();

@interface DataManager : NSObject
+ (instancetype)shareData;

- (void) dataWithID:(NSInteger) ID;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) myDetailsBlock detailsBlock;

@end
