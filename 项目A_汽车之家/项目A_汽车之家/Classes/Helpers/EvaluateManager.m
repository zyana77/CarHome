//
//  EvaluateManager.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/17.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "EvaluateManager.h"
#import "Evaluate.h"

@interface EvaluateManager()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation EvaluateManager
static EvaluateManager *manager = nil;
+ (EvaluateManager *) sharedManager{
    //GCD 提供的一种单例方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [EvaluateManager new];
        [manager requestData];
    });
    return manager;
}

- (void) requestData{
     // 在子线程中请求数据，防止假死
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urlStr = EVALUATEURL;
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
                Evaluate *evaluate = [Evaluate new];
                [evaluate setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:evaluate];
            }
//            for (Evaluate *ev in _dataArray) {
//                NSLog(@"aaaaaaaaa:%@", ev);
//            }
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

- (NSArray *) allNews{
    return self.dataArray;
}

//返回一个下标是index的
- (Evaluate *)evaluateWithIndex:(NSInteger)index{
    return self.allNews[index];
}

@end
