//
//  ExploreListViewController.m
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "ExploreListViewController.h"
#import "project.h"


@interface ExploreListViewController ()
{
    
    IBOutlet UITableView *_tableview;
}

@property (retain, nonatomic) NSMutableArray* items;

@end

@implementation ExploreListViewController

@synthesize items = _items;

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

-(void)search
{
    // http://unleashed.oeg.com.au/explore/search?lat=-34.9&lon=138.6&dist=5
    // TODO - lat/long is hard-coded
    double lat_ = -34.9;
    double long_ = 138.6;
    double dist_ = 5;
    
    // whats near me?
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%f", lat_] forKey:@"lat"];
    [params setValue:[NSString stringWithFormat:@"%f", long_] forKey:@"lon"];
    [params setValue:[NSString stringWithFormat:@"%f", dist_] forKey:@"dist"];
    //  http://unleashed.oeg.com.au/tours/search?name=adelaide
    NSString* path = @"/explore/search";
    
    NSMutableURLRequest* request = [ClientManager requestWithMethod:@"GET" path:path parameters:params];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success_:^(AFJSONRequestOperation*operation) {
      // NSArray* tours = operation.responseJSON;
        
        NSMutableArray* results = [[NSMutableArray alloc] init];
        for (NSDictionary* item_data in operation.responseJSON)
        {
            ExploreItem* item = [[ExploreItem alloc] init];
            item.name = [item_data objectForKey:@"name"];
            [results addObject:item];
            [item release];
        }
        self.items = results;
        [_tableview reloadData];
        [results release];
        
    } failure_:^(AFJSONRequestOperation*operation) {
        NSString* response = [operation responseJSON] ? [operation responseJSON] : [operation responseString];
        NSLog(@"Failure: %@", response);
        NSLog(@"error: %@", [[operation error] description]);
    }];
    
    [params release];
    [operation start];
}

-(void)viewDidAppear:(BOOL)animated
{
    // request whats nearby!!!!!!!
    [self navigationItem].title = @"Explore!";
    [self search];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    
    ExploreItem* item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

#pragma mark -

- (void)dealloc
{
    [_tableview release];
    [super dealloc];
}
@end
