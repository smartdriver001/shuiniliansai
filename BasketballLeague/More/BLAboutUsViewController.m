//
//  BLAboutUsViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-18.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLAboutUsViewController.h"
#import "BLAgreement.h"
#import "BLBaseObject.h"
#import "UIColor+Hex.h"

@interface BLAboutUsViewController ()

@end

@implementation BLAboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setBackgroudView:@""];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initLeftButton];
    [self initViews];
    [self requestData];
}

-(void)requestData{
    NSString *path = @"aboutus/";
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view ];
        if (error) {
            [ShowLoading showErrorMessage:@"网络连接失败!" view:self.view];
            return ;
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            [self initData:base.data];
        }else{
            [ShowLoading showErrorMessage:@"未知错误!" view:self.view];
        }
    } path:path];
    
}

-(void)initData:(BLData *)data{
    tel = data.customerservicephone;
    [calButton setTitle:[NSString stringWithFormat:@"客服电话：%@",data.customerservicephone] forState:UIControlStateNormal];
    sinaLabel.text = data.weibo;
    weixinLabel.text = data.weixin;
}

-(void)initViews{
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((320-125)/2, (277-125)/2-40, 125, 125)];
    logoImageView.image = [UIImage imageNamed:@"loginLOGO"];
    [self.view addSubview:logoImageView];
    
    calButton = [UIButton buttonWithType:UIButtonTypeCustom];
    calButton.frame = CGRectMake(20, 277-70, 280, 44);
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [calButton setBackgroundImage:image forState:UIControlStateNormal];
//    [calButton setTitle:@"客服电话：400-011-0394" forState:UIControlStateNormal];
    calButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [calButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
    [calButton addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calButton];
    
    UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 250, 200, 32)];
    telLabel.backgroundColor = [UIColor clearColor];
    telLabel.textColor = [UIColor grayColor];
    telLabel.font = [UIFont systemFontOfSize:14.0f];
    telLabel.text = @"客服电话按当地市话费标准计费";
    [self.view addSubview:telLabel];

    UILabel *weixinLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 320, 200, 32)];
    weixinLabel1.backgroundColor = [UIColor clearColor];
    weixinLabel1.textColor = [UIColor grayColor];
    weixinLabel1.font = [UIFont systemFontOfSize:14.0f];
    weixinLabel1.text = @"我们的微信账号：";
    [self.view addSubview:weixinLabel1];
    
    weixinLabel = [[UILabel alloc]initWithFrame:CGRectMake(142, 320, 200, 32)];
    weixinLabel.backgroundColor = [UIColor clearColor];
    weixinLabel.textColor = [UIColor colorWithHexString:@"#ff5839"];
    weixinLabel.font = [UIFont systemFontOfSize:14.0f];
//    weixinLabel.text = @"78987678";
    [self.view addSubview:weixinLabel];
    
    
    UILabel *sinaLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(35, 340, 200, 32)];
    sinaLabel1.backgroundColor = [UIColor clearColor];
    sinaLabel1.textColor = [UIColor grayColor];
    sinaLabel1.font = [UIFont systemFontOfSize:14.0f];
    sinaLabel1.text = @"我们的新浪账号：";
    [self.view addSubview:sinaLabel1];
    sinaLabel = [[UILabel alloc]initWithFrame:CGRectMake(142, 340, 200, 32)];
    sinaLabel.backgroundColor = [UIColor clearColor];
    sinaLabel.textColor = [UIColor colorWithHexString:@"#ff5839"];
    sinaLabel.font = [UIFont systemFontOfSize:14.0f];
//    sinaLabel.text = @"78987678";
    [self.view addSubview:sinaLabel];
}

-(void)call{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tel]]];
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
