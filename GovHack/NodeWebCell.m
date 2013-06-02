//
//  NodeWebCell.m
//  GovHack
//
//  Created by Myles on 31/05/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "NodeWebCell.h"

@interface NodeWebCell()
{
    IBOutlet UIWebView *_webview;
}


@end

@implementation NodeWebCell

@synthesize indexPath;
@synthesize delegate;

+(float)cellHeight
{
    return 200.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _webview.delegate = self;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)contentHeight
{
    CGSize fittingSize = [_webview sizeThatFits:CGSizeZero];
    return fittingSize.height;
}


-(void)setup_html:(NSString*)html
{
    [_webview loadHTMLString:html baseURL:nil];
}

#pragma mark -

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // tell the tableview to reload this index path
    if (self.delegate)
    {
        [self.delegate reloadIndexPath:self.indexPath];
    }
}

#pragma mark -

- (void)dealloc
{
    [_webview release];
    [super dealloc];
}
@end
