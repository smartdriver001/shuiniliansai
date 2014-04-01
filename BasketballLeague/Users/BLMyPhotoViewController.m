//
//  BLMyPhotoViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-3-9.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyPhotoViewController.h"
#import "SwipeView.h"
#import "BLPhoto.h"
#import "UIImageView+WebCache.h"

#define BROWSER_TITLE_LBL_TAG 12731


@interface BLMyPhotoViewController () <SwipeViewDataSource, SwipeViewDelegate>
{
    NSArray *imageURLs;
    NSArray *descriptions;
    SwipeView *_swipeView;
}

@property (nonatomic, strong) NSMutableArray *photoDataSource;

@end

@implementation BLMyPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.photoDataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self initSwipeView];
    
    [self addLeftNavItem:@selector(dismiss)];
    
    NSString *path = [NSString stringWithFormat:@"my_albumlist/?uid=%@",@"2"];
    
    [ShowLoading showWithMessage:showloading view:self.view];
    [BLPhoto globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        [ShowLoading hideLoading:self.view];
        if (error) {
            return ;
        }
        if (posts.count > 0) {
            BLPhoto *photo = [posts objectAtIndex:0];
            if (photo.msg == nil) {
                [self initData:posts];
            }else{
                [ShowLoading showErrorMessage:@"暂无数据" view:self.view];
            }
        }
    } path:path];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initData:(NSArray *)posts{
    
    for (int i = 0; i<posts.count; i++) {
        BLPhoto *photo = [posts objectAtIndex:i];
        [_photoDataSource addObject:photo.url];
    }
    
    self.title = [NSString stringWithFormat:@"%d/%d",1,_photoDataSource.count];
    
    [self initSwipeView];
    [_swipeView reloadData];
    
}

-(void)initSwipeView{
     _swipeView = [[SwipeView alloc]init];
    if (iPhone5) {
        _swipeView.frame = iPhone5_frame;
    }else{
        _swipeView.frame = iPhone4_frame;
    }
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
    _swipeView.pagingEnabled = YES;
    _swipeView.currentItemIndex = 0;
    
    [self.view addSubview:_swipeView];
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //return the total number of items in the carousel
    return [_photoDataSource count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
//    UIView *view = nil;
    UIImageView *imageview = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        
        if (iPhone5) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 330, 548 - 44)];
            imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 548 - 44)];
        }else{
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 330, 460 - 44)];
            imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460 - 44)];
        }
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
//        imageview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        imageview.contentMode =UIViewContentModeScaleAspectFit;
        imageview.tag = 1;
        [view addSubview:imageview];
    }
    else
    {
        //get a reference to the label in the recycled view
        imageview = (UIImageView *)[view viewWithTag:1];
    }
    
    [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[_photoDataSource objectAtIndex:index]]] placeholderImage:nil];
//    imageview.contentMode = UIViewContentModeScaleAspectFit;
    
    return imageview;
}


-(void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView{
    self.title = [NSString stringWithFormat:@"%d/%d",swipeView.currentItemIndex+1,_photoDataSource.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
