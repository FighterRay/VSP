//
//  VSPSaleServiceSearchView.h
//  VipServicePlatform
//
//  Created by JD on 3/20/17.
//  Copyright © 2017 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSPSaleServiceSearchViewDelegate <NSObject>

- (void)saleServiceSearchEndEditing:(NSString *)string;
- (void)saleServiceSearchDidChange:(NSString *)string;

@end

@interface VSPSaleServiceSearchView : UIView

@property (nonatomic, weak) id<VSPSaleServiceSearchViewDelegate> delegate;

@end
