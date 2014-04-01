//
//  BLCommenNewCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLCommenNewCell.h"
#import "UIColor+Hex.h"

@implementation BLCommenNewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    _bgView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:_bgView];
    _title = [[UILabel alloc]initWithFrame:CGRectMake(37, (44-25)/2, 100, 25)];
    _title.backgroundColor = [UIColor clearColor];
    _title.textColor = [UIColor colorWithHexString:@"#cccccc"];
    _title.font = [UIFont boldSystemFontOfSize:17.0f];
    _title.textAlignment = UITextAlignmentCenter;
    _title.text = @"我的战队";
    [self addSubview:_title];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow@2x"]];
    imageView.frame = CGRectMake(285, (44-25)/2, 25, 25);
    [self addSubview:imageView];
    
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, (44-25)/2, 25, 26)];
    _icon.image = [UIImage imageNamed:@"bisai"];
    [self addSubview:_icon];
    
    _count = [[UILabel alloc]initWithFrame:CGRectMake(285-60, (44-25)/2, 100, 25)];
    _count.backgroundColor = [UIColor clearColor];
    _count.textColor = [UIColor colorWithHexString:@"#cccccc"];
    _count.textAlignment = UITextAlignmentRight;
    _count.font = [UIFont boldSystemFontOfSize:17.0f];
    _count.textAlignment = UITextAlignmentCenter;
//    _count.text = @"12";
    [self addSubview:_count];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}
@end
