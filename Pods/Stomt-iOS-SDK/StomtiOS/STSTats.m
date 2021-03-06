//
//  Stats.m
//  StomtiOS
//
//  Created by Leonardo Cascianelli on 12/09/15.
//  Copyright (c) 2015 Leonardo Cascianelli. All rights reserved.
//

#import "STStats.h"
#import "dbg.h"

@interface STStats ()
- (instancetype)initWithFollowers:(NSInteger)followers
				  peopleItFollows:(NSInteger)follows
					createdStomts:(NSInteger)cStomts
				   receivedStomts:(NSInteger)rStomts;
@end

@implementation STStats

- (instancetype)init
{
	self = [super init];
	if(self)
	{
		_followers =
		_follows =
		_createdStomts =
		_receivedStomts = 0;
	}
	return self;
}

- (instancetype)initWithFollowers:(NSInteger)followers
				  peopleItFollows:(NSInteger)follows
					createdStomts:(NSInteger)cStomts
				   receivedStomts:(NSInteger)rStomts
{
	self = [super init];
	if(self)
	{
		_followers = followers;
		_follows = follows;
		_createdStomts = cStomts;
		_receivedStomts = rStomts;
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
#define ezIn(X,Y) [aCoder encodeInteger:self.X forKey:Y];
	ezIn(followers,@"followers");
	ezIn(follows, @"follows");
	ezIn(createdStomts, @"createdStomts");
	ezIn(receivedStomts, @"receivedStomts");
	
#ifdef ezIn
#undef ezIn
#endif
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if(self = [super init])
	{
		
#define ezOut(X,Y) self.X = [aDecoder decodeIntegerForKey:Y];
		
		ezOut(followers,@"followers");
		ezOut(follows, @"follows");
		ezOut(createdStomts, @"createdStomts");
		ezOut(receivedStomts, @"receivedStomts");
		
#ifdef ezOut
#undef ezOut
#endif
		return self;
		
	} _err("Could not init with coder. Aborting...");
error:
	return nil;
}

+ (instancetype)initWithStatsDictionary:(NSDictionary*)stats
{
	NSInteger followers,follows,cStomts,rStomts;
	STStats* statsObject;
	
	if(!stats) _err("No stats dictionary provided. Aborting...");
	 followers = [[stats objectForKey:@"amountFollowers"] integerValue];
	 follows = [[stats objectForKey:@"amountFollowers"] integerValue];
	 cStomts = [[stats objectForKey:@"amountFollowers"] integerValue];
	 rStomts = [[stats objectForKey:@"amountFollowers"] integerValue];
	
	statsObject = [[STStats alloc] initWithFollowers:followers
											  peopleItFollows:follows
												createdStomts:cStomts
											   receivedStomts:rStomts];
	if(statsObject)
		return statsObject;
	else _err("Could not create stats object.");

//Fallthrough intended ->|
error:
	return nil;
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"<STTats Object\nFollowers: %ld\nFollows:%ld\nCreated stomts:%ld\nReceived stomts:%ld\n>",(long)_followers,(long)_follows,(long)_createdStomts,(long)_receivedStomts];
}

@end
