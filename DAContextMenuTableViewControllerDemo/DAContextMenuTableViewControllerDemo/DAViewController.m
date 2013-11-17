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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Inbox";
    
    NSString *url=@"http://dukeintouch.cloudapp.net:3000/api/contacts";
    self.response = [[ServerResponse alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
        NSLog(@"response: %@", self.response);
        people = (NSMutableArray<Utility> *) self.response.response;
        [self.myTableView reloadData];
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //    NSString *url=@"10.190.54.255:8888/";
    //    NSString *url = [[NSString alloc] initWithFormat:@"http://%@search/generic/?search=%@&count=%d", ip, searchTerm, 20];
    //    self.dataController.searchResult = [[SearchResult alloc] initFromURLWithString:url completion:^(JSONModel *model, JSONModelError *err) {
    //        //json fetched
    //        //NSLog(@"response: %@", self.dataController.searchResult.response);
    //        self.dataController.masterContactList = (NSMutableArray *)self.dataController.searchResult.response;
    //        [self.collectionView reloadData];
    //        [self.spinner stopAnimating];
    //    }];
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
    NSInteger count = 0;
    for(int i=0; i<[people count]; i++) {
        if(self.segmentedControl.selectedSegmentIndex == 0){
            if([[[people objectAtIndex:i] status] isEqualToString:@"archive"]) {
                count++;
            }
        } else if (self.segmentedControl.selectedSegmentIndex == 1) {
            if([[[people objectAtIndex:i] status] isEqualToString:@"inbox"]) {
                count++;
            }
        } else {
            if([[[people objectAtIndex:i] status] isEqualToString:@"later"]) {
                count++;
            }
        }
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DADemoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //    if(self.segmentedControl.selectedSegmentIndex == 0){
    //        cell.nameLabel.text = [archived_tableData objectAtIndex:indexPath.row];
    //        cell.imageView.image = [UIImage imageNamed:[archived_thumbnails objectAtIndex:indexPath.row]];
    //        cell.tagsLabel.text = [archived_tags objectAtIndex:indexPath.row];
    //
    //    }else if (self.segmentedControl.selectedSegmentIndex == 1){
    //        cell.nameLabel.text = [inbox_tableData objectAtIndex:indexPath.row];
    //        cell.imageView.image = [UIImage imageNamed:[inbox_thumbnails objectAtIndex:indexPath.row]];
    //        cell.tagsLabel.text = [inbox_tags objectAtIndex:indexPath.row];
    //
    //    }else{
    //        cell.nameLabel.text = [later_tableData objectAtIndex:indexPath.row];
    //        cell.imageView.image = [UIImage imageNamed:[later_thumbnails objectAtIndex:indexPath.row]];
    //        cell.tagsLabel.text = [later_tags objectAtIndex:indexPath.row];
    //    }
    
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
    [self.tableView reloadData];
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
        } break;
        case 1: {
            if ([self.tableView indexPathForCell:cell]) {
                self.rowsCount -= 1;
                [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationFade];
            }
        } break;
        default: break;
            
    }
}

@end