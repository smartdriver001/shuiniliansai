//
//  BLCityListViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-10.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLCityListViewController.h"
#import "BLCityBase.h"
#import "BLCityLists.h"
#import "BLCounty.h"
#import "BLVillage.h"
#import "BLCityListCell.h"
#import "UIColor+Hex.h"

@interface BLCityListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    
    int indexRow[2][100];
    
    NSString * localCity;
    BLCityBase *base;
}

@property (nonatomic,strong) NSMutableArray * cityArray;

@end

@implementation BLCityListViewController

@synthesize cityArray;

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
//    for (int i = 0; i < 100; i++) {
//        if (indexRow[1][i] == 1) {
//            BLCityLists * city = [cityArray objectAtIndex:i];
//            [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",city.name] forKey:@"location"];
//            [_delegate titleCityName:[NSString stringWithFormat:@"%@",city.name]];
//            [[BLUtils globalCache]setString:[cityArray objectAtIndex:i] forKey:@"location"];
//            [_delegate titleCityName:[cityArray objectAtIndex:i]];
//        }
//    }
//    
//    if (indexRow[0][0] == 1) {
//        [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",localCity] forKey:@"location"];
//        [_delegate titleCityName:localCity];
//    }

    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.cityArray = [NSMutableArray arrayWithCapacity:0];
    
    localCity = [[BLUtils globalCache]stringForKey:@"GPSLocation"];
    
    [self addNavBar];
    [self addLeftNavBarItem:@selector(leftButtonClick)];
    [self addNavBarTitle:@"城市列表" action:nil];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = [BLUtils frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    cityArray = [userDefaults objectForKey:@"citylist"];
    if (cityArray.count > 0) {
        
    }else{
        [self requestCity];
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc]init];
    header.backgroundColor = [UIColor clearColor];
    
    if (section == 0) {
        
    }else{
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, 25)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithHexString:@"FBB03B"];
        label.text = @"热门城市";
        [header addSubview:label];
    }
    
    return header;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor clearColor];
    
    return footer;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }else{
        return 25;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7.5f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return self.cityArray.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BLCityListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[BLCityListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexRow[indexPath.section][indexPath.row] == 1) {
            cell.imageView.image = [UIImage imageNamed:@"citySelect"];
            [cell setData:localCity detail:@"GPS定位" backImg:@"button_normal"];
        }else{
            cell.imageView.image = nil;
            [cell setData:localCity detail:@"GPS定位" backImg:@"tableViewCellBlack"];
        }
        
        return cell;
    }else{
        BLCityListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[BLCityListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        BLCityLists * city = [cityArray objectAtIndex:indexPath.row];

        if (indexRow[indexPath.section][indexPath.row] == 1) {
            cell.imageView.image = [UIImage imageNamed:@"citySelect"];
//            [cell setData:[NSString stringWithFormat:@"%@",city.name]  detail:@"" backImg:@"button_normal"];
            [cell setData:[cityArray objectAtIndex:indexPath.row]  detail:@"" backImg:@"button_normal"];
        }else{
            cell.imageView.image = nil;
//            [cell setData:[NSString stringWithFormat:@"%@",city.name]  detail:@"" backImg:@"tableViewCellBlack"];
            [cell setData:[cityArray objectAtIndex:indexPath.row]  detail:@"" backImg:@"tableViewCellBlack"];
        }
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 100; j++) {
            indexRow[i][j] = 0;
        }
    }
    
    if (indexPath.section == 0) {
        [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",localCity] forKey:@"location"];
        [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",@"2"] forKey:@"cityId"];
        [_delegate titleCityName:localCity];
    }else{
        BLCityLists * city = [base.cityListsArray objectAtIndex:indexPath.row];
        [[BLUtils globalCache]setString:[NSString stringWithFormat:@"%@",city.cityId] forKey:@"cityId"];
        [[BLUtils globalCache]setString:[cityArray objectAtIndex:indexPath.row] forKey:@"location"];
        [_delegate titleCityName:[cityArray objectAtIndex:indexPath.row]];
    }
    
    indexRow[indexPath.section][indexPath.row] = 1;
    
    [_tableView reloadData];
    
    [self performSelector:@selector(dismissVC) withObject:self afterDelay:.3];
}

-(void)dismissVC
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)requestCity
{
    NSString *path = [NSString stringWithFormat:@"city/"];
    
    [BLCityBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
//                cityArray = [NSMutableArray arrayWithArray:base.cityListsArray];
                self.cityArray = [NSMutableArray array];
                for (int i = 0; i < base.cityListsArray.count; i++) {
                    BLCityLists * city = [base.cityListsArray objectAtIndex:i];
                    [self.cityArray addObject:city.name];
                }
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.cityArray forKey:@"citylist"];
                [userDefaults synchronize];
                
                [_tableView reloadData];
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
