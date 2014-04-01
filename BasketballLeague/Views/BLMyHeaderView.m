//
//  BLMyHeaderView.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyHeaderView.h"
#import "UIColor+Hex.h"
#import "BLPersonData.h"
#import "UIImageView+WebCache.h"

@implementation BLMyHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    /*UIImageView *iconImage;
     UILabel *idLabel;
     UILabel *ageLabel;
     UILabel *heightLabel;
     UILabel *weightLabel;
     UILabel *detailLabel;*/
    
    iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(23, 0, 76, 90)];
    iconImage.backgroundColor = [UIColor clearColor];
    [self addSubview:iconImage];
    
    UIImageView *iconImageBG = [[UIImageView alloc]initWithFrame:CGRectMake(21, 0, 80, 90)];
    iconImageBG.backgroundColor = [UIColor clearColor];
    iconImageBG.image = [UIImage imageNamed:@"iconBG@2x"];
    [self addSubview:iconImageBG];
    
    iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    iconBtn.frame = CGRectMake(21, 0, 80, 90);
    [iconBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:iconBtn];
    
    idLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 115, 95, 18)];
    idLabel.backgroundColor = [UIColor clearColor];
    idLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    idLabel.textColor = [UIColor whiteColor];
    idLabel.text = @"ID：12312131";
    [self addSubview:idLabel];
    
    ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 115+20, 95, 20)];
    ageLabel.backgroundColor = [UIColor clearColor];
    ageLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    ageLabel.textColor = [UIColor whiteColor];
    ageLabel.text = @"年龄：51";
    [self addSubview:ageLabel];
    
    heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 115+20+20, 95, 20)];
    heightLabel.backgroundColor = [UIColor clearColor];
    heightLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    heightLabel.textColor = [UIColor whiteColor];
    heightLabel.text = @"身高：198CM";
    [self addSubview:heightLabel];
    
    weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 115+20+20+20, 95, 20)];
    weightLabel.backgroundColor = [UIColor clearColor];
    weightLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    weightLabel.textColor = [UIColor whiteColor];
    weightLabel.text = @"体重：66KG";
    [self addSubview:weightLabel];
    
    /*背景图 */
    UIImage *image = [[UIImage imageNamed:@"personLabelBG.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.frame = CGRectMake(135, 10, 171, 25);
    bgImageView.image = image;
    [self addSubview:bgImageView];
    
    UIImage *image1 = [[UIImage imageNamed:@"personProgressBG.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 50, 0, 0)];

    NSArray *titleArray = @[@"得分",@"篮板",@"助攻",@"远投",@"抢断",@"封盖"];
    for (int i=0; i<6; i++) {
        UIImageView *titleImage = [[UIImageView alloc]init];
        titleImage.frame = CGRectMake(135, 37+(i*25+i*2), 171, 25);
        titleImage.image = image1;
        [self addSubview:titleImage];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(138, 37+(i*25+i*2), 30, 25)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor colorWithHexString:@"#505051"];
        titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        titleLabel.text = [titleArray objectAtIndex:i];
        [self addSubview:titleLabel];
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(140+110, 37+(i*25+i*2), 50, 25)];
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.textColor = [UIColor whiteColor];
        countLabel.textAlignment = UITextAlignmentRight;
        countLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        countLabel.text = @"100";
        countLabel.tag = i+1;
        [self addSubview:countLabel];
        
        UIImageView *progress = [[UIImageView alloc]init];
        progress.frame = CGRectMake(180, 48+(22*i+i*5), 92, 4);
        progress.image = image;
        progress.tag = 100+i;
        [self addSubview:progress];
    }
    
    detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(135, 10, 171, 25)];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    detailLabel.text = @"     公牛队 男  后卫  23号";
    [self addSubview:detailLabel];
}

-(void)change{
    [_delegate changeIcon];
}

-(void)setDatas:(BLPersonData *)person{
    NSString *sex;
    if ([person.sex intValue] == 1) {
        sex = @"男";
    }else{
        sex = @"女";
    }
    detailLabel.text = [NSString stringWithFormat:@"     %@  %@  %@  %@号",person.teamName,sex,person.role,person.ballnumber];
    idLabel.text = [NSString stringWithFormat:@"ID：%@",person.uid];
    ageLabel.text = [NSString stringWithFormat:@"年龄：%@",person.ageS];
    heightLabel.text = [NSString stringWithFormat:@"身高：%@cm",person.heightS];
    weightLabel.text = [NSString stringWithFormat:@"体重：%@kg",person.weightS];
    
    NSString *defen = person.defen;
    NSString *lanban = person.lanban;
    NSString *zhugong = person.zhugong;
    NSString *yuantou = person.yuantou;
    NSString *qiangduan = person.qiangduan;
    NSString *fenggai = person.gaimao;
    NSArray *countsArray = @[defen,lanban,zhugong,yuantou,qiangduan,fenggai];
    
    for (int i=0; i<countsArray.count; i++) {
        
        UIImageView *imageview = (UIImageView *)[self viewWithTag:100+i];
        float widthTemp = [[countsArray objectAtIndex:i]floatValue];
        float width ;
        if (widthTemp <= 0.0) {
            width = 0;
        }else{
            width = 92/100*widthTemp;
        }
        
        imageview.frame = CGRectMake(180, 48+(22*i+i*5), width, 4);
        
        UILabel *count = (UILabel *)[self viewWithTag:i+1];
        count.text = [NSString stringWithFormat:@"%@",[countsArray objectAtIndex:i]];
    }
    
    [iconImage setImageWithURL:[NSURL URLWithString:person.icon] placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
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
