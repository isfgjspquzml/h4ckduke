//
//  DAViewController.m
//  DAContextMenuTableViewControllerDemo
//
//  Created by Daria Kopaliani on 7/24/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAViewController.h"

#import "DAContextMenuCell.h"
#import "DADemoCell.h"

#import "ServerResponse.h"

@interface DAViewController () <DAContextMenuCellDataSource, DAContextMenuCellDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (assign, nonatomic) NSInteger rowsCount;
@property NSInteger statusSelected;

@end


@implementation DAViewController
{
    NSMutableArray<Utility>* people;
    NSMutableArray<Utility>* peopleArchive;
    NSMutableArray<Utility>* peopleInbox;
    NSMutableArray<Utility>* peopleLater;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Inbox";
    
    peopleArchive = [NSMutableArray array];
    peopleInbox = [NSMutableArray array];
    peopleLater = [NSMutableArray array];
    
    NSString *url=@"http://dukeintouch.cloudapp.net:3000/api/contacts";
    self.response = [[ServerResponse alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        NSLog(@"response: %@", self.response);
        people = (NSMutableArray<Utility> *) self.response.response;
        for(int i=0; i<[people count]; i++) {
            if([[[people objectAtIndex:i] status] isEqualToString:@"archive"]) {
                [peopleArchive addObject:[people objectAtIndex:i]];
            }
            if([[[people objectAtIndex:i] status] isEqualToString:@"inbox"]) {
                [peopleInbox addObject:[people objectAtIndex:i]];
            }
            if([[[people objectAtIndex:i] status] isEqualToString:@"later"]) {
                [peopleLater addObject:[people objectAtIndex:i]];
            }
        }
        [self.myTableView reloadData];
    }];
    
    _statusSelected = 1;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    peopleArchive = [NSMutableArray array];
    peopleInbox = [NSMutableArray array];
    peopleLater = [NSMutableArray array];
    
    NSString *query = [searchBar text];
    NSString *userId = @"313131313131313131313131";
    NSString *url=[[NSString alloc] initWithFormat:@"http://dukeintouch.cloudapp.net:3000/api/contacts/search?term=%@&userId=%@", query, userId];
    self.response = [[ServerResponse alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        NSLog(@"response: %@", self.response);
        people = (NSMutableArray<Utility> *) self.response.response;
        for(int i=0; i<[people count]; i++) {
            if([[[people objectAtIndex:i] status] isEqualToString:@"archive"]) {
                [peopleArchive addObject:[people objectAtIndex:i]];
            }
            if([[[people objectAtIndex:i] status] isEqualToString:@"inbox"]) {
                [peopleInbox addObject:[people objectAtIndex:i]];
            }
            if([[[people objectAtIndex:i] status] isEqualToString:@"later"]) {
                [peopleLater addObject:[people objectAtIndex:i]];
            }
        }

        [self.myTableView reloadData];
    }];
}

#pragma mark - Private

- (void)setRowsCount:(NSInteger)rowsCount
{
    if (rowsCount < 0) {
        _rowsCount = 0;
    } else {
        _rowsCount = rowsCount;
    }
}

#pragma mark * Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.segmentedControl.selectedSegmentIndex == 0){
        return [peopleArchive count];
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        return [peopleInbox count];
    } else {
        return [peopleLater count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DADemoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString* space = @" ";
    
    NSMutableArray *toCheck = [NSMutableArray array];
    
    if(_statusSelected == 0) {
        toCheck = peopleArchive;
    } else if (_statusSelected == 1){
        toCheck = peopleInbox;
    } else{
        toCheck = peopleLater;
    }
    
    NSString* firstName =[[[toCheck objectAtIndex:indexPath.row] firstName] stringByTrimmingCharactersInSet: [NSCharacterSet symbolCharacterSet]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@%@%@", firstName, space,[[toCheck objectAtIndex:indexPath.row] lastName]];
    NSString* url =[[toCheck objectAtIndex:indexPath.row]  picUrl];
    NSError* error = nil;
    NSData*imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:0 error:&error];
    cell.imageView.image = [UIImage imageWithData:imageData];
    cell.tagsLabel.text = [[[toCheck objectAtIndex:indexPath.row] tags] componentsJoinedByString:@", "];
    
    cell.notesLabel.text = [[toCheck objectAtIndex:indexPath.row] notes];
    
    cell.dataSource = self;
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.;
}

#pragma mark * DAContextMenuCell data source

    - (NSUInteger)numberOfButtonsInContextMenuCell:(DAContextMenuCell *)cell
    {
        return 2;
    }
    
    - (UIButton *)contextMenuCell:(DAContextMenuCell *)cell buttonAtIndex:(NSUInteger)index
    {
        DADemoCell *demoCell = [cell isKindOfClass:[DADemoCell class]] ? (DADemoCell *)cell : nil;
        switch (index) {
            case 0: return demoCell.remindButton;
        case 1: return demoCell.archiveButton;
        default: return nil;
    }
}

- (DAContextMenuCellButtonVerticalAlignmentMode)contextMenuCell:(DAContextMenuCell *)cell alignmentForButtonAtIndex:(NSUInteger)index
{
    return DAContextMenuCellButtonVerticalAlignmentModeCenter;
}

-(IBAction)statusSelected:(id)sender{
    _statusSelected = [sender selectedSegmentIndex];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[DetailViewController class]]) {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:[self myTableView]];
        NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
        NSMutableArray<Utility> *toCheck;
        if(_statusSelected == 0) {
            toCheck = peopleArchive;
        } else if (_statusSelected == 1){
            toCheck = peopleInbox;
        } else{
            toCheck = peopleLater;
        }
        Utility *person = toCheck[indexPath.row];
        DetailViewController* dvC = [segue destinationViewController];
        dvC.utility = person;
    }
}

#pragma mark * DAContextMenuCell delegate

- (void)contextMenuCell:(DAContextMenuCell *)cell buttonTappedAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0: {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Cancel"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"1 Day", @"2 Days", @"3 Days", @"1 Week", @"1 Month", @"3 Months",  nil];
            [actionSheet showInView:self.view];
            Utility *remove = [peopleInbox objectAtIndex:0];
            remove.status = @"later";
            [peopleInbox removeObject:remove];
            [peopleLater addObject:remove];
            [self.tableView reloadData];
        } break;
        case 1: {
            Utility *remove = [peopleInbox objectAtIndex:0];
            remove.status = @"archive";
            [peopleInbox removeObject:remove];
            [peopleArchive addObject:remove];
            [self.tableView reloadData];
        } break;
        default: break;
            
    }
}

@end