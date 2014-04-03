//
//  BLResetPwdViewController.m
//  ShuiNiLianSai
//
//  Created by 陈庭俊 on 14-4-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLResetPwdViewController.h"
#import "BLTextField.h"
#import "UIColor+Hex.h"
#import "UIButton+Bootstrap.h"
#import "BLResetPwd.h"

@interface BLResetPwdViewController () {
    UIView *resetPwdView;
}

@end

@implementation BLResetPwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)initResetPwd{
    
    [resetPwdView removeFromSuperview];
    resetPwdView = nil;
    CGRect cgrect = self.view.frame;
    cgrect.origin = CGPointMake(0, 0);
    resetPwdView = [[UIView alloc]initWithFrame:cgrect];
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    for (int i=0; i<3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20+(i*44+i*2), 280, 44)];
        imageView.image = image;
        
        [resetPwdView addSubview:imageView];
        
        BLTextField *textfield = [[BLTextField alloc]initWithFrame:CGRectMake(30,26+(i*44)+(2*i), 200, 32)];
        textfield.font = [UIFont boldSystemFontOfSize:17.0f];
        textfield.backgroundColor = [UIColor clearColor];
        textfield.textColor = [UIColor colorWithHexString:@"#666666"];
        textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        if (i==0) {
            textfield.placeholder = @"当前密码";
            [textfield setReturnKeyType:UIReturnKeyNext];
        }else if (i==1){
            textfield.placeholder = @"新密码";
            [textfield setReturnKeyType:UIReturnKeyNext];
        }else{
            textfield.placeholder = @"确认新密码";
            [textfield setReturnKeyType:UIReturnKeyDone];
        }
        
        textfield.delegate = self;
        textfield.tag = 189+i;
        
        [resetPwdView addSubview:textfield];
    }
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(20, 180, 281, 44);
    [commitButton commitStyle];
    [commitButton setTitle:@"完成" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(resetPwdAction) forControlEvents:UIControlEventTouchUpInside];
    commitButton.tag = 101;
    [resetPwdView addSubview:commitButton];
    
    [self.view addSubview:resetPwdView];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == 189) {
        [[resetPwdView viewWithTag:190]becomeFirstResponder];
    }else if (textField.tag == 190){
        [[resetPwdView viewWithTag:191]becomeFirstResponder];
    }else if (textField.tag == 191){
        [self resetPwdAction];
    }
    return YES;
}// called when 'return' key pressed. return NO to ignore.

-(void)resetPwdAction{
    
    UILabel *pwd = (UILabel *)[resetPwdView viewWithTag:191];
    UILabel *pwd2 = (UILabel *)[resetPwdView viewWithTag:190];
    if (![pwd.text isEqualToString:pwd2.text]) {
        [ShowLoading showErrorMessage:@"新密码与确认密码不一致！" view:self.view];
        return;
    }
    BLTextField *oldPwd = (BLTextField *)[resetPwdView viewWithTag:189];
    
    [self hideKeyboard];
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    /*uid	int	true	 	球员序号
     oldpasswd	string	true	 	旧密码
     newpasswd	string	true	 	新密码
     status	int	false		是否强制修改密码	 0强制修改密码 1不强制 默认0*/
    NSString *path = [NSString stringWithFormat:@"user/rePasswd/?uid=%@&oldpasswd=%@&newpasswd=%@&status=1",uid,oldPwd.text,pwd2.text];
    path = [BLUtils encode:path];
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLResetPwd globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLResetPwd *resetPwd = [posts objectAtIndex:0];
            if ([resetPwd.msg isEqualToString:@"succ"]) {
                [[BLUtils globalCache]setString:@"1" forKey:@"status"];
                [[BLUtils globalCache]setString:resetPwd.uid forKey:@"uid"];
                [ShowLoading showSuccView:self.view message:@"修改密码成功！"];
                
                [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.5];
            }else{
                [ShowLoading showErrorMessage:resetPwd.msg view:self.view];
            }
        }
    } path:path];
}

-(void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)hideKeyboard{
    [[resetPwdView viewWithTag:189] resignFirstResponder];
    [[resetPwdView viewWithTag:190] resignFirstResponder];
    [[resetPwdView viewWithTag:191] resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
