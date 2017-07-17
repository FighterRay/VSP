//
//  FloorTableViewCell.m
//  VSP
//
//  Created by FighterRay on 2017/7/17.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "FloorTableViewCell.h"
#import "FloorCollectionViewCell.h"

@interface FloorTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FloorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.scrollEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UICollection Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FloorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FloorCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

@end
