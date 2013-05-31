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

+(float)cellHeight
{
    return 300.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setup_html:(NSString*)html
{
    [_webview loadHTMLString:html baseURL:nil];
}

- (void)dealloc
{
    [_webview release];
    [super dealloc];
}
@end
