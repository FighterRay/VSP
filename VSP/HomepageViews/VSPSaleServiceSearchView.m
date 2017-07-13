//
//  VSPSaleServiceHeaderView.m
//  VipServicePlatform
//
//  Created by JD on 3/20/17.
//  Copyright © 2017 JD. All rights reserved.
//
#define VSPColorViewLightGray [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.] /**< 灰色背景 */

#import "VSPSaleServiceSearchView.h"

@interface VSPSaleServiceSearchView() <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *backImageView;
@property (nonatomic, weak) IBOutlet UIImageView *searchImageView;
@property (nonatomic, weak) IBOutlet UITextField *inputText;

@end

@implementation VSPSaleServiceSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
        [self addSubview:view];
        
        view.backgroundColor = VSPColorViewLightGray;
        
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
        [self addSubview:view];
        
        view.backgroundColor = VSPColorViewLightGray;
        
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.backImageView.layer.cornerRadius = 2;
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.searchImageView.image = [UIImage imageNamed:@"icon_search"];
    
    self.inputText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    self.inputText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputText.returnKeyType = UIReturnKeySearch;
    self.inputText.tintColor = [UIColor blueColor];
    
    self.inputText.text = nil;
    self.inputText.placeholder = @"请输入要查询的订单编号";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextField

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(saleServiceSearchEndEditing:)]) {
        [self.delegate saleServiceSearchEndEditing:textField.text];
    }
}

- (void)textFieldTextDidChange:(id)sender {
    if ([self.delegate respondsToSelector:@selector(saleServiceSearchDidChange:)]) {
        [self.delegate saleServiceSearchDidChange:self.inputText.text];
    }
}

@end
