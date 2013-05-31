//
//  NodeWebCell.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NodeWebCell : UITableViewCell

+(float)cellHeight;

-(void)setup_html:(NSString*)html;

@end
