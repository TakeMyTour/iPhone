//
//  NodesViewController.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "NodesViewController.h"
#import "project.h"

@interface NodesViewController ()
{
    IBOutlet UITableView *_tableview;
    //NSMutableArray* _nodes;
}

@property (retain, nonatomic) Tour* tour;

@end

@implementation NodesViewController

@synthesize tour = _tour;

-(id)init:(Tour*)tour
{
    self = [super init];
    if (self)
    {
        self.tour = tour;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)mapButtonPressed
{   //  Map View  //
    UIViewController* ctrl = [[UIViewController alloc] init];
    MKMapView* map = [[MKMapView alloc] initWithFrame:ctrl.view.bounds];
    map.delegate = self;
    [ctrl.view addSubview:map];
    
    [self.tour addToMap:map];
    
    [[self navigationController] pushViewController:ctrl animated:YES];
}



-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = self.tour.name;
    [self.tour refreshData:^(){
        [_tableview reloadData];
    }];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleDone target:nil action:nil];
    rightButton.tintColor = [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f];
    rightButton.target = self;
    rightButton.action = @selector(mapButtonPressed);
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tour.nodes.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    Node* node = [self.tour.nodes objectAtIndex:indexPath.row];
    cell.textLabel.text = node.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Node* node = [self.tour.nodes objectAtIndex:indexPath.row];
    NodeViewController* ctrl = [[NodeViewController alloc] init:node];
    [[self navigationController] pushViewController:ctrl animated:YES];
    [ctrl release];
}


#pragma mark - foo
- (void)dealloc
{
    [_tableview release];
    [super dealloc];
}
@end
