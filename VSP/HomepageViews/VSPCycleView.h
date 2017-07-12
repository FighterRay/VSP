//
//  VSPCycleView.h
//  VSP
//
//  Created by FighterRay on 2017/7/11.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSPCycleViewDelegate <NSObject>

@optional
- (void)vspCycleViewClickAtIndex:(NSInteger)index;

@end

@interface VSPCycleView : UIView

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *pageDescrips;
@property (nonatomic, assign) NSTimeInterval timeInterval;  // 改变 page 的时间间隔
@property (nonatomic, weak) id<VSPCycleViewDelegate> delegate;

@end
