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
    IBOutlet UITextField *_text_field;
    
    
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
        [_tableview registerNib:[UINib nibWithNibName:@"AddTourCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddTourCell"];
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

-(void)search
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setValue:_text_field.text forKey:@"name"];
    //  http://unleashed.oeg.com.au/tours/search?name=adelaide
    NSString* path = @"/tours/search";
    
    NSMutableURLRequest* request = [ClientManager requestWithMethod:@"GET" path:path parameters:params];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success_:^(AFJSONRequestOperation*operation) {
        // NSLog(@"Success! %@", operation.responseJSON);
        NSArray* tours = operation.responseJSON;
        
        NSMutableArray* current_tours = [[NSMutableArray alloc] initWithCapacity:tours.count];
        
        for (NSDictionary* tour_data in tours)
        {
            Tour* tour = [Tour newObjectFromDictionary:tour_data];
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
- (IBAction)whatsNearMeButtonPressed:(id)sender
{
    [self search_locally];
}

-(void)search_locally
{
    // TODO - lat/long is hard-coded
    double lat_ = -34.9;
    double long_ = 138.6;
    double dist_ = 20;
    
    // whats near me?
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%f", lat_] forKey:@"lat"];
    [params setValue:[NSString stringWithFormat:@"%f", long_] forKey:@"lon"];
    [params setValue:[NSString stringWithFormat:@"%f", dist_] forKey:@"dist"];
    //  http://unleashed.oeg.com.au/tours/search?name=adelaide
    NSString* path = @"/tours/search";
    
    NSMutableURLRequest* request = [ClientManager requestWithMethod:@"GET" path:path parameters:params];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success_:^(AFJSONRequestOperation*operation) {
        NSArray* tours = operation.responseJSON;
        
        NSMutableArray* current_tours = [[NSMutableArray alloc] initWithCapacity:tours.count];
        
        for (NSDictionary* tour_data in tours)
        {
            Tour* tour = [Tour newObjectFromDictionary:tour_data];
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

-(void)search_all
{
    NSDictionary* params = [[NSDictionary alloc] init];
    
    NSMutableURLRequest* request = [ClientManager requestWithMethod:@"GET" path:@"/tours" parameters:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success_:^(AFJSONRequestOperation*operation) {
        // NSLog(@"Success! %@", operation.responseJSON);
        NSArray* tours = operation.responseJSON;
        
        NSMutableArray* current_tours = [[NSMutableArray alloc] initWithCapacity:tours.count];
        
        for (NSDictionary* tour_data in tours)
        {
            Tour* tour = [Tour newObjectFromDictionary:tour_data];
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

-(void)refresh_data
{
    if (_text_field.text.length==0)
    {
        [self search_all];
    }
    else
    {
        [self search];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self navigationItem].title = @"Find Tours";
    [self refresh_data];
}

#pragma mark - Text Field

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self refresh_data];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder] && [textField canResignFirstResponder])
    {
        [textField resignFirstResponder]; 
    }
    return YES;
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
    AddTourCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddTourCell"];
    if (cell==nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddTourCell" owner:nil options:nil] lastObject];
    }
    Tour* tour = [self.current_tours objectAtIndex:indexPath.row];
    cell.label.text = tour.name;
    
    if (tour.tours_user_inverse!=nil)
    {
        cell.button.hidden = YES;
    }
    else
    {
        cell.button.hidden = NO;
    }
    
    cell.tour = tour;
    cell.delegate = self;
    return cell;
}

#pragma mark - addTourCellButtonPressed

-(void)addTourCellButtonPressed:(AddTourCell*)cell
{
    if (cell.tour.tours_user_inverse==nil)
    {
        cell.tour.tours_user_inverse = [User sharedInstance];
        cell.button.hidden = YES;
        [DataManager save];
    }
    // otherwise the button shouldnt have been visible, but anyway...
}


#pragma mark -

- (void)dealloc
{
    [findToursViewController release];
    [_tableview release];
    [_text_field release];
    [super dealloc];
}
@end
