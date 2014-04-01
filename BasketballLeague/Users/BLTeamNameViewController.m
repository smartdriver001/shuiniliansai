//
//  BLTeamNameViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTeamNameViewController.h"
#import "UIColor+Hex.h"
#import "BLBaseObject.h"

@interface BLTeamNameViewController ()<UITextViewDelegate>
{
    UITextView * _textView;
    UILabel * placeholderLabel;
    NSString * placeholderStr;
    int cellIndex;
    
    float navHigh;
}
@end

@implementation BLTeamNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick
{
    if (cellIndex == 0) {
        if (_textView.text.length < 2) {
            [_textView resignFirstResponder];
            [ShowLoading showErrorMessage:@"字数不够" view:self.view];
        }else{
            [_textView resignFirstResponder];
            [self requestMyTeamDit:myType Value:_textView.text];
        }
    }else{
        [_textView resignFirstResponder];
        [self requestMyTeamDit:myType Value:_textView.text];
    }
//    [_delegate rightButtonClickWithText:_textView.text :cellIndex];
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doSomeThing{
    [self leftButtonClick];
    [_delegate rightButtonClickWithText:_textView.text :cellIndex];
}

/*type	string	true		球队字段名称	 球队名称:name
 球队口号:slogan
 球队角色:role
 球队介绍:intro
 value	string	true		值	 球队名称:string
 球队口号:string
 球队角色:number (前锋:1、中锋:2、后卫:3、替补:4) (1-4之前数值)
 球队介绍:string */

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)setData:(NSString *)title
{
//    [self addNavBarTitle:title action:nil];
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            navHigh = 0;
            
            [self addLeftNavItem:@selector(leftButtonClick)];
            
            [self addRightNavItemWithImg:@"commit_normal" hImg:@"commit_press" action:@selector(rightButtonClick)];
        }else{
            if (ios7) {
                navHigh = 64;
            }else{
                navHigh = 44;
            }
  
            [self addNavBar];
            [self addNavBarTitle:title action:nil];
            [self addLeftNavBarItem:@selector(leftButtonClick)];
            [self addRightNavBarItemImg:@"commit_normal" hImg:@"commit_press" action:@selector(rightButtonClick)];
        }
        
    }else{
        navHigh = 0;
        
        [self addLeftNavItem:@selector(leftButtonClick)];
        
        [self addRightNavItemWithImg:@"commit_normal" hImg:@"commit_press" action:@selector(rightButtonClick)];
    }

    
    self.title = title;
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, navHigh + 15, 290, 120)]; //初始化
    _textView.textColor = [UIColor colorWithHexString:@"FFFFFF"];//设置textview里面的字体颜色
    _textView.font = [UIFont boldSystemFontOfSize:16];//设置字体名字和字体大小
    _textView.delegate = self;//设置它的委托方法
    _textView.backgroundColor = [UIColor colorWithHexString:@"27292E"];//设置它的背景颜色
    _textView.layer.cornerRadius = 3;
    _textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _textView.scrollEnabled = YES;//是否可以拖动
    
//    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
//    [self.view addSubview:_textView];//加入到整个页面中
    
    placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 280, 40)];
    placeholderLabel.textAlignment = UITextAlignmentLeft;
    placeholderLabel.textColor = [UIColor grayColor];
    placeholderLabel.font = [UIFont systemFontOfSize:17];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    [_textView addSubview:placeholderLabel];
    
    UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(250, navHigh + 140, 55, 30)];

    numLabel.font = [UIFont systemFontOfSize:17];
    numLabel.textAlignment = UITextAlignmentCenter;
    numLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    numLabel.backgroundColor = [UIColor clearColor];
    
    if ([title isEqualToString:@"球队名称"]) {
        cellIndex = 0;
        myType = @"name";
        _textView.frame = CGRectMake(15, navHigh + 15, 290, 44);
        placeholderStr = @"请填写球队名称(2-10字)";
        
    }else if ([title isEqualToString:@"球队口号"]) {
        cellIndex = 1;
        myType = @"slogan";
        placeholderStr = @"请输入球队口号";
        numLabel.text = @"15字内";
        [self.view addSubview:numLabel];
        
    }else if ([title isEqualToString:@"我的角色"]) {
        
//        placeholderStr = @"请填写球队名称";
//        [self.view addSubview:numLabel];
        
    }else if ([title isEqualToString:@"球队介绍"]) {
        
        numLabel.text = @"80字内";
        cellIndex = 3;
        myType = @"intro";
        placeholderStr = @"请输入球队介绍";
        [self.view addSubview:numLabel];
    }
    placeholderLabel.text = placeholderStr;
    
    [self.view addSubview:_textView];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (cellIndex == 0) {
        NSString * str = [NSString stringWithFormat:@"%@",textView.text];
        if (str.length == 0) {
            placeholderLabel.text = placeholderStr;
        }else{
            placeholderLabel.text = @"";
            
            NSString *toBeString = textView.text;
            NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
            if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
                UITextRange *selectedRange = [textView markedTextRange];
                //获取高亮部分
                UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
                // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (!position) {
                    if (toBeString.length > 10) {
                        textView.text = [toBeString substringToIndex:10];
                    }
                }
                // 有高亮选择的字符串，则暂不对文字进行统计和限制
                else{
                }
            }
            // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            else{
                if (toBeString.length > 10) {
                    textView.text = [toBeString substringToIndex:10];
                }
            }
            
        }
    }else if(cellIndex == 3){
        NSString *toBeString = textView.text;
        NSString * str = [NSString stringWithFormat:@"%@",textView.text];
        if (str.length == 0) {
            placeholderLabel.text = placeholderStr;
        }else{
            placeholderLabel.text = @"";
        }
        if (toBeString.length > 80) {
            textView.text = [toBeString substringToIndex:80];
        }
    }else{
        NSString * str = [NSString stringWithFormat:@"%@",textView.text];
        if (str.length == 0) {
            placeholderLabel.text = placeholderStr;
        }else{
            placeholderLabel.text = @"";
            
            NSString *toBeString = textView.text;
            NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
            if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
                UITextRange *selectedRange = [textView markedTextRange];
                //获取高亮部分
                UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
                // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (!position) {
                    if (toBeString.length > 15) {
                        textView.text = [toBeString substringToIndex:15];
                    }
                }
                // 有高亮选择的字符串，则暂不对文字进行统计和限制
                else{
                }
            }
            // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            else{
                if (toBeString.length > 15) {
                    textView.text = [toBeString substringToIndex:15];
                }
            }

        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
