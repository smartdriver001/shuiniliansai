//
//  BLSearchBarView.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-13.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLTextField.h"

@interface BLSearchBarView : UIView

@property(nonatomic,strong)BLTextField *searchField;
@property(nonatomic,strong)UIButton *cancelButton;

@end
