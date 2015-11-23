//
//  SearchManager.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/20.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "SearchManager.h"
#import "BrandModel.h"

@interface SearchManager ()

@property (nonatomic, strong) BrandModel *brandModel;

@end

@implementation SearchManager

static SearchManager *searchManager = nil;
// 单例
+ (SearchManager *) sharedDataHandle{
    if (searchManager == nil) {
        searchManager = [[SearchManager alloc] init];
        [searchManager sharedData];
//        [searchManager parameterRequestData];
    }
    return searchManager;
}

// 解析文件
- (void) sharedData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"汽车型号编码" ofType:@"plist"];
    // 最外层大字典
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    for (id key in dic) {
        NSArray *array = dic[key];
        NSMutableArray *mutArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [mutArray addObject:dict];
            NSLog(@"aaaaaaaa%@", [mutArray lastObject]);
        }
        [self.dataDictionary setValue:mutArray forKey:key];
    }
    self.dataArray = [NSMutableArray arrayWithArray: [dic allKeys]];
     [_dataArray sortUsingSelector:@selector(compare:)];
}

//- (void) parameterRequestData{
//    NSString *str = @"http://app.api.autohome.com.cn/autov5.0.0/cars/seriessummary-pm1-s";
//    NSString *urlStr = [NSString stringWithFormat:@"%@%ld-t-c110100.json", str, _brandModel.ID];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSString *html = operation.responseString;
//        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSDictionary *outerDic = dataDic[@"result"];
//        NSDictionary *innerDic = outerDic[@"shareinfo"];
//        self.brandModel = [BrandModel new];
//        [_brandModel setValuesForKeysWithDictionary:innerDic];
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"error:%@", error);
//    }];
//    [[NSOperationQueue mainQueue] addOperation:operation];
//}

- (NSMutableArray *) dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *) dataDictionary{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}

@end
