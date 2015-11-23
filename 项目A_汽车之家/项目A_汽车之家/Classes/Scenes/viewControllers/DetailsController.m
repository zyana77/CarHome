//
//  DetailsController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/19.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "DetailsController.h"
#import "DataManager.h"
#import "DetailsModel.h"

@interface DetailsController ()<UIWebViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailsLabel;
@property (nonatomic, strong) DetailsModel *model;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation DetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    [self loadWebPageWithString];
//    [self allControls];
}

- (void)viewWillAppear:(BOOL)animated{
    [[DataManager shareData] dataWithID:self.ID];
//    __weak typeof (self) temp = self;
//    [DataManager shareData].detailsBlock = ^(){
////        temp.model = [[DataManager shareData].dataArray lastObject];
////        temp.titleLabel.text = temp.model.title;
////        temp.timeLabel.text = temp.model.time;
////        temp.detailsLabel.text = temp.model.des;
//        temp.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//                temp.webView.backgroundColor = [UIColor yellowColor];
//        temp.webView.delegate = temp;
//        NSString *urlStr = temp.model.url;
//        NSURL *url = [NSURL URLWithString:urlStr];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [temp.view addSubview:temp.webView];
//        [temp.webView loadRequest:request];
//    };
}

- (void) loadWebPageWithString{
    __weak typeof (self) temp = self;
    [DataManager shareData].detailsBlock = ^(){
        temp.model = [[DataManager shareData].dataArray lastObject];
        //        temp.titleLabel.text = temp.model.title;
        //        temp.timeLabel.text = temp.model.time;
        //        temp.detailsLabel.text = temp.model.des;
        temp.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        temp.webView.backgroundColor = [UIColor yellowColor];
        temp.webView.delegate = temp;
        NSString *urlStr = temp.model.url;
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


- (void) back:(UIBarButtonItem *) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void) allControls{
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, WIDTH - 20, HEIGHT / 8)];
//    _titleLabel.font = [UIFont systemFontOfSize:22];
//    _titleLabel.numberOfLines = 0;
//    [self.view addSubview:_titleLabel];
//    
//    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT / 8 + 30, WIDTH / 3, HEIGHT / 30)];
//    _showLabel.textColor = [UIColor darkGrayColor];
//    _showLabel.font = [UIFont systemFontOfSize:14];
//    _showLabel.text = @"汽车之家    原创";
//    [self.view addSubview:_showLabel];
//    
//    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 10 - WIDTH / 5, HEIGHT / 8 + 30, WIDTH / 5, HEIGHT / 30)];
//    _timeLabel.textColor = [UIColor darkGrayColor];
//    _timeLabel.font = [UIFont systemFontOfSize:14];
//    [self.view addSubview:_timeLabel];
//    
//    self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT / 8 + 50 + HEIGHT / 30, WIDTH - 20, HEIGHT / 2)];
//    _detailsLabel.font = [UIFont systemFontOfSize:18];
//    _detailsLabel.numberOfLines = 0;
//    [self.view addSubview:_detailsLabel];
//}

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
