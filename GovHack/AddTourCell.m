//
//  AddTourCell.m
//  GovHack
//
//  Created by Myles on 1/06/13.
//  Copyright (c) 2013 Myles. All rights reserved.
//

#import "AddTourCell.h"
@interface AddTourCell()
{

}
-(void)addButtonPressed:(UIButton*)button;

@end




@implementation AddTourCell

@synthesize delegate = _delegate;
@synthesize tour = _tour;


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
    [self.button addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addButtonPressed:(UIButton*)button
{
    [self.delegate addTourCellButtonPressed:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_label release];
    [_button release];
    [super dealloc];
}
@end
