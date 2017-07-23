//
//  UserRegistrationViewController.h
//  NewChatApp
//
//  Created by User on 11/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegistrationViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate>
{
    IBOutlet UITextField *usernameTextFieldObj;
    
    IBOutlet UITextField *emailidTextFieldObj;
    IBOutlet UITextField *contactNumberTextFieldObj;
    IBOutlet UITextView *descriptionTextViewObj;
    
    NSXMLParser *chatParser;
    NSMutableData *receivedData;
    
}
- (IBAction)saveButtonTapped:(id)sender;

@end
