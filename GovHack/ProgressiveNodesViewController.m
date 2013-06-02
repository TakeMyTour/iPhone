//
//  ProgressiveNodesViewController.m
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "ProgressiveNodesViewController.h"
#import "project.h"


@interface ProgressiveNodesViewController ()
{
    
    IBOutlet UITableView *_tableview;
}


@property (retain, nonatomic) Tour* tour;

@end

@implementation ProgressiveNodesViewController
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tour refreshData:^{
        [_tableview reloadData];
    }];
}

#pragma mark - NodeHintCellDelegate

-(void)reloadIndexPath:(NSIndexPath*)indexPath
{
    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - tableview

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
    NodeHintCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NodeHintCell"];
    if (cell==nil)
    {
        cell = (NodeHintCell*)[[[NSBundle mainBundle] loadNibNamed:@"NodeHintCell" owner:nil options:nil] lastObject];
    }
    cell.delegate = self;
    Node* node = [self.tour.nodes objectAtIndex:indexPath.row];
    if (node.hasBeenSeen)
    {
        cell.label.text = node.name;
        cell.button.hidden = YES;
    }
    else
    {
        cell.label.text = @"Unknown - Show Hint";
        cell.button.hidden = NO;
    }
    cell.node = node;
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Node* node = [self.tour.nodes objectAtIndex:indexPath.row];
    if (node.hasBeenSeen)
    {
        NodeViewController* ctrl = [[NodeViewController alloc] init:node];
        [[self navigationController] pushViewController:ctrl animated:YES];
        [ctrl release];
    }
    else
    {
        // show hint controller!!!
        NodeHintViewController* ctrl = [[NodeHintViewController alloc] init:node];
        [[self navigationController] pushViewController:ctrl animated:YES];
        [ctrl release];
    }
}


#pragma mark -

- (void)dealloc
{
    [_tableview release];
    [super dealloc];
}
@end
