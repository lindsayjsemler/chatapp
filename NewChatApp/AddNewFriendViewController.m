//
//  AddNewFriendViewController.m
//  NewChatApp
//
//  Created by User on 11/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import "AddNewFriendViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"

@interface AddNewFriendViewController ()

@end

@implementation AddNewFriendViewController

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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonTapped:(id)sender {
    NSString *url = [NSString stringWithFormat:
                     @"http://chatapp.mygamesonline.org/addFriend.php"];
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"] forKey:@"userid"];
    [request setPostValue:friendText.text forKey:@"email"];
    [request setDelegate:self];
    [request setTag:2];
    [request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
   
        NSString *responseString = [request responseString];
        NSDictionary *resultDictionary = [responseString JSONValue];
        if ([[resultDictionary valueForKey:@"success"] isEqualToString:@"false"]) {
            UIAlertView *alertObj = [[UIAlertView alloc]initWithTitle:@"ChatApp" message:@"Your friend is not using ChatApp" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertObj show];
        }
   
    
    
    // Use when fetching binary data
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}
@end
