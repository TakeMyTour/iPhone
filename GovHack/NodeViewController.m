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
    NSMutableArray* _currentCells;
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

#pragma mark - NodeCallDelegate

-(void)reloadIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath)
    {
        [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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
            if (self.node.description_text!=nil)
            {
                return 1;
            }
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
            return 100;
           // NodeWebCell* cell = (NodeWebCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
           // return MAX(100, cell.contentHeight);
            break;
        }
        case NodeSectionImages:
        {
            return 200;
           // NodeWebCell* cell = (NodeWebCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            //return MAX(200, cell.contentHeight);
            break;
        }
    }
    return 44;
}

-(NSString*)htmlForIndexPath:(NSIndexPath*)indexPath
{
    NSString* html = nil;
    NodeSection section = indexPath.section;
    switch (section)
    {
        case NodeSectionImages:
        {
            Image* img = [self.node.images objectAtIndex:indexPath.row];
            
            NSString* imageString = [NSString stringWithFormat:@"<img height=\"120\" src=\"%@\" width=\"120\" />", img.url];
            NSString* img_desc = [NSString stringWithFormat:@"<p>%@</p>", img.desc];
            html = [NSString stringWithFormat:@"<html><body style='background-color: transparent; width: 320px; margin: 0; padding: 0;'><div id='ContentDiv' style=\"width:200px; margin:auto\">%@</div>%@</body></html>", imageString, img_desc];
            
            break;
        }
        case NodeSectionDescription:
        {
            html = self.node.description_text;
            break;
        }
    }
    return html;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NodeWebCell* web_cell = [tableView dequeueReusableCellWithIdentifier:@"NodeWebCell"];
    if (web_cell==nil)
    {
        web_cell = [[[NSBundle mainBundle] loadNibNamed:@"NodeWebCell" owner:nil options:nil] lastObject];
    }
    web_cell.delegate = self;
    NSString* html = [self htmlForIndexPath:indexPath];
    [web_cell setup_html:html];
    web_cell.userInteractionEnabled = NO;
    web_cell.indexPath = indexPath;
    return web_cell;
    
    
#if 0
    NodeSection section = indexPath.section;
    switch (section)
    {
        case NodeSectionImages:
        {
            //return [[UITableViewCell alloc] init];
            NodeWebCell* web_cell = [tableView dequeueReusableCellWithIdentifier:@"NodeWebCell"];
            if (web_cell==nil)
            {
                web_cell = [[[NSBundle mainBundle] loadNibNamed:@"NodeWebCell" owner:nil options:nil] lastObject];
            }
            Image* img = [self.node.images objectAtIndex:indexPath.row];
            
            NSString* imageString = [NSString stringWithFormat:@"<img height=\"120\" src=\"%@\" width=\"120\" />", img.url];
            NSString* img_desc = [NSString stringWithFormat:@"<p>%@</p>", img.desc];
            NSString* html = [NSString stringWithFormat:@"<html><body style='background-color: transparent; width: 320px; height: 200px; margin: 0; padding: 0;'><div id='ContentDiv' style=\"width:200px; margin:auto\">%@</div>%@</body></html>", imageString, img_desc];
            [web_cell setup_html:html];
            cell = web_cell;
            cell.userInteractionEnabled = NO;
            break;
        }
        case NodeSectionDescription:
        {
            NodeWebCell* web_cell = [tableView dequeueReusableCellWithIdentifier:@"NodeWebCell"];
            if (web_cell==nil)
            {
                web_cell = [[[NSBundle mainBundle] loadNibNamed:@"NodeWebCell" owner:nil options:nil] lastObject];
            }
            [web_cell setup_html:self.node.description_text];
            cell = web_cell;
            cell.userInteractionEnabled = NO;
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
#endif
}

#pragma mark - foo

- (void)dealloc
{
    [_tableview release];
    [super dealloc];
}
@end
