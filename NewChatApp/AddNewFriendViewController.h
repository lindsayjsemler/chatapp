//
//  AddNewFriendViewController.h
//  NewChatApp
//
//  Created by User on 11/11/13.
//  Copyright (c) 2013 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewFriendViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *friendText;
    
}
- (IBAction)addButtonTapped:(id)sender;
@end
