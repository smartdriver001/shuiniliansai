//
//  BLLevelCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.

//  级别Cell

#import "BLLevelCell.h"
#import "UIColor+Hex.h"

@implementation BLLevelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{

    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    view.backgroundColor = [UIColor colorWithHexString:@"#3e4149"];
    [self addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, (45-25)/2, 55, 25)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = @"等级";
    [self addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow@2x"]];
    imageView.frame = CGRectMake(285, (45-25)/2, 25, 25);
    [self addSubview:imageView];
    
    levelIcon = [[UIImageView alloc]initWithFrame:CGRectMake(83, 5, 40, 40)];
    levelIcon.image = [UIImage imageNamed:@"level@2x"];
    [self addSubview:levelIcon];
    
    levelTitle = [[UILabel alloc]initWithFrame:CGRectMake(112, 12, 120, 25)];
    levelTitle.backgroundColor = [UIColor clearColor];
    levelTitle.textColor = [UIColor whiteColor];
    levelTitle.font = [UIFont boldSystemFontOfSize:17.0f];
    levelTitle.textAlignment = UITextAlignmentCenter;
//    levelTitle.text = @"空中飞人";
    [self addSubview:levelTitle];
    
}

-(void)initData:(BLPersonData *)person{
    NSString *titleString;
    if ([person.level intValue] > 10 && [person.level intValue] <=20 ) {
        titleString = [NSString stringWithFormat:@"白银%@级",person.level];
    }else if ([person.level intValue] > 20 && [person.level intValue] <=30 ){
        titleString = [NSString stringWithFormat:@"黄金%@级",person.level];
    }else if ([person.level intValue] > 30 && [person.level intValue] <=40 ){
        titleString = [NSString stringWithFormat:@"白金%@级",person.level];
    }else if ([person.level intValue] > 40 && [person.level intValue] <=50 ){
        titleString = [NSString stringWithFormat:@"钻石%@级",person.level];
    }else{
        titleString = [NSString stringWithFormat:@"青铜%@级",person.level];
    }
    levelTitle.text = titleString;//[NSString stringWithFormat:@"%@",person.level];;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

@end
