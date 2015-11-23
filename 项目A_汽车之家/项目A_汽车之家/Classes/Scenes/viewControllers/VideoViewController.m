//
//  VideoViewController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/18.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "VideoViewController.h"
#import "PlayVideoModel.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *playCountLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *imgBtn;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation VideoViewController

- (instancetype) init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
     [self requestData];
}

- (void)setVideoModel:(VideoModel *)videoModel{
    _videoModel = videoModel;
}

- (void) requestData{
//    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//    [dict setObject:@"apple" forKey:@"weburl"];
    
    NSString *str = @"http://app.api.autohome.com.cn/autov5.0.0/news/videoinfo-pm1-i";
    NSString *urlStr = [NSString stringWithFormat:@"%@%ld.json", str, _videoModel.ID];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dic = dataDic[@"result"];
        self.playVideo = [PlayVideoModel new];
        [self.playVideo setValuesForKeysWithDictionary:dic];
        self.block();

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawingControl];
//    [self loadWebPageWithString];
}

- (void) drawingControl{
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3)];
    [self.view addSubview:_imgView];
    
    self.imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _imgBtn.frame = CGRectMake(0, 0, WIDTH, HEIGHT / 3);
    _imgBtn.backgroundColor = [UIColor clearColor];
    [_imgBtn addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imgBtn];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIDEOX, VIDEOY, VIDEOWIDTH, VIDEOHEIGHT)];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.numberOfLines = 0;
    [self.view addSubview:_titleLabel];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, VIDEOY + VIDEOHEIGHT + 10, WIDTH / 12, HEIGHT / 20)];
    _typeLabel.font = [UIFont systemFontOfSize:14];
    _typeLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:_typeLabel];
    
    self.playCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + WIDTH / 15 + 15, VIDEOY + VIDEOHEIGHT + 10, WIDTH / 3, HEIGHT / 20)];
    _playCountLabel.font = [UIFont systemFontOfSize:14];
    _playCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:_playCountLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 10 - WIDTH / 5, VIDEOY + VIDEOHEIGHT + 10, WIDTH / 5, HEIGHT / 20)];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:_timeLabel];
    
    [self valueBlock];
}

- (void) valueBlock{
    __weak typeof (self) temp = self;
    self.block = ^(){
        temp.titleLabel.text = temp.playVideo.title;
        temp.typeLabel.text = temp.playVideo.type;
        temp.playCountLabel.text = [NSString stringWithFormat:@"播放数： %ld", temp.playVideo.playcount];
        temp.timeLabel.text = temp.playVideo.time;
        [temp.imgView sd_setImageWithURL:[NSURL URLWithString:temp.playVideo.imgurl] placeholderImage:[UIImage imageNamed:@"3"]];
    };
}

- (void)loadWebPageWithString{
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _webView.delegate = self;
    NSString *urlStr = _playVideo.weburl;
    NSURL *url =[NSURL URLWithString:urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
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

- (void) playVideo:(UIButton *) sender{
    NSLog(@"bofang!!!!!!!!!!!!!!!!!!!");
    [self loadWebPageWithString];
    

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
