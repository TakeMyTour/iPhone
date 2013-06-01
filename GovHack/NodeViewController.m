//
//  NodeViewController.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "NodeViewController.h"
#import "project.h"

@interface NodeViewController ()
{
    IBOutlet UITableView *_tableview;
}
-(void)mapButtonPressed;


@end

@implementation NodeViewController

@synthesize node = _node;

-(id)init:(Node*)node
{
    self = [super init];
    if (self)
    {
        self.node = node;
        [_tableview registerNib:[UINib nibWithNibName:@"NodeWebCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NodeWebCell"];
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


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    return nil;
}

-(void)mapButtonPressed
{   //  Map View  //
    UIViewController* ctrl = [[UIViewController alloc] init];
    MKMapView* map = [[MKMapView alloc] initWithFrame:ctrl.view.bounds];
    map.delegate = self;
    [ctrl.view addSubview:map];
    
    [self.node addToMap:map];
    
    [[self navigationController] pushViewController:ctrl animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = self.node.name;
    UIButton* button = [[[NSBundle mainBundle] loadNibNamed:@"MapButton" owner:nil options:nil] lastObject];
    [button addTarget:self action:@selector(mapButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [[self navigationItem] setRightBarButtonItem:rightButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

typedef enum
{
    NodeSectionDescription,
    NodeSectionImages
} NodeSection;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section_
{
    NodeSection section = section_;
    switch (section)
    {
        case NodeSectionDescription:
        {
            if (self.node.description!=nil)
            {
                return 1;
            }
            return 0;
            break;
        }
        case NodeSectionImages:
        {
            return self.node.images.count;
            break;
        }
    }
    return 0;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NodeSection section = indexPath.section;
    switch (section)
    {
        case NodeSectionDescription:
        {
            return [NodeWebCell cellHeight];
            break;
        }
        case NodeSectionImages:
        {
            break;
        }
    }
    return 44.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    NodeSection section = indexPath.section;
    switch (section)
    {
        case NodeSectionImages:
        {
            return [[UITableViewCell alloc] init];
            break;
        }
        case NodeSectionDescription:
        {
            NodeWebCell* web_cell = [tableView dequeueReusableCellWithIdentifier:@"NodeWebCell"];
            if (web_cell==nil)
            {
                web_cell = [[[NSBundle mainBundle] loadNibNamed:@"NodeWebCell" owner:nil options:nil] lastObject];
            }
            [web_cell setup_html:self.node.description];
            cell = web_cell;
            
            break;
        }
        default:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil)
            {
                cell = [[UITableViewCell alloc] init];
            }
            cell.backgroundColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.0f alpha:1.0f];
        }
    }
    
    return cell;
}

#pragma mark - foo

- (void)dealloc
{
    [_tableview release];
    [super dealloc];
}
@end
