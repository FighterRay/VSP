//
//  VSPCycleView.h
//  VSP
//
//  Created by FighterRay on 2017/7/17.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSPCycleViewDelegate <NSObject>

@optional
- (void)vspCycleViewClickAtIndex:(NSInteger)index;

@end

@interface VSPCycleView : UIView

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, weak) id<VSPCycleViewDelegate> delegate;

- (instancetype)initWithImages:(NSArray *)images frame:(CGRect)frame timeInterval:(NSTimeInterval)timeInterval;

@end
