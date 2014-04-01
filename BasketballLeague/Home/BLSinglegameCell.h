//
//  BLSinglegameCell.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-2-28.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLSingleUser.h"

@interface BLSinglegameCell : UITableViewCell {
    NSString *uid;
}

-(void)setData:(BLSingleUser *)user :(NSIndexPath *)indexPath;

@end
