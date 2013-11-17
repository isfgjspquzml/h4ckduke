//
//  DetailViewController.m
//  DAContextMenuTableViewControllerDemo
//
//  Created by Tianyu Shi on 11/16/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate>

@property NSInteger fieldID;
@property NSString* userId;

@end

@implementation DetailViewController

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
    [_notes scrollRectToVisible:CGRectMake(0,0,1,1) animated:YES];
    _fieldID = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonTapped:(UIButton*)sender {
    NSString* text = @"";
    _userId = @"313131313131313131313131";
    
    if([[sender currentTitle] isEqualToString:@"Add"]) {
        text = @"Are you sure you would like to add the following profile?";
    } else {
        text = @"Are you sure you would like to make the following changes?";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Changes"
                                                    message:text
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        NSLog(@"Don't make changes");
    }
    else
    {
        NSLog(@"Make changes");
        Utility* httpSend = [Utility initWithStringfirstName:[self.firstName text]
                                                             lastName:[self.lastName text]
                                                              company:[self.companyField text]
                                                                 tags:[self.tags text]
                                                                notes:[self.notes text]
                                                               status:@"inbox"
                                                      picUrl:self.picUrl
                                                                email:[self.primaryEmail text]
                                                          phoneNumber:[self.phoneNumber text]
                                                       userId:_userId];
        
    }
}

- (IBAction)editingDidBegin:(id)sender {
    if ([sender isEqual:_firstName]) {
        _fieldID = 0;
    } else if([sender isEqual:_lastName]) {
        _fieldID = 1;
    } else if([sender isEqual:_companyField]) {
        _fieldID = 2;
    } else if([sender isEqual:_phoneNumber]) {
        _fieldID = 3;
    } else if([sender isEqual:_primaryEmail]) {
        _fieldID = 4;
    } else if([sender isEqual:_tags]) {
        _fieldID = 5;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)keyboardWillShow {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    
    // Animate the current view out of the way
    
    if (_fieldID == 0) {}
    else if (_fieldID == 1) {}
    else if (_fieldID == 2) {}
    else if (_fieldID == 3) {}
    else if (_fieldID == 4) {
        rect.origin.y -= 120;
        rect.size.height += 120;
    } else if (_fieldID == 5) {
        rect.origin.y -= 170;
        rect.size.height += 170;
    } else {
        rect.origin.y -= 220;
        rect.size.height += 220;
    }
    
    self.view.frame = rect;
    [UIView commitAnimations];
}

-(void)keyboardWillHide {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    
    // Animate the current view out of the way
    
    if (_fieldID == 0) {}
    else if (_fieldID == 1) {}
    else if (_fieldID == 2) {}
    else if (_fieldID == 3) {}
    else if (_fieldID == 4) {
        rect.origin.y += 120;
        rect.size.height -= 120;
    } else if (_fieldID == 5) {
        rect.origin.y += 170;
        rect.size.height -= 170;
    } else {
        rect.origin.y += 220;
        rect.size.height -= 220;
    }
    
    self.view.frame = rect;
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

@end
