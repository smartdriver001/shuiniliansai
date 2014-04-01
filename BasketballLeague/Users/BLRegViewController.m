//
//  BLRegViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLRegViewController.h"
#import "BLReg1ViewController.h"
#import "RegexKitLite.h"
#import "BLBaseObject.h"
#import "BLLeagueSubViewController.h"
#import "UIButton+Bootstrap.h"
#import "BLTextField.h"
#import "UIColor+Hex.h"
#import "BLReg2ViewController.h"

@interface BLRegViewController ()<UITextFieldDelegate>{
    UITextField *phoneField;
    UITextField *passwordField;
}

@end

@implementation BLRegViewController

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
    [self addLeftNavItem:@selector(dimiss)];
    [self initViews];
}

-(void)dimiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initViews{
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 282, 44)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20+46, 282, 44)];
    imageView1.image = image;
    [self.view addSubview:imageView1];
    
    phoneField = [[BLTextField alloc]initWithFrame:CGRectMake(30, 20+6, 250, 32)];
    phoneField.font = [UIFont boldSystemFontOfSize:17.0f];
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.textColor = [UIColor grayColor];
//    phoneField.keyboardType = UIKeyboardTypePhonePad;
    phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [phoneField setReturnKeyType:UIReturnKeyNext];
    phoneField.placeholder = @"请输入用户名（4-16个字符）";
    phoneField.delegate = self;
    phoneField.tag = 123;
    [self.view addSubview:phoneField];
    
    passwordField = [[BLTextField alloc]initWithFrame:CGRectMake(30, 20+6+46, 250, 32)];
    passwordField.font = [UIFont boldSystemFontOfSize:17.0f];
    passwordField.backgroundColor = [UIColor clearColor];
    passwordField.textColor = [UIColor grayColor];
    [passwordField setReturnKeyType:UIReturnKeyDone];
//    passwordField.keyboardType = UIKeyboardTypePhonePad;
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.placeholder = @"设置密码（6-20位数字加字母）";
    passwordField.delegate = self;
    [self.view addSubview:passwordField];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(20, 190, 281, 44);
    [commitButton commitStyle];
    [commitButton setTitle:@"下一步" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(getVcode:) forControlEvents:UIControlEventTouchUpInside];
    commitButton.tag = 101;
    [self.view addSubview:commitButton];
    
    [_agreementButton setTitleColor:[UIColor colorWithHexString:@"#fbb03b"] forState:UIControlStateNormal];
    _agreementButton.selected = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)getVcode:(id)sender {
    
    [self dimissKeyboard:sender];
    
    if ([sender tag] == 100) {
        //选择
        _agreementButton = sender;
        if (_agreementButton.selected) {
            _agreementButton.selected = NO;
        }else{
            _agreementButton.selected = YES;
        }
        
    }else if ([sender tag] == 101){
        //获取验证码
        
//        BLReg1ViewController *reg1 = [[BLReg1ViewController alloc]initWithNibName:@"BLReg1ViewController" bundle:nil];
//        reg1.isNext = @"YES";
//        reg1.title = @"注册";
//        reg1.telPhone = phoneField.text;
//        [self.navigationController pushViewController:reg1 animated:YES];
        
//        NSString *regexString = @"^13[0-9]{1}[0-9]{8}$|14[0-9]{9}|15[0189]{1}[0-9]{8}$|18[0-9]{9}$";
//        
//        if(![phoneField.text isMatchedByRegex:regexString]){
//            [ShowLoading showErrorMessage:@"请输入正确的手机号码！" view:self.view];
//            return;
//        }
        
        if (phoneField.text.length < 4 || phoneField.text.length > 16) {
            [ShowLoading showErrorMessage:@"请输入4-16个字符！" view:self.view];
            return;
        }else if (passwordField.text.length < 6 || passwordField.text.length > 20){
            [ShowLoading showErrorMessage:@"请输入6-20位数字加字母！" view:self.view];
            return;
        }
        
//        BLReg2ViewController *reg1 = [[BLReg2ViewController alloc]initWithNibName:@"BLReg2ViewController" bundle:nil];
//        reg1.title = @"注册";
//        
//        [self.navigationController pushViewController:reg1 animated:YES];
        
        if (!_agreementButton.selected) {
            [ShowLoading showErrorMessage:@"您还为勾选用户使用协议！" view:self.view];
            return;
        }
        
        [self requestWithData:phoneField.text password:passwordField.text];
        
    }
}

-(void)requestWithData:(NSString *)string password:(NSString *)password{
    NSString *path = [NSString stringWithFormat:@"signup/?username=%@&passwd=%@",string,password];
    
    path = [BLUtils encode:path];
    
    [ShowLoading showWithMessage:@"注册中..." view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            [ShowLoading showErrorMessage:@"网络连接失败，请稍后再试。" view:self.view];
            return ;
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            [self nextViewController:base];
        }
    } path:path];
}

-(void)nextViewController:(BLBaseObject *)baseObject{

    if ([baseObject.msg isEqualToString:@"succ"]) {
//        BLReg1ViewController *reg1 = [[BLReg1ViewController alloc]initWithNibName:@"BLReg1ViewController" bundle:nil];
//        reg1.isNext = _isNext;
//        reg1.telPhone = phoneField.text;
//        [self.navigationController pushViewController:reg1 animated:YES];
        BLReg2ViewController *reg1 = [[BLReg2ViewController alloc]initWithNibName:@"BLReg2ViewController" bundle:nil];
        reg1.data = baseObject.data;
        reg1.title = @"注册";
        [self.navigationController pushViewController:reg1 animated:YES];

    }else{
        [ShowLoading showErrorMessage:baseObject.msg view:self.view];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField*)theTextField{
    if (theTextField.tag == 123) {
        [passwordField becomeFirstResponder];
    }else{
        [phoneField resignFirstResponder];
        [passwordField resignFirstResponder];
    }
    
    return YES;
}


- (IBAction)dimissKeyboard:(id)sender {
    [phoneField resignFirstResponder];
    [passwordField resignFirstResponder];
}
- (IBAction)protocolAction:(id)sender {
    BLLeagueSubViewController *subView = [[BLLeagueSubViewController alloc]initWithNibName:@"BLLeagueSubViewController" bundle:nil];
    subView.title = @"用户使用协议";
    [self.navigationController pushViewController:subView animated:YES];
}
@end
