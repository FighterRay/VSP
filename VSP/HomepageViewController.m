//
//  HomepageViewController.m
//  VSP
//
//  Created by FighterRay on 2017/7/11.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "HomepageViewController.h"
#import "VSPCycleView.h"
#import "VSPSaleServiceSearchView.h"
#import "AnnouncementTableViewCell.h"
#import "FloorTableViewCell.h"

@interface HomepageViewController ()<UITableViewDelegate, UITableViewDataSource, CCCycleScrollViewClickActionDeleage>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.hidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0 || row == 2) {
        return 150;
    } else if (row == 1 || row == 3) {
        return 30;
    } else if (row == 4) {
        return 500;
    } else {
        return 816;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CycleViewTableViewCell" forIndexPath:indexPath];
        return cell;
    } else if (row == 1) {
        AnnouncementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnnouncementTableViewCell" forIndexPath:indexPath];
        return cell;
    } else if (row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvertisementTableViewCell" forIndexPath:indexPath];
        return cell;
    } else if (row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell" forIndexPath:indexPath];
        return cell;
    } else if (row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotSaleTableViewCell" forIndexPath:indexPath];
        return cell;
    } else {
        FloorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FloorTableVIewCell"];
        return cell;
    }
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
