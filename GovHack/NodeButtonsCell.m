//
//  NodeButtonsCell.m
//  GovHack
//
//  Created by Myles on 2/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "NodeButtonsCell.h"

@interface NodeButtonsCell()
{
}


@end

@implementation NodeButtonsCell

@synthesize delegate;


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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(void)nearbyButtonPressed

- (IBAction)nearbyButtonPressed:(id)sender
{
    if (self.delegate)
    {
        [self.delegate nearbyButtonPressed];
    }
}

- (void)dealloc
{
    [super dealloc];
}
@end
