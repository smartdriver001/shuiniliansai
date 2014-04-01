//
//  UIColor+Hex.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)colorWithHex:(NSInteger)hexValue;
+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue;
+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue;
@end
