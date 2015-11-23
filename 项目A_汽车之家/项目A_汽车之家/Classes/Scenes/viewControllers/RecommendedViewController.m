//
//  RecommendedViewController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/17.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "RecommendedViewController.h"
#import "CultureController.h"
#import "NewsController.h"
#import "EvaluateController.h"
#import "TechnologyController.h"

@interface RecommendedViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) CultureController *cultureController;
@property (nonatomic, strong) NewsController *newsController;
@property (nonatomic, strong) EvaluateController *evaluateController;
@property (nonatomic, strong) TechnologyController *technologyController;

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation RecommendedViewController

- (instancetype) init{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:[UIImage imageNamed:@"nav_icon_article_f.png"] selectedImage:[UIImage imageNamed: @"nav_icon_article_p.png"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49)];
    [self.view addSubview:aview];
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49- 64)];
    _scroll.pagingEnabled = YES;
    _scroll.bounces = YES;
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width * 4, 0);
    
    self.cultureController = [[CultureController alloc] init];
    _cultureController.view.frame = CGRectMake(0, 0, self.scroll.frame.size.width, self.scroll.frame.size.height );
    self.newsController = [[NewsController alloc] init];
    _newsController.view.frame = CGRectMake(self.scroll.frame.size.width,0, self.scroll.frame.size.width, self.scroll.frame.size.height);
    self.evaluateController = [[EvaluateController alloc] init];
    _evaluateController.view.frame = CGRectMake(self.scroll.frame.size.width * 2, 0, self.scroll.frame.size.width, self.scroll.frame.size.height);
    self.technologyController = [[TechnologyController alloc] init];
    _technologyController.view.frame = CGRectMake(self.scroll.frame.size.width * 3, 0, self.scroll.frame.size.width, self.scroll.frame.size.height);
    [_scroll addSubview:_cultureController.view];
    [_scroll addSubview:_newsController.view];
    [_scroll addSubview:_evaluateController.view];
    [_scroll addSubview:_technologyController.view];
    [aview addSubview:_scroll];
    
    [self segmented];
    
     self.edgesForExtendedLayout = UIRectEdgeNone;
}

// UISegmentedControl
- (void) segmented{
    NSArray *array = [NSArray arrayWithObjects:@"最新", @"新闻", @"评测", @"技术", nil];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
    _segmentedControl.frame = CGRectMake(0, 0, WIDTH, 30);
    [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.tintColor = [UIColor clearColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName: [UIColor blueColor]};
    [_segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                               NSForegroundColorAttributeName: [UIColor grayColor]};
    [_segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    _segmentedControl.selectedSegmentIndex = 0;
    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:_segmentedControl];
    self.navigationItem.rightBarButtonItem = segButton;
    
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentSegmented = _scroll.contentOffset.x / WIDTH;
    _segmentedControl.selectedSegmentIndex = currentSegmented;
}

// UISegmentedControl方法实现
- (void) segmentAction:(UISegmentedControl *) sender{
    NSInteger index = sender.selectedSegmentIndex;
    _scroll.contentOffset = CGPointMake(WIDTH * index, 0);
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
