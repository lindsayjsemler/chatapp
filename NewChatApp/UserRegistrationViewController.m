//
//  UserRegistrationViewController.m
//  NewChatApp
//
//  Created by User on 11/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import "UserRegistrationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface UserRegistrationViewController ()

@end

@implementation UserRegistrationViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Chat App";
    descriptionTextViewObj.layer.borderWidth = 2.0;
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
- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)saveButtonTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    if ([defaults stringForKey:@"user_preference"]) {
    [defaults setValue:[usernameTextFieldObj text] forKey:@"user_preference"];
    //    }
    NSString *url = [NSString stringWithFormat:
                     @"http://chatapp.mygamesonline.org/adduser.php"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    init] ;
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"user=%@&contact=%@&description=%@&email=%@",
                       usernameTextFieldObj.text,
                       contactNumberTextFieldObj.text,descriptionTextViewObj.text,emailidTextFieldObj.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = [[NSError alloc] init] ;
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
    NSDictionary *responseHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
    
    NSLog(@"headers: %@", responseHeaders.description);
    [[NSUserDefaults standardUserDefaults]setValue:[responseHeaders valueForKey:@"userid"] forKey:@"UserId"];
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
    
    
    chatParser = [[NSXMLParser alloc] initWithData:receivedData];
    [chatParser setDelegate:self];
    [chatParser parse];
    
    //    [receivedData release];
    
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    if ( [elementName isEqualToString:@"message"] ) {
        
    }
    if ( [elementName isEqualToString:@"user"] ) {
        
    }
    if ( [elementName isEqualToString:@"text"] ) {
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"%@",string);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ( [elementName isEqualToString:@"message"] ) {
        
    }
    if ( [elementName isEqualToString:@"user"] ) {
        //        inUser = NO;
    }
    if ( [elementName isEqualToString:@"text"] ) {
        //        inText = NO;
    }
}

@end
