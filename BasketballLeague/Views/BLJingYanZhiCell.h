//
//  BLJingYanZhiCell.h
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLPersonData.h"

@interface BLJingYanZhiCell : UITableViewCell {
    
    UIImageView *jyzBG;
    UIImageView *jyzProgress;
    UILabel *jyzLabel;
    UILabel *jyzPer;
}

-(void)initData:(BLPersonData *)person;

@end
