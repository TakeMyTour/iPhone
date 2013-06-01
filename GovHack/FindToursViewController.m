//
//  FindToursViewController.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "FindToursViewController.h"
#import "project.h"

@interface FindToursViewController ()
{
    
    IBOutlet UITableView *findToursViewController;
    NSArray* _current_tours;
    IBOutlet UITableView *_tableview;
}
@property (retain, nonatomic) NSArray* current_tours;  



@end

@implementation FindToursViewController
@synthesize current_tours = _current_tours;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _current_tours = [[NSArray alloc] init];
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

-(void)setCurrentTours:(NSArray*)current_tours
{
    self.current_tours = current_tours;
    [_tableview reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSDictionary* params = [[NSDictionary alloc] init];
    
    NSMutableURLRequest* request = [ClientManager requestWithMethod:@"GET" path:@"/tours" parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success_:^(AFJSONRequestOperation*operation) {
        NSLog(@"Success! %@", operation.responseJSON);
        NSArray* tours = operation.responseJSON;
        
        NSMutableArray* current_tours = [[NSMutableArray alloc] initWithCapacity:tours.count];
        
        for (NSDictionary* tour_data in tours)
        {
            Tour* tour = [[Tour alloc] initFromDictionary:tour_data];
            [current_tours addObject:tour];
        }
        [self setCurrentTours:current_tours];
        
    } failure_:^(AFJSONRequestOperation*operation) {
        NSString* response = [operation responseJSON] ? [operation responseJSON] : [operation responseString];
        NSLog(@"Failure: %@", response);
        NSLog(@"error: %@", [[operation error] description]);
    }];

    [params release];
    [operation start];
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_current_tours count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}


#pragma mark -

- (void)dealloc
{
    [findToursViewController release];
    [_tableview release];
    [super dealloc];
}
@end
