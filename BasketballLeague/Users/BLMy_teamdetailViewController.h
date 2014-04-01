//
//  BLMy_teamdetailViewController.h
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBaseViewController.h"
#import "ASIFormDataRequest.h"
#import "BLData.h"

@interface BLMy_teamdetailViewController : BLBaseViewController{
    NSArray *photosArray;
    NSString *filePath;
    int currentIndex;
    BLData *myData;
    BOOL showAddDel;//隐藏除了自己和战队相册的添加和删除按钮
    NSString *titleName;
}

-(void)requestMy_teamdetail:(NSString *)uid;
-(void)requestMy_teamdetail:(NSString *)uid from:(NSString *)from;

@property (retain, nonatomic) ASIFormDataRequest *request;

@end
