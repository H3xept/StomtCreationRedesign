//
//  StomtView.m
//  NewUX
//
//  Created by Leonardo Cascianelli on 11/11/16.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import "StomtView.h"

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
        
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:.0f];
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:50.0f];
        
        [self addConstraint:width];
        [self addConstraint:height];
        [self addConstraints:horizontalPin];
        [self addConstraints:verticalPin];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = 7.0f;
}

@end
