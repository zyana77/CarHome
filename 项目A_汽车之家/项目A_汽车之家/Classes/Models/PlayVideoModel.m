//
//  PlayVideoModel.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "PlayVideoModel.h"

@implementation PlayVideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        _des = value;
    }
    NSLog(@"error key : %@", key);
}

@end
