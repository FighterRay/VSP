//
//  AnnocementView.m
//  VSP
//
//  Created by FighterRay on 2017/7/21.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "VSPAnnouncementView.h"

@implementation VSPAnnouncementView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
        [self addSubview:view];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
        [self addSubview:view];
    }
    return self;
}

@end
