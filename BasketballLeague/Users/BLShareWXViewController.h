//
//  BLShareWXViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"

@protocol DismissModelView <NSObject>

-(void)dismisModelViewController;

@end
@interface BLShareWXViewController : BLBaseViewController{
    
    UIImageView *shareImageView;
    UIImage *_image;
}

-(void)initImage:(UIImage *)image;
@property(nonatomic,assign)id<DismissModelView> delegate;

@end
