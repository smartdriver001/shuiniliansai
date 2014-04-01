//
//  BLMySingleGameViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-4.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"

@interface BLMySingleGameViewController : BLBaseViewController {
    UIImageView * iconAImageView;
    UIImageView * iconBImageView;
    
    UILabel * nameALabel;
    UILabel * nameBLabel;
    
    UILabel * scoreLabel;
    UILabel * scoreLabel1;
    
    UILabel *duishouLabel;
    UILabel *benduiLabel;
}

-(void)requestSingleGame:(NSString *)matchid uid:(NSString *)uid from:(NSString *)from;

@end
