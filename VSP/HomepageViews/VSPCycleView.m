//
//  VSPCycleView.m
//  VSP
//
//  Created by FighterRay on 2017/7/11.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

#import "VSPCycleView.h"

@interface VSPCycleView ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger currentNumber;

@end

@implementation VSPCycleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *contentView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                             owner:self
                                                           options:nil] objectAtIndex:0];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:contentView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(contentView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(contentView)]];
        // 保证 AutoLayout 生效
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Configuration
        [self configureScrollView];
        [self configurePageControl];
        [self configureCycleImageViews];
        [self configurePageImageDescribeLabel];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPage)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

#pragma mark - Configuration

- (void)configureScrollView {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(3 * width, height);
    self.scrollView.contentOffset = CGPointMake(width, self.scrollView.frame.origin.y);
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * width, 0, width, height)];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.middleImageView];
    [self.scrollView addSubview:self.rightImageView];
    
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
}

- (void)configurePageControl {
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.images.count;
}

- (void)configurePageImageDescribeLabel {
    
}

- (void)configureCycleImageViews {
    if ([self.images count] == 0) {
        NSLog(@"VSPCycleView don't have images.");
        return;
    }
    
    self.leftImageView.image = (UIImage *)self.images[(self.currentNumber + self.images.count - 1) % self.images.count];
    self.middleImageView.image = (UIImage *)self.images[(self.currentNumber + self.images.count) % self.images.count];
    self.rightImageView.image = (UIImage *)self.images[(self.currentNumber + self.images.count - 1) % self.images.count];
    
    [self configureTimer];
}

- (void)clickPage {
    if ([self.delegate respondsToSelector:@selector(vspCycleViewClickAtIndex:)]) {
        [self.delegate vspCycleViewClickAtIndex:self.currentNumber];
    }
}

#pragma mark - Timer

- (void)configureTimer {
    self.timer = [NSTimer timerWithTimeInterval:self.timeInterval
                                         target:self
                                       selector:@selector(changeTimer)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)changeTimer {
    if (self.images.count == 0) {
        NSLog(@"VSPCycleView don't have images.");
        return;
    }
    
    self.currentNumber ++;
    self.currentNumber = (self.currentNumber + self.images.count) % self.images.count;
    self.pageControl.currentPage = self.currentNumber;
    [self.scrollView setContentOffset:CGPointMake(2*self.scrollView.frame.size.width, 0) animated:YES];
    [self changeImageViewWith:self.currentNumber];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y);
}

#pragma mark - iamgeView cycle changed

- (void)changeImageViewWith:(NSInteger)imageNumber {
    self.middleImageView.image = self.images[(imageNumber + self.images.count) / self.images.count];
    self.leftImageView.image = self.images[(imageNumber - 1 + self.images.count) / self.images.count];
    self.rightImageView.image = self.images[(imageNumber + 1 + self.images.count) / self.images.count];
}

#pragma mark - ScrollView  Delegate

//当用户手动个轮播时 关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

//当用户手指停止滑动图片时 启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self configureTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = [self.scrollView contentOffset];
    if (offset.x == 2 * self.scrollView.frame.size.width) {
        self.currentNumber = (self.currentNumber + 1 + self.images.count) / self.images.count;
    } else if (offset.x == 0){
        self.currentNumber = (self.currentNumber -  1 + self.images.count) / self.images.count;
    } else {
        return;
    }
    
    self.pageControl.currentPage = self.currentNumber;
    [self changeImageViewWith:self.currentNumber];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, self.scrollView.frame.origin.y);
    
}

@end
