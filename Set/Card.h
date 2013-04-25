//
//  Card.h
//  Matchismo
//
//  Created by Angel on 4/8/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

@property (strong, nonatomic) NSString *matchDescription;

- (int)match:(NSArray *)otherCards;

@end
