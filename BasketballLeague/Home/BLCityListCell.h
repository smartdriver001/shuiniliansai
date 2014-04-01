//
//  BLCityListCell.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCityListCell : UITableViewCell
{
    UILabel * CityLabel;
    UILabel * CityLabel1;
    UIImageView * BackImageView;
}

-(void)setData:(NSString *)cityName detail:(NSString *)str backImg:(NSString *)imageName;

@end
