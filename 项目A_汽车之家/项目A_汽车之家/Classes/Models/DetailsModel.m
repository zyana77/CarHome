//
//  DetailsModel.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/19.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "DetailsModel.h"

@implementation DetailsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }else if ([key isEqualToString:@"description"]){
        _des = value;
    }
    NSLog(@"error key : %@", key);
}

@end
