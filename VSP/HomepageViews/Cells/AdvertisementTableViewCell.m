//
//  AdvertisementTableViewCell.m
//  VSP
//
//  Created by FighterRay on 2017/7/13.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "AdvertisementTableViewCell.h"
#import "AdvertisementCollectionViewCell.h"

@interface AdvertisementTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AdvertisementTableViewCell

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
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AdvertisementCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdvertisementCollectionViewCell" forIndexPath:indexPath];
    return collectionCell;
}

@end
