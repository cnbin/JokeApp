//
//  MainTableViewCell.h
//  Smile
//
//  Created by Apple on 10/21/15.
//  Copyright © 2015 cnbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PureLayout/PureLayout.h>
@interface MainTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *jokeTitle;
@property (strong, nonatomic) UILabel *jokeContent;
@property (strong, nonatomic) UILabel *jokeTime;

@end
