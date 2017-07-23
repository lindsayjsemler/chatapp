//
//  AddNewChatRoomViewController.m
//  NewChatApp
//
//  Created by User on 11/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import "AddNewChatRoomViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@interface AddNewChatRoomViewController ()

@end

@implementation AddNewChatRoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Chat App"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)addButtonTapped:(id)sender {
    [chatRoomName resignFirstResponder];
    NSString *url = [NSString stringWithFormat:
                     @"http://chatapp.mygamesonline.org/createChatRoom.php"];
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:chatRoomName.text forKey:@"roomname"];
    [request setDelegate:self];
    [request setTag:2];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
        NSString *responseString = [request responseString];
        NSDictionary *resultDictionary = [responseString JSONValue];
        if ([[resultDictionary valueForKey:@"success"] isEqualToString:@"false"]) {
            UIAlertView *alertObj = [[UIAlertView alloc]initWithTitle:@"ChatApp" message:@"Error occured" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertObj show];
        }
    
    // Use when fetching binary data
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}

@end
