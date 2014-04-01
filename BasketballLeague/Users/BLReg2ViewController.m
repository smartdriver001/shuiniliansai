//
//  BLReg2ViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-20.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLReg2ViewController.h"
#import "BLBaseObject.h"
#import "BLTextField.h"
#import "UIButton+Bootstrap.h"
#import "UIColor+Hex.h"
#import "IBActionSheet.h"
#import "BLEditSecondViewController.h"
#import "ActionSheetStringPicker.h"
#import "BLSchool.h"
#import "BLCollege.h"

@interface BLReg2ViewController ()<UIActionSheetDelegate, IBActionSheetDelegate,EditedDelegate,UITextFieldDelegate>{
    
    UITextField *userNameField;
    NSArray *titles;
    NSArray *titlesBX;
    
    IBActionSheet *sexAction;
    int sex;
    NSString *birthday;
    NSString *height;
    NSString *school;
    NSString *college;
    NSString *shoes;
    NSString *ballnumber;
    NSString *size;
    
    int weight;
    NSMutableArray *sizeArr;
    NSArray *schools;
    BLSchool *mySchool;
    NSArray *collegss;
}

@end

@implementation BLReg2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titles = @[@"性别",@"生日",@"身高",@"体重",@"球号",@"学校",@"院系",@"球鞋",@"尺码"];
    titlesBX = @[@"",@"",@"",@"",@"",@"（必选）",@"（必选）",@"",@""];
//    titles1 = @[@"男",@"1987年08月12日",@"187cm",@"75kg"];
    [self initBackground];
    
    NSData *data = [[BLUtils globalCache]dataForKey:@"schools"];
    schools = [BLSchool parseJsonToArray:data];
}

-(void)initBackground {
    
    [self addLeftNavItem:@selector(dimiss)];
    
    /* 输入框背景图 */
    UIImage *image = [[UIImage imageNamed:@"textBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    if (iPhone5) {
        scrollView.frame = iPhone5_frame;
        scrollView.contentSize = CGSizeMake(320, 548+44*2);
    }else{
        scrollView.frame = iPhone4_frame;
        scrollView.contentSize = CGSizeMake(320, 460+44*3);
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 280, 44)];
    imageView.image = image;
    [scrollView addSubview:imageView];
    
    userNameField = [[BLTextField alloc]initWithFrame:CGRectMake(30, 20+6, 230, 32)];
    userNameField.font = [UIFont boldSystemFontOfSize:17.0f];
    userNameField.backgroundColor = [UIColor clearColor];
    userNameField.textColor = [UIColor grayColor];
    userNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [userNameField setReturnKeyType:UIReturnKeyDone];
    userNameField.delegate = self;
    userNameField.placeholder = @"请输入真实姓名";
    [scrollView addSubview:userNameField];
    
    UILabel *tips = [[UILabel alloc]initWithFrame:CGRectMake(20, 66, 280, 19)];
    tips.backgroundColor = [UIColor clearColor];
    tips.font = [UIFont boldSystemFontOfSize:13.0f];
    tips.text = @"真实姓名填写后不可更改";
    tips.textColor = [UIColor grayColor];
    
    [scrollView addSubview:tips];
    
    int yplus = 0;
    for (int i=0; i<9; i++) {
        
        if (i == 5) {
            yplus = 14;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 90+(i*44+i*2)+yplus, 280, 44);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(additions:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [scrollView addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+14, 90+6+(i*32+i*2+i*12)+yplus, 40, 32)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [titles objectAtIndex:i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [scrollView addSubview:titleLabel];
        
        UILabel *bixuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+14+35, 90+6+(i*32+i*2+i*12)+yplus, 70, 32)];
        bixuanLabel.backgroundColor = [UIColor clearColor];
        bixuanLabel.text = [titlesBX objectAtIndex:i];
        bixuanLabel.textColor = [UIColor colorWithHexString:@"#ff5839"];
        bixuanLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [scrollView addSubview:bixuanLabel];
        
        UILabel *additionLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 90+6+(i*32+i*2+i*12)+yplus, 170, 32)];
        additionLabel.backgroundColor = [UIColor clearColor];
        
        additionLabel.textAlignment = UITextAlignmentRight;
        additionLabel.textColor = [UIColor whiteColor];
        additionLabel.font = [UIFont systemFontOfSize:16.0f];
        additionLabel.tag = 100+i;
        
        [scrollView addSubview:additionLabel];
    }
    _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitButton.frame = CGRectMake(20, 100+6+(9*32+9*2+9*12)+yplus, 280, 44);
    [_commitButton commitStyle];
    [_commitButton setTitle:@"完成" forState:UIControlStateNormal];
    [scrollView addSubview:_commitButton];
    [_commitButton addTarget:self action:@selector(doFinish:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scrollView];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [userNameField resignFirstResponder];
    return YES;
}// called when 'return' key pressed. return NO to ignore

-(void)dimiss{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)additions:(UIButton *)button{
    
    BLEditSecondViewController *second = [[BLEditSecondViewController alloc]initWithNibName:@"BLEditSecondViewController" bundle:nil];
    second.isCommit = @"";
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
    UILabel *collegeLabel = (UILabel *)[self.view viewWithTag:106];
    collegeLabel.text = @"" ;
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
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
}

-(void)didEditCondition:(NSString *)result tag:(NSString *)tag{
    
    if ([tag isEqualToString:@"height"]) {
        UILabel *heightLabel = (UILabel *)[self.view viewWithTag:102];
        heightLabel.text = [NSString stringWithFormat:@"%@CM",result];
        float heightF = [result floatValue]/100;
        height = [NSString stringWithFormat:@"%0.2f",heightF];
    }else if ([tag isEqualToString:@"weight"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:103];
        weight = [result intValue];
        weightLabel.text = [NSString stringWithFormat:@"%@KG",result];
    }else if ([tag isEqualToString:@"ballnumber"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:104];
        ballnumber = result;
        weightLabel.text = [NSString stringWithFormat:@"%@号",result];
    }else if ([tag isEqualToString:@"school"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:105];
        weightLabel.text = [NSString stringWithFormat:@"%@",result];
        school = result;
    }else if ([tag isEqualToString:@"college"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:106];
        weightLabel.text = [NSString stringWithFormat:@"%@",result];
        college = result;
    }else if ([tag isEqualToString:@"shoes"]){
        UILabel *weightLabel = (UILabel *)[self.view viewWithTag:107];
        weightLabel.text = [NSString stringWithFormat:@"%@",result];
        shoes = result;
    }
}

- (IBAction)setDatePick:(id)sender {
    self.selectedDate = [NSDate date];
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
    if (buttonIndex == 0) {
        sexLabel.text = @"男";
        sex = 1;
    }else if (buttonIndex == 1){
        sexLabel.text = @"女";
        sex = 2;
    }
}

/*参数	类型	必选	默认值	说明	示例
 uid	int	true		注册用户主键索引
 realname	varchar	true		真实姓名
 sex	varchar	false		性别	男
 birth	varchar	false		生日	1983-01-02
 height	varchar	false		身高	1.81
 weight	varchar	false		体重	83
 ballnumber	varchar	false		球号	11*/
-(void)registerUser{
    
//    NSString *uid = [[BLUtils globalCache]stringForKey:@"uid"];
    
    /*uid	int	true		注册用户主键索引
     realname	varchar	true		真实姓名
     sex	int	false		性别	男:1 女:2
     birth	varchar	false		生日	1983-01-02
     height	varchar	false		身高	1.81
     weight	varchar	false		体重	83
     ballnumber	varchar	false		球号	11
     school	int	false		学校序号
     college	int	false		院系序号
     shoes	varchar	false		球鞋
     size	int	false		尺码	（37-42）*/
    
    if (userNameField.text.length < 1) {
        [ShowLoading showErrorMessage:@"请输入真实姓名！" view:self.view];
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"updateuserinfo/?uid=%@&realname=%@&sex=%d&birth=%@&height=%@&weight=%d&ballnumber=%@&school=%@&college=%@&shoes=%@&size=%@",_data.uid,userNameField.text,sex,birthday,height,weight,ballnumber,school,college,shoes,size];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [BLBaseObject globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
//        if (error) {
//            
//        }
//        if (posts.count > 0) {
//            BLBaseObject *base = [posts objectAtIndex:0];
//            if ([base.msg isEqualToString:@"succ"]) {
//                
//                [self dismissModalViewControllerAnimated:YES];
//            }else{
//                [ShowLoading showErrorMessage:base.msg view:self.view];
//            }
//        }
//    } path:path];
    
    [BLPersonData globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        [ShowLoading hideLoading:self.view];
        
        if (error) {
            
        }
        if (posts.count > 0) {
            BLPersonData *personData = [posts objectAtIndex:0];
            if ([personData.msg isEqualToString:@"succ"]) {
                
                [[BLUtils appDelegate]setAPTags:personData.uid];//像服务器发送uid
                
                [[BLUtils globalCache]setString:personData.uid forKey:@"uid"];
                [[BLUtils globalCache]setString:personData.token forKey:@"token"];
                [_delegate initUID:personData];
                [self dismissModalViewControllerAnimated:YES];
                
            }else{
                [ShowLoading showErrorMessage:personData.msg view:self.view];
            }
        }
        
    } path:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)dismissKeyBorad:(id)sender {
    [userNameField resignFirstResponder];
}

- (IBAction)doFinish:(UIButton *)sender {
    [self registerUser];
}
@end
