//
//  HotSaleTableViewCell.m
//  VSP
//
//  Created by FighterRay on 2017/7/14.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "HotSaleTableViewCell.h"
#import "HotSaleCollectionViewCell.h"

@interface HotSaleTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HotSaleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotSaleCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotSaleCollectionViewCell" forIndexPath:indexPath];
    return collectionCell;
}

@end
