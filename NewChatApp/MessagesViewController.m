//
//  MessagesViewController.m
//  NewChatApp
//
//  Created by User on 12/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import "MessagesViewController.h"
//#import "ChatListItemCell.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController
@synthesize messagesList;
@synthesize userId;
@synthesize friendsId;
@synthesize chatRoomId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        lastId = 0;
        chatParser = NULL;
    }
    self.chatRoomId = nil;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getNewMessages];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    if (messages.count > 0) {
        return messages.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[self.messagesList
                                                  dequeueReusableCellWithIdentifier:@"ChatListItem"];
    //ChatListItemCell *cell = (ChatListItemCell *)[self.messagesList
    //                                              dequeueReusableCellWithIdentifier:@"ChatListItem"];
    if (cell == nil) {
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatListItem"];
    }
    
    NSDictionary *itemAtIndex = (NSDictionary *)[messages objectAtIndex:indexPath.row];
    //    UILabel *textLabel = (UILabel *)[cell viewWithTag:1];
    //cell.textLabelObject.text = [itemAtIndex objectForKey:@"text"];
    //    UILabel *userLabel = (UILabel *)[cell viewWithTag:2];
    //cell.userLabelObject.text = [itemAtIndex objectForKey:@"user"];
    
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




- (void)getNewMessages {
    NSString *url;
    if (self.chatRoomId) {
        url = [NSString stringWithFormat:
               @"http://chatapp.mygamesonline.org/messages.php?past=%d&t=%ld&chatroomid=%@",
               lastId, time(0),self.chatRoomId];
    }
    if (self.userId && self.friendsId) {
        url = [NSString stringWithFormat:
               @"http://chatapp.mygamesonline.org/messages.php?past=%d&t=%ld&userid=%@&friendsid=%@",
               lastId, time(0),self.userId,self.friendsId];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn)
    {
        receivedData = [NSMutableData data] ;
    }
    else
    {
    }
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (chatParser)
        chatParser = nil;
    
    if ( messages == nil )
        messages = [[NSMutableArray alloc] init];
    
    chatParser = [[NSXMLParser alloc] initWithData:receivedData];
    [chatParser setDelegate:self];
    [chatParser parse];
    
    //    [receivedData release];
    
    [messagesList reloadData];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                [self methodSignatureForSelector: @selector(timerCallback)]];
    [invocation setTarget:self];
    [invocation setSelector:@selector(timerCallback)];
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                         invocation:invocation repeats:NO];
}

- (void)timerCallback {
    //    [timer release];
    timer = nil;
    [self getNewMessages];
}
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    if ( [elementName isEqualToString:@"message"] ) {
        msgAdded = [attributeDict objectForKey:@"added"];
        msgId = [[attributeDict objectForKey:@"id"] intValue];
        msgUser = [[NSMutableString alloc] init];
        msgText = [[NSMutableString alloc] init];
        inUser = NO;
        inText = NO;
    }
    if ( [elementName isEqualToString:@"user"] ) {
        inUser = YES;
    }
    if ( [elementName isEqualToString:@"text"] ) {
        inText = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ( inUser ) {
        [msgUser appendString:string];
    }
    if ( inText ) {
        [msgText appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ( [elementName isEqualToString:@"message"] ) {
        [messages addObject:[NSDictionary dictionaryWithObjectsAndKeys:msgAdded,
                             @"added",msgUser,@"user",msgText,@"text",nil]];
        
        lastId = msgId;
        
        //        [msgAdded release];
        //        [msgUser release];
        //        [msgText release];
        msgAdded = nil;
        msgUser = nil;
        msgText = nil;
    }
    if ( [elementName isEqualToString:@"user"] ) {
        inUser = NO;
    }
    if ( [elementName isEqualToString:@"text"] ) {
        inText = NO;
    }
}
- (IBAction)sendButtonTapped:(id)sender {
    [messagesText resignFirstResponder];
    if ( [messagesText.text length] > 0 ) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *url = [NSString stringWithFormat:
                         @"http://chatapp.mygamesonline.org/add.php"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                        init] ;
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        if (self.chatRoomId) {
            [body appendData:[[NSString stringWithFormat:@"user=%@&message=%@&chatroomid=%@",
                               [defaults stringForKey:@"user_preference"],
                               messagesText.text,self.chatRoomId] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        if (self.userId && self.friendsId) {
            [body appendData:[[NSString stringWithFormat:@"user=%@&message=%@&userid=%@&friendsid=%@",
                               [defaults stringForKey:@"user_preference"],
                               messagesText.text,self.userId,self.friendsId] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [request setHTTPBody:body];
        
        NSHTTPURLResponse *response = nil;
        NSError *error = [[NSError alloc] init] ;
        [NSURLConnection sendSynchronousRequest:request
                              returningResponse:&response error:&error];
        
        [self getNewMessages];
    }
    
    messagesText.text = @"";
}
@end
