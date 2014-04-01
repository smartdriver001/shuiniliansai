//
//  BLAlertViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"

@protocol didClickDelegate <NSObject>

-(void)didClickButton:(UIButton *)button;

@end

@interface BLAlertViewController : BLBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
- (IBAction)btnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property(nonatomic,assign)id<didClickDelegate> delegate;
@end
