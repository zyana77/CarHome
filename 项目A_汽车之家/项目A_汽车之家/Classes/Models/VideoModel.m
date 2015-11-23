//
//  VideoModel.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void) setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }
    NSLog(@"error key : %@", key);
}

@end
