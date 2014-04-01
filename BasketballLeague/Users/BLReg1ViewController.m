//
//  BLReg1ViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLReg1ViewController.h"
#import "BLReg2ViewController.h"
#import "BLBaseObject.h"
#import "UIColor+Hex.h"
#import "BLTextField.h"
#import "UIButton+Bootstrap.h"

@interface BLReg1ViewController (){
    NSTimer *timer;
    int seconds;
}

@end

@implementation BLReg1ViewController

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
    
    [self initTimer];
    
    [self initBackground];
    
    [self performSelector:@selector(setTelAndButtonText)  withObject:nil afterDelay:0.5];
}

-(void)initBackground {
    
    [self addLeftNavItem:@selector(dimiss)];
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 94, 178, 44)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(18, 94+44+4, 280, 44)];
    imageView1.image = image;
    [self.view addSubview:imageView1];
    
    UILabel *tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 10, 100, 32)];
    tagLabel.text = @"您的手机号";
    tagLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    tagLabel.backgroundColor = [UIColor clearColor];
    tagLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:tagLabel];
    
    telLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 11, 200, 32)];
    telLabel.font = [UIFont systemFontOfSize:16.0f];
    telLabel.backgroundColor = [UIColor clearColor];
    telLabel.textColor = [UIColor colorWithHexString:@"#ff5839"];
    [self.view addSubview:telLabel];
    
    UIImage *imageN = [[UIImage imageNamed:@"redButton_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImage *imageP = [[UIImage imageNamed:@"redButton_press.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    [_validCodeBtn_ setBackgroundImage:imageN forState:UIControlStateNormal];
    [_validCodeBtn_ setBackgroundImage:imageP forState:UIControlStateHighlighted];
    
    /*验证码 和 重置密码*/
    vCodeLabel = [[BLTextField alloc]initWithFrame:CGRectMake(25, 94+6, 165, 32)];
    vCodeLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    vCodeLabel.backgroundColor = [UIColor clearColor];
    vCodeLabel.textColor = [UIColor grayColor];
    vCodeLabel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    vCodeLabel.keyboardType = UIKeyboardTypePhonePad;

    vCodeLabel.placeholder = @"填写验证码";
    [self.view addSubview:vCodeLabel];
    
    resetPwdLabel = [[BLTextField alloc]initWithFrame:CGRectMake(25, 94+6+44+4, 270, 32)];
    resetPwdLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    resetPwdLabel.backgroundColor = [UIColor clearColor];
    resetPwdLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    resetPwdLabel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    resetPwdLabel.placeholder = @"设置密码(6-20位数字加密码)";
    resetPwdLabel.secureTextEntry = YES;
    [self.view addSubview:resetPwdLabel];
    
    _commitButton.frame = CGRectMake(18, 235, 280, 44);
    [_commitButton commitStyle];

}

-(void)dimiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTelAndButtonText{
    
    telLabel.text = [NSString stringWithFormat:@"+86%@",_telPhone];

    if ([_isNext isEqualToString:@"YES"]) {
        [_commitButton setTitle:@"下一步" forState:UIControlStateNormal];
    }else{
        [_commitButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    
}

-(void)initTimer{
    [_validCodeBtn_ setEnabled:NO];
    seconds = 60;
     timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

//倒计时方法验证码实现倒计时60秒，60秒后按钮变换开始的样子
-(void)timerFireMethod:(NSTimer *)theTimer {
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
        [_validCodeBtn_ setTitle:@"获取验证码" forState: UIControlStateNormal];
        _validCodeBtn_.titleLabel.font = [UIFont systemFontOfSize:16.0f];

        [_validCodeBtn_ setEnabled:YES];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"重新获取(%ds)",seconds];

        [_validCodeBtn_ setTitle:title forState:UIControlStateNormal];
        _validCodeBtn_.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    }
}
//如果登陆成功，停止验证码的倒数，
- (void)releaseTimer {
    if (timer) {
        if ([timer respondsToSelector:@selector(isValid)]) {
            if ([timer isValid]) {
                [timer invalidate];
                seconds = 60;
            }
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)doAction:(id)sender {
    
    BLReg2ViewController *reg2 = [[BLReg2ViewController alloc]initWithNibName:@"BLReg2ViewController" bundle:nil];
    [self.navigationController pushViewController:reg2 animated:YES];
    /*
    [self resignResponer];
    
    if ([sender tag] == 100) {
        [self reloadVcode];
    }else if ([sender tag] == 101){
        if (vCodeLabel.text.length < 6) {
            [ShowLoading showErrorMessage:@"验证码不能小于6位" view:self.view];
            return;
        }else if (resetPwdLabel.text.length < 6){
            [ShowLoading showErrorMessage:@"重置密码不能小于6位" view:self.view];
            return;
        }
        [self regAndSetPwd];
    }*/
}

-(void)regAndSetPwd{
    
    NSString *path ;
    
    if ([_isNext isEqualToString:@"YES"]) {
        path = [NSString stringWithFormat:@"signup/?tel=%@&passwd=%@&code=%@",_telPhone,resetPwdLabel.text,vCodeLabel.text];
    }else{
        path = [NSString stringWithFormat:@"resetpwd/?code=%@&tel=%@&passwd=%@",vCodeLabel.text,_telPhone,resetPwdLabel.text];

    }
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
//                [self nextStep:base];
                [ShowLoading showSuccView:self.view message:@"设置成功"];
                [self performSelector:@selector(nextStep:) withObject:base afterDelay:1.5f];
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
    } path:path];
}

-(void)nextStep:(BLBaseObject *)baseInfo{
    [self releaseTimer];
    if ([_isNext isEqualToString:@"YES"]) {
        
        BLReg2ViewController *reg2 = [[BLReg2ViewController alloc]initWithNibName:@"BLReg2ViewController" bundle:nil];
        [self.navigationController pushViewController:reg2 animated:YES];
        reg2.data = baseInfo.data;
        
    }else{
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void)reloadVcode{
    NSString *path = [NSString stringWithFormat:@"sendmessage/?tel=%@",_telPhone];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                [self initTimer];
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
    } path:path];
}

-(void)resignResponer {
    [resetPwdLabel resignFirstResponder];
    [vCodeLabel resignFirstResponder];
}


@end
