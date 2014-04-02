//
//  BLLeagueSubViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-18.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLLeagueSubViewController.h"
#import "BLBaseObject.h"

@interface BLLeagueSubViewController ()

@end

@implementation BLLeagueSubViewController

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
    _webView.delegate = self;
    
    [self initLeftButton];
    
    [self performSelector:@selector(requestWithData) withObject:nil afterDelay:0.3];
}

-(void)initLeftButton{
    [self addLeftNavItem:@selector(dismiss)];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requestWithData{
    
    //    奖励制度 http://115.29.137.26/other/prize/
//    升级方式 http://115.29.137.26/other/update/
    NSString *path ;
    //        dataSource = @[@"奖励制度",@"升级方式"];
    if ([self.title isEqualToString:@"奖励制度"]) {
        path = @"other/prize/";
        NSURLRequest *reuqest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",base_url1,path]]];
        [_webView loadRequest:reuqest];
        
    }else if([self.title isEqualToString:@"用户使用协议"]){
        path = @"agreement/";
        
        [ShowLoading showWithMessage:showloading view:self.view];
        [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
            [ShowLoading hideLoading:self.view];
            if (error) {
                return ;
            }
            if (posts.count > 0) {
                BLBaseObject *base = [posts objectAtIndex:0];
                if ([base.msg isEqualToString:@"succ"]) {
                    if ([base.docs isEqualToString:@""]) {
                       [_webView loadHTMLString:@"暂无协议内容！" baseURL:nil];
                    }else{
                        [_webView loadHTMLString:base.docs baseURL:nil];
                    }
                }else{
                    [ShowLoading showErrorMessage:base.msg view:self.view];
                }
            }
        } path:path];
    }else{
        path = @"other/update/";
        NSURLRequest *reuqest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",base_url1,path]]];
        [_webView loadRequest:reuqest];
        
    }
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [ShowLoading showWithMessage:showloading view:self.view];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [ShowLoading hideLoading:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
