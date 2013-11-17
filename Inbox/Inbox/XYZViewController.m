//
//  XYZViewController.m
//  Inbox
//
//  Created by Intern on 11/16/13.
//  Copyright (c) 2013 Jeff Hou. All rights reserved.
//

#import "XYZViewController.h"
//#import "XYZCell.h"
@interface XYZViewController ()

@end

@implementation XYZViewController
{
    NSArray *archived_tableData;
    NSArray *archived_thumbnails;
    NSArray *archived_tags;
    NSArray *inbox_tableData;
    NSArray *inbox_thumbnails;
    NSArray *inbox_tags;
    NSArray *later_tableData;
    NSArray *later_thumbnails;
    NSArray *later_tags;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    archived_tableData = [NSArray arrayWithObjects:@"John F. Kennedy", nil];
    archived_thumbnails = [NSArray arrayWithObjects:@"jfk.jpg", nil];
    archived_tags = [NSArray arrayWithObjects:@"#awesome #super cool", nil];
    
    inbox_tableData = [NSArray arrayWithObjects:@"Barack Obama", @"George W. Bush", nil];
    inbox_thumbnails = [NSArray arrayWithObjects:@"obama.jpg", @"bush.jpeg", nil];
    inbox_tags = [NSArray arrayWithObjects:@"#black #cool #democrat",@"#troll #vacation days", nil];
    
    later_tableData = [NSArray arrayWithObjects:@"Bill Clinton", @"The Other Bush", @"Ronald Reagan", @"Jimmy Carter", @"Richard Nixon", @"L. B. Johnson", nil];
    later_thumbnails = [NSArray arrayWithObjects:@"clinton.jpg", @"bush2.jpg", @"reagan.jpg", @"carter.jpg", @"nixon.jpg", @"johnson.jpg", nil];
    later_tags = [NSArray arrayWithObjects:@"#cool #democrat",@"#father",@"#actor",@"#two first names", @"#watergate", @"#who?", nil];

	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.statusOpt.selectedSegmentIndex == 0){
       return [archived_tableData count];
    }else if (self.statusOpt.selectedSegmentIndex == 1){
        return [inbox_tableData count];
    }else{
        return [later_tableData count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *XYZIdentifier = @"XYZCell";
    
//    XYZCell *cell = (XYZCell *)[tableView dequeueReusableCellWithIdentifier:XYZIdentifier];
//    if (cell == nil)
//    {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"XYZCell" owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//    }
//    if(self.statusOpt.selectedSegmentIndex == 0){
//        cell.nameLabel.text = [archived_tableData objectAtIndex:indexPath.row];
//        cell.thumbnailImageView.image = [UIImage imageNamed:[archived_thumbnails objectAtIndex:indexPath.row]];
//        cell.tagsLabel.text = [archived_tags objectAtIndex:indexPath.row];
//        
//    }else if (self.statusOpt.selectedSegmentIndex == 1){
//        cell.nameLabel.text = [inbox_tableData objectAtIndex:indexPath.row];
//        cell.thumbnailImageView.image = [UIImage imageNamed:[inbox_thumbnails objectAtIndex:indexPath.row]];
//        cell.tagsLabel.text = [inbox_tags objectAtIndex:indexPath.row];
//        
//    }else{
//        cell.nameLabel.text = [later_tableData objectAtIndex:indexPath.row];
//        cell.thumbnailImageView.image = [UIImage imageNamed:[later_thumbnails objectAtIndex:indexPath.row]];
//        cell.tagsLabel.text = [later_tags objectAtIndex:indexPath.row];
//        
//    }
//    
    
//    return cell;
    return nil;
}

-(IBAction)statusSelected:(id)sender{
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end