//
//  BLJingYanZhiCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLJingYanZhiCell.h"
#import "UIColor+Hex.h"

@implementation BLJingYanZhiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    if (jyzBG) {
        return;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    view.backgroundColor = [UIColor colorWithHexString:@"#36383f"];
    [self addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, (45-25)/2, 55, 25)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    titleLabel.textAlignment = UITextAlignmentRight;
    titleLabel.text = @"经验值";
    [self addSubview:titleLabel];
    
    jyzBG = [[UIImageView alloc]init];
    jyzBG.frame = CGRectMake(136, (45-6)/2, 140, 6);
    jyzBG.image = [UIImage imageNamed:@"jyz_bg"];
    [self addSubview:jyzBG];
    
    jyzProgress = [[UIImageView alloc]init];
//    jyzProgress.frame = CGRectMake(137, 23, 100, 4);
    jyzProgress.image = [UIImage imageNamed:@"jyz_progress"];
    [self addSubview:jyzProgress];
    
    jyzLabel = [[UILabel alloc]initWithFrame:CGRectMake(73, (45-25)/2, 63, 25)];
    jyzLabel.backgroundColor = [UIColor clearColor];
    jyzLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    jyzLabel.textAlignment = UITextAlignmentCenter;
    jyzLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    jyzLabel.text = @"323542";
    [self addSubview:jyzLabel];
    
    jyzPer = [[UILabel alloc]initWithFrame:CGRectMake(274, (45-25)/2, 320-274, 25)];
    jyzPer.backgroundColor = [UIColor clearColor];
    jyzPer.textColor = [UIColor colorWithHexString:@"#cccccc"];
    jyzPer.textAlignment = UITextAlignmentCenter;
    jyzPer.font = [UIFont boldSystemFontOfSize:13.0f];

    [self addSubview:jyzPer];
}

-(void)initData:(BLPersonData *)person{
    
    jyzLabel.text = [NSString stringWithFormat:@"%@",person.jingyanzhi];
    
    if ([person.jingyanzhi intValue] == 0) {
        jyzProgress.frame = CGRectMake(137, (45-4)/2, 0, 4);
        return;
    }else if ([person.jingyanzhiMax intValue] == 0){
        jyzProgress.frame = CGRectMake(137, (45-4)/2, 0, 4);
        return;
    }
    
    float per = [person.jingyanzhi floatValue]/[person.jingyanzhiMax floatValue];
    if (per>1.0) {
        per = 1.0;
    }
    jyzPer.text = [NSString stringWithFormat:@"%.0f%@",per*100,@"%"];
    
    float progress =  138.0/100.0;
    
    jyzProgress.frame = CGRectMake(137, (45-4)/2, progress*per*100, 4);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
