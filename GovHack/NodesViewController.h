//
//  NodesViewController.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tour.h"

@interface NodesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


-(id)init:(Tour*)tour;

@end
