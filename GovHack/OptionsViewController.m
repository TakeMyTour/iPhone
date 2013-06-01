//
//  OptionsViewController.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "OptionsViewController.h"
#import "project.h"
@interface OptionsViewController ()
{
    
    IBOutlet UITextField *_base_url_textview;
}

@end

@implementation OptionsViewController

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
    self.navigationItem.title = @"Options";
    _base_url_textview.text = [Options sharedInstance].baseURL;
}

#pragma mark - Text Field
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [Options sharedInstance].baseURL = _base_url_textview.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder] && [textField canResignFirstResponder])
    {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark -

- (void)dealloc
{
    [_base_url_textview release];
    [super dealloc];
}
@end
