//
//  BookTableViewController.m
//  Library
//
//  Created by Daniel Fairbanks on 3/29/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "BookTableViewController.h"
#import "Book.h"

@interface BookTableViewController ()

@end

@interface BookTableViewController ()


@property (readwrite) NSIndexPath *path;
@property (readwrite) BOOL isAdd;

@end

@implementation BookTableViewController

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
    
    return self.shelf.books.count +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"BookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    if (indexPath.row < self.shelf.books.count) {
        Book *book = [self.shelf.books objectAtIndex:indexPath.row];
        cell.textLabel.text = book.title;
    } else {
        cell.textLabel.text = @"Add New Book";
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Book *book = [self.shelf.books objectAtIndex:indexPath.row];
        [book unshelf];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger selectedRow = indexPath.row;
    if (selectedRow == self.shelf.books.count) {
        self.path = indexPath;
        self.isAdd = YES;
        UIAlertView * bookTitlePrompt = [[UIAlertView alloc] initWithTitle:@"Add New Book" message:@"Please enter the book title." delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Ok", nil];
        bookTitlePrompt.alertViewStyle = UIAlertViewStylePlainTextInput;
        [bookTitlePrompt show];
        
    } else if (selectedRow < self.shelf.books.count) {
        self.isAdd = NO;
        self.path = indexPath;
        UIAlertView *editBookTitlePrompt =
        [[UIAlertView alloc] initWithTitle:@"Edit Book Title" message:@"Please enter the book title." delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Ok", nil];
        
        editBookTitlePrompt.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        Book *book = [self.shelf.books objectAtIndex:indexPath.row];
        UITextField *textField = [editBookTitlePrompt textFieldAtIndex:0];
        
        textField.text = book.title;
        
        [editBookTitlePrompt show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        if (self.isAdd) {
            
            [self.shelf addNewBookWithTitle:[[alertView textFieldAtIndex:0] text]];
            
            NSArray *paths = [NSArray arrayWithObject:self.path];
            
            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
            
        } else {
            
            Book *book = [self.shelf.books objectAtIndex:self.path.row];
            
            book.title = [[alertView textFieldAtIndex:0] text];
            
            
            [self.tableView reloadData];
            
        }
    }
    
    
}

@end
