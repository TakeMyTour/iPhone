//
//  NodeViewController.h
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Node.h"
#import "NodeWebCell.h"
#import "NodeButtonsCell.h"

@interface NodeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, NodeWebCellDelegate, NodeButtonsCellDelegate>

-(id)init:(Node*)node;

@property (retain, nonatomic) Node* node;

@end
