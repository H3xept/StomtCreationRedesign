//
//  StomtCreationModal.m
//  NewUX
//
//  Created by Leonardo Cascianelli on 03/11/16.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import "StomtCreationModal.h"
#import "ProfileBubble.h"
#import "StomtView.h"

#define kLightPurple [UIColor colorWithRed:0.76 green:0.17 blue:1.00 alpha:0.1]
#define kDarkPurple [UIColor colorWithRed:0.56 green:0.07 blue:1.00 alpha:1.0]

@interface StomtCreationModal (){
	CAGradientLayer* gradientLayer;
	BOOL blurredViewHasBeenSetup;
}
@property (nonatomic,weak) UIView* containerView;
@property (nonatomic,weak) UIScrollView* scrollView;
@property (nonatomic,weak) UIButton* closeButton;
@property (nonatomic,weak) UIVisualEffectView* blurredView;
@property (nonatomic,weak) StomtView* stomtView;
@property (nonatomic,weak) NSLayoutConstraint* topPaddingCloseButton;
@property (nonatomic,weak) NSLayoutConstraint* topPaddingProfileBubble;
@property (nonatomic,weak) NSLayoutConstraint* containerViewWidth;
@property (nonatomic,weak) NSLayoutConstraint* containerViewHeight;
@property (nonatomic,weak) ProfileBubble* profileBubble;
- (void)setupBackground;
- (void)closeButtonHasBeenPressed;
@end

@implementation StomtCreationModal

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil target:(STTarget *)target defaultText:(NSString *)defaultText likeOrWish:(kSTObjectQualifier)likeOrWish
{
	if((self = [super init]))
	{
		[self setupBackground];
	}
	return self;
}

- (void)setupBackground
{
	if(!blurredViewHasBeenSetup){
		
		// ====================
		// Blurred View
		// ====================
		UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		UIVisualEffectView *beView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		beView.translatesAutoresizingMaskIntoConstraints = NO;

		self.view.backgroundColor = [UIColor clearColor];
		[self.view insertSubview:beView atIndex:0];
		self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
		
		_blurredView = beView;
		
		// ========================
		// Blurred View Constraints
		// ========================
		NSArray* horiztonalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_blurredView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_blurredView)];
		NSArray* verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_blurredView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_blurredView)];
		[self.view addConstraints:horiztonalConstraints];
		[self.view addConstraints:verticalConstraints];
		
		// ========================
		// Purple gradient overlay
		// ========================
		CAGradientLayer *gradient = [CAGradientLayer layer];
	
		gradient.colors = @[(id)kLightPurple.CGColor,(id)kDarkPurple.CGColor];
		gradient.locations = @[@0.0,@0.5];
		
		[self.view.layer insertSublayer:gradient atIndex:1];
		
		self->gradientLayer = gradient;
		self->gradientLayer.frame = [UIScreen mainScreen].bounds;
		
		self->blurredViewHasBeenSetup = YES;
	}
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	if(!_scrollView){
		UIScrollView* scrollView = [[UIScrollView alloc] init];
		scrollView.translatesAutoresizingMaskIntoConstraints = NO;
		scrollView.backgroundColor = [UIColor clearColor];
		scrollView.alwaysBounceVertical = YES;
        scrollView.delaysContentTouches = NO;
		[self.view addSubview:scrollView];
		_scrollView = scrollView;
		
		NSArray* horiztonalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)];
		NSArray* verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)];
		[self.view addConstraints:horiztonalConstraints];
		[self.view addConstraints:verticalConstraints];
	}
	if(!_containerView){
		UIView* containerView = [[UIView alloc] init];
		containerView.backgroundColor = [UIColor clearColor];
		containerView.translatesAutoresizingMaskIntoConstraints = NO;
		[_scrollView addSubview:containerView];
		_containerView = containerView;
		
		NSArray* horiztonalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)];
		NSArray* verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)];
		
		NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:[UIScreen mainScreen].bounds.size.width];
		NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:[UIScreen mainScreen].bounds.size.height];
		
		[_containerView addConstraint:width];
		[_containerView addConstraint:height];
		
		_containerViewWidth = width;
		_containerViewHeight = height;
		
		[self.scrollView addConstraints:horiztonalConstraints];
		[self.scrollView addConstraints:verticalConstraints];
	}
	
	if(!_closeButton){
		UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		closeButton.backgroundColor  = [UIColor whiteColor];
		[closeButton setImage:[UIImage imageNamed:@"purpleCloseButtonX"] forState:UIControlStateNormal];
		closeButton.translatesAutoresizingMaskIntoConstraints = NO;
		closeButton.contentMode = UIViewContentModeCenter;
		[closeButton addTarget:self action:@selector(closeButtonHasBeenPressed) forControlEvents:UIControlEventTouchUpInside];
		
		// ========================
		// Round Mask (Elon)
		// ========================
		
		UIBezierPath* roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 34, 34) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(17, 17)];
		CAShapeLayer *roundLayer = [CAShapeLayer layer];
		roundLayer.path = roundPath.CGPath;
		closeButton.layer.masksToBounds = YES;
		closeButton.layer.mask = roundLayer;
		
		[_containerView addSubview:closeButton];
		
		_closeButton = closeButton;
		
		// ========================
		// Boring Constraints
		// ========================
		
		NSLayoutConstraint* trailingSpaceFromContainer = [NSLayoutConstraint constraintWithItem:closeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-16.0f];
		NSLayoutConstraint* topSpaceFromContainer = [NSLayoutConstraint constraintWithItem:closeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeTop multiplier:1.0f constant:16.0f+20.0f];
		NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:closeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:34.0f];
		NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:closeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:34.0f];
		
		[_containerView addConstraints:@[trailingSpaceFromContainer,topSpaceFromContainer,heightConstraint,widthConstraint]];
		
		_topPaddingCloseButton = topSpaceFromContainer;
	}
	if(!_profileBubble){
		ProfileBubble* profileBubble = [[ProfileBubble alloc] init];
		profileBubble.translatesAutoresizingMaskIntoConstraints = NO;
		[self.containerView addSubview:profileBubble];
		_profileBubble = profileBubble;
		
#warning image download
		[profileBubble setupWithImage:[UIImage imageNamed:@"lol"] text:@""];
		
		// ========================
		// Boring Constraints
		// ========================
		
		//There is an error ahead, i'll find time to fix it. If you start in landscape mode the spacing from top is wrong.
		
		NSArray* horiztonalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[_profileBubble(>=8)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_profileBubble,_closeButton)];

		NSLayoutConstraint* verticalSpacing = [NSLayoutConstraint constraintWithItem:_profileBubble attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeTop multiplier:1.0f constant:20.0f+16.0f];
		NSLayoutConstraint* horizontalSpacing = [NSLayoutConstraint constraintWithItem:_profileBubble attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:16.0f];
		
		[self.containerView addConstraint:verticalSpacing];
		[self.containerView addConstraint:horizontalSpacing];
		[self.containerView addConstraints:horiztonalConstraints];
		
		_topPaddingProfileBubble = verticalSpacing;
	}
    if(!_stomtView){
        StomtView* stomtView = [[StomtView alloc] init];
        stomtView.translatesAutoresizingMaskIntoConstraints = NO;
        [_containerView addSubview:stomtView];
        _stomtView = stomtView;
        
        NSArray* horizontalPin = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[stomtView]-12-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(stomtView)];
        NSArray* verticalPin = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_profileBubble]-16-[stomtView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(stomtView,_profileBubble)];
        
        [self.containerView addConstraints:horizontalPin];
        [self.containerView addConstraints:verticalPin];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
	// ===========================================
	// Why do people use landscape mode, it's lame
	// ===========================================
	[UIView animateWithDuration:.1f animations:^{
		CGFloat topPadding;
		
		self->gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
		
		topPadding = (size.width > size.height) ? 16.0f : 20.0f+16.0f;
		if(_topPaddingCloseButton) _topPaddingCloseButton.constant = topPadding;
		if(_topPaddingProfileBubble) _topPaddingProfileBubble.constant = topPadding;
		
		_containerViewHeight.constant = size.height;
		_containerViewWidth.constant = size.width;
		
	}];
}

#pragma mark Interactions

- (void)closeButtonHasBeenPressed
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
