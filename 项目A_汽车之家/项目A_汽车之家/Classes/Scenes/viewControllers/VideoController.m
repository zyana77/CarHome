//
//  BBSController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/16.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "VideoController.h"
#import "VideoModel.h"
#import "VideoTableViewCell.h"
#import "VideoViewController.h"

@interface VideoController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation VideoController

static NSString *videoIdentifier = @"videoCell";

- (instancetype) initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        self.navigationItem.title = @"精彩视频";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视频" image:[UIImage imageNamed:@"nav_icon_forum_f.png"] selectedImage:[UIImage imageNamed:@"nav_icon_forum_p.png"]];
        [self requestData];
    }
    return self;
}

- (void) requestData{
    NSString *urlStr = VIDEOURL;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dic = dataDic[@"result"];
        NSArray *array = dic[@"list"];
        self.dataArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            VideoModel *model = [VideoModel new];
            [model setValuesForKeysWithDictionary:dict];
            [_dataArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:videoIdentifier];
//    self.tableView.backgroundColor = [UIColor yellowColor];
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
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT / 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoIdentifier forIndexPath:indexPath];
    
    VideoModel *model = _dataArray[indexPath.row];
    cell.videoModel = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    VideoModel *model = _dataArray[indexPath.row];
    videoVC.videoModel = model;
    [self.navigationController pushViewController:videoVC animated:YES];
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
