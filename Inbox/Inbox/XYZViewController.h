//
//  XYZViewController.h
//  Inbox
//
//  Created by Intern on 11/16/13.
//  Copyright (c) 2013 Jeff Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UISegmentedControl *statusOpt;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end