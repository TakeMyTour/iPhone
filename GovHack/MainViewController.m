//
//  MainViewController.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "MainViewController.h"
#import "project.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.0f];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self navigationItem].title = @"Welcome!";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - GUI

- (IBAction)exploreButtonPressed:(id)sender
{
    ExploreListViewController* ctrl = [[ExploreListViewController alloc] init];
    [[self navigationController] pushViewController:ctrl animated:YES];
    [ctrl release];
}

- (IBAction)myToursButtonPressed:(id)sender
{
    ToursViewController* ctrl = [[ToursViewController alloc] init];
    [[self navigationController] pushViewController:ctrl animated:YES];
    [ctrl release];
}

- (IBAction)findToursButtonPressed:(id)sender
{
    FindToursViewController* ctrl = [[FindToursViewController alloc] init];
    [[self navigationController] pushViewController:ctrl animated:YES];
    [ctrl release];
}

- (IBAction)optionsButtonPressed:(id)sender
{
    OptionsViewController* ctrl = [[OptionsViewController alloc] init];
    [[self navigationController] pushViewController:ctrl animated:YES];
    [ctrl release];
}


#pragma mark - 


@end
