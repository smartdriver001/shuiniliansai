//
//  BLMessageCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-6.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMessageCell.h"
#import "BLMessage.h"
#import "UIButton+Bootstrap.h"

@implementation BLMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    
    bgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    bgView.image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.contentView addSubview:bgView];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 15, 280, 25)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.text = @"数字证书基于公钥-私钥加密方法";
    [self.contentView addSubview:titleLabel];
    
    detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:detailLabel];
    
    joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    joinButton.frame = CGRectMake(245, 35, 60, 30);
    [joinButton setTitle:@"同意" forState:UIControlStateNormal];
    [joinButton dangerStyle];
    [joinButton addTarget:self action:@selector(joinAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:joinButton];

}

-(void)joinAction{
//    NSString *index = [NSString stringWithFormat:@"",button.tag];
    [self.delegate joinTeam:myIndex];
//    [self.delegate joinTeam:message.teamId uid:message.joinerId];
}

-(void)initData:(BLMessage *)myMessage index:(int)index{
    myIndex = index;
    message = myMessage;
    
    /*系统消息:1    申请入队消息:2    入队消息:3    比赛报名消息:4    升级消息:5*/
    if ([myMessage.type intValue] == 2 && [myMessage.isreaded intValue] == 1) {
        joinButton.hidden = YES;
    }else if([myMessage.type intValue] == 2 && [myMessage.isreaded intValue] == 0){
        joinButton.hidden = NO;
    }else{
        joinButton.hidden = YES;
    }
    
    CGFloat contentWidth = 320-36;
    UIFont *font = [UIFont systemFontOfSize:14.0f];
//    NSMutableString *str;
    NSString *detail = myMessage.message;
    CGSize size = [detail sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 2000) lineBreakMode:NSLineBreakByWordWrapping];
    
    detailLabel.frame = CGRectMake(18, 30, contentWidth, size.height + 26);
    detailLabel.numberOfLines = 0;
    detailLabel.text = detail;
    detailLabel.font = font;
    titleLabel.text = myMessage.title;
    
    bgView.frame = CGRectMake(10, 10, 300, size.height + 45);;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
