//
//  AddTourCell.h
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tour.h"

@class AddTourCell;


@protocol AddTourCellDelegate <NSObject>
@required
-(void)addTourCellButtonPressed:(AddTourCell*)cell;

@end

@interface AddTourCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) Tour* tour;
@property (retain, nonatomic) IBOutlet UIButton *button;
@property (assign, nonatomic) id<AddTourCellDelegate> delegate;
@end
