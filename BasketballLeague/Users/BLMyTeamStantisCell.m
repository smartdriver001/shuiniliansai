//
//  BLMyTeamStantisCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-12.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamStantisCell.h"
#import "UIColor+Hex.h"

@implementation BLMyTeamStantisCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 89, 30)];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:nameLabel];
        
        for (int i = 0; i < 6; i++) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(89 + i*38.5, 0, 38.5, 30)];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = UITextAlignmentCenter;
            label.tag = 100 + i;
            [self addSubview:label];
        }
    }
    return self;
}

-(void)setData:(BLTotalAndAvg *)totalAvg :(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        nameLabel.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
    }else{
        nameLabel.backgroundColor = [UIColor colorWithHexString:@"55585F"];
    }
    nameLabel.text = [NSString stringWithFormat:@"%@",totalAvg.name];
    
    NSArray * array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",totalAvg.defen],[NSString stringWithFormat:@"%@",totalAvg.lanban],[NSString stringWithFormat:@"%@",totalAvg.zhugong],[NSString stringWithFormat:@"%@",totalAvg.yuantou],[NSString stringWithFormat:@"%@",totalAvg.qiangduan],[NSString stringWithFormat:@"%@",totalAvg.gaimao], nil];
    for (int i = 0; i < 6; i++) {
        UILabel * label = (UILabel *)[self viewWithTag:100 + i];
        if (indexPath.row % 2 == 0) {
            label.backgroundColor = [UIColor colorWithHexString:@"36383F"];
        }else{
            label.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
        }
        label.text = [array objectAtIndex:i];
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
