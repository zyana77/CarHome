//
//  TechnologyController.m
//  项目A_汽车之家
//
//  Created by zyana on 15/11/16.
//  Copyright © 2015年 zyana. All rights reserved.
//

#import "TechnologyController.h"
#import "TechnologyManager.h"
#import "TechnologyTableViewCell.h"
#import "DetailsController.h"

@interface TechnologyController ()

@end

@implementation TechnologyController

static NSString *technologyIdentifier = @"technologyCell";

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"TechnologyTableViewCell" bundle:nil] forCellReuseIdentifier:technologyIdentifier];
    [TechnologyManager sharedManager].myUpDataUI = ^(){
        [self.tableView reloadData];
    };
    
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
    return [TechnologyManager sharedManager].allNews.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT / 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TechnologyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:technologyIdentifier forIndexPath:indexPath];
    
    Technology *technology = [[TechnologyManager sharedManager] technologyWithIndex:indexPath.row];
    cell.technology = technology;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsController *detailsVC = [[DetailsController alloc] init];
    Technology *technology = [[TechnologyManager sharedManager] technologyWithIndex:indexPath.row];
    detailsVC.ID = technology.ID;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailsVC];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
//    [self.navigationController pushViewController:nav animated:YES];
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
