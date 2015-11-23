//
//  DataManager.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/19.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "DataManager.h"
#import "DetailsModel.h"


static DataManager *datda = nil;
@implementation DataManager
+ (instancetype)shareData{
    if (datda == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            datda = [DataManager new];
        });
    }
    return datda;
}

- (void)dataWithID:(NSInteger )ID{
    NSString *str = @"http://cont.app.autohome.com.cn/autov5.0.0/content/news/newsinfo-pm1-i";
    NSString *urlStr = [NSString stringWithFormat:@"%@%ld.json", str, ID];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dic = dataDic[@"result"];
//        NSMutableArray *dataArray = [NSMutableArray array];
        DetailsModel *model = [DetailsModel new];
        [model setValuesForKeysWithDictionary:dic];
        self.dataArray = [NSMutableArray array];
        [_dataArray addObject:model];
        self.detailsBlock();
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
}

@end
