//
//  BLMyTeamDitViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "BLData.h"
#import "BLMy_teamMembers.h"
#import "ASIFormDataRequest.h"

@protocol MyTeamDitDelegate;

@interface BLMyTeamDitViewController : BLBaseViewController{
    NSArray *roles;
    ASIFormDataRequest *request;
    NSString *filePath;
    UIImage *iconImage;
    UIImageView * iconImageView;
}

-(void)setData:(BLData *)data :(BLMy_teamMembers *)myMember :(NSString *)imageUrl;

@property (strong, nonatomic) ASIFormDataRequest *request;

@property (nonatomic, assign) id<MyTeamDitDelegate>delegate;

@end

@protocol MyTeamDitDelegate <NSObject>

-(void)reloadMyTeamDetail;

@end
