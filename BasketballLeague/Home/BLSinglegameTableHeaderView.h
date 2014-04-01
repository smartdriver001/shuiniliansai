//
//  BLSinglegameTableHeaderView.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLData.h"

@interface BLSinglegameTableHeaderView : UIView
{
    UIImageView * iconAImageView;
    UIImageView * iconBImageView;
    
    UILabel * nameALabel;
    UILabel * nameBLabel;
    
    UILabel * scoreLabel;
    UILabel * scoreLabel1;
}

- (id)initWithFrame:(CGRect)frame :(BLData *)data;

@end
