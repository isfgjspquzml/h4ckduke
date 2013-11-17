//
//  DADemoCell.h
//  DAContextMenuTableViewControllerDemo
//
//  Created by Daria Kopaliani on 10/8/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAContextMenuCell.h"


@interface DADemoCell : DAContextMenuCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *tagsLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *notesLabel;
@property (strong, nonatomic) IBOutlet UIButton *archiveButton;
@property (strong, nonatomic) IBOutlet UIButton *remindButton;

@end