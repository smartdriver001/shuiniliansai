//
//  BLGuessRuleViewController.m
//  BasketballLeague
//
//  Created by ptshan on 14-3-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLGuessRuleViewController.h"
#import "BLAFAppAPIClient.h"

@interface BLGuessRuleViewController ()

@end

@implementation BLGuessRuleViewController

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
    
    [self addLeftNavItem:@selector(dismiss)];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(15, 22, 320-30, 70)];
    if (ios7) {
        label.frame = CGRectMake(15, 0, 320-30, 70);
    }
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@""];
    [self.view addSubview:label];
    
    [self requestData];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requestData{
//    base_url1
//    http://115.29.137.26:8080/api/quiz/rules/
    NSString *path = @"quiz/rules/";
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalRequestWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view ];
        if (error) {
            [ShowLoading showErrorMessage:@"网络连接失败!" view:self.view];
            return ;
        }
        if (posts.count > 0) {
            base = [posts objectAtIndex:0];
            label.text = [NSString stringWithFormat:@"%@",base.data.quizrules];
        }else{
            [ShowLoading showErrorMessage:@"未知错误!" view:self.view];
        }
    } path:path];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
