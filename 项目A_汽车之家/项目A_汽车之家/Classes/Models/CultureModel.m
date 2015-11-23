//
//  NewInformation.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/17.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "CultureModel.h"

@implementation CultureModel

- (void) setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }
    NSLog(@"error key : %@", key);
}

@end
