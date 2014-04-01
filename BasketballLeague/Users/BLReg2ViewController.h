//
//  BLReg2ViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//
//完善注册用户资料 、 用户修改信息
#import <UIKit/UIKit.h>
#import "BLData.h"
#import "BLBaseViewController.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetCustomPickerDelegate.h"
#import "BLPersonData.h"

@class AbstractActionSheetPicker;

@protocol InitUID <NSObject>

-(void)initUID:(BLPersonData *)personData;

@end

@interface BLReg2ViewController : BLBaseViewController

@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
@property (nonatomic, strong) NSDate *selectedDate;
@property(nonatomic)int selectedIndex;

@property(nonatomic,strong)BLData *data;
- (IBAction)dismissKeyBorad:(id)sender;

- (IBAction)doFinish:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@property(weak,nonatomic)id<InitUID> delegate;
@end
