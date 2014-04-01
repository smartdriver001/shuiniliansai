//
//  BLSinglegameCell.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-28.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSinglegameCell.h"
#import "UIColor+Hex.h"

@implementation BLSinglegameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        for (int i = 0; i < 7; i++) {
            UILabel * label = [[UILabel alloc]init];
            if (i == 0) {
                label.frame = CGRectMake(0, 0, 80, 30);
            }else{
                label.frame = CGRectMake(40 + i * 40, 0, 40, 30);
            }
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = UITextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithHexString:@"FFFFFF"];
            label.tag = 100 + i;
            [self addSubview:label];
        }
        
        uid = [[BLUtils globalCache]stringForKey:@"uid"];
        
    }
    return self;
}

-(void)setData:(BLSingleUser *)user :(NSIndexPath *)indexPath
{
//    if (i == 1) {
//        label.backgroundColor = [UIColor colorWithHexString:@"55585F"];
//    }else{
//        label.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
//    }
//    if (i == 1) {
//        label.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
//    }else{
//        label.backgroundColor = [UIColor colorWithHexString:@"36383F"];
//    }
    NSArray * array = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",user.username],[NSString stringWithFormat:@"%@",user.defen],[NSString stringWithFormat:@"%@",user.lanban],[NSString stringWithFormat:@"%@",user.zhugong],[NSString stringWithFormat:@"%@",user.yuantou],[NSString stringWithFormat:@"%@",user.qiangduan],[NSString stringWithFormat:@"%@",user.gaimao], nil];
    for (int i = 0; i < 7; i++) {
        UILabel * label = (UILabel *)[self viewWithTag:100 + i];
        label.text = [array objectAtIndex:i];
        
        if ([uid isEqualToString:user.uid]) {
            label.backgroundColor = [UIColor colorWithHexString:@"#736357"];
        }else{
            if (indexPath.row%2 == 1) {
                if (i == 0) {
                    label.backgroundColor = [UIColor colorWithHexString:@"55585F"];
                }else{
                    label.backgroundColor = [UIColor colorWithHexString:@"3C3E45"];
                }
            }else{
                if (i == 0) {
                    label.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
                }else{
                    label.backgroundColor = [UIColor colorWithHexString:@"36383F"];
                }
            }

        }
        
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
