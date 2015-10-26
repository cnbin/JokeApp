//
//  MainTableViewCell.m
//  Smile
//
//  Created by Apple on 10/21/15.
//  Copyright © 2015 cnbin. All rights reserved.
//

#import "MainTableViewCell.h"

@interface MainTableViewCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    self.jokeTitle= [UILabel newAutoLayoutView];
    [self.jokeTitle setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.jokeTitle setNumberOfLines:1];
    [self.jokeTitle setTextAlignment:NSTextAlignmentLeft];
    self.jokeTitle.font = [UIFont fontWithName:@"Helvetica" size:15];
    [self.jokeTitle setTextColor:[UIColor blueColor]];
        
    self.jokeContent = [UILabel newAutoLayoutView];
    [self.jokeContent setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.jokeContent setNumberOfLines:0];
    [self.jokeContent setTextAlignment:NSTextAlignmentLeft];
    [self.jokeContent setTextColor:[UIColor blackColor]];
    self.jokeContent.font = [UIFont fontWithName:@"Helvetica" size:12];
    
    self.jokeTime = [UILabel newAutoLayoutView];
    [self.jokeTime setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.jokeTime setNumberOfLines:1];
    [self.jokeTime setTextAlignment:NSTextAlignmentLeft];
    [self.jokeTime setTextColor:[UIColor blackColor]];
    self.jokeTime.font = [UIFont fontWithName:@"Helvetica" size:12];
    
    [self.contentView addSubview:self.jokeTitle];
    [self.contentView addSubview:self.jokeContent];
    [self.contentView addSubview:self.jokeTime];

    }
    
    return self;

}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        //title
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.jokeTitle autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.jokeTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.jokeTitle autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
        [self.jokeTitle autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
        
        //content
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.jokeContent autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.jokeContent autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
        [self.jokeContent autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
        [self.jokeContent autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.jokeTitle withOffset:10];
        
        //time
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.jokeTime autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.jokeTime autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
        [self.jokeTime autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.jokeContent withOffset:10];
        [self.jokeTime autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        
        self.didSetupConstraints = YES;
        
    }
    
    [super updateConstraints];
}


@end
