//
//  BLCommentCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLCommentCell.h"
#import "UIImageView+WebCache.h"

@implementation BLCommentCell

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 50)];
    UIImage *image1 = [[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 10)];
    imageview.image = image1;
    [self addSubview:imageview];
    
    iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(10+5, 15, 40, 40)];
    [self addSubview:iconImage];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+50, 22, 200, 25)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:17.0f];
//    nameLabel.text = @"乔丹";
    [self addSubview:nameLabel];
    
    guanzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guanzhuBtn.frame = CGRectMake(230, 22, 70, 25);
    guanzhuBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [guanzhuBtn setTitle:@"关注" forState:UIControlStateNormal];
    [guanzhuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    [guanzhuBtn addTarget:self action:@selector(guanzhu:) forControlEvents:UIControlEventTouchUpInside];
//    personLabelBG@2x
    imageN = [[UIImage imageNamed:@"personLabelBG.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    imageS = [[UIImage imageNamed:@"guanzhu_press@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    [guanzhuBtn setBackgroundImage:imageN forState:UIControlStateNormal];
    [self addSubview:guanzhuBtn];
    
    guanzhuIcon = [[UIImageView alloc]initWithFrame:CGRectMake(235, 15+9, 20, 20)];
    guanzhuIcon.image = [UIImage imageNamed:@"guanzhuIcon"];
    [self addSubview:guanzhuIcon];
}

-(void)guanzhu:(UIButton *)button{
    
    if (guanzhuBtn.selected) {
        guanzhuBtn.selected = NO;
        [guanzhuBtn setTitle:@"关注" forState:UIControlStateNormal];
        [guanzhuBtn setBackgroundImage:imageN forState:UIControlStateSelected];
        [guanzhuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        guanzhuIcon.hidden = NO;
        [self.delegate didfocus:myFollowers index:myRow add:NO];
    }else{
        
        [guanzhuBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [guanzhuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [guanzhuBtn setBackgroundImage:imageS forState:UIControlStateSelected];
//        guanzhuIcon.hidden = YES;
        guanzhuIcon.image = [UIImage imageNamed:@"ygzBtn"];

        guanzhuBtn.selected = YES;
        
        [self.delegate didfocus:myFollowers index:myRow add:YES];
    }
}

-(void)initPlayer:(BLTeamListLists *)player{
    nameLabel.text = player.realname ;
    [iconImage setImageWithURL:[NSURL URLWithString:player.icon] placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    guanzhuBtn.hidden = YES;
    guanzhuIcon.hidden = YES;
    
}

-(void)initData:(BLFollowers *)followers index:(int)row{
    myRow = row;
    myFollowers = followers;
    nameLabel.text = followers.name ;
    [iconImage setImageWithURL:[NSURL URLWithString:followers.icon] placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    int i = [followers.relationship intValue];
    if (i == 0) {
        guanzhuBtn.selected = NO;
        [guanzhuBtn setTitle:@"添加" forState:UIControlStateNormal];
        [guanzhuBtn setBackgroundImage:imageN forState:UIControlStateSelected];
        [guanzhuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        guanzhuIcon.image = [UIImage imageNamed:@"addgz"];
        
    }else if(i == 1){
        [guanzhuBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [guanzhuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [guanzhuBtn setBackgroundImage:imageS forState:UIControlStateSelected];
//        guanzhuIcon.hidden = YES;
        guanzhuIcon.image = [UIImage imageNamed:@"ygzBtn"];
        guanzhuBtn.selected = YES;
    }else if(i == 2){
        [guanzhuBtn setTitle:@"互粉" forState:UIControlStateNormal];
        [guanzhuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [guanzhuBtn setBackgroundImage:imageS forState:UIControlStateSelected];
        //        guanzhuIcon.hidden = YES;
        guanzhuIcon.image = [UIImage imageNamed:@"xhgzBtn"];
        guanzhuBtn.selected = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
