//
//  BLJinBiCell.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLJinBiCell.h"
#import "UIColor+Hex.h"
#import "BLEditingViewController.h"

@implementation BLJinBiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{

    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    view.backgroundColor = [UIColor colorWithHexString:@"#3e4149"];
    [self addSubview:view];
    if (jinbiLabel) {
        return;
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 12, 55, 25)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = @"金币";
    [self addSubview:titleLabel];
    
    jinbiLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 12, 120, 25)];
    jinbiLabel.backgroundColor = [UIColor clearColor];
    jinbiLabel.textColor = [UIColor colorWithHexString:@"#fbb03b"];
    jinbiLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    jinbiLabel.textAlignment = UITextAlignmentLeft;
    jinbiLabel.text = @"$1,400";
    [self addSubview:jinbiLabel];
    
    _jinbiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _jinbiBtn.frame = CGRectMake(235, 12, 71, 25);
    [_jinbiBtn setTitle:@"获取金币" forState:UIControlStateNormal];
    UIImage *redN = [[UIImage imageNamed:@"redButton_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIImage *redP = [[UIImage imageNamed:@"redButton_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [_jinbiBtn setBackgroundImage:redN forState:UIControlStateNormal];
    [_jinbiBtn setBackgroundImage:redP forState:UIControlStateHighlighted];
    _jinbiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [_jinbiBtn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_jinbiBtn];
}

-(void)initData:(BLPersonData *)person{
    jinbiLabel.text = [NSString stringWithFormat:@"$%@",person.coinCnt];
}

-(void)buy{
    [ShowLoading showErrorMessage:@"敬请期待！" view:self.superview.superview];
   
    /**
    BLEditingViewController *edit = [[BLEditingViewController alloc]initWithNibName:@"BLEditingViewController" bundle:nil];
    
    UIViewController *viewcontrol = (UIViewController *)self.nextResponder.nextResponder.nextResponder;
    [viewcontrol.navigationController pushViewController:edit animated:YES];
    */
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
