//
//  BLLoginViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLLoginViewController.h"
#import "BLRegViewController.h"
#import "BLBaseObject.h"
#import "RegexKitLite.h"
#import "UIButton+Bootstrap.h"
#import "UIColor+Hex.h"
#import "BLTextField.h"
#import "MLNavigationController.h"
#import "BLFindPwdViewController.h"
#import "BLReg1ViewController.h"

@interface BLLoginViewController ()

@end

@implementation BLLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)initViews{
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 176+44+4, 281, 44)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UIImageView *textImg = [[UIImageView alloc]initWithFrame:CGRectMake(23, 12, 20, 20)];
    textImg.image = [UIImage imageNamed:@"pwdIcon.png"];
    [imageView addSubview:textImg];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 176, 281, 44)];
    imageView1.image = image;
    [self.view addSubview:imageView1];
    
    UIImageView *textImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(23, 12, 20, 20)];
    textImg1.image = [UIImage imageNamed:@"loginTextIcon.png"];
    [imageView1 addSubview:textImg1];
    
    /*用户名 和 密码*/
    username = [[BLTextField alloc]initWithFrame:CGRectMake(80, 176+6, 200, 32)];
    username.font = [UIFont boldSystemFontOfSize:17.0f];
    username.backgroundColor = [UIColor clearColor];
    username.textColor = [UIColor grayColor];
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.placeholder = @"账号";
    [self.view addSubview:username];
    
    password = [[BLTextField alloc]initWithFrame:CGRectMake(80, 176+6+44+4, 200, 32)];
    password.font = [UIFont boldSystemFontOfSize:17.0f];
    password.backgroundColor = [UIColor clearColor];
    password.textColor = [UIColor colorWithHexString:@"#666666"];
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.placeholder = @"密码";
    password.secureTextEntry = YES;
    [self.view addSubview:password];
    
    //忘记密码
    UIButton *forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwd.frame = CGRectMake(221, 336-64, 80, 21);
    [forgetPwd setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetPwd.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    forgetPwd.tag = 111;
    [forgetPwd setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [forgetPwd addTarget:self action:@selector(dissmis:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwd];
    
}

//初始化登陆按钮样式
-(void)initLoginButton{
    _loginButton.frame = CGRectMake(20, 312, 281, 44);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton dangerStyle];
}

-(void)clickLeftButton{
    [self resignResponer];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)clickRightButton{
    
    [self resignResponer];
    
    BLRegViewController *regViewController = [[BLRegViewController alloc]initWithNibName:@"BLRegViewController" bundle:nil];
    regViewController.isNext = @"YES";
    regViewController.title = @"注册" ;
    [self.navigationController pushViewController:regViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addLeftNavItem:@selector(clickLeftButton)];
    [self addNavRightText:@"注册" action:@selector(clickRightButton)];
    [self initLoginButton];

    [self showKeyboard];
    
    [self initViews];
    
}

//注册键盘通知事件
-(void)showKeyboard{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification  object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];

}

//显示键盘
-(void)keyboardDidShow{
    
    y = (password.frame.origin.y+216-3)-self.view.frame.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        if (iPhone5 && ios7) {
            self.view.frame = CGRectMake(0, y,self.view.frame.size.width, self.view.frame.size.height);
            NSStringFromCGRect(self.view.frame);
        }else if (ios7){
            self.view.frame = CGRectMake(0, -100,self.view.frame.size.width, self.view.frame.size.height);
        }else{
            self.view.frame = CGRectMake(0, -160,self.view.frame.size.width, self.view.frame.size.height);

        }
        
    }];
}

//隐藏键盘
-(void)keyboardDidHide{
    [UIView animateWithDuration:0.2f animations:^{
        if (iPhone5 && ios7) {
            self.view.frame = CGRectMake(0, abs(y)+3,self.view.frame.size.width, self.view.frame.size.height);
        }else if (ios7){
            self.view.frame = CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height);
        }else{
            self.view.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height);
        }

    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)dissmis:(id)sender {
    [self resignResponer];
    if ([sender tag] == 110) {
        
    }else if([sender tag] == 111){
        
        BLRegViewController *fogetPwdVC = [[BLRegViewController alloc]initWithNibName:@"BLRegViewController" bundle:nil];
        fogetPwdVC.isNext = @"NO";
        fogetPwdVC.title = @"找回密码" ;
        BLFindPwdViewController *findPwd = [[BLFindPwdViewController alloc]initWithNibName:nil bundle:nil];
        findPwd.title = @"找回密码" ;
//
        [self.navigationController pushViewController:findPwd animated:YES];
        
//        BLReg1ViewController *reg1 = [[BLReg1ViewController alloc]initWithNibName:@"BLReg1ViewController" bundle:nil];
//        reg1.isNext = @"NO";
////        reg1.telPhone = phoneField.text;
//        [self.navigationController pushViewController:reg1 animated:YES];
        
    }else if ([sender tag] == 112){
        
        if (username.text.length <4) {
            [ShowLoading showErrorMessage:@"账号不能小于11位！" view:self.view];
            return;
        }else if (password.text.length < 6){
            [ShowLoading showErrorMessage:@"密码不能小于6位！" view:self.view];
            return;
        }else{
//            NSString *regexString = @"^13[0-9]{1}[0-9]{8}$|14[0-9]{9}|15[0189]{1}[0-9]{8}$|18[0-9]{9}$";
            
//            if(![username.text isMatchedByRegex:regexString]){
//                [ShowLoading showErrorMessage:@"请输入正确的手机号码！" view:self.view];
//                return;
//            }else{
                [self LoginAction];
//            }
        }
    }
}

-(void)LoginAction{
    
    [ShowLoading showWithMessage:@"登录中..." view:self.view];
    NSString *path = [NSString stringWithFormat:@"signin/?username=%@&passwd=%@",username.text,password.text];
    
    [BLPersonData globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];

        if (error) {
            
        }
        if (posts.count > 0) {
            BLPersonData *personData = [posts objectAtIndex:0];
            if ([personData.msg isEqualToString:@"succ"]) {
                
                [[BLUtils appDelegate]setAPTags:personData.uid];//像服务器发送uid
                
                [[BLUtils globalCache]setString:personData.uid forKey:@"uid"];
                [[BLUtils globalCache]setString:personData.token forKey:@"token"];
                [self dismissModalViewControllerAnimated:YES];
                [_delegate initUID:personData];
                
            }else{
                [ShowLoading showErrorMessage:personData.msg view:self.view];
            }
        }
        
    } path:path];
}


-(void)resignResponer {
    [username resignFirstResponder];
    [password resignFirstResponder];
}
@end
