//
//  ProfileBubble.h
//  NewUX
//
//  Created by Leonardo Cascianelli on 04/11/16.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileBubble : UIView
@property (nonatomic,weak) UIImageView* imageView;
@property (nonatomic,weak) UIImageView* secondaryImage;
@property (nonatomic,weak) UILabel* label;
@property (nonatomic) BOOL displayMainImage;
@property (nonatomic) BOOL displaySecondaryImage;
- (void)setupWithImage:(UIImage*)image text:(NSString*)text secondaryImage:(UIImage*)secondaryImage;
@end
