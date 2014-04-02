//
//  ShelfTableViewController.m
//  Library
//
//  Created by Daniel Fairbanks on 3/29/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "ShelfTableViewController.h"
#import "BookTableViewController.h"
#import "Shelf.h"
#import "Library.h"
#import "Book.h"

@interface ShelfTableViewController ()

@end

@implementation ShelfTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad

{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.library.shelves count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"ShelfCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    
    Shelf *shelf1 = [self.library.shelves objectAtIndex:indexPath.row];
    cell.textLabel.text = shelf1.shelfName;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"showArrayDetail2"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BookTableViewController *destViewController = segue.destinationViewController;
        // destViewController.bookName = [shelf objectAtIndex:indexPath.row]; // with the line below, you can delete the bookName property on the bookTableViewController.
        destViewController.shelf = [self.library.shelves objectAtIndex:indexPath.row];
        destViewController.title = destViewController.bookName;
    }
}
@end

