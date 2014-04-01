//
//  BLSearchBarView.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-13.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSearchBarView.h"
#import "BLTextField.h"

@implementation BLSearchBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
//    searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    searchView.backgroundColor = [UIColor clearColor];
//    searchView.tag = 100;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageview.image = [UIImage imageNamed:@"navigationbar_background"];
    [self addSubview:imageview];
    
    UIImageView *textfiedBG = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 240, 30)];
    textfiedBG.image = [[UIImage imageNamed:@"searchbar"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 35, 0, 20)];
    textfiedBG.tag = 19876;
    [self addSubview:textfiedBG];
    _searchField = [[BLTextField alloc]initWithFrame:CGRectMake(40, 7, 200, 30)];
    _searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _searchField.placeholder = @"搜索";
    _searchField.textColor = [UIColor whiteColor];
    [self addSubview:_searchField];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(255, 0, 60, 44);
    
    [_cancelButton setBackgroundColor:[UIColor clearColor]];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    [self addSubview:_cancelButton];
    
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
