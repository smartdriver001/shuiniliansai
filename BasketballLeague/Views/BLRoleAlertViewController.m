//
//  BLRoleAlertViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-13.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLRoleAlertViewController.h"
#import "UIButton+Bootstrap.h"
#import "BLBaseObject.h"

@interface BLRoleAlertViewController ()

@end

@implementation BLRoleAlertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBtnStyle];
}

-(void)initBtnStyle{
    [self setBackgroudView:@""];
    [UIImage imageNamed:@"navigationbar_background"];
    
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forState:UIControlStateNormal];
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forState:UIControlStateHighlighted];
    
    [_titleBtn setTitle:@"申请加入" forState:UIControlStateNormal];
    
    [_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [_cancel dangerStyle];
    
    [_commit setTitle:@"确定" forState:UIControlStateNormal];
    [_commit commitStyle];
    
    [_qianfengBtn roleStyle];
    [_zhongfengBtn roleStyle];
    [_houweiBtn roleStyle];
    [_tibuBtn roleStyle];
    
    [self performSelector:@selector(defaultRole) withObject:nil afterDelay:0.1];
    
}

-(void)defaultRole{
    if ([_role isEqualToString:@"前锋"]) {
        _qianfengBtn.selected = YES;
        number = 1;
    }else if ([_role isEqualToString:@"中锋"]){
        _zhongfengBtn.selected = YES;
        number = 2;
    }else if ([_role isEqualToString:@"后卫"]){
        _houweiBtn.selected = YES;
        number = 3;
    }else{
        _tibuBtn.selected = YES;
        number = 4;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)selectRoleAction:(id)sender {
    _zhongfengBtn.selected = NO;
    _qianfengBtn.selected = NO;
    _houweiBtn.selected = NO;
    _tibuBtn.selected = NO;
    UIButton *button = sender;
    title = button.titleLabel.text;
    number = button.tag+1;
    if (button.selected) {
        button.selected = NO;
    }else{
        button.selected = YES;
    }
}

- (IBAction)didClickAction:(id)sender {
    if ([sender tag] == 100) {
//        [_delegate didClickWhenCommit:title];
        if ([self.role isEqualToString:@"100"]) {
            [_delegate didClickWhenCommit:[NSString stringWithFormat:@"%d",number]];
        }else{
            [self requestMyTeamDit:@"role" Value:[NSString stringWithFormat:@"%d",number]];
        }
    }else{
        [_delegate didClickWhenCommit:nil];
    }
}

-(void)doSomeThing{
    [_delegate didClickWhenCommit:title];
}

-(void)requestMyTeamDit:(NSString *)type Value:(NSString *)value
{
    NSString *path = [NSString stringWithFormat:@"my_teamedit/?id=%@&type=%@&value=%@",_blData.teamid,type,value];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                [ShowLoading showSuccView:self.view message:@"修改成功！"];
                [self performSelector:@selector(doSomeThing) withObject:nil afterDelay:1];
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}
@end
