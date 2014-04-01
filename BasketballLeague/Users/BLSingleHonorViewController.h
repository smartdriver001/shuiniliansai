//
//  BLSingleHonorViewController.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-12.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLBaseViewController.h"
#import "SwipeView.h"

@protocol DismissModelView <NSObject>

-(void)dismisModelViewController;

@end

@interface BLSingleHonorViewController : BLBaseViewController<SwipeViewDataSource,SwipeViewDelegate>{
    
    UILabel *titleLabel;
    UILabel *detailLabel;
    UILabel *curentLabel;
    SwipeView *mySwipeView;
    int currentIndex;
    UIImage *tempImage;
}

@property(nonatomic,assign)id<DismissModelView> delegate;
@property(nonatomic,strong)NSArray *honors;

@end
