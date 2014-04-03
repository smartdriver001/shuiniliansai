//
//  BLSingleHonorViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-12.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLSingleHonorViewController.h"
#import "BLHonor.h"
#import "UIButton+Bootstrap.h"
#import "IBActionSheet.h"
#import "UIColor+Hex.h"

@interface BLSingleHonorViewController ()<IBActionSheetDelegate>{
    IBActionSheet *shareAction;
}

@end

@implementation BLSingleHonorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iPhone5) {
        self.view.frame = CGRectMake(0, 0, 300, 568-88);
    }else{
        self.view.frame =CGRectMake(0, 0, 300, 480-88);
    }
    
    [self initViews];
//    [self initDetailViews];
    [self performSelector:@selector(initDetailViews) withObject:nil afterDelay:0.1];
}

-(void)initDetailViews{
    int y =0;
    if (!iPhone5) {
        y = 25;
    }
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(18, 350-y, 125, 44);
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn commitStyle];
    [self.view addSubview:commitBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(18+125+13, 350-y, 125, 44);
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn commitStyle];
    [self.view addSubview:shareBtn];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 240, 32)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    mySwipeView = [[SwipeView alloc]initWithFrame:CGRectMake((300-114)/2, 66, 114, 160)];
    mySwipeView.backgroundColor = [UIColor clearColor];
    mySwipeView.delegate = self;
    mySwipeView.dataSource = self;
    mySwipeView.pagingEnabled = YES;
    mySwipeView.currentItemIndex = 0;
    mySwipeView.scrollEnabled = NO;
    currentIndex = 0;
    [self.view addSubview:mySwipeView];
    [mySwipeView reloadData];
    
    detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 240, 250, 70)];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.font = [UIFont systemFontOfSize:13.0f];
    detailLabel.numberOfLines = 0;
    [self.view addSubview:detailLabel];
    
    curentLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 220, 240, 25)];
    curentLabel.backgroundColor = [UIColor clearColor];
    curentLabel.textColor = [UIColor grayColor];
    curentLabel.textAlignment = UITextAlignmentCenter;
    curentLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.view addSubview:curentLabel];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(20, 116, 40, 40);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"leftbtn"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(scollToLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(240, 116, 40, 40);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"rightbtn"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(scollToRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
}

-(void)scollToRight{
    if (currentIndex>=_honors.count) {
        return;
    }
    [mySwipeView scrollToItemAtIndex:currentIndex+1 duration:0.2];
}

-(void)scollToLeft{
    if (currentIndex == 0) {
        return;
    }
    [mySwipeView scrollToItemAtIndex:currentIndex-1 duration:0.2];
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [_honors count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageview = nil;
    
    if (view == nil)
    {
        
        view = [[UIView alloc] initWithFrame:mySwipeView.bounds];
        imageview = [[UIImageView alloc] initWithFrame:mySwipeView.bounds];
        imageview.tag = 1;
        [view addSubview:imageview];
    }
    else
    {
        imageview = (UIImageView *)[view viewWithTag:1];
    }
    /*1:得分王、2:篮板王、3:助攻王、
     4:盖帽王、5:抢断王、6:远投王*/
    BLHonor *honor = [_honors objectAtIndex:index];
    titleLabel.text = honor.honourname;
    curentLabel.text = [NSString stringWithFormat:@"%d/%d",index+1,_honors.count];

    NSString *name =[honor.honourname substringToIndex:2];
    detailLabel.text =[NSString stringWithFormat:@"由于你在%@ \"%@ VS %@\"\n的比赛中得到了%@个%@，力压群雄，恭喜你荣获\"%@\"的称号！",honor.mdate,honor.teamA,honor.teamB,honor.result,name,honor.honourname];
    NSString *imageName;
    if ([honor.honourname isEqualToString:@"得分王"]) {
        imageName = @"defenwang";
    }else if ([honor.honourname isEqualToString:@"篮板王"]){
        imageName = @"lanbanwang";
    }else if ([honor.honourname isEqualToString:@"助攻王"]){
        imageName = @"zhugongwang";
    }else if ([honor.honourname isEqualToString:@"盖帽王"]){
        imageName = @"gaimaowang";
    }else if ([honor.honourname isEqualToString:@"抢断王"]){
        imageName = @"qiangduanwang";
    }else{
        imageName = @"yuantouwang";
    }
    
    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];

    return view;
}

-(void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView{
    currentIndex = swipeView.currentItemIndex;
    detailLabel.text = [NSString stringWithFormat:@"%d/%d",swipeView.currentItemIndex+1,_honors.count];
    BLHonor *honor = [_honors objectAtIndex:swipeView.currentItemIndex];
    titleLabel.text = honor.honourname;
    NSString *name =[honor.honourname substringToIndex:2];
    detailLabel.text =[NSString stringWithFormat:@"由于你在%@ \"%@ VS %@\"\n的比赛中得到了%@个%@，力压群雄，恭喜你荣获\"%@\"的称号！",honor.mdate,honor.teamA,honor.teamB,honor.result,name,honor.honourname];
}

-(void)initViews{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 15, 300-16, self.view.frame.size.height-30)];
    imageView.image = [UIImage imageNamed:@"backgroundDarkGray"];
    [self.view addSubview:imageView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(300-30, 0, 30, 30);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"close_normal"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"close_press"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
}


-(void)showShareAction{
    
    shareAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesArray:@[@"分享到朋友圈",@"分享给好友"]];
    [shareAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#55585f"]];
    [shareAction setButtonTextColor:[UIColor whiteColor]];
    [shareAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#ac3726"] forButtonAtIndex:2];
    
    [shareAction showInView:self.view.superview];
    
}

-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex >= 2) {
        return;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImageJPEGRepresentation(tempImage, 0.3);//(image, 0.5);//(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    
    if (buttonIndex == 0) {
        //朋友圈
        req.scene = WXSceneTimeline;
    }else{
        //好友
        req.scene = WXSceneSession;
    }
    [WXApi sendReq:req];

    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
}

-(void)share:(UIButton *)button{
    
    tempImage = [self screenshot];
    [self showShareAction];
    
}

- (UIImage*)screenshot
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    imageSize.height = imageSize.height-20;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            //            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextTranslateCTM(context, [window center].x, [window center].y - 20);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


-(void)dismiss{
    [_delegate dismisModelViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
