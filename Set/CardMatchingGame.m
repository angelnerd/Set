//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Angel on 4/8/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "CardMatchingGame.h"
#import "SetCard.h"
#import "PlayingCard.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index  
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            
            // Output the description of the flipped card
            self.matchLabelOutput = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            
            // Array of cards we're going to compute
            NSMutableArray *cardsToMatch = [[NSMutableArray alloc] init];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardsToMatch addObject:otherCard];
                    if ([cardsToMatch count] == (self.numberOfCardsToMatch - 1)) break;
                }
            }

            if ([cardsToMatch count] == (self.numberOfCardsToMatch - 1)) {
                int matchScore = [card match:[cardsToMatch mutableCopy]];
                self.score += matchScore;
                
                if ([card isKindOfClass:[SetCard class]]) {
                    if (matchScore > 0) {
                        for (Card *otherCard in cardsToMatch) otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.matchLabelOutput = [NSString stringWithFormat:@"You matched %@, %@, and %@! +%dpts", [card contents], [cardsToMatch[0] contents], [cardsToMatch[1] contents], self.score];
                    } else {
                        for (Card *otherCard in self.cards) {
                            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                                otherCard.faceUp = NO;
                            }
                        }
                        self.matchLabelOutput = [NSString stringWithFormat:@"%@, %@, and %@ don't match. %dpt penalty.", [card contents], [cardsToMatch[0] contents], [cardsToMatch[1] contents], self.score];
                    }
                } else {
                    if (matchScore > 0) {
                        for (Card *otherCard in cardsToMatch) otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.matchLabelOutput = [NSString stringWithFormat:@"You matched %@ and %@! +%dpts", [card contents], [cardsToMatch[0] contents], self.score];
                    } else {
                        for (Card *otherCard in self.cards) {
                            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                                otherCard.faceUp = NO;
                            }
                        }
                        self.matchLabelOutput = [NSString stringWithFormat:@"%@ and %@ don't match. %dpt penalty.", [card contents], [cardsToMatch[0] contents], self.score];
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
