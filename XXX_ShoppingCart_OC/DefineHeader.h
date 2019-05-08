//
//  DefineHeader.h
//  XXX_ShoppingCart_OC
//
//  Created by PohlKepler on 4/29/19.
//  Copyright © 2019 iOS. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h



#define kScreenBounds       [UIScreen mainScreen].bounds
#define kKeyWindow          [UIApplication sharedApplication].keyWindow

/**
 *  iPhone X机型判断
 */
#pragma mark - iPhone X机型判断
// 判断是否为iPhone X 或者 iPhone XS 或者 iPhone XS Max
#define kIsiPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kWeakSelf __weak typeof(self) weakSelf = self;
#define kScreenW            [UIScreen mainScreen].bounds.size.width
#define kScreenRealH        [UIScreen mainScreen].bounds.size.height
#define kScreenH            (kIsiPhoneX ? [UIScreen mainScreen].bounds.size.height - 88 : [UIScreen mainScreen].bounds.size.height - 64)

#define kScaleX             (kScreenW < 375 ? (kScreenW / 375) : 1.0)
#define kScaleY             (kScreenRealH < 667 ? (kScreenRealH / 667) : 1.0)
#define kCGRectX(x)         x * kScaleX
#define kCGRectY(y)         y * kScaleY
#define kCGRectW(width)     width * kScaleX
#define kCGRectH(height)    height * kScaleY

/**
 *  字体
 */
#pragma mark - 字体
// 字体适配屏幕
#define fontSizeValue(fontSize) (kScreenRealH < 667) ? (fontSize * 0.8) : fontSize
#define fontSize(fontSize) [UIFont systemFontOfSize:(kScreenRealH < 667) ? (fontSize * 0.8) : fontSize]
#define fontSizeBold(fontSize) [UIFont boldSystemFontOfSize:(kScreenRealH < 667) ? (fontSize * 0.8) : fontSize]
/**
 *  字符串拼接
 */
#pragma mark - 字符串拼接
#define kNSStringFormat(...) [NSString stringWithFormat:__VA_ARGS__]

/**
 *  颜色设置
 */
#pragma mark - 颜色设置
#define kRGBAColor(r, g, b, a) \
[UIColor colorWithRed:(r/255.0)\
green:(g/255.0)\
blue:(b/255.0)\
alpha:(a)]


#endif /* DefineHeader_h */
