//
//  ViewController.m
//  NewUX
//
//  Created by Leonardo Cascianelli on 03/11/16.
//  Copyright © 2016 Leonardo Cascianelli. All rights reserved.
//

#import "ViewController.h"
#import "StomtCreationModal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	StomtCreationModal* modal = [[StomtCreationModal alloc] initWithNibName:nil bundle:nil target:nil defaultText:nil likeOrWish:0];
	
	[self presentViewController:modal animated:YES completion:nil];

	
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	StomtCreationModal* modal = [[StomtCreationModal alloc] initWithNibName:nil bundle:nil target:nil defaultText:nil likeOrWish:0];
	
	[self presentViewController:modal animated:YES completion:nil];
}

@end
