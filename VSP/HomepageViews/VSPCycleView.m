//
//  VSPCycleView.m
//  VSP
//
//  Created by FighterRay on 2017/7/17.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "VSPCycleView.h"

#define DEFAULT_TIMEINTERVAL 2.0
#define DEFAULT_FRAME CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)

@interface VSPCycleView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentNumber;

@end

@implementation VSPCycleView

- (void)setPageChangeTime:(NSTimeInterval)duration
{
    self.timeInterval = duration;
    [self.timer invalidate];
    [self timerConfigure];
}

#pragma mark - init

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%d", i]];
        [imagesArr addObject:img];
    }
    return [self initWithImages:imagesArr frame:DEFAULT_FRAME timeInterval:2.0];
}

- (instancetype)initWithImages:(NSArray *)images frame:(CGRect)frame timeInterval:(NSTimeInterval)timeInterval {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.images = images;
        self.timeInterval = timeInterval;
        self.currentNumber = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [self addGestureRecognizer:tap];
        
        [self cycleViewConfigure];
        [self pageControlConfigure];
        [self cycleImageViewConfigure];
    }
    return self;
}

#pragma mark - configure

- (void)cycleViewConfigure {
    
    CGFloat width = self.containerView.frame.size.width;
    CGFloat height = self.containerView.frame.size.height;
    
    self.containerView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.containerView.contentSize = CGSizeMake(3 * width, height);
    self.containerView.contentOffset = CGPointMake(width, self.containerView.frame.origin.y);
    
    self.containerView.backgroundColor = [UIColor grayColor];
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * width, 0, width, height)];
    
    self.containerView.delegate = self;
    [self.containerView addSubview:self.leftImageView];
    [self.containerView addSubview:self.middleImageView];
    [self.containerView addSubview:self.rightImageView];
    
    self.containerView.scrollEnabled = YES;
    self.containerView.showsHorizontalScrollIndicator = NO;
    self.containerView.showsVerticalScrollIndicator = NO;
    self.containerView.pagingEnabled = YES;
    
    [self addSubview:self.containerView];
}

- (void)pageControlConfigure {
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.currentPage = 0;
    self.pageControl.frame = CGRectMake(self.center.x - 50, self.frame.size.height -30, 100, 30);
    self.pageControl.numberOfPages = self.images.count;
    [self addSubview:self.pageControl];
}

- (void)cycleImageViewConfigure {
    
    self.leftImageView.image = (UIImage *)self.images[(self.currentNumber - 1 + self.images.count) % self.images.count];
    self.middleImageView.image = (UIImage *)self.images[(self.currentNumber + self.images.count) % self.images.count];
    self.rightImageView.image = (UIImage *)self.images[(self.currentNumber + 1 + self.images.count) % self.images.count];
    
    [self timerConfigure];
}

#pragma mark - action

- (void)clickAction {
    if ([self.delegate respondsToSelector:@selector(vspCycleViewClickAtIndex:)]) {
        [self.delegate vspCycleViewClickAtIndex:self.currentNumber];
    }
}

#pragma mark - timer

- (void)timerConfigure {
    self.timer = [NSTimer timerWithTimeInterval:self.timeInterval
                                         target:self
                                       selector:@selector(timerChange) userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerChange {
    self.currentNumber = (self.currentNumber + 1 + self.images.count) % self.images.count;
    self.pageControl.currentPage = self.currentNumber;
    [self.containerView setContentOffset:CGPointMake(2 * self.containerView.frame.size.width, 0) animated:YES];
    
    self.leftImageView.image = self.images[(self.currentNumber - 1 + self.images.count) % self.images.count];
    self.middleImageView.image = self.images[(self.currentNumber + self.images.count) % self.images.count];
    self.rightImageView.image = self.images[(self.currentNumber + 1 + self.images.count) % self.images.count];
    
    self.containerView.contentOffset = self.containerView.frame.origin;
}

#pragma mark - scrollView delegate

// 滑动时关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

//当用户手指停止滑动图片时 启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self timerConfigure];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    CGPoint offset = [self.containerView contentOffset];
    
    if (offset.x == 2 * self.containerView.frame.size.width) {
        self.currentNumber = (self.currentNumber + 1 + self.images.count) % self.images.count;
    } else if (offset.x == 0) {
        self.currentNumber = (self.currentNumber - 1 + self.images.count) % self.images.count;
    } else {
        return;
    }
    
    self.pageControl.currentPage = self.currentNumber;
    self.leftImageView.image = self.images[(self.currentNumber - 1 + self.images.count) % self.images.count];
    self.middleImageView.image = self.images[(self.currentNumber + self.images.count) % self.images.count];
    self.rightImageView.image = self.images[(self.currentNumber + 1 + self.images.count) % self.images.count];
    
    self.containerView.contentOffset = CGPointMake(self.containerView.frame.size.width, self.containerView.frame.origin.y);
}

@end
