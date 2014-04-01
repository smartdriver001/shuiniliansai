//
//  BLMyTeamDitCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamDitCell.h"
#import "UIColor+Hex.h"
#import "BLData.h"
#import "BLMy_teamMembers.h"

@implementation BLMyTeamDitCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 1, 290, 44)];
        view.backgroundColor = [UIColor colorWithHexString:@"27292E"];
        view.layer.cornerRadius = 3;
        [self addSubview:view];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 1, 90, 44)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self addSubview:titleLabel];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(105, 1, 165, 44)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor = [UIColor colorWithHexString:@"909092"];
        [self addSubview:label];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 - 32 - 15, 12, 20, 20)];
        imageView.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:imageView];
    }
    return self;
}

-(void)setData:(NSArray *)ditCellArray :(NSIndexPath *)indexPath
{
    NSArray * array = [NSArray arrayWithObjects:@"球队名称",@"球队口号",@"我的角色", nil];
    if (ditCellArray.count > 0) {
        titleLabel.text = [array objectAtIndex:indexPath.row];
        BLData * data = [ditCellArray objectAtIndex:0];
        BLMy_teamMembers * member = [ditCellArray objectAtIndex:1];
        if (indexPath.row == 0) {
            label.text = data.teamname;
        }else if (indexPath.row == 1){
            label.text = data.slogan;
        }else if (indexPath.row == 2){
            label.text = member.role;
        }
    }else{
        titleLabel.text = [array objectAtIndex:indexPath.row];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
