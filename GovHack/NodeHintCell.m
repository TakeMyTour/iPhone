//
//  NodeHintCell.m
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "NodeHintCell.h"
#import "project.h"

@interface NodeHintCell()

-(void)foundButtonPressed;

@end



@implementation NodeHintCell

@synthesize node = _node;
@synthesize indexPath = _indexPath;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [self.button addTarget:self action:@selector(foundButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UI

-(void)foundButtonPressed
{
    self.node.hasBeenSeen = [NSNumber numberWithBool:YES];
    [self.delegate reloadIndexPath:self.indexPath];
}




#pragma mark -
- (void)dealloc
{
    [_label release];
    [_button release];
    [super dealloc];
}
@end
