//
//  BizcardViewController.h
//  Bizcard
//
//  Created by Tianyu Shi on 11/17/13.
//  Copyright (c) 2013 InTouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCamCaptureManager, AVCamPreviewView, AVCaptureVideoPreviewLayer;

@interface BizcardViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
}

@property (nonatomic,retain) AVCamCaptureManager *captureManager;
@property (nonatomic,retain) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) IBOutlet UILabel *header;
@property (strong, nonatomic) IBOutlet UILabel *subheader;
@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;
@property (strong, nonatomic) IBOutlet UIButton *snapButton;


- (IBAction)captureStillImage:(id)sender;

@end
