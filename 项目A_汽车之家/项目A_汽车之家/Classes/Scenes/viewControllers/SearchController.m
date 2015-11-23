//
//  SearchController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/16.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "SearchController.h"
#import "SearchManager.h"
#import "ParameterController.h"
#import "SearchTableViewCell.h"


@interface SearchController ()<JTRevealSidebarV2Delegate, UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (nonatomic, strong) UITableView *rightSidebarView;
@property (nonatomic, strong) NSArray *array1;
@property (nonatomic, strong) UINib *nib;
@property (nonatomic, strong) SearchManager *searchManager;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSArray *keyArray;
@property (nonatomic, strong) NSString *string;
//@property (nonatomic, strong) NSMutableArray *parameterArray;

@end

@implementation SearchController

static NSString *tableCellIdentifier = @"ceeeell";
static NSString *CellIdentifier = @"rightcell";

- (instancetype) initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"找车" image:[UIImage imageNamed:@"nav_icon_findcar_f.png"] selectedImage:[UIImage imageNamed:@"nav_icon_findcar_p.png"]];
        self.navigationItem.title = @"品牌";
        self.searchManager = [SearchManager sharedDataHandle];
//        [self parameterRequestData];
    }
    return self;
}

- (void) requestDataWithUid:(NSString *)uid{
    NSString *str = @"http://app.api.autohome.com.cn/autov5.0.0/cars/seriesprice-pm1-b";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@-t1.json", str, uid];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dic = dataDic[@"result"];
        // 取出来的是数组中得字典，0，1，2
        NSArray *array = dic[@"fctlist"];  // 【0，1，2】
        self.nameArray = [NSMutableArray array];
        self.dictionary = [NSMutableDictionary dictionary];
    
        for (int i = 0; i < array.count; i ++) {
            self.dict = [NSDictionary dictionary];
            self.dict = array[i];
            BrandModel *model = [BrandModel new];
            [model setValuesForKeysWithDictionary:_dict];
            // 汽车类型分区
            [_nameArray addObject:_dict[@"name"]];
            NSLog(@"qqqqqqqqqqq:%@", _nameArray);
            _dataArray = [NSMutableArray array];
            NSArray *arrayA = _dict[@"serieslist"];
            for (int i = 0; i < arrayA.count; i++) {
                self.dic = arrayA[i];
                BrandModel *brand = [BrandModel new];
                [brand setValuesForKeysWithDictionary:_dic];
                [_dataArray addObject:brand];
                NSLog(@"wwwwwwwwwww:%@", _dataArray);
}
            [_dictionary setValue:_dataArray forKey:_dict[@"name"] ];
}
        NSLog(@"ddddddddddddd%@", [_dictionary allValues]);
        [self.tableView reloadData];
        [self.rightSidebarView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.revealSidebarDelegate = self;
//    self.view.backgroundColor = [UIColor redColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableCellIdentifier];
}

- (void)revealRightSidebar:(id)sender{
    JTRevealedState state = JTRevealedStateRight;
    if (self.navigationController.revealedState == JTRevealedStateRight) {
        state = JTRevealedStateNo;
    }
    [self.navigationController setRevealedState:state];
}

- (UITableView *)viewForRightSidebar{
    CGRect mainFrame = self.navigationController.applicationViewFrame;
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(50, mainFrame.origin.y, 270, mainFrame.size.height) style:UITableViewStyleGrouped];
    if (view) {
        self.rightSidebarView = view;
        
        view.dataSource = self;
        view.delegate = self;
        [self.rightSidebarView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:CellIdentifier];

        _rightSidebarView.rowHeight = 70;
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
//        view.backgroundColor = [UIColor yellowColor];
        
        UIView* rightHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 42)];
        rightHeaderView.backgroundColor = [UIColor whiteColor];
        rightHeaderView.opaque = NO;
        
        UILabel* lable = [[UILabel alloc] initWithFrame:CGRectMake(90, 2, 100, 38)];
        [lable setText:@"在售"];
        lable.font = [UIFont systemFontOfSize:16];
        [rightHeaderView addSubview:lable];
        
        UIView* lines = [[UIView alloc] initWithFrame:CGRectMake(0, 42, 300, 2)];
        lines.backgroundColor = [UIColor cyanColor];
        [rightHeaderView addSubview:lines];
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(213, 2, 53, 38)];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [rightHeaderView addSubview:button];
        view.tableHeaderView = rightHeaderView;
    }
        return view;
}

-(void) leftButtonClicked:(id)sender{
    NSLog(@"leftButtonClicked");
    [self.navigationController setRevealedState:JTRevealedStateNo];
}

-(void) rightButtonClicked:(id)sender{
    NSLog(@"rightButtonClicked");
    [self.navigationController setRevealedState:JTRevealedStateNo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.rightSidebarView) {
        return _dictionary.count;
    }else{
        return _searchManager.dataArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.rightSidebarView) {
        NSArray *aaa = self.dictionary[_nameArray[section]];
        return aaa.count;
    }else{
        NSArray *array = _searchManager.dataDictionary[_searchManager.dataArray[section]];
        NSDictionary *dic = [array lastObject];
        return dic.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightSidebarView) {
        return _nameArray[section];
}else{
        return _searchManager.dataArray[section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.rightSidebarView) {
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
        NSArray *array = self.dictionary[_nameArray[indexPath.section]];
        
        if (array != nil) {
            BrandModel *model = array[indexPath.row];
            //        cell.textLabel.text = model.name;
            
            cell.brandModel = model;
        }

        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
        NSString *key = _searchManager.dataArray[indexPath.section];
        NSArray *array = _searchManager.dataDictionary[key];
        cell.textLabel.text =[ [array lastObject] allKeys][indexPath.row];
       // NSArray *ara =[dict allKeys];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightSidebarView) {
        ParameterController *parameterVC = [[ParameterController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:parameterVC];
        nav.navigationBar.translucent = NO;
        NSArray *aaa = self.dictionary[_nameArray[indexPath.section]];
        BrandModel *model = aaa[indexPath.row];
        parameterVC.brandModel = model;
        [self presentViewController:nav animated:YES completion:nil];
//        [self.navigationController pushViewController:nav animated:YES];
    }else{
        NSString *key = _searchManager.dataArray[indexPath.section];
        NSArray *array = _searchManager.dataDictionary[key];
        [self requestDataWithUid: [[array lastObject] allValues][indexPath.row]];
        [self revealRightSidebar:nil];
    }
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
