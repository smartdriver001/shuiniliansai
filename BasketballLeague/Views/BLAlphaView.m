//
//  BLAlphaView.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-16.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLAlphaView.h"

@implementation BLAlphaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initview];
    }
    return self;
}

-(void)initview{
    int y = 0;
    if (ios7) {
        y = 20;
    }else{
        y = 0;
    }

    self.frame = CGRectMake(0, 44 + y, self.frame.size.width, self.frame.size.height);
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.5;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
