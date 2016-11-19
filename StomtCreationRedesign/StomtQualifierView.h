//
//  StomtQualifierView.h
//  StomtCreationRedesign
//
//  Created by Leonardo Cascianelli on 17/11/2016.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProfileBubble;

@interface StomtQualifierView : UIView
@property (nonatomic,weak) ProfileBubble* likeBubble;
@property (nonatomic,weak) ProfileBubble* wishBubble;
+ (CGSize)predictedSize;
@end
