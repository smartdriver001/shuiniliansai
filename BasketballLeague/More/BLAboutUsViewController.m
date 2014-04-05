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
//    [self requestData];
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
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((320-125)/2, (277-125)/2, 125, 125)];
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
//    [self.view addSubview:calButton];
    
    UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 250, 200, 32)];
    telLabel.backgroundColor = [UIColor clearColor];
    telLabel.textColor = [UIColor grayColor];
    telLabel.font = [UIFont systemFontOfSize:14.0f];
    telLabel.text = @"客服电话按当地市话费标准计费";
//    [self.view addSubview:telLabel];

    UILabel *weixinLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(25, 320, 200, 32)];
    weixinLabel1.backgroundColor = [UIColor clearColor];
    weixinLabel1.textColor = [UIColor grayColor];
    weixinLabel1.font = [UIFont systemFontOfSize:14.0f];
    weixinLabel1.textAlignment = UITextAlignmentCenter;
    weixinLabel1.text = @"微信账号：";
    [self.view addSubview:weixinLabel1];
    
    UILabel *weixinLabel33 = [[UILabel alloc]initWithFrame:CGRectMake(142+12, 320, 200, 32)];
    weixinLabel33.backgroundColor = [UIColor clearColor];
    weixinLabel33.textColor = [UIColor colorWithHexString:@"#ff5839"];
    weixinLabel33.font = [UIFont systemFontOfSize:14.0f];
    weixinLabel33.text = @"荣耀之城";
    [self.view addSubview:weixinLabel33];
    
    
    UILabel *sinaLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(25, 340, 200, 32)];
    sinaLabel1.backgroundColor = [UIColor clearColor];
    sinaLabel1.textColor = [UIColor grayColor];
    sinaLabel1.font = [UIFont systemFontOfSize:14.0f];
    sinaLabel1.text = @"微博账号：";
    sinaLabel1.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:sinaLabel1];
    UILabel *sinaLabel09 = [[UILabel alloc]initWithFrame:CGRectMake(142+12, 340, 200, 32)];
    sinaLabel09.backgroundColor = [UIColor clearColor];
    sinaLabel09.textColor = [UIColor colorWithHexString:@"#ff5839"];
    sinaLabel09.font = [UIFont systemFontOfSize:14.0f];
    sinaLabel09.text = @"高登麦德科技";
    [self.view addSubview:sinaLabel09];
    
    int y = 50;
    
    UILabel *weixinLabel11 = [[UILabel alloc]initWithFrame:CGRectMake(25, 320-y, 200, 32)];
    weixinLabel11.backgroundColor = [UIColor clearColor];
    weixinLabel11.textColor = [UIColor grayColor];
    weixinLabel11.font = [UIFont systemFontOfSize:14.0f];
    weixinLabel11.textAlignment = UITextAlignmentCenter;
    weixinLabel11.text = @"微信账号：";
    [self.view addSubview:weixinLabel11];
    
    UILabel *weixinLabel12 = [[UILabel alloc]initWithFrame:CGRectMake(142+12, 320-y, 200, 32)];
    weixinLabel12.backgroundColor = [UIColor clearColor];
    weixinLabel12.textColor = [UIColor colorWithHexString:@"#ff5839"];
    weixinLabel12.font = [UIFont systemFontOfSize:14.0f];
    weixinLabel12.text = @"安踏体育";
    [self.view addSubview:weixinLabel12];
    
    
    UILabel *sinaLabel11 = [[UILabel alloc]initWithFrame:CGRectMake(25, 340-y, 200, 32)];
    sinaLabel11.backgroundColor = [UIColor clearColor];
    sinaLabel11.textColor = [UIColor grayColor];
    sinaLabel11.font = [UIFont systemFontOfSize:14.0f];
    sinaLabel11.text = @"新浪账号：";
    sinaLabel11.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:sinaLabel11];
    UILabel *sinaLabel12 = [[UILabel alloc]initWithFrame:CGRectMake(142+12, 340-y, 200, 32)];
    sinaLabel12.backgroundColor = [UIColor clearColor];
    sinaLabel12.textColor = [UIColor colorWithHexString:@"#ff5839"];
    sinaLabel12.font = [UIFont systemFontOfSize:14.0f];
    sinaLabel12.text = @"安踏篮球";
    [self.view addSubview:sinaLabel12];
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
