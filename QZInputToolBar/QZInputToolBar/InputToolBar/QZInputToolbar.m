//
//  QZInputToolbar.m
//  QZInputToolBar
//
//  Created by 臧乾坤 on 2018/1/18.
//  Copyright © 2018年 QuentinZang. All rights reserved.
//

#import "QZInputToolbar.h"
#import "UIView+SetRect.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface QZInputToolbar ()<UITextViewDelegate>

/**文本输入框*/
@property (strong, nonatomic) UITextView *textView;
/**边框*/
@property (strong, nonatomic) UIView *edgeLineView;
/**顶部线条*/
@property (strong, nonatomic) UIView *topLine;
/**底部线条*/
@property (strong, nonatomic) UIView *bottomLine;
/**textView占位符*/
@property (strong, nonatomic) UILabel *placeholderLabel;
/**发送按钮*/
@property (strong, nonatomic) UIButton *sendButton;
/**键盘高度*/
@property (assign, nonatomic) CGFloat keyboardHeight;
/**发送回调*/
@property (copy, nonatomic) inputTextBlock inputTextBlock;

@end

@implementation QZInputToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0,kScreenHeight, kScreenWidth, 50);
        [self initView];
        [self addNotification];
    }
    return self;
    
}
-(void)initView {
    self.backgroundColor = [UIColor whiteColor];
    //顶部线条
    self.topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
    self.topLine.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
    [self addSubview:self.topLine];
    //底部线条
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
    self.bottomLine.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
    [self addSubview:self.bottomLine];
    //边框
    self.edgeLineView = [[UIView alloc]init];
    self.edgeLineView.width = self.width - 50 - 30;
    self.edgeLineView.left = 10;
    self.edgeLineView.layer.cornerRadius = 5;
    self.edgeLineView.layer.borderColor = RGBACOLOR(0, 0, 0, 0.5).CGColor;
    self.edgeLineView.layer.borderWidth = 1;
    self.edgeLineView.layer.masksToBounds = YES;
    [self addSubview:self.edgeLineView];
    //输入框
    self.textView = [[UITextView alloc] init];;
    self.textView.width = self.width - 50 - 46;
    self.textView.left = 18;
    self.textView.enablesReturnKeyAutomatically = YES;
    self.textView.delegate = self;
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    self.textView.scrollsToTop = NO;
    self.textView.textContainerInset = UIEdgeInsetsZero;
    self.textView.textContainer.lineFragmentPadding = 0;
    [self addSubview:self.textView];
    //占位文字
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.width = self.textView.width - 10;
    self.placeholderLabel.textColor = RGBACOLOR(0, 0, 0, 0.5);
    self.placeholderLabel.left = 23;
    [self addSubview:self.placeholderLabel];
    //发送按钮
    self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 50 - 10, self.height - 30 - 10, 50, 30)];
    [self.sendButton.layer setBorderWidth:1.0];
    [self.sendButton.layer setCornerRadius:5.0];
    self.sendButton.layer.borderColor = RGBACOLOR(0, 0, 0, 0.5).CGColor;
    self.sendButton.enabled = NO;
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:RGBACOLOR(0, 0, 0, 0.2) forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(didClicksendButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sendButton];
    self.fontSize = 20;
    self.textViewMaxLine = 3;
    
}
// 添加通知
-(void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)setFontSize:(CGFloat)fontSize {
    
    _fontSize = fontSize;
    if (!fontSize || _fontSize < 20) {
        _fontSize = 20;
    }
    self.textView.font = [UIFont systemFontOfSize:_fontSize];
    self.placeholderLabel.font = self.textView.font;
    CGFloat lineH = self.textView.font.lineHeight;
    self.height = ceil(lineH) + 10 + 10;
    self.textView.height = lineH;
    
}

- (void)setTextViewMaxLine:(NSInteger)textViewMaxLine {
    
    _textViewMaxLine = textViewMaxLine;
    if (!_textViewMaxLine || _textViewMaxLine <= 0) {
        _textViewMaxLine = 3;
    }
    
}

-(void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    
}

#pragma mark keyboardnotification
- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = keyboardFrame.size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.y = keyboardFrame.origin.y - self.height;
    }];
    
}
- (void)keyboardWillHidden:(NSNotification *)notification {
    
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.y = kScreenHeight;
    }];
    
}
#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    self.placeholderLabel.hidden = textView.text.length;
    if (textView.text.length == 0) {
        self.sendButton.enabled = NO;
        [self.sendButton setTitleColor:RGBACOLOR(0, 0, 0, 0.2) forState:UIControlStateNormal];
    }else{
        self.sendButton.enabled = YES;
        [self.sendButton setTitleColor:RGBACOLOR(0, 0, 0, 1.0) forState:UIControlStateNormal];
    }
    CGFloat contentSizeH = textView.contentSize.height;
    CGFloat lineH = textView.font.lineHeight;
    CGFloat maxTextViewHeight = ceil(lineH * self.textViewMaxLine + textView.textContainerInset.top + textView.textContainerInset.bottom);
    
    if (contentSizeH <= maxTextViewHeight) {
        
        textView.height = contentSizeH;
        
    } else {
        
        textView.height = maxTextViewHeight;
        
    }
    
    self.height = ceil(textView.height) + 10 + 10;
    self.bottom = kScreenHeight - _keyboardHeight;
    [textView scrollRangeToVisible:NSMakeRange(textView.selectedRange.location, 1)];
    
}

// 发送按钮
-(void)didClicksendButton {
    
    if (self.inputTextBlock) {
        self.inputTextBlock(self.textView.text);
    }
    
}
- (void)inputToolbarSendText:(inputTextBlock)sendText {
    
    self.inputTextBlock = sendText;
    
}

- (void)popToolbar {
    
    self.fontSize = _fontSize;
    [self.textView becomeFirstResponder];
    
}
// 发送成功 清空文字 更新输入框大小
-(void)bounceToolbar {
    
    self.textView.text = nil;
    [self.textView.delegate textViewDidChange:self.textView];
    [self endEditing:YES];
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    self.edgeLineView.height = self.textView.height + 10;
    self.textView.centerY = self.height * 0.5;
    self.placeholderLabel.height = self.textView.height;
    self.placeholderLabel.centerY = self.height * 0.5;
    self.sendButton.centerY = self.height * 0.5;
    self.edgeLineView.centerY = self.height * 0.5;
    self.bottomLine.y = self.height - 1;
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



@end
