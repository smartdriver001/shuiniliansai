//
//  BLMyTeamDitViewController.m
//  BasketballLeague
//
//  Created by 崔洪禄 on 14-3-2.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMyTeamDitViewController.h"
#import "UIImageView+WebCache.h"
#import "BLMyteamImages.h"
#import "BLMy_teamMembers.h"
#import "UIColor+Hex.h"
#import "BLMyTeamDitCell.h"
#import "BLMyTeamDitCell1.h"
#import "BLTeamNameViewController.h"
#import "BLBaseObject.h"
#import "IBActionSheet.h"
#import "BLRoleAlertViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface BLMyTeamDitViewController ()<UITableViewDataSource,UITableViewDelegate,BLTeamNameVCDelegate,IBActionSheetDelegate,ResultClickDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView * _tableView;
    NSString * role;
    IBActionSheet *roleAction;
    
    float navHigh;
}

@property (nonatomic,strong)NSMutableArray * ditArray;

@end

@implementation BLMyTeamDitViewController

@synthesize request;

@synthesize ditArray;

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
    self.ditArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc]init];
    
//    NSString * nav = [[BLUtils globalCache]stringForKey:@"navigation"];
//    if ([nav isEqualToString:@"noNav"]) {
//        if (ios7) {
//            navHigh = 64;
//        }else{
//            navHigh = 44;
//        }
//        [self addNavBar];
//        [self addNavBarTitle:@"资料修改" action:nil];
//        [self addLeftNavBarItem:@selector(leftButtonClick)];
//        
//        _tableView.frame = [BLUtils frame];
//        
//    }else{
//        navHigh = 0;
//        
//        [self addLeftNavItemAndTextImg:@"" Text:@"取消" :@selector(leftButtonClick)];
//        
//        [self addNavText:@"资料修改" action:nil];
//        
//        if (iPhone5) {
//            _tableView.frame = iPhone5_frame;
//        }else{
//            _tableView.frame = iPhone4_frame;
//        }
//    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        if (ditArray.count > 0) {
            BLData * data = [ditArray objectAtIndex:0];
            CGSize size = [data.intro sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(235, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            return size.height + 68 +20;
        }else{
            return 68;
        }
    }else{
        return 46;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        BLMyTeamDitCell1 * cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell1 == nil) {
            cell1 = [[BLMyTeamDitCell1 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        }
        cell1.backgroundColor = [UIColor clearColor];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell1 setData:ditArray :indexPath];
        return cell1;
    }else{
        BLMyTeamDitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[BLMyTeamDitCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData:ditArray :indexPath];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 2) {
        BLTeamNameViewController * teamNameView = [[BLTeamNameViewController alloc]init];
        BLData * data = [ditArray objectAtIndex:0];
        teamNameView.blData = data;
        teamNameView.delegate = self;
        if (indexPath.row == 0) {
            [teamNameView setData:@"球队名称"];
        }else if (indexPath.row == 1){
            [teamNameView setData:@"球队口号"];
        }else if (indexPath.row == 2){
//            [teamNameView setData:@"我的角色"];
            
            
        }else if (indexPath.row == 3){
            [teamNameView setData:@"球队介绍"];
        }
        [self.navigationController pushViewController:teamNameView animated:YES];
    }else{
        [self showRolesAction];
    }
}

-(void)showRolesAction{
    BLData * data = [ditArray objectAtIndex:0];
    BLMy_teamMembers * member = [ditArray objectAtIndex:1];
    BLRoleAlertViewController *roleAlert = [[BLRoleAlertViewController alloc]initWithNibName:nil bundle:nil];
    roleAlert.delegate = self;
    roleAlert.role = member.role;
    roleAlert.blData = data;
    [self presentPopupViewController:roleAlert animationType:MJPopupViewAnimationSlideBottomBottom];
//    roles = @[@"前锋",@"中锋",@"后卫",@"替补"];
//    roleAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesArray:roles];
//    [roleAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#55585f"]];
//    [roleAction setFont:[UIFont boldSystemFontOfSize:16.0f]];
//    [roleAction setButtonTextColor:[UIColor whiteColor]];
//    [roleAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#ac3726"] forButtonAtIndex:roles.count];
//    
//    [roleAction showInView:self.navigationController.view];
    
}

-(void)didClickWhenCommit:(NSString *)result{
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    
    if (result == nil) {
        return;
    }
    BLMy_teamMembers * member = [ditArray objectAtIndex:1];
    [member setRole:result];
    [ditArray replaceObjectAtIndex:1 withObject:member];
    [_tableView reloadData];
}

-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex >= roles.count) {
        return;
    }
    
    if (buttonIndex == 0) {
        [self openCamera];
    }else if (buttonIndex == 1){
        [self openPics];
    }
}

// 打开相机
- (void)openCamera {
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        [ShowLoading showErrorMessage:@"无摄像头！" view:self.view];
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        }];
   
}


// 打开相册
- (void)openPics {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;

    [self presentViewController:imagePicker animated:YES completion:^{
        }];
    
}

// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@", info);
    //    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:101];
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }

    NSString *mfilePath = [NSString stringWithFormat:@"photo.jpg"];
    
    UIImage *tempImage = [self scaleImage:image toScale:0.3];
    iconImage = tempImage;
    [self saveImage:tempImage WithName:mfilePath];
    
    [self upload];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)upload{
    
    BLData * data = [ditArray objectAtIndex:0];
    
    NSString *path  = [NSString stringWithFormat:@"%@team_icon/",base_url];
    
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:path]];
	[request setPostValue:data.teamid forKey:@"tid"];
    
    [request setTimeOutSeconds:60];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
    //	[request setUploadProgressDelegate:progressIndicator];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(uploadFailed:)];
	[request setDidFinishSelector:@selector(uploadFinished:)];

    [request setFile:filePath forKey:[NSString stringWithFormat:@"Teams[file]"]];
    
	[request startAsynchronous];
    
}

- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{
	[ShowLoading showErrorMessage:@"上传失败!" view:self.view];
}

- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
    [ShowLoading showSuccView:self.view message:@"上传成功！"];
    iconImageView.image = iconImage;
    
    [_delegate reloadMyTeamDetail];
    //    CXPhoto *photo = [[CXPhoto alloc]initWithFilePath:filePath];
    //    [self.photoDataSource addObject:photo];
    //    [self.browser reloadData];
    
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(tempImage,.50f);
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    filePath = fullPathToFile;
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}


// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)rightButtonClickWithText:(NSString *)text :(int)index
{
    if (ditArray.count > 0) {
        BLData * data = [ditArray objectAtIndex:0];
        if (index == 0) {
            data.teamname = text;
        }else if (index == 1){
            data.slogan = text;
        }else if (index == 3){
            data.intro = text;
        }
        
        [_tableView reloadData];
        
        [_delegate reloadMyTeamDetail];
    }
}

-(void)setData:(BLData *)data :(BLMy_teamMembers *)myMember :(NSString *)imageUrl
{
    NSString *home = [[BLUtils globalCache]stringForKey:@"home"];
    NSString *whose = [[BLUtils globalCache]stringForKey:@"whose"];
    
    if ([whose isEqualToString:@"TA的"]) {
        if ([home isEqualToString:@""]) {
            if (iPhone5) {
                _tableView.frame = iPhone5_frame;
            }else{
                _tableView.frame = iPhone4_frame;
            }
            navHigh = 0;
            
            [self addLeftNavItemAndTextImg:@"" Text:@"取消" :@selector(leftButtonClick)];
            self.title = @"资料修改";
//            [self addNavText:@"资料修改" action:nil];
        }else{
//            [self addNavBar];
//            [self addNavBarTitle:@"战队等级" action:nil];
//            [self addLeftNavBarItem:@selector(leftButtonClick)];
            if (ios7) {
                navHigh = 64;
            }else{
                navHigh = 44;
            }
            [self addNavBar];
            [self addNavBarTitle:@"资料修改" action:nil];
            [self addLeftNavBarItem:@selector(leftButtonClick)];
            
            _tableView.frame = [BLUtils frame1];
        }
        
    }else{
        
        if (iPhone5) {
            _tableView.frame = iPhone5_frame;
        }else{
            _tableView.frame = iPhone4_frame;
        }
        navHigh = 0;
        
        [self addLeftNavItemAndTextImg:@"" Text:@"取消" :@selector(leftButtonClick)];
        self.title = @"资料修改";
        
//        [self addNavText:@"资料修改" action:nil];

    }
    
    UIView * iconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 128)];
    iconView.backgroundColor = [UIColor clearColor];
    
    iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 14, 100, 100)];
    [iconImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    iconImageView.backgroundColor = [UIColor colorWithHexString:@"1E2023"];
    [iconView addSubview:iconImageView];
    
    UIButton * iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    iconButton.frame = CGRectMake(110, 14, 100, 100);
    iconButton.backgroundColor = [UIColor clearColor];
    [iconButton addTarget:self action:@selector(iconButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [iconView addSubview:iconButton];
    
    _tableView.tableHeaderView = iconView;
    
    [ditArray addObject:data];
    [ditArray addObject:myMember];
    
    [_tableView reloadData];
}

-(void)iconButtonClick
{
    [self showTakePicAction];
}

-(void)showTakePicAction{
    
    roles = @[@"照相机",@"相册"];
    roleAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesArray:roles];
    [roleAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#55585f"]];
    [roleAction setButtonTextColor:[UIColor whiteColor]];
    [roleAction setButtonBackgroundColor:[UIColor colorWithHexString:@"#ac3726"] forButtonAtIndex:roles.count];
    
    [roleAction showInView:self.navigationController.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
