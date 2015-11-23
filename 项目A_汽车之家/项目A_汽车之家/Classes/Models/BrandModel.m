//
//  BrandModel.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/20.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel

- (void) setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }else if ([key isEqualToString:@"imgurl"]){
        _imgurl = value;
    }
    NSLog(@"error key : %@", key);
}

@end
