//
//  StomtQualifierView.m
//  StomtCreationRedesign
//
//  Created by Leonardo Cascianelli on 17/11/2016.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import "StomtQualifierView.h"

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
    
    height += 34.0f; //Image
    height += 4.0f; //V displacement
    height += 4.0f; //V padding
    height += boundingRect.size.height;
    
    size.width = ceilf(width);
    size.height = ceilf(height);
    
    return size;
}

- (CGSize)intrinsicContentSize
{
    return [StomtQualifierView predictedSize];
}

@end
