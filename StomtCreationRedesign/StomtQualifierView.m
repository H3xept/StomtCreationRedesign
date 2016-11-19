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

@interface StomtQualifierView ()
@property (nonatomic) kSTObjectQualifier type;
@property (nonatomic) BOOL wishOnFront;
@end

@implementation StomtQualifierView

- (instancetype)initWithType:(kSTObjectQualifier)type
{
    if((self = [super init])){
        _type = type;
        _wishOnFront = (type == kSTObjectWish) ? YES : NO;
    }
    return self;
}
+ (CGSize)predictedSize
{
    CGFloat height = .0f;
    CGFloat width = .0f;
    CGSize size = CGSizeMake(.0f, .0f);
    
    NSString* string = @"I wish";
#warning LATO FONT!
    CGRect boundingRect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil];
    
    width += 8.0f; //H displacement
    width += 10.0f; //H padding
    width += boundingRect.size.width;
    width += 34.0f; //Image
    width += 20.0f; //Image 2
    
    height += 34.0f; //Image
    height += 12.0f; //V displacement
    
    size.width = ceilf(width);
    size.height = ceilf(height);
    
    return size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSString* backString = (_type != kSTObjectLike) ? @"I like" : @"I wish";
    NSString* frontString = (_type == kSTObjectLike) ? @"I like" : @"I wish";
    UIColor* backColour = (_type != kSTObjectLike) ? kLikeColour : kWishColour;
    UIColor* frontColour = (_type == kSTObjectLike) ? kLikeColour : kWishColour;
    UIImage* secondaryImage = [UIImage imageNamed:@"refresh"];
    
    id backBubble;
    id frontBubble;
    
    if(!_likeBubble || !_wishBubble){
        ProfileBubble* likeBubble = [[ProfileBubble alloc] init];
        likeBubble.translatesAutoresizingMaskIntoConstraints = NO;
        likeBubble.backgroundColor = backColour;
        [likeBubble setupWithImage:[UIImage imageNamed:@"lol"] text:backString secondaryImage:nil];
        likeBubble.label.backgroundColor = backColour;
        likeBubble.label.textColor = [UIColor whiteColor];
        [self addSubview:likeBubble];
        
        backBubble = likeBubble;
        
        ProfileBubble* wishBubble = [[ProfileBubble alloc] init];
        wishBubble.translatesAutoresizingMaskIntoConstraints = NO;
        wishBubble.backgroundColor = frontColour;
        [wishBubble setupWithImage:[UIImage imageNamed:@"lol"] text:frontString secondaryImage:secondaryImage];
        wishBubble.label.backgroundColor = frontColour;
        wishBubble.label.textColor = [UIColor whiteColor];
        [self addSubview:wishBubble];
        _wishBubble = wishBubble;
        
        frontBubble = wishBubble;
        
        
        _wishBubble = (_wishOnFront) ? frontBubble : backBubble;
        _likeBubble = (_wishOnFront) ? backBubble : frontBubble;
        
        NSLayoutConstraint* wishBubbleLeftMargin = [NSLayoutConstraint constraintWithItem:frontBubble attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:.0f];
        NSLayoutConstraint* likeBubbleLeftMargin = [NSLayoutConstraint constraintWithItem:backBubble attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:16.0f];
        NSLayoutConstraint* wishBubbleBotMargin = [NSLayoutConstraint constraintWithItem:frontBubble attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:.0f];
        NSLayoutConstraint* likeBubbleBotMargin = [NSLayoutConstraint constraintWithItem:backBubble attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-12.0f];
        
        [self addConstraint:wishBubbleBotMargin];
        [self addConstraint:wishBubbleLeftMargin];
        [self addConstraint:likeBubbleBotMargin];
        [self addConstraint:likeBubbleLeftMargin];
    }
}

- (CGSize)intrinsicContentSize
{
    return [StomtQualifierView predictedSize];
}

@end
