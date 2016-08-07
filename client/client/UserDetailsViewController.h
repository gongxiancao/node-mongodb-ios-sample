//
//  UserDetailsViewController.h
//  client
//
//  Created by GongXian Cao on 16/8/6.
//  Copyright © 2016年 GongXian Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsViewController : UITableViewController
@property (strong, nonatomic) NSDictionary *user;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@end
