//
//  TechnologyManager.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "TechnologyManager.h"

@interface TechnologyManager ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TechnologyManager
static TechnologyManager *manager = nil;
+ (TechnologyManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TechnologyManager new];
        [manager requestData];
    });
    return manager;
}

- (void) requestData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urlStr = TECHNOLOGYURL;
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSString *html = operation.responseString;
            NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dic = dataDic[@"result"];
            NSArray *array = dic[@"newslist"];
            for (NSDictionary *dict in array) {
                Technology *technology = [Technology new];
                [technology setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:technology];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!self.myUpDataUI) {
                    NSLog(@"block没有代码");
                }else{
                    self.myUpDataUI();
                }
            });
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"error:%@", error);
        }];
        [[NSOperationQueue mainQueue] addOperation:operation];
    });
}

// 懒加载
- (NSMutableArray *) dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSArray *)allNews{
    return self.dataArray;
}

- (Technology *)technologyWithIndex:(NSInteger)index{
    return self.allNews[index];
}


@end
