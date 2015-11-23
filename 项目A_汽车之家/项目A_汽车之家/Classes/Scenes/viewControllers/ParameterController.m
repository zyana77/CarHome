//
//  ParameterController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/21.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "ParameterController.h"
#import "SearchManager.h"
#import "SearchController.h"

@interface ParameterController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSMutableArray *parameterArray;
@property (nonatomic, strong) SearchManager *manager;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ParameterController

- (instancetype) init{
    if (self = [super init]) {
//        [self parameterRequestData];
//        self.manager = [SearchManager sharedDataHandle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    [self relevantParameterBlock];
}

- (void) back:(UIBarButtonItem *) sender{
//    SearchController *searchVC = [[SearchController alloc] init];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToViewController:searchVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
     [self parameterRequestData];
    
//     [self relevantParameter];
}

- (void)viewDidAppear:(BOOL)animated{
    self.parameterBlock();
}

- (void)setBrandModel:(BrandModel *)brandModel{
    _brandModel = brandModel;
}

- (void) parameterRequestData{
    NSString *str = @"http://app.api.autohome.com.cn/autov5.0.0/cars/seriessummary-pm1-s";
    NSString *urlStr = [NSString stringWithFormat:@"%@%ld-t-c110100.json", str, _brandModel.ID];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *outerDic = dataDic[@"result"];
        NSDictionary *innerDic = outerDic[@"shareinfo"];
        NSLog(@"kkkkkkkkkkkkk%@", innerDic);
        self.brandModel = [BrandModel new];
        [_brandModel setValuesForKeysWithDictionary:innerDic];
        
//        [_parameterArray addObject:_brandModel];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
}


- (void)relevantParameterBlock{
    __weak typeof (self) temp = self;
    self.parameterBlock = ^(){
        temp.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        temp.webView.backgroundColor = [UIColor yellowColor];
        temp.webView.delegate = temp;
        NSString *urlStr = temp.brandModel.url;
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [temp.view addSubview:temp.webView];
        [temp.webView loadRequest:request];
    };
}

- (void) webViewDidStartLoad:(UIWebView *)webView{
    //创建UIActivityIndicatorView背底半透明View
    UIView *aView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    aView.tag = 100;
    aView.backgroundColor = [UIColor blackColor];
    aView.alpha = 0.5;
    [self.view addSubview:aView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    _activityIndicator.center = aView.center;
    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [aView addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityIndicator startAnimating];
    UIView *aView = (UIView *)[self.view viewWithTag:100];
    [aView removeFromSuperview];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_activityIndicator stopAnimating];
    UIView *aView = (UIView *)[self.view viewWithTag:100];
    [aView removeFromSuperview];
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    //    [alert addAction:action];
    //    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
