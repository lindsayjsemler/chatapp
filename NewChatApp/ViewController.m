//
//  ViewController.m
//  NewChatApp
//
//  Created by User on 09/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import "ViewController.h"
#import "UserRegistrationViewController.h"
#import "ChatRoomViewController.h"
#import "FriendsListViewController.h"
#import "AddNewFriendViewController.h"
#import "AddNewChatRoomViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Chat App";
    listDataArray = [[NSMutableArray alloc]initWithObjects:@"User Registration",@"Friends Chat",@"Chat Room",@"Add new friend",@"Add new chat room", nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (listDataArray.count > 0) {
        return listDataArray.count;
    }
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [listDataArray objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UserRegistrationViewController *obj = [[UserRegistrationViewController alloc]initWithNibName:@"UserRegistrationViewController" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    if(indexPath.row == 1){
        FriendsListViewController *obj = [[FriendsListViewController alloc]initWithNibName:@"FriendsListViewController" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    if (indexPath.row == 2) {
        ChatRoomViewController *obj = [[ChatRoomViewController alloc]initWithNibName:@"ChatRoomViewController" bundle:nil];
        [obj getChatRoomsList];
        [self.navigationController pushViewController:obj animated:YES];
    }
    if (indexPath.row == 3) {
        AddNewFriendViewController *obj = [[AddNewFriendViewController alloc]initWithNibName:@"AddNewFriendViewController" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    if (indexPath.row == 4) {
        AddNewChatRoomViewController *obj = [[AddNewChatRoomViewController alloc]initWithNibName:@"AddNewChatRoomViewController" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
