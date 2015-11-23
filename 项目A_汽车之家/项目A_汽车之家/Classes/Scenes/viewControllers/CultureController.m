//
//  NewController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/16.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "CultureController.h"
#import "RecommendedTableViewCell.h"
#import "Carousel.h"
#import "DetailsController.h"


@interface CultureController ()

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *carouselArray;

@end

@implementation CultureController

static NSString *identifier = @"recommendedCell";

- (instancetype) initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        [self requestData];
        [self requestCultureData];
    }
    return self;
}

// 解析数据
- (void) requestData{
    NSString *urlStr = CAROUSELURL;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        // NSLog(@"json:%@", responseObject);
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        // 最新界面解析
//        NSDictionary *dic = dataDic[@"result"];
//        NSArray *array = dic[@"newslist"];
//        self.dataArray = [NSMutableArray array];
//        for (NSDictionary *dict in array) {
//            cultureModel *newInformation = [cultureModel new];
//            [newInformation setValuesForKeysWithDictionary:dict];
//            [_dataArray addObject:newInformation];
//            NSLog(@"%@", newInformation);
//        }
        // 轮播图解析
        NSDictionary *carouselDic = dataDic[@"result"];
        NSArray *carousel = carouselDic[@"focusimg"];
        self.carouselArray = [NSMutableArray array];
        for (NSDictionary *carouselDict in carousel) {
            Carousel *carousel = [Carousel new];
            [carousel setValuesForKeysWithDictionary:carouselDict];
            [_carouselArray addObject:carousel];
        }
        [self updataTableHeader];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
}

- (void) requestCultureData{
    NSString *urlStr = CULTUREURL;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dic = dataDic[@"result"];
        NSArray *array = dic[@"newslist"];
        self.dataArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            CultureModel *cultureModel = [CultureModel new];
            [cultureModel setValuesForKeysWithDictionary:dict];
            [_dataArray addObject:cultureModel];
            NSLog(@"%@", cultureModel);
    }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
        [[NSOperationQueue mainQueue] addOperation:operation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendedTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    [self carouselImage];
}

// 轮播图
- (void) carouselImage{
    UIView *carouseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, CAROUSELHEIGHT )];
    carouseView.tag = CAROUSELTAG;
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, CAROUSELHEIGHT)];
    _scroll.pagingEnabled = YES;
    _scroll.scrollEnabled = YES;
    _scroll.contentSize = CGSizeMake(WIDTH*6, 0);
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.delegate = self;
    
    for (int i = 0; i < 6; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, CAROUSELHEIGHT)];
        imgView.tag = HEADERSCROLL_TAG + i;
        imgView.userInteractionEnabled = YES;
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", 3]];
        [_scroll addSubview:imgView];
    }
    
    [carouseView addSubview:_scroll];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH - 100, CAROUSELHEIGHT - 20, 100, 20)];
    _pageControl.numberOfPages = 6;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [_pageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventValueChanged];
    [carouseView addSubview:_pageControl];
    // 添加到头视图中
    self.tableView.tableHeaderView = carouseView;
    // 设置定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerClick:) userInfo:nil repeats:YES];
}

- (void) updataTableHeader{
//    UIView *backView = [self.view viewWithTag:CAROUSELTAG];
    for (int j = 0; j < self.carouselArray.count; j++) {
        UIImageView *imgView =(UIImageView *) [_scroll viewWithTag:HEADERSCROLL_TAG + j];
        Carousel *carousel = self.carouselArray[j];
        [imgView sd_setImageWithURL:[NSURL URLWithString:carousel.imgurl]];
    }
    [self.tableView reloadData];
}

// scrollView方法
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 获取偏移量
    NSInteger currentPage = _scroll.contentOffset.x / WIDTH;
    // 更新currentPage
    _pageControl.currentPage = currentPage;
}

// NSTimer方法实现
- (void) timerClick:(NSTimer *) sender{
    static int i = 0;
    i++;
    if (i == 6) {
        i = 0;
    }
    // 偏移量
    _scroll.contentOffset = CGPointMake(WIDTH*i, 0);
    _pageControl.currentPage = i;
}

- (void) pageClick: (UIPageControl *) sender{
    // 获取当前显示的页面
    NSInteger currentPage = sender.currentPage;
    _scroll.contentOffset = CGPointMake(WIDTH*currentPage, 0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT / 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecommendedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    CultureModel *cultureModel = _dataArray[indexPath.row];
    cell.information = cultureModel;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsController *detailsVC = [[DetailsController alloc] init];
    CultureModel *cultureModel = _dataArray[indexPath.row];
    detailsVC.ID = cultureModel.ID;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailsVC];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
