//
//  BLFindPwdViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLFindPwdViewController.h"
#import "BLTextField.h"
#import "UIButton+Bootstrap.h"
#import "RegexKitLite.h"
#import "BLReg1ViewController.h"
#import "BLBaseObject.h"

@interface BLFindPwdViewController (){
    BLTextField *phoneField;
}

@end

@implementation BLFindPwdViewController

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
    
    [self initViews];
    [self addLeftNavItem:@selector(dismiss)];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initViews{
    
    //键盘隐藏
    UIButton *hideKeyBoard = [UIButton buttonWithType:UIButtonTypeCustom];
    hideKeyBoard.backgroundColor = [UIColor clearColor];
    hideKeyBoard.frame = self.view.frame;
    [hideKeyBoard addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hideKeyBoard];
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 282, 44)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    phoneField = [[BLTextField alloc]initWithFrame:CGRectMake(30, 20+6, 250, 32)];
    phoneField.font = [UIFont boldSystemFontOfSize:17.0f];
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.textColor = [UIColor grayColor];
    phoneField.keyboardType = UIKeyboardTypePhonePad;
    phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneField.placeholder = @"请填写您的手机号";
    [self.view addSubview:phoneField];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(20, 89, 281, 44);
    [commitButton commitStyle];
    [commitButton setTitle:@"完成" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
}

-(void)finish{
    
    [self hideKeyboard];
    
    NSString *regexString = @"^13[0-9]{1}[0-9]{8}$|14[0-9]{9}|15[0189]{1}[0-9]{8}$|18[0-9]{9}$";
    
    if(![phoneField.text isMatchedByRegex:regexString]){
        [ShowLoading showErrorMessage:@"请输入正确的手机号码！" view:self.view];
        return;
    }
    
    [self requestWithData:phoneField.text];
    
}


-(void)requestWithData:(NSString *)phone{
    NSString *path = [NSString stringWithFormat:@"sendmessage/?tel=%@",phone];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
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
        BLReg1ViewController *reg1 = [[BLReg1ViewController alloc]initWithNibName:@"BLReg1ViewController" bundle:nil];
        reg1.isNext = @"NO";
        reg1.title = @"重置密码";
        reg1.telPhone = phoneField.text;
        [self.navigationController pushViewController:reg1 animated:YES];
    }else{
        [ShowLoading showErrorMessage:baseObject.msg view:self.view];
    }
    
}

-(void)hideKeyboard{
    [phoneField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
