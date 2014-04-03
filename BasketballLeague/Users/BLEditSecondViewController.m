//
//  BLEditSecondViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLEditSecondViewController.h"
#import "BLTextField.h"
#import "BLBaseObject.h"

@interface BLEditSecondViewController (){
    
    BLTextField *textField;
    UILabel *tagLabel;
}
- (IBAction)hidenKeyboard:(id)sender;

@end


@implementation BLEditSecondViewController

@synthesize delegate = delegate;

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
    
    [self initBackground];
}

-(void)initBackground {
    
    [self addLeftNavItem:@selector(dimiss)];
    [self addRightNavItemWithImg:@"commit_normal@2x" hImg:@"commit_press@2x" action:@selector(commit)];
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 280, 44)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    textField = [[BLTextField alloc]initWithFrame:CGRectMake(30, 20+6, 230, 32)];
    textField.font = [UIFont boldSystemFontOfSize:17.0f];
    textField.backgroundColor = [UIColor clearColor];
    textField.textColor = [UIColor grayColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    textField.keyboardType = UIKeyboardTypePhonePad;
    
    [self.view addSubview:textField];
    
    tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, 20+6, 50, 32)];
    tagLabel.backgroundColor = [UIColor clearColor];
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.view addSubview:tagLabel];
    
    [self performSelector:@selector(initHolderText) withObject:nil afterDelay:0.1];
}

-(void)initHolderText{
    if ([_tag isEqualToString:@"height"]) {
        textField.placeholder = @"请填写您的身高";
        tagLabel.text = @"(CM)";
        textField.keyboardType = UIKeyboardTypePhonePad;
    }else if([_tag isEqualToString:@"weight"]){
        textField.placeholder = @"请填写您的体重";
        tagLabel.text = @"(KG)";
        textField.keyboardType = UIKeyboardTypePhonePad;
    }else if ([_tag isEqualToString:@"ballnumber"]){
        textField.placeholder = @"请填写您的球号";
        textField.keyboardType = UIKeyboardTypePhonePad;
    }else if ([_tag isEqualToString:@"shoes"]){
        textField.placeholder = @"请填写您的球鞋";
    }else if ([_tag isEqualToString:@"school"]){
        textField.placeholder = @"请填写您的学校";
    }else if ([_tag isEqualToString:@"college"]){
        textField.placeholder = @"请填写您的院系";
    }
}

-(void)dimiss{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commit{
    
    NSString *result;
    NSString *result1;
    
    if ([_tag isEqualToString:@"height"]) {
        
        result = textField.text;
        float heightF = [result floatValue]/100;
        result1 = [NSString stringWithFormat:@"%0.2f",heightF];
    }else{
        result1 = textField.text;
        result = textField.text;
    }
    
    [self hidenKeyboard:nil];
    
    [self.delegate didEditCondition:result tag:_tag];
    
    if (_isCommit.length > 0) {
        [self commitWithchange:_tag value:result1];
    }else{
        [self dimiss];
    }
    
    
}

-(void)commitWithchange:(NSString *)type value:(NSString *)value{
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    
    NSString *path = [NSString stringWithFormat:@"my_edit/?uid=%@&type=%@&value=%@",uid,type,value];
    
    path = [BLUtils encode:path];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            
        }
        if (posts.count > 0) {
            
            BLBaseObject *base = [posts objectAtIndex:0];
            
            if ([base.msg isEqualToString:@"succ"]) {
                [ShowLoading showSuccView:self.view message:@"提交成功！"];
                [[BLUtils globalCache]setString:@"yes" forKey:@"reload"];
                [self performSelector:@selector(dimiss) withObject:nil afterDelay:1.5f];
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
    } path:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)hidenKeyboard:(id)sender {
    [textField resignFirstResponder];
}
@end
