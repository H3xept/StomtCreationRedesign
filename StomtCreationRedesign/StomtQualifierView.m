//
//  StomtQualifierView.m
//  StomtCreationRedesign
//
//  Created by Leonardo Cascianelli on 17/11/2016.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import "StomtQualifierView.h"
#import "ProfileBubble.h"

#define kWishColour [UIColor colorWithRed:0.44 green:0.07 blue:0.85 alpha:1.0]
#define kLikeColour [UIColor colorWithRed:0.25 green:0.79 blue:0.66 alpha:1.0]
@implementation StomtQualifierView

+ (CGSize)predictedSize
{
    CGFloat height = .0f;
    CGFloat width = .0f;
    CGSize size = CGSizeMake(.0f, .0f);
    
    NSString* string = @"I wish";
#warning LATO FONT!
    CGRect boundingRect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil];
    
    width += 16.0f; //H displacement
    width += 8.0f; //H padding
    width += boundingRect.size.width;
    width += 34.0f; //Image
    width += 24.0f; //Image 2
    
    height += 34.0f; //Image
    height += 12.0f; //V displacement
    
    size.width = ceilf(width);
    size.height = ceilf(height);
    
    return size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(!_likeBubble){
        ProfileBubble* likeBubble = [[ProfileBubble alloc] init];
        likeBubble.translatesAutoresizingMaskIntoConstraints = NO;
        likeBubble.backgroundColor = kLikeColour;
        [likeBubble setupWithImage:[UIImage imageNamed:@"lol"] text:@"I like" secondaryImage:[UIImage imageNamed:@"refresh"]];
        likeBubble.label.backgroundColor = kLikeColour;
        likeBubble.label.textColor = [UIColor whiteColor];
        [self addSubview:likeBubble];
        _likeBubble = likeBubble;
    }
    if(!_wishBubble){
        ProfileBubble* wishBubble = [[ProfileBubble alloc] init];
        wishBubble.translatesAutoresizingMaskIntoConstraints = NO;
        wishBubble.backgroundColor = kWishColour;
        [wishBubble setupWithImage:[UIImage imageNamed:@"lol"] text:@"I wish" secondaryImage:[UIImage imageNamed:@"refresh"]];
        wishBubble.label.backgroundColor = kWishColour;
        wishBubble.label.textColor = [UIColor whiteColor];
        [self addSubview:wishBubble];
        _wishBubble = wishBubble;
    }
    NSLayoutConstraint* wishBubbleLeftMargin = [NSLayoutConstraint constraintWithItem:_wishBubble attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:.0f];
    NSLayoutConstraint* likeBubbleLeftMargin = [NSLayoutConstraint constraintWithItem:_likeBubble attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:16.0f];
    NSLayoutConstraint* wishBubbleBotMargin = [NSLayoutConstraint constraintWithItem:_wishBubble attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:.0f];
    NSLayoutConstraint* likeBubbleBotMargin = [NSLayoutConstraint constraintWithItem:_likeBubble attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-12.0f];
    
    [self addConstraint:wishBubbleBotMargin];
    [self addConstraint:wishBubbleLeftMargin];
    [self addConstraint:likeBubbleBotMargin];
    [self addConstraint:likeBubbleLeftMargin];
}

- (CGSize)intrinsicContentSize
{
    return [StomtQualifierView predictedSize];
}

@end
