//
//  BLFeedbackViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-18.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLFeedbackViewController.h"
#import "BLTextField.h"
#import "BLBaseObject.h"

@interface BLFeedbackViewController (){
    
    UITextView *_textView;
    BLTextField *telphoneField;
    UILabel *holderLabel;
}

@end

@implementation BLFeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"意见反馈";
        [self setBackgroudView:@""];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLeftButton];
    [self addNavRightText:@"发送" action:@selector(commit)];
    
    [self initViews];
}

-(void)initViews{
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone5) {
        bgButton.frame = iPhone5_frame;
    }else{
        bgButton.frame = iPhone4_frame;
    }
    bgButton.backgroundColor = [UIColor clearColor];
    [bgButton addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgButton];
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 140)];
    bgImageView.backgroundColor = [UIColor clearColor];
    bgImageView.image = image;
    [self.view addSubview:bgImageView];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 12, 300, 135)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.delegate = self;
    _textView.textColor = [UIColor grayColor];
    [self.view addSubview:_textView];
    
    holderLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 13, 300, 32)];
    holderLabel.backgroundColor = [UIColor clearColor];
    holderLabel.textColor = [UIColor grayColor];
    holderLabel.text = @"请输入您的意见";
    [self.view addSubview:holderLabel];
    
    UILabel *contactM = [[UILabel alloc]initWithFrame:CGRectMake(18, 150, 100, 32)];
    contactM.backgroundColor = [UIColor clearColor];
    contactM.text = @"联系方式";
    contactM.font = [UIFont boldSystemFontOfSize:16.0f];
    contactM.textColor = [UIColor grayColor];
    [self.view addSubview:contactM];
    
    UIImageView *telImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 180, 300, 44)];
    telImageView.image = image ;
    [self.view addSubview:telImageView];
    
    if (ios7) {
        telphoneField = [[BLTextField alloc]initWithFrame:CGRectMake(16, 180, 294, 44)];

    }else{
        
        telphoneField = [[BLTextField alloc]initWithFrame:CGRectMake(16, 192, 294, 44)];
    }
    telphoneField.backgroundColor = [UIColor clearColor];
    telphoneField.placeholder = @"请留下联系方式，方面我们联系您！";
    telphoneField.font = [UIFont boldSystemFontOfSize:15.0f];
    telphoneField.textColor = [UIColor grayColor];
    telphoneField.delegate = self;
    [self.view addSubview:telphoneField];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        holderLabel.hidden = YES;
    }else{
        holderLabel.hidden = NO;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!iPhone5 && !ios7) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, -30, 320, 460-44);
        }];
    }else if (!iPhone5 && ios7){
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, -30, 320, 460-44);
        }];
    }
}// became first responder

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (!iPhone5 && !ios7) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, 0, 320, 460-44);
        }];
    }else if (!iPhone5 && ios7){
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, 20+44, 320, 460-44);
        }];
    }
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

-(void)hideKeyboard{
    [_textView resignFirstResponder];
    [telphoneField resignFirstResponder];
}

-(void)commit{

    [self hideKeyboard];
    
    NSString *content = _textView.text;
    NSString *contact = telphoneField.text;
    if (content.length < 1 || contact.length < 1) {
        [ShowLoading showErrorMessage:@"反馈内容和联系方式不能为空" view:self.view];
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"feedback/?content=%@&contact=%@",content,contact];
    NSString *pathEncode = [BLUtils urlEncode:path];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLBaseObject *baseInfo = [posts objectAtIndex:0];
            if ([baseInfo.msg isEqualToString:@"succ"]) {
                [ShowLoading showSuccView:self.view message:@"提交成功"];
            }
        }
    } path:pathEncode];
    
}

-(void)initLeftButton{
    [self addLeftNavItem:@selector(dismiss)];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
