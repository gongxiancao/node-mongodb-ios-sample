//
//  UserDetailsTableViewCell.h
//  client
//
//  Created by GongXian Cao on 16/8/6.
//  Copyright © 2016年 GongXian Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) NSDictionary *user;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@end
