//
//  UserListTableViewController.m
//  client
//
//  Created by GongXian Cao on 16/8/6.
//  Copyright © 2016年 GongXian Cao. All rights reserved.
//

#import "UserListTableViewController.h"
#import "UserDetailsTableViewCell.h"
#import "UserDetailsViewController.h"
#import "ApiClient.h"

@interface UserListTableViewController ()
@property NSArray  *users;
@end

@implementation UserListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [ApiClient get:@"api/v1/user" success:^(id responseObject) {
        self.users = [responseObject objectForKey:@"users"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Failed to get user list"
                                    preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [[self navigationController] popViewControllerAnimated:YES];
                                        }];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = self.users ? self.users.count: 0;
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserDetailsCell";

    UserDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *user = self.users[indexPath.row];
    cell.user = user;
    cell.nameLabel.text = [user valueForKey:@"name"] ?: @"";
    cell.emailLabel.text = [user valueForKey:@"email"] ?: @"";
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"editUser"]) {
        UserDetailsViewController *detailsVC = segue.destinationViewController;
        detailsVC.user = [(UserDetailsTableViewCell *) sender user];
    }
}

- (void)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC
{
    NSLog(@"unwind %@", unwindSegue.identifier);
}
@end
