//
//  BLMyCrewCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyCrewCell.h"
#import "BLMy_teamdetailViewController.h"
#import "BLNoTeamDetailViewController.h"

@implementation BLMyCrewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIImageView *myCrewiconImage = [[UIImageView alloc]initWithFrame:CGRectMake(16, 5, 60, 63)];
    myCrewiconImage.image = image;
    [self addSubview:myCrewiconImage];
    
    myCrewLogo = [[UIImageView alloc]initWithFrame:CGRectMake(20, 9, 52, 55)];
    myCrewLogo.image = [UIImage imageNamed:@"placeholder@2x"];
    [self addSubview:myCrewLogo];
    
    UIButton *myCrewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCrewButton.frame = CGRectMake(79, 5, 232, 63);
    [myCrewButton setBackgroundImage:image forState:UIControlStateNormal];
    [myCrewButton addTarget:self action:@selector(gotoMyCrew) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:myCrewButton];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(8, 4, 100, 25)];
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor whiteColor];
    label1.text= @"我的战队";
    label1.font = [UIFont boldSystemFontOfSize:14.0f];
    [myCrewButton addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(40, 27, 200, 25)];
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor whiteColor];
    label2.text= @"CL SMOOTH CREW";
    label2.font = [UIFont boldSystemFontOfSize:16.0f];
    [myCrewButton addSubview:label2];
    
}

-(void)initData:(BLPersonData *)person :(NSString *)perUID{
    personUID = perUID;
    personData = person;
}

-(void)gotoMyCrew{
    
    if (personData.teamid == NULL || [personData.teamid isEqual:@""]) {
        BLNoTeamDetailViewController * noteamView = [[BLNoTeamDetailViewController alloc]init];
        UIViewController *vc = [BLUtils viewControlle:self];
        [vc.navigationController pushViewController:noteamView animated:YES];
        [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
    }else{
        BLMy_teamdetailViewController * teamsView = [[BLMy_teamdetailViewController alloc]init];
        [teamsView requestMy_teamdetail:personUID];
        UIViewController *vc = [BLUtils viewControlle:self];
        [vc.navigationController pushViewController:teamsView animated:YES];
        [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
