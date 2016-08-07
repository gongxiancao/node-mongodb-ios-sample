//
//  UserDetailsViewController.m
//  client
//
//  Created by GongXian Cao on 16/8/6.
//  Copyright © 2016年 GongXian Cao. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "ApiClient.h"

@implementation UserDetailsViewController
-(void)viewDidLoad {
    if(!self.user) {
        self.user = [NSMutableDictionary new];
    } else {
        self.user = [self.user mutableCopy];
    }
    self.nameText.text = [self.user objectForKey:@"name"] ?: @"";
    self.emailText.text = [self.user objectForKey:@"email"] ?: @"";
}

- (IBAction)didSave:(id)sender {
    NSLog(@"Save click");
    [self saveUser];
}

- (void)saveUser {
//    NSLog(@"name: %@", self.nameText.text);
    [self.user setValue:self.nameText.text forKey:@"name"];
    [self.user setValue:self.emailText.text forKey:@"email"];

    NSString *apiUrl = @"api/v1/user";
    NSString *_id = [self.user objectForKey:@"_id"];

    if(_id) {
        apiUrl = [NSString stringWithFormat:@"%@/%@", apiUrl, _id];
    }
    [ApiClient post:apiUrl parameters:self.user success:^(id responseObject) {
        [[self navigationController] popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"User change not saved"
                                    preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:nil];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

@end
