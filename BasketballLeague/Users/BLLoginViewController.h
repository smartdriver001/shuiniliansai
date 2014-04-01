//
//  BLLoginViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "BLPersonData.h"

@protocol InitUID <NSObject>

-(void)initUID:(BLPersonData *)personData;

@end

@interface BLLoginViewController : BLBaseViewController{
    float y ;
    UITextField *username;
    UITextField *password;
}
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property(nonatomic,assign)id<InitUID> delegate;
- (IBAction)dissmis:(id)sender;

@end
