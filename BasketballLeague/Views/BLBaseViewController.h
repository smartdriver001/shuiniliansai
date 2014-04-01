//
//  BLBaseViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLBaseViewController : UIViewController

-(void)setBackgroudView:(NSString *)image;

- (void)addLeftNavItem:(SEL)action;

- (void)addLeftNavItemAndTextImg:(NSString *)img Text:(NSString *)text :(SEL)action;

- (void)addRightNavItemWithImg:(NSString *)img hImg:(NSString *)hImg action:(SEL)action;

- (void)addCustomBtnToNavBar:(NSInteger)position btn:(UIButton *)btn;

- (void)addNavTextAndDetailText:(NSString *)text :(NSString *)detailText action:(SEL)action;

- (void)addNavText:(NSString *)text action:(SEL)action;

- (void)addNavRightText:(NSString *)text action:(SEL)action;

-(void)addNavBar;
-(void)addLeftNavBarItem:(SEL)action;
-(void)addNavBarTitle:(NSString *)text action:(SEL)action;
- (void)addNavBarTitle:(NSString *)text andDetailTitle:(NSString *)dtext action:(SEL)action;
-(void)addRightNavBarItemImg:(NSString *)img hImg:(NSString *)himg action:(SEL)action;

-(void)addADNavBar;

-(void)initURLS;

-(void)addRightNavBarItem:(NSString *)title action:(SEL)action;

@end
