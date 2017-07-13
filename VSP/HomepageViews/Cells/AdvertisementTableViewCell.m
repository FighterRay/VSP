//
//  AdvertisementTableViewCell.m
//  VSP
//
//  Created by FighterRay on 2017/7/13.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "AdvertisementTableViewCell.h"

@interface AdvertisementTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AdvertisementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 

@end
