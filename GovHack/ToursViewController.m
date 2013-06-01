//
//  ToursViewController.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "ToursViewController.h"
#import "project.h"

@interface ToursViewController ()
{
    IBOutlet UITableView *_tableview;
    NSMutableArray* _tours;
}

@end


@implementation ToursViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
# if 0
        _tours = [[NSMutableArray alloc] init];
        Tour* tour = [Tour createLocal];
        tour.name = @"My Tour";
        tour.tour_type = TourTypeBasic;
        
        Node* node1 = [Node createLocal];
        node1.name = @"Node 1";
        node1.gps_longitude = [NSNumber numberWithDouble:-34.9333];
        node1.gps_latitude = [NSNumber numberWithDouble:138.5833];
        
        node1.description_text = @"<html><body><h1>Hello, world!</h1></body></html>";
       // [node1.images addObject:@"https://secure.gravatar.com/avatar/5cef062286e5e39adb3e0e5dac4f5b74?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"];
        
        Node* node2 = [Node createLocal];
        node2.name = @"Node 2";
        node2.description_text = @"Foobar";
        node2.address = @"Adelaide, Australia";
        node1.nodes_inverse = tour;
        node2.nodes_inverse = tour;
        
        [_tours addObject:tour];
        
#endif
        _tours = [[[User sharedInstance].tours allObjects] mutableCopy];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = @"My Tours";
    // send the request to refresh data!
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_tours release];
    [_tableview release];
    [super dealloc];
}


#pragma mark - tableview

-(int)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tours count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    
    Tour* selected = [_tours objectAtIndex:indexPath.row];
    cell.textLabel.text = selected.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        // just an assertion
        if (0 <= indexPath.row && indexPath.row < _tours.count)
        {
            Tour* selected = [_tours objectAtIndex:indexPath.row];
            if (selected.tour_type.intValue==TourTypeBasic)
            {
                NodesViewController* ctrl = [[NodesViewController alloc] init:selected];
                [[self navigationController] pushViewController:ctrl animated:YES];
                [ctrl release];
            }
        }
    }
    
    
}


@end
