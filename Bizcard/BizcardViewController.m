//
//  BizcardViewController.m
//  Bizcard
//
//  Created by Tianyu Shi on 11/17/13.
//  Copyright (c) 2013 InTouch. All rights reserved.
//
#import "BizcardViewController.h"
#import "AVCamCaptureManager.h"
#import "AVCamRecorder.h"
#import <AVFoundation/AVFoundation.h>

@interface BizcardViewController ()
@end

@implementation BizcardViewController
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"captureManager.videoInput.device.focusMode"];
	[self.captureManager release];
    [self.captureVideoPreviewLayer release];
    [self.header release];
    [self.subheader release];
    [self.videoPreviewView release];
	[self.snapButton release];
	
    [super dealloc];
}
- (void)viewDidLoad
{
    [self shadeLabel:self.header];
    [self shadeLabel:self.subheader];
    
    
    if (self.captureManager == nil) {
		AVCamCaptureManager* manager = [[AVCamCaptureManager alloc] init];
		[self setCaptureManager:manager];
		[manager release];
		
		//[self.captureManager setDelegate:self];

		if (self.captureManager.setupSession) {
            // Create video preview layer and add it to the UI
            AVCaptureVideoPreviewLayer*newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureManager.session];
            UIView* view = self.videoPreviewView;
			CALayer* viewLayer = view.layer;
			//[viewLayer setMasksToBounds:YES];
            
			CGRect bounds = view.bounds;
			[newCaptureVideoPreviewLayer setFrame:bounds];
            
			[newCaptureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
			
			[viewLayer insertSublayer:newCaptureVideoPreviewLayer
                                below:[viewLayer.sublayers objectAtIndex:0]];

			[self setCaptureVideoPreviewLayer:newCaptureVideoPreviewLayer];
            [newCaptureVideoPreviewLayer release];

            // Start the session. This is done asychronously since -startRunning doesn't return until the session is running.
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
				[[self.captureManager session] startRunning];
			});
		}
	}
    
    
    [super viewDidLoad];
}

-(void) shadeLabel:(UILabel*)label {
    label.layer.shadowColor = [[UIColor blackColor] CGColor];
	label.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
	label.layer.shadowOpacity = 1.0f;
	label.layer.shadowRadius = 1.0f;
}

-(IBAction)captureStillImage:(id)sender {
    // Capture a still image
    @try {
        [self.captureManager captureStillImage];
    }
    @catch(NSException* iae) {
        NSLog(@"%@", iae.reason);
    }
    
    // Flash the screen white and fade it out to give UI feedback that a still image was taken
    UIView *flashView = [[UIView alloc] initWithFrame:self.view.frame];
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [self.view.window addSubview:flashView];
    [UIView animateWithDuration:.4f
                     animations:^{
                         [flashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         [flashView removeFromSuperview];
                         [flashView release];
                     }
     ];
}
@end