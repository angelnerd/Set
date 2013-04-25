//
//  SetCardDeck.m
//  Set
//
//  Created by Angel on 4/12/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        NSString *number;
        NSString *symbol;
        NSString *color;
        NSString *shading;
        
        for (number in [SetCard validNumber]) {
            for (symbol in [SetCard validSymbol]) {
                for (color in [SetCard validColor]) {
                    for (shading in [SetCard validShading]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
