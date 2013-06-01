//
//  NodesViewController.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tour+Methods.h"

@interface NodesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>


-(id)init:(Tour*)tour;

@end
