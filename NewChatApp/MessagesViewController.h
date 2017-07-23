//
//  MessagesViewController.h
//  NewChatApp
//
//  Created by User on 12/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesViewController : UIViewController
{
    
    IBOutlet UITextField *messagesText;
    IBOutlet UITableView *messagesList;
    NSMutableData *receivedData;
    NSMutableArray *messages;
    int lastId;
    
    NSTimer *timer;
    
    NSXMLParser *chatParser;
    NSString *msgAdded;
    NSMutableString *msgUser;
    NSMutableString *msgText;
    int msgId;
    Boolean inText;
    Boolean inUser;
}
@property (nonatomic,retain) UITableView *messagesList;
@property (nonatomic,retain) NSString *friendsId;
@property (nonatomic,retain) NSString *userId;
@property (nonatomic,retain) NSString *chatRoomId;
- (IBAction)sendButtonTapped:(id)sender;
@end
