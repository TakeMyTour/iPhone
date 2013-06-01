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
}



@end

@implementation FindToursViewController

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
    NSDictionary* params = [[NSDictionary alloc] init];
    
    NSMutableURLRequest* request = [ClientManager requestWithMethod:@"GET" path:@"index.php/tours" parameters:params];
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success_:^(AFJSONRequestOperation*operation) {
        NSLog(@"Success! %@", operation.responseJSON);
    } failure_:^(AFJSONRequestOperation*operation) {
        NSString* response = [operation responseJSON] ? [operation responseJSON] : [operation responseString];
        NSLog(@"Failure: %@", response);
        NSLog(@"error: %@", [[operation error] description]);
    }];

    [operation start];
}

- (void)dealloc
{
    [findToursViewController release];
    [super dealloc];
}
@end
