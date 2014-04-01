//
//  BLMyButonsCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyButonsCell.h"
#import "BLFollowersViewController.h"
#import "BLMyGameViewController.h"
#import "BLMyPhotoViewController.h"

@implementation BLMyButonsCell

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
    
    UIButton *bisaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bisaiButton.frame = CGRectMake(26, 8, 131, 30);
    [bisaiButton setTitle:@"比赛" forState:UIControlStateNormal];
    bisaiButton.titleLabel.textColor = [UIColor whiteColor];
    bisaiButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [bisaiButton setBackgroundImage:image forState:UIControlStateNormal];
    bisaiButton.tag = 98;
    [bisaiButton addTarget:self action:@selector(gotoViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bisaiButton];
    
    UIButton *xiangceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xiangceBtn.frame = CGRectMake(26+131+14, 8, 131, 30);
    [xiangceBtn setTitle:@"相册" forState:UIControlStateNormal];
    [xiangceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    xiangceBtn.titleLabel.textColor = [UIColor whiteColor];
    xiangceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [xiangceBtn setBackgroundImage:image forState:UIControlStateNormal];
    xiangceBtn.tag = 99;
    [xiangceBtn addTarget:self action:@selector(gotoViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:xiangceBtn];
    
    UIButton *guanzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guanzhuBtn.frame = CGRectMake(26, 8+42, 131, 30);
    [guanzhuBtn setTitle:@"关注" forState:UIControlStateNormal];
    [guanzhuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    guanzhuBtn.titleLabel.textColor = [UIColor whiteColor];
    guanzhuBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [guanzhuBtn setBackgroundImage:image forState:UIControlStateNormal];
    guanzhuBtn.tag = 100;
    [guanzhuBtn addTarget:self action:@selector(gotoViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:guanzhuBtn];
    
    UIButton *fensiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fensiBtn.frame = CGRectMake(26+131+14, 8+42, 131, 30);
    [fensiBtn setTitle:@"粉丝" forState:UIControlStateNormal];
    [fensiBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    fensiBtn.titleLabel.textColor = [UIColor whiteColor];
    fensiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [fensiBtn setBackgroundImage:image forState:UIControlStateNormal];
    fensiBtn.tag = 101;
    [fensiBtn addTarget:self action:@selector(gotoViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:fensiBtn];
    
    xiangceLabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 4, 65, 25)];
    xiangceLabel.backgroundColor = [UIColor clearColor];
    xiangceLabel.textColor = [UIColor grayColor];
    xiangceLabel.font = [UIFont boldSystemFontOfSize:13.0f];
//    xiangceLabel.text = @"22个";
    [xiangceBtn addSubview:xiangceLabel];
    
    fensiLabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 4, 65, 25)];
    fensiLabel.backgroundColor = [UIColor clearColor];
    fensiLabel.textColor = [UIColor grayColor];
    fensiLabel.font = [UIFont boldSystemFontOfSize:13.0f];
//    fensiLabel.text = @"122个";
    [fensiBtn addSubview:fensiLabel];
    
    guanzhuLabe = [[UILabel alloc]initWithFrame:CGRectMake(67, 4, 65, 25)];
    guanzhuLabe.backgroundColor = [UIColor clearColor];
    guanzhuLabe.textColor = [UIColor grayColor];
    guanzhuLabe.font = [UIFont boldSystemFontOfSize:13.0f];
//    guanzhuLabe.text = @"152个";
    [guanzhuBtn addSubview:guanzhuLabe];
    
}

-(void)gotoViewController:(UIButton *)button{
    
    [_delegate didclick:button];
//    UIViewController *vc = [BLUtils viewControlle:self];
//    
//    if (button.tag == 99) {
//        //相册
//        BLMyPhotoViewController *photo = [[BLMyPhotoViewController alloc]initWithNibName:nil bundle:nil];
////        photo.title = @"我的相册";
//        [vc.navigationController pushViewController:photo animated:YES];
//    }else if (button.tag == 100){
//        //关注
//       BLFollowersViewController *follower = [[BLFollowersViewController alloc]initWithNibName:nil bundle:nil];
//        follower.title = @"我的关注";
//        follower.funsORfollowers = @"followers";
////        follower.followers = personData.guanzhuArray;
//        [vc.navigationController pushViewController:follower animated:YES];
//        
//    }else if (button.tag == 101){
//        //粉丝
//        BLFollowersViewController *funs = [[BLFollowersViewController alloc]initWithNibName:nil bundle:nil];
//        funs.funsORfollowers = @"funs";
//        funs.title = @"我的粉丝";
//        //        follower.followers = personData.guanzhuArray;
//        [vc.navigationController pushViewController:funs animated:YES];
//    }else if (button.tag == 98){
//        //比赛
//        BLMyGameViewController * scheduleView = [[BLMyGameViewController alloc]init];
//        scheduleView.title = @"我的比赛";
//        [vc.navigationController pushViewController:scheduleView animated:YES];
//    }
//    
//    [[BLUtils appDelegate].tabBarController setTabBarHidden:YES animated:YES];
    
    
}

-(void)initData:(BLPersonData *)person{
    personData = person;
    fensiLabel.text = [NSString stringWithFormat:@"%d个",person.funsArray.count];
    guanzhuLabe.text = [NSString stringWithFormat:@"%d个",person.guanzhuArray.count];
    xiangceLabel.text = [NSString stringWithFormat:@"%@个",person.albumCnt];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
