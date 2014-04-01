//
//  BLMessageViewController.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-18.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLMessageViewController.h"
#import "BLReadMsgViewController.h"
#import "BLConfirmViewController.h"
#import "BLMessageCell.h"
#import "BLMessage.h"

@interface BLMessageViewController (){
    NSMutableArray *dataSource;
    CGSize size;
}

@end

@implementation BLMessageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundDarkGray"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.clearsSelectionOnViewWillAppear = NO;
 
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    dataSource = [NSMutableArray arrayWithObjects:@"fdsafa",@"fdsafa",@"fdsafa",@"fdsafa",@"fdsafa",@"fdsafa", nil];//@[@"fdsafa",@"fdsafa",@"fdsafa",@"fdsafa",@"fdsafa",@"fdsafa"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addLeftNavItem];
    
}

-(void)requestData:(NSString *)uid{
    
    NSString *path = [NSString stringWithFormat:@"message/?uid=%@",uid];
    [BLMessage globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            return ;
        }
        if (posts.count>0) {
            BLMessage *message = [posts objectAtIndex:0];
            if ([message.msg isEqualToString:@"succ"]) {
                
            }else{
                
            }
        }
    } path:path];
}

- (void)addLeftNavItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (ios7) {
        btn.frame = CGRectMake(0, 0, 25, 25);
    }else{
        btn.frame = CGRectMake(12, 9.5, 25, 25);
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:@"back_normal@2x"]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_selected@2x"]
                   forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item;
    UIView *view;
    if (!ios7) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
        view.backgroundColor = [UIColor clearColor];
        [view addSubview:btn];
        item = [[UIBarButtonItem alloc] initWithCustomView:view];
    }else{
        item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    self.navigationItem.leftBarButtonItem = item;

}
-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BLMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    [cell initData:@"证书是密钥对的非秘密的部分。将它发送给其它人是安全的，比如通过SSL通讯的过程中就会包含证书。然而，对于私钥，当然是私有的。它是秘密的。你的私钥只对你有用，对其他人没用。要重视的是：如果你没有私钥的话，就无法使用证书。"];
    
    // Configure the cell...
//    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
//    [[cell textLabel] setFont:[UIFont systemFontOfSize:14.0f]];
//    [[cell textLabel] setText:[dataSource objectAtIndex:indexPath.row]];
//    cell.imageView.image = [UIImage imageNamed:@"first_normal.png"];;
//    cell.accessoryType =UITableViewCellAccessoryDetailDisclosureButton;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [dataSource removeObjectAtIndex:indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = @"证书是密钥对的非秘密的部分。将它发送给其它人是安全的，比如通过SSL通讯的过程中就会包含证书。然而，对于私钥，当然是私有的。它是秘密的。你的私钥只对你有用，对其他人没用。要重视的是：如果你没有私钥的话，就无法使用证书。";
    
    size = [str sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(320-36, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    
    return size.height+60;
    
//    return 100;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [self performSelector:@selector(push:) withObject:indexPath afterDelay:.25f];
}

-(void)push:(NSIndexPath *)indexPath{
    
    UIViewController *detailViewController ;
    
    if (indexPath.row % 2 == 0) {
        detailViewController = [[BLReadMsgViewController alloc] initWithNibName:@"BLReadMsgViewController" bundle:nil];
        detailViewController.title = @"消息名称";
    }else{
        detailViewController = [[BLConfirmViewController alloc] initWithNibName:@"BLConfirmViewController" bundle:nil];
        detailViewController.title = @"入队消息";
    }
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
