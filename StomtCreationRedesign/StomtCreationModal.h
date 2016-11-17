//
//  StomtCreationModal.h
//  NewUX
//
//  Created by Leonardo Cascianelli on 03/11/16.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stomt.h"

@interface StomtCreationModal : UIViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil target:(STTarget *)target defaultText:(NSString *)defaultText likeOrWish:(kSTObjectQualifier)likeOrWish;
@end
