//
//  BLEntry1ViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-11.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLEntry1ViewController.h"
#import "BLBaseObject.h"
#import "BLTextField.h"
#import "UIColor+Hex.h"
#import "ActionSheetDatePicker.h"
#import "IBActionSheet.h"
#import "BLTimeBase.h"
#import "BLTimeData.h"
#import "BLCityBase.h"
#import "BLCityLists.h"
#import "BLCounty.h"
#import "BLVillage.h"

@interface BLEntry1ViewController ()<UITextFieldDelegate,IBActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BLTextField * _textField;
    UIDatePicker * picker;
    IBActionSheet * sexAction;
    NSArray * timeArray;
    
    UITableView * _tableView;
    
    int _tableViewBack[100];
    
    NSString * placeStr;
    NSString * gameDate;
    NSString * gameTime;
}

@property(nonatomic,strong)NSDate * selectedDate;
@property(nonatomic,strong)ActionSheetDatePicker * actionSheetPicker;
@property(nonatomic,strong)NSMutableArray * timedataArray;
@property(nonatomic,strong)NSMutableArray * villageListArray;

@end

@implementation BLEntry1ViewController

@synthesize timedataArray;
@synthesize villageListArray;

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
    self.timedataArray = [NSMutableArray arrayWithCapacity:0];
    self.villageListArray = [NSMutableArray arrayWithCapacity:0];
    
    [self addNavBar];
    [self addNavBarTitle:@"比赛报名" action:nil];
    [self addLeftNavBarItem:@selector(leftButtonClick)];
    
    placeStr = @"";
    gameDate = @"";
    gameTime = @"";
    
    float y = 44;
    if (ios7) {
        y = 44 + 20;
    }
    float high;
    if (iPhone5) {
        high = 548 - 44;
    }else{
        high = 460 - 44;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, 320, high)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.hidden = YES;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"27292E"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self createView];
    
    [self requestMy_teamdetail];
    
//    [self requestTime];
    
    [self requestCity];
}

-(void)requestCity
{
    NSString *path = [NSString stringWithFormat:@"city/"];
    
    [BLCityBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLCityBase *cityBase = [posts objectAtIndex:0];
            if ([cityBase.msg isEqualToString:@"succ"]) {
                
                for (int i = 0; i < cityBase.cityListsArray.count; i++) {
                    BLCityLists * city = [cityBase.cityListsArray objectAtIndex:i];
                    for (int j = 0; j < city.countyArray.count; j++) {
                        BLCounty * county = [city.countyArray objectAtIndex:j];
                        for (int k = 0; k < county.villageArray.count; k++) {
                            BLVillage * village = [county.villageArray objectAtIndex:k];
                            [villageListArray addObject:village];
                        }
                    }
                }
                
                [_tableView reloadData];
                
            }else{
                [ShowLoading showErrorMessage:cityBase.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)requestTime:(NSString *)placeID
{
    NSString *path = [NSString stringWithFormat:@"time/?id=%@",placeID];
    
    [BLTimeBase globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLTimeBase * base = [posts objectAtIndex:0];
            
            timedataArray = [NSMutableArray arrayWithArray:base.timeDataArray];
            
        }else{
            
            
        }
        
    } path:path];
}

-(void)requestMy_teamdetail
{
    NSString * uid = [[BLUtils globalCache]stringForKey:@"uid"];
    
    NSString *path = [NSString stringWithFormat:@"my_teamdetail?uid=%@",uid];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLBaseObject *base = [posts objectAtIndex:0];
            if ([base.msg isEqualToString:@"succ"]) {
                
                UILabel * label = (UILabel *)[self.view viewWithTag:100];
                label.text = [NSString stringWithFormat:@"参赛球队：%@",base.data.teamname];
                
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
        
    } path:path];
}

-(void)createView
{
    float high = 44;
    if (ios7) {
        high = 44 + 20;
    }
    NSArray * array = [NSArray arrayWithObjects:@"参赛球队：",@"参赛场地：",@"参赛日期：",@"参赛时间：",@"请输入您的联系方式", nil];
    for (int i = 0; i < array.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, high + 16 + i * 45, 280, 44)];
        imageView.image = [[UIImage imageNamed:@"tableViewCellBlack"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        imageView.tag = 300 + i;
        [self.view addSubview:imageView];
        
        if (i < 4) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30, high + 16 + i * 45, 260, 44)];
            label.font = [UIFont boldSystemFontOfSize:18];
            label.textColor = [UIColor whiteColor];
            label.tag = 100 + i;
            label.backgroundColor = [UIColor clearColor];
            label.text = [array objectAtIndex:i];
            [self.view addSubview:label];
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(30, high + 16 + i * 45, 260, 44);
            button.backgroundColor = [UIColor clearColor];
            button.tag = 200 + i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
    
    _textField = [[BLTextField alloc]initWithFrame:CGRectMake(30, high + 16 + 4 * 45, 260, 44)];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.layer.cornerRadius = 2;
    _textField.placeholder = @"请输入您的联系方式";
    _textField.font = [UIFont boldSystemFontOfSize:18];
    _textField.textColor = [UIColor whiteColor];
    _textField.delegate = self;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textField];
    
    UIButton * entryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    entryButton.frame = CGRectMake(20, high + 555/2, 280, 44);
    entryButton.tag = 90;
    [entryButton setTitle:@"提交" forState:UIControlStateNormal];
    [entryButton setBackgroundImage:[[UIImage imageNamed:@"redButton_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [entryButton setBackgroundImage:[[UIImage imageNamed:@"redButton_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateHighlighted];
    [entryButton addTarget:self action:@selector(SubmitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:entryButton];
    
    [self.view bringSubviewToFront:_tableView];
}

-(void)changeFrameBegin
{
    float high = 44;
    if (ios7) {
        high = 44 + 20;
    }
    
    UIButton * entryButton = (UIButton *)[self.view viewWithTag:90];
    entryButton.frame = CGRectMake(20, high + 555/2 - 50, 280, 44);
    
    _textField.frame = CGRectMake(30, high + 16 + 4 * 45 - 50, 260, 44);
    
    for (int i = 0; i < 5; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:200 + i];
        button.frame = CGRectMake(30, high + 16 + i * 45 - 50, 260, 44);
        [self.view sendSubviewToBack:button];
        
        UILabel * label = (UILabel *)[self.view viewWithTag:100 + i];
        label.frame = CGRectMake(30, high + 16 + i * 45 - 50, 260, 44);
        [self.view sendSubviewToBack:label];
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag:300 + i];
        imageView.frame = CGRectMake(20, high + 16 + i * 45 - 50, 280, 44);
        [self.view sendSubviewToBack:imageView];
    }
}

-(void)changeFrameEnd
{
    float high = 44;
    if (ios7) {
        high = 44 + 20;
    }
    
    UIButton * entryButton = (UIButton *)[self.view viewWithTag:90];
    entryButton.frame = CGRectMake(20, high + 555/2, 280, 44);
    
    _textField.frame = CGRectMake(30, high + 16 + 4 * 45, 260, 44);
    
    for (int i = 0; i < 5; i++) {
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag:300 + i];
        imageView.frame = CGRectMake(20, high + 16 + i * 45, 280, 44);
        
        UILabel * label = (UILabel *)[self.view viewWithTag:100 + i];
        label.frame = CGRectMake(30, high + 16 + i * 45, 260, 44);
        
        UIButton * button = (UIButton *)[self.view viewWithTag:200 + i];
        button.frame = CGRectMake(30, high + 16 + i * 45, 260, 44);
    }
}

-(void)SubmitButtonClick
{
    [self changeFrameEnd];
    [_textField resignFirstResponder];
    
    if ([placeStr isEqualToString:@""]) {
        [ShowLoading showErrorMessage:@"请选择参赛场地" view:self.view];
    }else{
        if ([gameDate isEqualToString:@""]||[gameTime isEqualToString:@""]) {
            [ShowLoading showErrorMessage:@"请选择参赛时间" view:self.view];
        }else{
            if (_textField.text == NULL || [_textField.text isEqualToString:@""]) {
                [ShowLoading showErrorMessage:@"请填写联系方式" view:self.view];
            }else{
                [self requestEntry];
            }
        }
    }
}

-(void)requestEntry
{
    NSString * uid = [[BLUtils globalCache]stringForKey:@"uid"];
    NSString * teamid = [[BLUtils globalCache]stringForKey:@"teamid"];
    NSString * ctime = [NSString stringWithFormat:@"%@ %@",gameDate,gameTime];
    NSString *path = [NSString stringWithFormat:@"entry/?uid=%@&teamid=%@&place=%@&ctime=%@&contactinfo=%@",uid,teamid,placeStr,ctime,_textField.text];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            
            BLBaseObject * base = [posts objectAtIndex:0];
            NSLog(@"%@",base.msg);
            if ([base.msg isEqualToString:@"succ"]) {
                [ShowLoading showErrorMessage:@"恭喜你报名成功，稍后工作人员将联系你" view:self.view];
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
            
        }else{
            
            
        }
        
    } path:path];
}

-(void)buttonClick:(id)sender
{
    [self changeFrameEnd];
    UIButton * button = (UIButton *)sender;
    if (button.tag == 201) {
        if (_tableView.hidden) {
            _tableView.hidden = NO;
        }else{
            _tableView.hidden = YES;
        }
        
    }else if (button.tag == 202){
        
        self.selectedDate = [NSDate date];
        _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate target:self action:@selector(dateWasSelected:element:) origin:sender];
        self.actionSheetPicker.title = @"参赛日期";
        
        self.actionSheetPicker.hideCancel = NO;
        [self.actionSheetPicker showActionSheetPicker];
        
    }else if (button.tag == 203){
        
        BOOL times = NO;
        if (timedataArray.count > 0) {
            for (int i = 0; i < timedataArray.count; i++) {
                BLTimeData * data = [timedataArray objectAtIndex:i];
                
                NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYY-MM-dd"];
                NSString * gdate = [dateFormatter stringFromDate:self.selectedDate];
                if ([data.day isEqualToString:gdate]) {
                    times = YES;
                    timeArray = [NSArray arrayWithArray:data.timesArray];
                    sexAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesArray:data.timesArray];
                    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#55585f"]];
                    [sexAction setButtonTextColor:[UIColor whiteColor]];
                    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#ac3726"] forButtonAtIndex:data.timesArray.count];
                    [sexAction showInView:self.navigationController.view];
                }
            }
            
            if (!times) {
                [ShowLoading showErrorMessage:@"无参赛时间可选" view:self.view];
            }
        }else{
            [ShowLoading showErrorMessage:@"无参赛时间可选" view:self.view];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return villageListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (_tableViewBack[indexPath.row] == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"3D3E43"];
    }else{
        cell.backgroundColor = [UIColor colorWithHexString:@"27292E"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BLVillage * village = [villageListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",village.name];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < 100; i++) {
        _tableViewBack[i] = 0;
    }
    _tableViewBack[indexPath.row] = 1;
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    BLVillage * village = [villageListArray objectAtIndex:indexPath.row];
    [self requestTime:[NSString stringWithFormat:@"%@",village.cityId]];
    
    [_tableView reloadData];
    
    UILabel * label = (UILabel *)[self.view viewWithTag:101];
    label.text = [NSString stringWithFormat:@"参赛场地：%@",village.name];
    
    placeStr = [NSString stringWithFormat:@"%@",village.cityId];
    
    [self performSelector:@selector(tableViewHide) withObject:self afterDelay:0.3];
}

-(void)tableViewHide
{
    _tableView.hidden = YES;
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    self.selectedDate = selectedDate;
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString * gdate = [dateFormatter stringFromDate:selectedDate];
    gameDate = gdate;
    UILabel * label = (UILabel *)[self.view viewWithTag:102];
    label.text = [NSString stringWithFormat:@"参赛日期：%@",gdate];
}

-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UILabel * label = (UILabel *)[self.view viewWithTag:103];
    if (buttonIndex == timeArray.count) {
        return;
    }
    label.text = [NSString stringWithFormat:@"参赛时间：%@",[timeArray objectAtIndex:buttonIndex]];
    gameTime = [timeArray objectAtIndex:buttonIndex];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_textField becomeFirstResponder];
    
    [self changeFrameBegin];
    
    if (picker) {
        [picker removeFromSuperview];
        picker = nil;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_textField resignFirstResponder];
    
    [self changeFrameEnd];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    
    [self changeFrameEnd];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
    
    [self changeFrameEnd];
    
    if (picker) {
        [picker removeFromSuperview];
        picker = nil;
    }
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
