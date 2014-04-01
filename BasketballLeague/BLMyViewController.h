//
//  BLMyViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-17.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "ASIFormDataRequest.h"

@class BLTextField;

@interface BLMyViewController : BLBaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    int currentIndex;
    
    NSString *filePath;
    
    ASIFormDataRequest *request;
    
    NSString *imgid;
    NSArray *photosArray;
    
    BOOL isIcon;
    UIImage *iconImage;
    
    NSString *fromString;
    NSString *uid;
    NSString *postId;
    
    BLTextField *username;
    BLTextField *password;
    
    UIButton *_loginButton;
    float loginy ;
    
    UIView *loginView;
    
    UIView *resetPwdView;
    
}

-(void)setVisitid:(NSString *)visitid andName:(NSString *)name from:(NSString *)from;

-(void)setVisitid:(NSString *)visitid andName:(NSString *)name;

@property (retain, nonatomic) ASIFormDataRequest *request;
@property (assign, nonatomic) BOOL isFromeGoldRank;

@end
