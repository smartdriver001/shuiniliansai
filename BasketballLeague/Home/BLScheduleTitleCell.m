//
//  BLScheduleTitleCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-26.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLScheduleTitleCell.h"

@implementation BLScheduleTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(20, 9, 280, 20);
}

@end
