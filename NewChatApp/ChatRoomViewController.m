//
//  ChatRoomViewController.m
//  NewChatApp
//
//  Created by User on 11/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MessagesViewController.h"

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Chat App";
    chatRoomsList = [[NSMutableArray alloc]init];
//    [self getChatRoomsList];
//    [chatRoomsList addObject:@"Science"];
//    [chatRoomsList addObject:@"Entertainment"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)getChatRoomsList {
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"]) {
        return;
    }
    NSURL *url = [NSURL URLWithString:@"http://chatapp.mygamesonline.org/fetchAllChatRooms.php"];
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request setTag:1];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data

        NSString *responseStringObj = [request responseString];
        NSDictionary *resultDictionary = [responseStringObj JSONValue];
        chatRoomsList = [resultDictionary objectForKey:@"data"];
        NSLog(@"%d",[chatRoomsList count]);
        [chatRoomList reloadData];

    
    
    
    
    // Use when fetching binary data
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(chatRoomsList.count > 0)
    {
        return chatRoomsList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[chatRoomsList objectAtIndex:indexPath.row] objectForKey:@"chatroomname"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempDic = [chatRoomsList objectAtIndex:indexPath.row];
    MessagesViewController *obj = [[MessagesViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
    obj.chatRoomId = [tempDic objectForKey:@"id"];
    [[self navigationController]pushViewController:obj animated:YES];
}

@end
