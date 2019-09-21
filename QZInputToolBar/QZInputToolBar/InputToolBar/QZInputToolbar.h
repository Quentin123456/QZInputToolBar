//
//  QZInputToolbar.h
//  QZInputToolBar
//
//  Created by 臧乾坤 on 2018/1/18.
//  Copyright © 2018年 QuentinZang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^inputTextBlock)(NSString *text);

@interface QZInputToolbar : UIView

/**设置输入框最大行数*/
@property (assign, nonatomic) NSInteger textViewMaxLine;
/**输入框文字大小*/
@property (assign, nonatomic) CGFloat fontSize;
/**占位文字*/
@property (copy, nonatomic) NSString *placeholder;

/**收回键盘*/
- (void)bounceToolbar;
/**弹出键盘*/
- (void)popToolbar;
/**点击发送后的文字*/
- (void)inputToolbarSendText:(inputTextBlock)sendText;

@end
