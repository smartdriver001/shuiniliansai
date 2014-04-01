//
//  BLRoleAlertViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-13.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"
#import "BLData.h"

@protocol ResultClickDelegate <NSObject>

-(void)didClickWhenCommit:(NSString *)result;

@end

@interface BLRoleAlertViewController : BLBaseViewController{
    NSString *title;
    int number;
}
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property (weak, nonatomic) IBOutlet UIButton *qianfengBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhongfengBtn;
@property (weak, nonatomic) IBOutlet UIButton *houweiBtn;
@property (weak, nonatomic) IBOutlet UIButton *tibuBtn;
@property (weak, nonatomic) IBOutlet UIButton *commit;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
- (IBAction)selectRoleAction:(id)sender;

- (IBAction)didClickAction:(id)sender;

@property(nonatomic,assign)id<ResultClickDelegate> delegate;
@property(nonatomic,strong)NSString *role;
@property(nonatomic,strong)BLData *blData;
@end
