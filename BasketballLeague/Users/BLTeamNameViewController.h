//
//  BLTeamNameViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "BLData.h"

@protocol BLTeamNameVCDelegate;

@interface BLTeamNameViewController : BLBaseViewController{
    NSString *myType;
}

-(void)setData:(NSString *)title;

@property (nonatomic,strong) id<BLTeamNameVCDelegate>delegate;
@property(nonatomic,strong)BLData *blData;

@end

@protocol BLTeamNameVCDelegate <NSObject>

-(void)rightButtonClickWithText:(NSString *)text :(int)index;

@end