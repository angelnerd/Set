//
//  SetCard.h
//  Set
//
//  Created by Angel on 4/12/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;

+ (NSArray *)validNumber;
+ (NSArray *)validSymbol;
+ (NSArray *)validShading;
+ (NSArray *)validColor;

@end
