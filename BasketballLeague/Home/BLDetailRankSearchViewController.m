//
//  BLDetailRankSearchViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-12.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLDetailRankSearchViewController.h"

@interface BLDetailRankSearchViewController ()<UISearchBarDelegate>
{
    BOOL isSearch;
}

@property (nonatomic,strong) NSMutableArray * searchArray;

@end

@implementation BLDetailRankSearchViewController

@synthesize searchArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchArray = [NSMutableArray arrayWithCapacity:0];
    
    float y;
    if (ios7) {
        y = 20;
    }else{
        y = 0;
    }
    
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, y, 320, 44)];
    searchbar.delegate = self;
    searchbar.placeholder = @"搜索";
    [searchbar setBackgroundImage:[[UIImage imageNamed:@"navigationbar_background"] stretchableImageWithLeftCapWidth:22 topCapHeight:22]];
    [searchbar setTintColor:[UIColor whiteColor]];
    searchbar.showsCancelButton = YES;
    [self.view addSubview:searchbar];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    [searchArray removeAllObjects];
    //
    //    for (int i = 0; i < 1000; i++) {
    //        isSelectedSearch[i] = 0;
    //    }
    //
    //    for (NSString * str in dataArray) {
    //        NSRange range = [str rangeOfString:searchText];
    //        if (range.length > 0&&range.location == 0) {
    //            [searchArray addObject:str];
    //        }
    //    }
    //
    //    UITableView * tableview = (UITableView *)[self.view viewWithTag:101];
    //    isSearch = YES;
    //    if ([searchText isEqualToString:@""]) {
    //        isSearch = NO;
    //    }
    //
    //    if (isSearch == YES) {
    //        for (int i = 0; i < 1000; i++) {
    //            if (isSelected[i] == 1) {
    //                for (int j = 0; j < searchArray.count; j++) {
    //
    //                    if ([[searchArray objectAtIndex:j] isEqualToString:[dataArray objectAtIndex:i]]) {
    //                        if (isSelectedSearch[j] == 0) {
    //                            isSelectedSearch[j] = 1;
    //                        }else{
    //                            isSelectedSearch[j] = 0;
    //                        }
    //                    }
    //
    //                }
    //            }
    //
    //        }
    //    }
    //
    //    [tableview reloadData];
}

-(void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
//    [self leftButtonClick];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
