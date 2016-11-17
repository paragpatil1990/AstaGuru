//
//  SwipeTableViewController.m
//  SwipeTableCell
//
//  Created by Simon on 3/5/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SwipeTableViewController.h"
#import "CustomTableViewCell.h"

@interface SwipeTableViewController () {
    NSMutableArray *patterns;
    NSMutableArray *patternImages;
}

@end

@implementation SwipeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    patterns = [NSMutableArray arrayWithObjects:@"Neon Autumn", @"Alchmey", @"White Wood", @"Green Goblin", @"Subway Lines", @"Canvas Orange", @"Kiwis", @"Cuadros", @"HodgePodge", @"Naranjas", @"Bunting", nil];
    
    patternImages = [NSMutableArray arrayWithObjects:@"neon-autumn.gif", @"alchemy.jpg", @"white-wood.jpg", @"green-goblin.png", @"subway-lines.png", @"canvas-orange.jpg", @"kiwis.png", @"cuadros.png", @"hodgepodge.png", @"naranjas.png", @"bunting-flag.png", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [patterns count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    // Add utility buttons
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
                                                icon:[UIImage imageNamed:@"like.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
                                                icon:[UIImage imageNamed:@"message.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
                                                icon:[UIImage imageNamed:@"facebook.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]icon:[UIImage imageNamed:@"twitter.png"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]icon:[UIImage imageNamed:@"twitter.png"]];
    
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    cell.leftUtilityButtons = rightUtilityButtons;
    cell.rightUtilityButtons = leftUtilityButtons;
    cell.delegate = self;

    // Configure the cell...
    cell.patternLabel.text = [patterns objectAtIndex:indexPath.row];
    cell.patternImageView.image = [UIImage imageNamed:[patternImages objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bookmark" message:@"Save to favorites successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            break;
        }
        case 1:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email sent" message:@"Just sent the image to your INBOX" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            break;
        }
        case 2:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook Sharing" message:@"Just shared the pattern image on Facebook" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            break;
        }
        case 3:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitter Sharing" message:@"Just shared the pattern image on Twitter" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            // More button is pressed
            UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share on Facebook", @"Share on Twitter", nil];
            [shareActionSheet showInView:self.view];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button is pressed
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            [patterns removeObjectAtIndex:cellIndexPath.row];
            [patternImages removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

@end
