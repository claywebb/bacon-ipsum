//
//  MainViewController.m
//  Bacon Ipsum
//
//  Created by Clayton Webb on 9/28/13.
//  Copyright (c) 2013 Clayton Webb. All rights reserved.
//
/*
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 */

#import "MainViewController.h"
#import "BaconController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(retireKeyboard)];
    startWithBaconIpsum = YES;
    meatWithFiller = YES;
    numberOfParagraphs = 5;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)retireKeyboard
{
    [self.view endEditing:YES];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    numberOfParagraphs = [paragraphField.text intValue];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [paragraphField becomeFirstResponder];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            meatWithFiller = NO;
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]].accessoryType = UITableViewCellAccessoryNone;
        }else{
            meatWithFiller = YES;
            [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].accessoryType = UITableViewCellAccessoryNone;
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else if (indexPath.section == 2)
    {
            startWithBaconIpsum = !startWithBaconIpsum;
        if (startWithBaconIpsum) {
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"createBacon"]) {
        BaconController *bController = (BaconController *)[segue destinationViewController];
        bController.withFiller = meatWithFiller;
        bController.startWithBacon = startWithBaconIpsum;
        bController.numberOfParagraphs = numberOfParagraphs;
    }
}



@end
