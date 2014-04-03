//
//  BLShareWXViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLShareWXViewController.h"

@interface BLShareWXViewController ()

@end

@implementation BLShareWXViewController

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
}

-(void)initViews{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 15, 300-16, self.view.frame.size.height-30)];
    imageView.image = [UIImage imageNamed:@"shareBg"];
    [self.view addSubview:imageView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(300-30, 0, 30, 30);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"close_normal"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"close_press"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(28, self.view.frame.size.height-115, 300-(28*2), 44);
    [shareBtn setBackgroundImage:[[UIImage imageNamed:@"shareBtn_normal"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:[[UIImage imageNamed:@"shareBtn_press"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [shareBtn setTitle:@"分享到朋友圈" forState:UIControlStateNormal];
    [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
     shareBtn.tag = 100;
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    UIButton *friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friendBtn.frame = CGRectMake(28, self.view.frame.size.height-65, 300-(28*2), 44);
    [friendBtn setBackgroundImage:[[UIImage imageNamed:@"shareBtn_normal"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [friendBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
//    [friendBtn setBackgroundImage:[[UIImage imageNamed:@"shareBtn_press"]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [friendBtn setTitle:@"分享给好友" forState:UIControlStateNormal];
     [friendBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    friendBtn.tag = 101;
    [friendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:friendBtn];
    
    UIImageView *friendImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 9, 25, 25)];
    friendImage.image = [UIImage imageNamed:@"friend"];
    [shareBtn addSubview:friendImage];
    
    UIImageView *fImage = [[UIImageView alloc]initWithFrame:CGRectMake(65, 9, 25, 25)];
    fImage.image = [UIImage imageNamed:@"weixin"];
    [friendBtn addSubview:fImage];
    
    shareImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-self.view.frame.size.width/1.5)/2-10, 10, self.view.frame.size.width/1.5, self.view.frame.size.height/1.5-20)];
    
    [imageView addSubview:shareImageView];
}

-(void)share:(UIButton *)button{
    
    WXMediaMessage *message = [WXMediaMessage message];
    
//    UIImage *image = [UIImage imageNamed:@"singlegame@2x.png"];
//    UIImage *image = [[BLUtils globalCache]imageForKey:@"weixin"];
    
//    [message setThumbImage:_image];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImagePNGRepresentation(_image);//(image, 0.5);//(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    
    if (button.tag == 100) {
        //朋友圈
        req.scene = WXSceneTimeline;
    }else{
        //好友
        req.scene = WXSceneSession;
    }
    [WXApi sendReq:req];
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
}

-(void)initImage:(UIImage *)image{
    shareImageView.image = image;
    _image = image;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)dismiss{
    [_delegate dismisModelViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
