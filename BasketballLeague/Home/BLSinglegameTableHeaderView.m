//
//  BLSinglegameTableHeaderView.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-1.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSinglegameTableHeaderView.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Hex.h"

@implementation BLSinglegameTableHeaderView

- (id)initWithFrame:(CGRect)frame :(BLData *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        iconAImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, 50, 50)];
        [iconAImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.iconA]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self addSubview:iconAImageView];
        
        iconBImageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 30 - 50, 10, 50, 50)];
        [iconBImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.iconB]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self addSubview:iconBImageView];
        
        nameALabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 65, 70, 25)];
        nameALabel.text = [NSString stringWithFormat:@"%@",data.teamNameA];
        nameALabel.textAlignment = UITextAlignmentCenter;
        nameALabel.backgroundColor = [UIColor clearColor];
        nameALabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        nameALabel.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:nameALabel];
        
        nameBLabel = [[UILabel alloc]initWithFrame:CGRectMake(320 - 20 - 70, 65, 70, 25)];
        nameBLabel.text = [NSString stringWithFormat:@"%@",data.teamNameB];
        nameBLabel.textAlignment = UITextAlignmentCenter;
        nameBLabel.backgroundColor = [UIColor clearColor];
        nameBLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        nameBLabel.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:nameBLabel];
        
        scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 160, 50)];
        scoreLabel.text = [NSString stringWithFormat:@"%@ : %@",data.scoreA,data.scoreB];
        scoreLabel.textAlignment = UITextAlignmentCenter;
        scoreLabel.font = [UIFont systemFontOfSize:28];
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.textColor = [UIColor colorWithHexString:@"FF0000"];
        [self addSubview:scoreLabel];
        
        scoreLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 65, 140, 25)];
        scoreLabel1.text = [NSString stringWithFormat:@"%@",data.time];
        scoreLabel1.textAlignment = UITextAlignmentCenter;
        scoreLabel1.font = [UIFont boldSystemFontOfSize:13];
        scoreLabel1.backgroundColor = [UIColor clearColor];
        scoreLabel1.textColor = [UIColor colorWithHexString:@"FBB03B"];
        [self addSubview:scoreLabel1];
        
//        NSArray * teamArray = [NSArray arrayWithObjects:@"",[NSString stringWithFormat:@"%@",data.teamNameA],[NSString stringWithFormat:@"%@",data.teamNameB], nil];
//        for (int i = 0; i < 3; i++) {
//            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 95 + i * 30, 80, 30)];
//            label.text = [teamArray objectAtIndex:i];
//            label.textColor = [UIColor colorWithHexString:@"FFFFFF"];
//            label.font = [UIFont systemFontOfSize:14];
//            label.textAlignment = UITextAlignmentCenter;
//            [self addSubview:label];
//            if (i == 1) {
//                label.backgroundColor = [UIColor colorWithHexString:@"55585F"];
//            }else{
//                label.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
//            }
//        }
//        
//        NSArray * titleArray = [NSArray arrayWithObjects:@"一",@"二",@"三",@"四", nil];
//        for (int j = 0; j < 3; j++) {
//            for (int i = 0; i < 4; i++) {
//                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(80 + i * 44, 95 + j*30, 44, 30)];
//                if (j == 0) {
//                    label.text = [titleArray objectAtIndex:i];
//                }
//                label.textColor = [UIColor colorWithHexString:@"FBB03B"];
//                label.font = [UIFont systemFontOfSize:14];
//                label.textAlignment = UITextAlignmentCenter;
//                [self addSubview:label];
//                if (j == 1) {
//                    label.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
//                }else{
//                    label.backgroundColor = [UIColor colorWithHexString:@"36383F"];
//                }
//            }
//        }
//        
//        NSArray * scoreArray = [NSArray arrayWithObjects:@"总分",[NSString stringWithFormat:@"%@",data.scoreA],[NSString stringWithFormat:@"%@",data.scoreB], nil];
//        for (int i = 0; i < 3; i++) {
//            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(320-68, 95 + i*30, 68, 30)];
//            label.text = [scoreArray objectAtIndex:i];
//            label.textColor = [UIColor colorWithHexString:@"FF0000"];
//            label.font = [UIFont systemFontOfSize:14];
//            label.textAlignment = UITextAlignmentCenter;
//            [self addSubview:label];
//            
//            if (i == 1) {
//                label.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
//            }else{
//                label.backgroundColor = [UIColor colorWithHexString:@"36383F"];
//            }
//        }
        
    }
    return self;
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
