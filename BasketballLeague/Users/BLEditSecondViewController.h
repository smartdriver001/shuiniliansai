//
//  BLEditSecondViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
// 身高 体重 球号

#import "BLBaseViewController.h"

@protocol EditedDelegate <NSObject>

-(void)didEditCondition:(NSString *)result tag:(NSString *)tag;

@end

@interface BLEditSecondViewController : BLBaseViewController{
    id<EditedDelegate> delegate;
}

@property(nonatomic,strong) NSString *tag;
@property(nonatomic,strong) NSString *isCommit;
@property(strong,nonatomic) id <EditedDelegate> delegate;

@end
