//
//  BLEditingViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-22.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
// 修改个人资料

#import <UIKit/UIKit.h>
#import "AbstractActionSheetPicker.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetCustomPickerDelegate.h"
#import "BLBaseViewController.h"
#import "BLTextField.h"
#import "UIButton+Bootstrap.h"
#import "UIColor+Hex.h"
#import "IBActionSheet.h"


@class AbstractActionSheetPicker;
@interface BLEditingViewController : BLBaseViewController

@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
@property (nonatomic, strong) NSDate *selectedDate;

@property(nonatomic,strong)NSArray *personData;

@property(nonatomic)int selectedIndex;

- (IBAction)setDatePick:(id)sender;
@end
