//
//  ProgressiveNodesViewController.h
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tour.h"
@interface ProgressiveNodesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


-(id)init:(Tour*)tour;

@end
