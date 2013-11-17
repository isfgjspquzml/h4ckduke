//
//  DetailViewController.h
//  DAContextMenuTableViewControllerDemo
//
//  Created by Tianyu Shi on 11/16/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate>

@property (strong, atomic) IBOutlet UITextField *firstName;
@property (strong, atomic) IBOutlet UITextField *lastName;
@property (strong, atomic) IBOutlet UITextField *companyField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *primaryEmail;
@property NSString* picUrl;
@property (strong, nonatomic) IBOutlet UITextField *tags;
@property (strong, nonatomic) IBOutlet UITextView *notes;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;

@property (strong,nonatomic) Utility* utility;

- (IBAction)saveButtonTapped:(UIButton*)sender;
- (IBAction)editingDidBegin:(id)sender;
- (IBAction)touchUpOutside:(id)sender;

@end
