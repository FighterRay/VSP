//
//  PopMenuView.h
//  VSP
//
//  Created by FighterRay on 2017/7/14.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopMenuModel;

@interface PopMenuView : UIView

+ (instancetype)showWithFrame:(CGRect)frame
                        items:(NSArray <PopMenuModel *> *)items
                       action:(void (^)(NSInteger index))action;

@end
