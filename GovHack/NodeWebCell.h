//
//  NodeWebCell.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NodeWebCellDelegate <NSObject>
@required
-(void)reloadIndexPath:(NSIndexPath*)indexPath;

@end

@interface NodeWebCell : UITableViewCell <UIWebViewDelegate>

+(float)cellHeight;

-(void)setup_html:(NSString*)html;

-(float)contentHeight;

@property (copy, nonatomic) NSIndexPath* indexPath;
@property (assign, nonatomic) id<NodeWebCellDelegate> delegate;

@end
