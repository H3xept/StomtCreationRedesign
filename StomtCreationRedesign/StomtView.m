//
//  StomtView.m
//  NewUX
//
//  Created by Leonardo Cascianelli on 11/11/16.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import "StomtView.h"
#import "StomtQualifierView.h"
#import "ProfileBubble.h"

@interface StomtView ()
@property (nonatomic,weak) CAShapeLayer* mask;
@end

@implementation StomtView

- (instancetype)init
{
	if((self = [super init])){
		self.backgroundColor = [UIColor whiteColor];
        self.alwaysBounceVertical = YES;
        self.layer.masksToBounds = YES;
	}
	return self;
}

- (void)drawRect:(CGRect)rect
{
    if(!_contentView){
        UIView* contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:contentView];
        _contentView = contentView;
        
        NSArray* horizontalPin = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)];
        NSArray* verticalPin = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)];
        
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:.0f];
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:50.0f];
        
        [self addConstraint:width];
        [self addConstraint:height];
        [self addConstraints:horizontalPin];
        [self addConstraints:verticalPin];
    }
    
    if(!_likeWishView){
        StomtQualifierView* likeWishView = [[StomtQualifierView alloc] init];
        likeWishView.translatesAutoresizingMaskIntoConstraints = NO;
        likeWishView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:likeWishView];
        _likeWishView = likeWishView;
        
        NSLayoutConstraint* topSpacingConstraint = [NSLayoutConstraint constraintWithItem:likeWishView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:8.0f];
        NSLayoutConstraint* leftSpacingConstraint = [NSLayoutConstraint constraintWithItem:likeWishView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:8.0f];
        
        [_contentView addConstraint:topSpacingConstraint];
        [_contentView addConstraint:leftSpacingConstraint];
    }
    
    if(!_profileBubble){
        ProfileBubble* profileBubble = [[ProfileBubble alloc] init];
        profileBubble.translatesAutoresizingMaskIntoConstraints = NO;
        profileBubble.backgroundColor = [UIColor whiteColor];
        profileBubble.layer.borderColor = [UIColor lightGrayColor].CGColor;
        profileBubble.layer.borderWidth = 1.0f;
        [profileBubble setupWithImage:nil text:@"UFO PORNOOOOOOOOOOOO" secondaryImage:nil];
        
        [_contentView addSubview:profileBubble];
        _profileBubble = profileBubble;
        
        NSLayoutConstraint* midEqualToLikeWishViewConstraint = [NSLayoutConstraint constraintWithItem:profileBubble attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_likeWishView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:.0f];
        NSArray* horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_likeWishView]-[profileBubble(>=8)]-(>=8)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_likeWishView,profileBubble)];
        NSArray* verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[profileBubble(>=8)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(profileBubble)];
        
        [_contentView addConstraints:verticalConstraints];
        [_contentView addConstraint:midEqualToLikeWishViewConstraint];
        [_contentView addConstraints:horizontalConstraints];
        
        [_profileBubble setNeedsDisplay];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = 7.0f;
}

@end
