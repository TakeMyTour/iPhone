//
//  NodeButtonsCell.h
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NodeButtonsCellDelegate <NSObject>
@required
-(void)nearbyButtonPressed;

@end

@interface NodeButtonsCell : UITableViewCell


@property (assign, nonatomic) id<NodeButtonsCellDelegate> delegate;
@end
