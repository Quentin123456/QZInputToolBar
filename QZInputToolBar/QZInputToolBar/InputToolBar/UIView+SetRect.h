//
//  UIView+SetRect.h
//  QZInputToolBar
//
//  Created by 臧乾坤 on 2018/1/17.
//  Copyright © 2018年 QuentinZang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIScreen width.
 */
#define  kScreenWidth   [UIScreen mainScreen].bounds.size.width

/**
 *  UIScreen height.
 */
#define  kScreenHeight  [UIScreen mainScreen].bounds.size.height

/**iPhone5为标准，乘以宽的比例*/
#define kScaleX(value) (((value) / 2.0f)/320.0f * kScreenWidth)

/**iPhone5为标准，乘以高的比例*/
#define kScaleY(value) (((value) / 2.0f)/568.0f * kScreenHeight)

/**
 *  Status bar height.
 */
#define  kStatusBarHeight      20.f

/**
 *  Navigation bar height.
 */
#define  kNavigationBarHeight  44.f

/**
 *  Tabbar height.
 */
#define  kTabbarHeight         49.f

/**
 *  Status bar & navigation bar height.
 */
#define  kStatusBarAndNavigationBarHeight   (20.f + 44.f)

/**
 *  iPhone4 or iPhone4s
 */
#define  iPhone4_4s     (kScreenWidth == 320.f && kScreenHeight == 480.f ? YES : NO)

/**
 *  iPhone5 or iPhone5s
 */
#define  iPhone5_5s     (kScreenWidth == 320.f && kScreenHeight == 568.f ? YES : NO)

/**
 *  iPhone6 or iPhone6s
 */
#define  iPhone6_6s     (kScreenWidth == 375.f && kScreenHeight == 667.f ? YES : NO)

/**
 *  iPhone6Plus or iPhone6sPlus
 */
#define  iPhone6_6sPlus (kScreenWidth == 414.f && kScreenHeight == 736.f ? YES : NO)

@interface UIView (SetRect)

/**
 控件起点
 */
@property (nonatomic) CGPoint viewOrigin;

/**
 控件大小
 */
@property (nonatomic) CGSize  viewSize;

/**
 控件起点x
 */
@property (nonatomic) CGFloat x;

/**
 控件起点Y
 */
@property (nonatomic) CGFloat y;

/**
 控件宽
 */
@property (nonatomic) CGFloat width;

/**
 控件高
 */
@property (nonatomic) CGFloat height;

/**
 控件顶部
 */
@property (nonatomic) CGFloat top;

/**
 控件底部
 */
@property (nonatomic) CGFloat bottom;

/**
 控件左边
 */
@property (nonatomic) CGFloat left;

/**
 控件右边
 */
@property (nonatomic) CGFloat right;

/**
 控件中心点X
 */
@property (nonatomic) CGFloat centerX;

/**
 控件中心点Y
 */
@property (nonatomic) CGFloat centerY;

/**
 控件左下
 */
@property(readonly) CGPoint bottomLeft ;

/**
 控件右下
 */
@property(readonly) CGPoint bottomRight ;

/**
 控件左上
 */
@property(readonly) CGPoint topLeft ;
/**
 控件右上
 */
@property(readonly) CGPoint topRight ;


/**
 屏幕中心点X
 */
@property (nonatomic, readonly) CGFloat middleX;

/**
 屏幕中心点Y
 */
@property (nonatomic, readonly) CGFloat middleY;

/**
 屏幕中心点
 */
@property (nonatomic, readonly) CGPoint middlePoint;

/**
 控件size
 */
@property (nonatomic) CGSize size;

/**
 设置上边圆角
 */
- (void)setCornerOnTop:(CGFloat) conner;

/**
 设置下边圆角
 */
- (void)setCornerOnBottom:(CGFloat) conner;
/**
 设置左边圆角
 */
- (void)setCornerOnLeft:(CGFloat) conner;
/**
 设置右边圆角
 */
- (void)setCornerOnRight:(CGFloat) conner;

/**
 设置左上圆角
 */
- (void)setCornerOnTopLeft:(CGFloat) conner;

/**
 设置右上圆角
 */
- (void)setCornerOnTopRight:(CGFloat) conner;
/**
 设置左下圆角
 */
- (void)setCornerOnBottomLeft:(CGFloat) conner;
/**
 设置右下圆角
 */
- (void)setCornerOnBottomRight:(CGFloat) conner;


/**
 设置所有圆角
 */
- (void)setAllCorner:(CGFloat) conner;

@end
