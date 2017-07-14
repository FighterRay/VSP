//
//  PopMenuView.m
//  VSP
//
//  Created by FighterRay on 2017/7/14.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "PopMenuView.h"
#import "PopMenuModel.h"
#import "PopMenuTableViewCell.h"

@interface PopMenuView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <PopMenuModel *> *menuItems;
@property (nonatomic, strong) void(^action)(NSInteger index);

@end

@implementation PopMenuView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

// 绘制三角形
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[UIColor whiteColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGFloat location = [UIScreen mainScreen].bounds.size.width - 55;
    CGContextMoveToPoint(context,
                         location -  10 - 10, 180);//设置起点
    CGContextAddLineToPoint(context,
                            location - 2*10 - 10 ,  170);
    CGContextAddLineToPoint(context,
                            location - 10 * 3 - 10, 180);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor whiteColor] setFill];  //设置填充色
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}

+ (PopMenuView *)showWithFrame:(CGRect)frame
                        items:(NSArray<PopMenuModel *> *)items
                       action:(void (^)(NSInteger))action {
    static PopMenuView *popMenuView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popMenuView = [[PopMenuView alloc] initWithFrame:frame];
    });

    if (popMenuView) {
        popMenuView.menuItems = items;
        popMenuView.action = [action copy];
        
        popMenuView.tableView = [[UITableView alloc] initWithFrame:CGRectMake(-82, -60, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        popMenuView.tableView.delegate = popMenuView;
        popMenuView.tableView.dataSource = popMenuView;
        popMenuView.tableView.layer.cornerRadius = 10.0f;
        popMenuView.tableView.layer.anchorPoint = CGPointMake(0, 0);
        popMenuView.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        popMenuView.tableView.rowHeight = 40;
        [popMenuView.tableView setSeparatorInset:UIEdgeInsetsZero];
        [popMenuView.tableView setLayoutMargins:UIEdgeInsetsZero];

        [popMenuView addSubview:popMenuView.tableView];
        
        popMenuView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
        UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
        [window addSubview:popMenuView];
        
        [UIView animateWithDuration:0.3 animations:^{
            popMenuView.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    return popMenuView;
}

- (CGRect)menuMake {
    CGFloat menuX = 0;
    CGFloat menuY = 0;
    CGFloat width = 160;
    CGFloat heigh = 40 * 2;
    return CGRectMake(menuX, menuY, width, heigh);
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

@end
