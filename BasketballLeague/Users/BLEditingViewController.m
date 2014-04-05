//
//  BLEditingViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-22.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLEditingViewController.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetCustomPickerDelegate.h"
#import "ActionSheetStringPicker.h"
#import "BLEditSecondViewController.h"
#import "BLBaseObject.h"
#import "BLSchool.h"
#import "BLCollege.h"

@interface BLEditingViewController ()<UIActionSheetDelegate, IBActionSheetDelegate,EditedDelegate>{
    
    UITextField *userNameField;
    NSArray *titles;
    NSArray *titlesBX;
    NSArray *titles1;
    
    IBActionSheet *sexAction;
    int sex;
    NSString *birthday;
    NSString *height;
    int weight;
    NSString *school;
    NSString *college;
    NSString *shoes;
    NSString *ballnumber;
    NSString *size;
    
    NSMutableArray *sizeArr;
    
    NSArray *schools;
    BLSchool *mySchool;
    NSArray *collegss;
}

@end

@implementation BLEditingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"资料修改";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titles = @[@"性别",@"生日",@"身高",@"体重",@"球号",@"学校",@"院系"];
    titlesBX = @[@"",@"",@"",@"",@"",@"（必选）",@"（必选）",@"",@""];
    NSData *data = [[BLUtils globalCache]dataForKey:@"schools"];
    if (data) {
        schools = [BLSchool parseJsonToArray:data];
    }
    
//    [self initBackground];
    [self performSelector:@selector(initBackground) withObject:nil afterDelay:0.1];
}

-(void)initBackground {
    
    [self addLeftNavItem:@selector(dimiss)];

    UIScrollView *scrollView = [[UIScrollView alloc]init];
    if (iPhone5) {
        scrollView.frame = iPhone5_frame;
        scrollView.contentSize = CGSizeMake(320, 548);
    }else{
        scrollView.frame = iPhone4_frame;
        scrollView.contentSize = CGSizeMake(320, 460);
    }
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    int yplus = 0;
    for (int i=0; i<9-2; i++) {
        
        if (i == 5) {
            yplus = 14;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 20+(i*44+i*2)+yplus, 280, 44);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(additions:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [scrollView addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+14, 20+6+(i*32+i*2+i*12)+yplus, 40, 32)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [titles objectAtIndex:i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [scrollView addSubview:titleLabel];
        
        UILabel *bixuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+14+35, 20+6+(i*32+i*2+i*12)+yplus, 70, 32)];
        bixuanLabel.backgroundColor = [UIColor clearColor];
        bixuanLabel.text = [titlesBX objectAtIndex:i];
        bixuanLabel.textColor = [UIColor colorWithHexString:@"#ff5839"];
        bixuanLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [scrollView addSubview:bixuanLabel];
        
        UILabel *additionLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 20+6+(i*32+i*2+i*12)+yplus, 170, 32)];
        additionLabel.backgroundColor = [UIColor clearColor];
        
        if (i == 0) {
            int sexInt = [[_personData objectAtIndex:i]intValue];
            if (sexInt ==1) {
                additionLabel.text = @"男";
            }else if(sexInt == 2){
                additionLabel.text = @"女";
            }else{
                additionLabel.text = @"保密";
            }
            
        }else if (i == 1){
            additionLabel.text = [NSString stringWithFormat:@"%@",[_personData objectAtIndex:i]];
        }else if (i == 2){
            additionLabel.text = [NSString stringWithFormat:@"%.0fCM",[[_personData objectAtIndex:i]floatValue]*100];
        }else if (i == 3){
            additionLabel.text = [NSString stringWithFormat:@"%@KG",[_personData objectAtIndex:i]];
        }else if (i == 4){
            additionLabel.text = [NSString stringWithFormat:@"%@号",[_personData objectAtIndex:i]];
        }else if (i == 5){
            additionLabel.text = [NSString stringWithFormat:@"%@",[_personData objectAtIndex:i]];
        }else if (i == 6){
            additionLabel.text = [NSString stringWithFormat:@"%@",[_personData objectAtIndex:i]];
        }else if (i == 7){
            additionLabel.text = [NSString stringWithFormat:@"%@",[_personData objectAtIndex:i]];
        }else if (i == 8){
            additionLabel.text = [NSString stringWithFormat:@"%@",[_personData objectAtIndex:i]];
        }
        
        additionLabel.textAlignment = UITextAlignmentRight;
        additionLabel.textColor = [UIColor whiteColor];
        additionLabel.font = [UIFont systemFontOfSize:16.0f];
        additionLabel.tag = 100+i;
        
        [scrollView addSubview:additionLabel];
    }
    
    [self.view addSubview:scrollView];
    
}

-(void)dimiss{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)additions:(UIButton *)button{
    
    BLEditSecondViewController *second = [[BLEditSecondViewController alloc]initWithNibName:@"BLEditSecondViewController" bundle:nil];
    second.isCommit = @"yes";
    if (button.tag == 1) {
        [self showSexChoiceAction:button];
    }else if (button.tag == 2){
        [self setDatePick:button];
    }else if (button.tag == 9){
        [self setSize:button];
    }else if(button.tag == 6){
        [self setSchool:button];
    }else if(button.tag == 7){
        [self setCollege:button];
    }else{
        
        if (button.tag == 3){
            second.title = @"身高修改";
            second.tag = @"height";
        }else if (button.tag == 4){
            second.title = @"体重修改";
            second.tag = @"weight";
        }else if(button.tag == 5){
            second.title = @"球号修改";
            second.tag = @"ballnumber";
        }else if(button.tag == 8){
            second.title = @"球鞋修改";
            second.tag = @"shoes";
        }
        second.delegate = self;
        [self.navigationController pushViewController:second animated:YES];
    }
}

-(void)didEditCondition:(NSString *)result tag:(NSString *)tag{
    
    if ([tag isEqualToString:@"height"]) {
        UILabel *heightLabel = (UILabel *)[self.view viewWithTag:102];
        heightLabel.text = [NSString stringWithFormat:@"%@CM",result];
        float heightF = [result floatValue];
        height = [NSString stringWithFormat:@"%.0f",heightF];
    }else if ([tag isEqualToString:@"weight"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:103];
        weight = [result intValue];
        weightLabel.text = [NSString stringWithFormat:@"%@KG",result];
    }else if ([tag isEqualToString:@"ballnumber"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:104];
        weight = [result intValue];
        weightLabel.text = [NSString stringWithFormat:@"%@号",result];
    }else if ([tag isEqualToString:@"school"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:105];
        weightLabel.text = [NSString stringWithFormat:@"%@",result];
    }else if ([tag isEqualToString:@"college"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:106];
        weightLabel.text = [NSString stringWithFormat:@"%@",result];
    }else if ([tag isEqualToString:@"shoes"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:107];
        weightLabel.text = [NSString stringWithFormat:@"%@",result];
    }
}

- (IBAction)setDatePick:(id)sender {
    NSString *dateString = [NSString stringWithFormat:@"%@",[_personData objectAtIndex:1]];
    if (![dateString isEqualToString:@""] || dateString.length > 1) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        NSDate *destDate= [dateFormatter dateFromString:dateString];
        self.selectedDate = destDate;  //[NSDate date];
    }else{
        self.selectedDate = [NSDate date];
    }
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate target:self action:@selector(dateWasSelected:element:) origin:sender];
    self.actionSheetPicker.title = @"生日选择";
    
    self.actionSheetPicker.hideCancel = NO;
    [self.actionSheetPicker showActionSheetPicker];
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    self.selectedDate = selectedDate;
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *birth = [dateFormatter stringFromDate:self.selectedDate];
    birthday = birth;
    
    [self commitWithchange:@"birth" value:birth];
    
    NSArray *ymd = [birth componentsSeparatedByString:@"-"];
    
    UILabel *birthdayLabel = (UILabel *)[self.view viewWithTag:101];
    birthdayLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",[ymd objectAtIndex:0],[ymd objectAtIndex:1],[ymd objectAtIndex:2]];
    
}

-(void)showSexChoiceAction:(UIButton *)button{
    sexAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesArray:@[@"男", @"女"]];
    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#55585f"]];
    [sexAction setButtonTextColor:[UIColor whiteColor]];
    [sexAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#ac3726"] forButtonAtIndex:2];
    [sexAction showInView:self.navigationController.view];
}

-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UILabel *sexLabel = (UILabel *)[self.view viewWithTag:100];
    if (buttonIndex >= 2) {
        return;
    }
    if (buttonIndex == 0) {
        sexLabel.text = @"男";
        sex = 1;
    }else if (buttonIndex == 1){
        sexLabel.text = @"女";
        sex = 2;
    }
    [self commitWithchange:@"sex" value:[NSString stringWithFormat:@"%d",sex]];
}


-(void)setSize:(UIButton *)button{
    sizeArr = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        [sizeArr addObject:[NSString stringWithFormat:@"%d",i+35]];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"设置尺码" rows:sizeArr initialSelection:self.selectedIndex target:self successAction:@selector(sizeWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:button];
}

- (void)sizeWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedIndex = [selectedIndex intValue];
    UILabel *sizeLabel = (UILabel *)[self.view viewWithTag:108];
    size = [sizeArr objectAtIndex:self.selectedIndex];
    sizeLabel.text = size;
    [self commitWithchange:@"size" value:size];
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
}

-(void)setSchool:(UIButton *)button{
    sizeArr = [NSMutableArray array];
    
    for (int i=0; i<schools.count; i++) {
        BLSchool *mySchool1 = [schools objectAtIndex:i];
        [sizeArr addObject:mySchool1.name];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"选择学校" rows:sizeArr initialSelection:self.selectedIndex target:self successAction:@selector(schoolWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:button];
}

- (void)schoolWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedIndex = [selectedIndex intValue];
    mySchool = [schools objectAtIndex:[selectedIndex intValue]];
    school = mySchool.schoolId;
    UILabel *sizeLabel = (UILabel *)[self.view viewWithTag:105];
    sizeLabel.text = [sizeArr objectAtIndex:self.selectedIndex];
//    UILabel *collegeLabel = (UILabel *)[self.view viewWithTag:106];
//    collegeLabel.text = @"" ;
    [self commitWithchange:@"school" value:school];
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
}

-(void)setCollege:(UIButton *)button{
    sizeArr = [NSMutableArray array];
    
    //    BLSchool *mySchool =  [schools objectAtIndex:self.selectedIndex];
    collegss = mySchool.colleges;
    for (int i=0; i<collegss.count; i++) {
        BLCollege *myCollege = [mySchool.colleges objectAtIndex:i];
        [sizeArr addObject:myCollege.name];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"院系选择" rows:sizeArr initialSelection:self.selectedIndex target:self successAction:@selector(collegeWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:button];
}

- (void)collegeWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedIndex = [selectedIndex intValue];
    if ([selectedIndex intValue]>collegss.count) {
        return;
    }
    BLCollege *myCollege = [collegss objectAtIndex:[selectedIndex intValue]];
    college = myCollege.collegeId;
    
    UILabel *sizeLabel = (UILabel *)[self.view viewWithTag:106];
    sizeLabel.text = [sizeArr objectAtIndex:self.selectedIndex];
    [self commitWithchange:@"college" value:college];
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
}

#pragma mark - Implementation

- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedIndex = [selectedIndex intValue];
    UILabel *sizeLabel = (UILabel *)[self.view viewWithTag:108];
    sizeLabel.text = [sizeArr objectAtIndex:self.selectedIndex];
    
    [self commitWithchange:@"size" value:[sizeArr objectAtIndex:self.selectedIndex]];
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
}

//my_edit/?uid=2&type=sex&value=1

-(void)commitWithchange:(NSString *)type value:(NSString *)value{
    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    NSString *path = [NSString stringWithFormat:@"my_edit/?uid=%@&type=%@&value=%@",uid,type,value];
    
    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            
        }
        if (posts.count > 0) {
            
            BLBaseObject *base = [posts objectAtIndex:0];
            
            if ([base.msg isEqualToString:@"succ"]) {
                [ShowLoading showSuccView:self.view message:@"提交成功！"];
                [[BLUtils globalCache]setString:@"yes" forKey:@"reload"];
            }else{
                [ShowLoading showErrorMessage:base.msg view:self.view];
            }
        }
    } path:path];
}

@end
