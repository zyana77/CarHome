//
//  SearchManager.h
//  项目A_汽车之家
//
//  Created by zyana on 15/11/20.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchManager : NSObject

+ (SearchManager *) sharedDataHandle;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;

@end
