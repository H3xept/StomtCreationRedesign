//
//  ProfileBubble.m
//  NewUX
//
//  Created by Leonardo Cascianelli on 04/11/16.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import "ProfileBubble.h"

@interface ProfileBubble (){
	CAShapeLayer* roundMask;
	CAShapeLayer* imageMask;
	BOOL viewsHaveBeenRounded;
	BOOL labelConstraintsHaveBeenSetup;
}

#define labelLeftSpacing 8.0f
#define labelRightSpacing 8.0f

@property (nonatomic,weak) NSLayoutConstraint* labelConstraintLeftSpacing;
@property (nonatomic,weak) NSLayoutConstraint* labelConstraintRightSpacing;

- (CGFloat)labelPredictedWidthWithSpacing:(BOOL)spacing;
- (void)loadLabelConstraints;
@end

@implementation ProfileBubble

- (instancetype)init
{
	if((self = [super init]))
	{
		self.backgroundColor = [UIColor whiteColor];
        _displayMainImage = YES;
        _displaySecondaryImage = YES;
	}
	return self;
}

- (void)setupWithImage:(UIImage*)image text:(NSString*)text secondaryImage:(UIImage*)secondaryImage
{
	//Need to add placeholder
	
	if(!_imageView){
		UIImageView* imageView = [[UIImageView alloc] init];
		imageView.backgroundColor = [UIColor whiteColor];
		[self addSubview:imageView];
		_imageView = imageView;
	}
	_imageView.image = (image) ? image : [UIImage new]; //nil set image easy
	
	if(!_label){
		UILabel* label = [[UILabel alloc] init];
		label.translatesAutoresizingMaskIntoConstraints = NO;
		label.backgroundColor = [UIColor whiteColor];
		label.textColor = [UIColor purpleColor];
		label.font = [UIFont systemFontOfSize:14.0f];
		[self addSubview:label];
		_label = label;
	}
	_label.text = (text && ![text isEqualToString:@""]) ? text : @"Anonymous. Login?";
	
    if(!_secondaryImage && _displaySecondaryImage && secondaryImage){
        UIImageView* secondaryImage = [[UIImageView alloc] init];
        secondaryImage.translatesAutoresizingMaskIntoConstraints = NO;
        secondaryImage.backgroundColor = [UIColor whiteColor];
        [self addSubview:secondaryImage];
        _secondaryImage = secondaryImage;
    }
    _secondaryImage.image = secondaryImage;
    
	[self loadLabelConstraints];
}

- (void)loadLabelConstraints
{
	if(!self->labelConstraintsHaveBeenSetup){
		
        if(_secondaryImage){
            NSLayoutConstraint* secondaryImageVerticalCenter = [NSLayoutConstraint constraintWithItem:_secondaryImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:.0f];
            NSLayoutConstraint* secondaryImageHeightConstraint = [NSLayoutConstraint constraintWithItem:_secondaryImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:24.0f];
            NSLayoutConstraint* secondaryImageAspectRatio = [NSLayoutConstraint constraintWithItem:_secondaryImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_secondaryImage attribute:NSLayoutAttributeHeight multiplier:1.0f constant:.0f];
            NSLayoutConstraint* secondaryImageRightSpacing = [NSLayoutConstraint constraintWithItem:_secondaryImage attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-8.0f];
            
            [self addConstraint:secondaryImageVerticalCenter];
            [self addConstraint:secondaryImageRightSpacing];
            [self addConstraint:secondaryImageHeightConstraint];
            [_secondaryImage addConstraint:secondaryImageAspectRatio];
        }
        
        id secondObject = (_secondaryImage) ? _secondaryImage : self;
        CGFloat spacing = (secondObject == _secondaryImage) ? 20.0f : .0f;
        
		NSLayoutConstraint* spacingFromImage = [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeRight multiplier:1.0f constant:labelLeftSpacing];
		NSLayoutConstraint* rightSpacing = [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:secondObject attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-labelRightSpacing-spacing];
		
		NSLayoutConstraint* verticalCenter = [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:.0f];
		
		[self addConstraint:verticalCenter];
		[self addConstraint:spacingFromImage];
		[self addConstraint:rightSpacing];
		
		_labelConstraintLeftSpacing = spacingFromImage;
		_labelConstraintRightSpacing = rightSpacing;
		
		self->labelConstraintsHaveBeenSetup = YES;
	}
}

- (CGFloat)labelPredictedWidthWithSpacing:(BOOL)spacing
{
	CGFloat labelWidth = .0f;
	
	if(self->labelConstraintsHaveBeenSetup){
		labelWidth = [_label.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50.0f, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size.width;
		if(spacing)
			labelWidth += labelLeftSpacing + labelRightSpacing;
	}

	
	return labelWidth;
}

- (void)layoutSubviews
{
    CGFloat height = (_displayMainImage && _imageView) ? self.bounds.size.height-4 : .0f;
    CGFloat width = height;
    
    _imageView.frame = CGRectMake(2, 2, height, width);
    
    if(!self->viewsHaveBeenRounded){
        
//        CGFloat labelPredictedWidth = [self labelPredictedWidthWithSpacing:YES];
//        if(labelPredictedWidth == .0f) labelPredictedWidth += 2.0f;
//        CGFloat predictedWidth = 2.0f + _imageView.frame.size.width + labelPredictedWidth;
//        
//        UIBezierPath* roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, predictedWidth, self.frame.size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(ceilf(self.frame.size.height/2), ceilf(self.frame.size.height/2))];
//        
//        CAShapeLayer* maskLayer = [CAShapeLayer layer];
//        maskLayer.path = roundPath.CGPath;
//        self.layer.mask = maskLayer;
//        
//        self->roundMask = maskLayer;
        
        self.layer.cornerRadius = (self.bounds.size.height)/2;
        
        UIBezierPath* imageRoundPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(_imageView.frame.size.height/2, _imageView.frame.size.height/2)];
        
        CAShapeLayer* imageMaskLayer = [CAShapeLayer layer];
        imageMaskLayer.path = imageRoundPath.CGPath;
        _imageView.layer.mask = imageMaskLayer;
        
        self->imageMask = imageMaskLayer;
        
        //Secondary image
        
        _secondaryImage.layer.masksToBounds = YES;
        _secondaryImage.layer.cornerRadius = 12.0f;
        
        self->viewsHaveBeenRounded = YES;
    }
}


- (CGSize)intrinsicContentSize
{
	return CGSizeMake(34.0f, 34.0f);
}

@end
