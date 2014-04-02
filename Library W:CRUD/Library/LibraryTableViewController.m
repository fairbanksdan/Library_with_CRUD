//
//  LibraryTableViewController.m
//  Library
//
//  Created by Daniel Fairbanks on 3/29/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "LibraryTableViewController.h"
#import "ShelfTableViewController.h"
#import "Shelf.h"
#import "Library.h"


@interface LibraryTableViewController ()

@property (strong, readwrite)NSArray *libraries;

@end

@implementation LibraryTableViewController

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
    
    Library *library = [[Library alloc] initWithName:@"Library"];
    
    Shelf *shelf1 = [[Shelf alloc] initWithName:@"Shelf 1"];
    Shelf *shelf2 = [[Shelf alloc] initWithName:@"Shelf 2"];
    Shelf *shelf3 = [[Shelf alloc] initWithName:@"Shelf 3"];
    Shelf *shelf4 = [[Shelf alloc] initWithName:@"Shelf 4"];
    
    
    [shelf1 addNewBookWithTitle: @"Harry Potter"];
    [shelf1 addNewBookWithTitle: @"The Once and Future King"];
    [shelf1 addNewBookWithTitle: @"Les Miserables"];
    [shelf2 addNewBookWithTitle: @"The Hobbit"];
    [shelf2 addNewBookWithTitle: @"A Tale of Two Cities"];
    [shelf2 addNewBookWithTitle: @"A Christmas Carol"];
    [shelf3 addNewBookWithTitle: @"Great Expectations"];
    [shelf3 addNewBookWithTitle: @"Uncle Tom's Cabin"];
    [shelf3 addNewBookWithTitle: @"Moby Dick"];
    [shelf3 addNewBookWithTitle: @"Robinson Crusoe"];
    [shelf4 addNewBookWithTitle: @"The Iliad"];
    [shelf4 addNewBookWithTitle: @"The Return of the Native"];
    [shelf4 addNewBookWithTitle: @"Jurassic Park"];
    
    
    [library.shelves addObject: shelf1];
    
    [library.shelves addObject: shelf2];
    
    [library.shelves addObject: shelf3];
    
    [library.shelves addObject: shelf4];
    
    self.libraries = [NSArray arrayWithObjects:library, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.libraries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"LibraryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    
    Library *library = [self.libraries objectAtIndex:indexPath.row];
    cell.textLabel.text = library.libraryName;
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showArrayDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ShelfTableViewController *destViewController = segue.destinationViewController;
        Library *library = [self.libraries objectAtIndex:indexPath.row];
        destViewController.shelves = library.libraryName;
        destViewController.title = destViewController.shelves;
        destViewController.library = library;
    }
}

@end
