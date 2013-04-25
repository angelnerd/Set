//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Angel on 4/8/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (strong, nonatomic) NSString *matchLabelOutput;
@property (nonatomic) BOOL matchMode;
@property (nonatomic) int numberOfCardsToMatch;

@end
