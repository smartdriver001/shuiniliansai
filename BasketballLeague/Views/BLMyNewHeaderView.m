//
//  BLMyNewHeaderView.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-15.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyNewHeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Hex.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "UIImageView+WebCache.h"

@implementation BLMyNewHeaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    
    UIImageView *iconBG = [[UIImageView alloc]initWithFrame:CGRectMake(12, 9, 120, 120)];
    iconBG.image = [UIImage imageNamed:@"icon_no"];
    iconBG.tag = 100;
    [self addSubview:iconBG];
    
    _loadPersonIcon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 90, 90)];
//    loadPersonIcon.image = [UIImage imageNamed:@"myicon"];
    _loadPersonIcon.layer.cornerRadius = 45;
    _loadPersonIcon.layer.masksToBounds = YES;
//    loadPersonIcon.layer.borderWidth = 2;
//    loadPersonIcon.layer.borderColor = [[UIColor redColor]CGColor];
    [iconBG addSubview:_loadPersonIcon];
    
    UIImageView *nengliBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 140, 320, 61)];
    nengliBg.image = [UIImage imageNamed:@"nengliBg"];
    [self addSubview:nengliBg];
    
    _takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _takePhotoBtn.frame = CGRectMake(100, 90, 30, 30);
    [_takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"takePhoto_normal"] forState:UIControlStateNormal];
    [_takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"takePhoto_press"] forState:UIControlStateHighlighted];
    [_takePhotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    _takePhotoBtn.hidden = YES;
//    [self addSubview:_takePhotoBtn];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 20-10, 170, 32)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:17.0f];
//    nameLabel.text = @"韩一平";
    [self addSubview:nameLabel];
    
    _idLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 30, 150, 32)];
    _idLabel.backgroundColor = [UIColor clearColor];
    _idLabel.textColor = [UIColor whiteColor];
    _idLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _idLabel.text = @"ID：88888888";
    [self addSubview:_idLabel];
    
    descLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 25+40-17, 170, 32)];
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    descLabel.text = @"热火队   3号   前锋";
    [self addSubview:descLabel];
    
    bodyLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 25+60-17, 170, 32)];
    bodyLabel.backgroundColor = [UIColor clearColor];
    bodyLabel.textColor = [UIColor whiteColor];
    bodyLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    bodyLabel.text = @"男 30岁 113kg/20.3m";
    [self addSubview:bodyLabel];
    
    schoolLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 25+60+2, 170, 32)];
    schoolLabel.backgroundColor = [UIColor clearColor];
    schoolLabel.textColor = [UIColor whiteColor];
    schoolLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    schoolLabel.text = @"清华大学";
    [self addSubview:schoolLabel];
    
    collegeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 25+60+20, 170, 32)];
    collegeLabel.backgroundColor = [UIColor clearColor];
    collegeLabel.textColor = [UIColor whiteColor];
    collegeLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    collegeLabel.text = @"计算机系";
    [self addSubview:collegeLabel];
    
    UIImageView *bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 220, 320, 10)];
    bottomView.image = [UIImage imageNamed:@"fenlanBG"];
    [self addSubview:bottomView];
    
    NSArray *tipsTitle = @[@"得分",@"栏板",@"助攻",@"远投",@"抢断",@"盖帽"];
    
    for (int i=0; i<6; i++) {
        
        UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(4+i*50+i*2.5, 140+55, 50, 25)];
        tipsLabel.backgroundColor = [UIColor clearColor];
        tipsLabel.text = [tipsTitle objectAtIndex:i];
        tipsLabel.textAlignment = UITextAlignmentCenter;
        tipsLabel.font = [UIFont systemFontOfSize:15.0f];
        tipsLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:tipsLabel];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(4+i*50+i*2.2, 140+5, 50, 50)];
        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 27, 25, 2)];
        lineImageView.image = [UIImage imageNamed:@"line"];
        [imageview addSubview:lineImageView];
        imageview.image = [UIImage imageNamed:@"singleBG"];
        [self addSubview:imageview];
        
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(4+i*50+i*2.2, 140+12, 50, 25)];
        valueLabel.backgroundColor = [UIColor clearColor];
//        valueLabel.text = @"25";
        valueLabel.tag = 100111+i;
        valueLabel.textAlignment = UITextAlignmentCenter;
        valueLabel.font = [UIFont systemFontOfSize:13.0f];
        valueLabel.textColor = [UIColor whiteColor];
        [self addSubview:valueLabel];
        
        UILabel *fenmuLabel = [[UILabel alloc]initWithFrame:CGRectMake(4+i*50+i*2.2, 140+27, 50, 25)];
        fenmuLabel.backgroundColor = [UIColor clearColor];
//        fenmuLabel.text = @"100";
        fenmuLabel.tag = 1000+i;
        fenmuLabel.textAlignment = UITextAlignmentCenter;
        fenmuLabel.font = [UIFont systemFontOfSize:11.0f];
        fenmuLabel.textColor = [UIColor whiteColor];
        [self addSubview:fenmuLabel];

        MDRadialProgressView *radialView2 = [[MDRadialProgressView alloc]initWithFrame:CGRectMake(4+i*50+i*2.2, 140+5+4, 46, 46)];
//        radialView2.progressTotal = 100;
//        radialView2.progressCounter = 25;
        radialView2.theme.thickness = 12;
        radialView2.theme.incompletedColor = [UIColor clearColor];
        if (i == 0) {
            radialView2.theme.completedColor = [UIColor orangeColor];
        }else if (i == 1){
            radialView2.theme.completedColor = [UIColor colorWithHexString:@"#0276e9"];
        }else if (i == 2){
            radialView2.theme.completedColor = [UIColor colorWithHexString:@"#00a99d"];
        }else if (i == 3){
            radialView2.theme.completedColor = [UIColor colorWithHexString:@"#bae82c"];
        }else if (i == 4){
            radialView2.theme.completedColor = [UIColor colorWithHexString:@"#e8276a"];
        }else if (i == 5){
            radialView2.theme.completedColor = [UIColor colorWithHexString:@"#da30e9"];
        }
        radialView2.theme.sliceDividerHidden = YES;
        radialView2.label.hidden = YES;
        radialView2.tag = 10+i;
        [self addSubview:radialView2];
    }
    
}

-(void)takePhoto{
    [_delegate changeIcon];
}

-(void)setDatas:(BLPersonData *)person{
    
    NSString *defen = person.defen;
    NSString *lanban = person.lanban;
    NSString *zhugong = person.zhugong;
    NSString *yuantou = person.yuantou;
    NSString *qiangduan = person.qiangduan;
    NSString *fenggai = person.gaimao;
    NSArray *countsArray = @[defen,lanban,zhugong,yuantou,qiangduan,fenggai];
    
    for (int i=0; i<countsArray.count; i++) {
        //分母
        UILabel *fenmuVale =  (UILabel *)[self viewWithTag:1000+i];
//        fenmuVale.text = [NSString stringWithFormat:@"%@",person.fenmu];
        
        //分子
        UILabel *fenziLabel = (UILabel *)[self viewWithTag:100111+i];
        fenziLabel.text = [NSString stringWithFormat:@"%@",[countsArray objectAtIndex:i]];
        
        MDRadialProgressView *radialView = (MDRadialProgressView *)[self viewWithTag:10+i];
        radialView.progressTotal = [person.fenmu intValue];
        radialView.progressCounter = [person.fenmu intValue]/4;//[[countsArray objectAtIndex:i]intValue];
    }
    
//    _idLabel.text = [NSString stringWithFormat:@"ID：%@",person.uid];
    descLabel.text = [NSString stringWithFormat:@"%@  %@号  %@",person.teamName,person.ballnumber,person.role];
    nameLabel.text = person.name;
    //@"男 30岁 113kg/20.3m";
    NSString *sex;
    if ([person.sex intValue] == 1) {
        sex = @"男";
    }else{
        sex = @"女";
    }
    bodyLabel.text = [NSString stringWithFormat:@"%@ %@岁 %@kg/%.0fcm",sex,person.ageS,person.weightS,[person.heightS floatValue]*100];
    
    [_loadPersonIcon setImageWithURL:[NSURL URLWithString:person.icon] placeholderImage:[UIImage imageNamed:@"myicon"]];
    
    schoolLabel.text = [NSString stringWithFormat:@"%@",person.school];
    collegeLabel.text = [NSString stringWithFormat:@"%@",person.college];
    
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
