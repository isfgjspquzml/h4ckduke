//
//  DAViewController.h
//  DAContextMenuTableViewControllerDemo
//
//  Created by Daria Kopaliani on 7/24/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "DAContextMenuTableViewController.h"
#import "ServerResponse.h"
#import "DetailViewController.h"

@interface DAViewController : DAContextMenuTableViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) ServerResponse *response;

@end
