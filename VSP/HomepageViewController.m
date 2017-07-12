//
//  HomepageViewController.m
//  VSP
//
//  Created by FighterRay on 2017/7/11.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "HomepageViewController.h"

@interface HomepageViewController ()<CCCycleScrollViewClickActionDeleage>

@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureCCCycleScrollView];
}

- (void)configureCCCycleScrollView {
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%d", i]];
        [imagesArr addObject:image];
    }
    
    self.cccycleScrollView = [[CCCycleScrollView alloc]initWithImages:imagesArr];
    self.cccycleScrollView.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影",@"秋树",@"摩天轮"];
    self.cccycleScrollView.delegate = self;
    self.cccycleScrollView.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cccycleScrollView.frame = CGRectMake(0, 64, 365, 200);
    [self.view addSubview:self.cccycleScrollView];
}

- (void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了第%ld个图片:%@",clickIndex,self.cccycleScrollView.pageDescrips[clickIndex]);
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
