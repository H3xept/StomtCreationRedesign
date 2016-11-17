//
//  StomtView.h
//  NewUX
//
//  Created by Leonardo Cascianelli on 11/11/16.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StomtQualifierView;

@interface StomtView : UIScrollView
@property (nonatomic,weak) UIView* contentView;
@property (nonatomic,weak) StomtQualifierView* likeWishView;
@end
