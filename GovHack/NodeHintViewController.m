//
//  NodeHintViewController.m
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "NodeHintViewController.h"

@interface NodeHintViewController ()
{
    
    IBOutlet UIWebView *_webview;
}

@property (retain, nonatomic) Node* node;

@end

@implementation NodeHintViewController

@synthesize node = _node;

-(id)init:(Node*)node
{
    self = [super init];
    if (self)
    {
        self.node = node;
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

-(void)populateWebView
{
    NSString* html_image = nil;
    NSString* html_desc = nil;
    if (self.node.hint_image)
    {
        html_image = [[NSString stringWithFormat:@"<img height=\"120\" src=\"%@\" width=\"120\" />", self.node.hint_image] copy];
    }
    if (self.node.hint_desc)
    {
        html_desc = [[NSString stringWithFormat:@"<p>%@</p>", self.node.hint_desc] copy];
    }
    
    NSString* html_body = [NSString stringWithFormat:@"<html><body style='background-color: transparent; width: 320px; margin: 0; padding: 0;'><div id='ContentDiv' style=\"width:200px; margin:auto\">%@<br/>%@</div></body></html>", html_image, html_desc];
    
    [_webview loadHTMLString:html_body baseURL:nil];
    
    [html_image release];
    [html_desc release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self populateWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webview release];
    [super dealloc];
}
@end
