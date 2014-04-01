//
//  BLMyImagesViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-5.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyImagesViewController.h"
#import "BLMyteamImages.h"
#import "UIImageView+WebCache.h"

@interface BLMyImagesViewController ()<UIScrollViewDelegate>
{
    NSArray * myImagesArray;
}
@end

@implementation BLMyImagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (ios7) {
            btn.frame = CGRectMake(0, 0, 25, 25);
        }else{
            btn.frame = CGRectMake(20, 9.5, 25, 25);
        }
        [btn setBackgroundImage:[UIImage imageNamed:@"addRightBtn_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"addRightBtn_press"] forState:UIControlStateHighlighted];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rightButton1Click) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *view ;
        UIBarButtonItem *item ;
        if (!ios7) {
            view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
            view.backgroundColor = [UIColor clearColor];
            [view addSubview:btn];
            item = [[UIBarButtonItem alloc] initWithCustomView:view];
        }else{
            item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        if (ios7) {
            btn1.frame = CGRectMake(0, 0, 25, 25);
        }else{
            btn1.frame = CGRectMake(20, 9.5, 25, 25);
        }
        [btn1 setBackgroundImage:[UIImage imageNamed:@"Delete_normal"] forState:UIControlStateNormal];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"Delete_press"] forState:UIControlStateHighlighted];
        
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(rightButton2Click) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *view1;
        UIBarButtonItem *item1;
        if (!ios7) {
            view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
            view1.backgroundColor = [UIColor clearColor];
            [view1 addSubview:btn1];
            item1 = [[UIBarButtonItem alloc] initWithCustomView:view1];
        }else{
            item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
        }
        
        NSArray * array = [NSArray arrayWithObjects:item1,item, nil];
        
        self.navigationItem.rightBarButtonItems = array;
        
//        UILabel * navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
//        navLabel.font = [UIFont boldSystemFontOfSize:18];
//        navLabel.textAlignment = UITextAlignmentCenter;
//        navLabel.textColor = [UIColor whiteColor];
//        navLabel.tag = 100;
//        navLabel.text = @"1/1";
//        
        self.navigationItem.title = @"1/1";
    }
    return self;
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButton1Click
{
    
}

-(void)rightButton2Click
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addLeftNavItem:@selector(leftButtonClick)];
}

-(void)setImages:(NSArray *)imagesArray
{
    myImagesArray = [NSArray arrayWithArray:imagesArray];
    
    UIScrollView * sv = [[UIScrollView alloc]init];
    if (iPhone5) {
        sv.frame = iPhone5_frame;
        sv.contentSize = CGSizeMake(320 * imagesArray.count, iPhone5_frame.size.height);
    }else{
        sv.frame = iPhone4_frame;
        sv.contentSize = CGSizeMake(320 * imagesArray.count, iPhone4_frame.size.height);
    }
    sv.delegate = self;
    [self.view addSubview:sv];

    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    
    sv.pagingEnabled = YES;
    
    for (int i = 0; i < imagesArray.count; i++) {
        BLMyteamImages * images = [imagesArray objectAtIndex:i];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 * i, 0, 320, sv.frame.size.height)];
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",images.imgURL]] placeholderImage:[UIImage imageNamed:@""]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [sv addSubview:imageView];
    }
    
//    [self addNavText:[NSString stringWithFormat:@"%d/%d",1,imagesArray.count] action:nil];
//    UILabel * label = (UILabel *)[self.view viewWithTag:100];
//    label.text = [NSString stringWithFormat:@"%d/%d",1,imagesArray.count];
    self.navigationItem.title = [NSString stringWithFormat:@"%d/%d",1,imagesArray.count];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2;
//    int currentPage = scrollView.contentOffset.x/pageWidth;
    NSLog(@"currentPage = %d",currentPage);
    
//    UILabel * label = (UILabel *)[self.view viewWithTag:100];
//    label.text = [NSString stringWithFormat:@"%d/%.0f",currentPage,pageWidth/320];
    self.navigationItem.title = [NSString stringWithFormat:@"%d/%d",currentPage,myImagesArray.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
