//
//  NodeHintCell.h
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"

@protocol NodeHintCellDelegate <NSObject>

-(void)reloadIndexPath:(NSIndexPath*)indexPath;

@end

@interface NodeHintCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) IBOutlet UIButton *button;


@property (retain, nonatomic) Node* node;

@property (copy, nonatomic) NSIndexPath* indexPath;
@property (assign, nonatomic) id<NodeHintCellDelegate> delegate;

@end
