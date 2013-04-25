//
//  SetCard.m
//  Set
//
//  Created by Angel on 4/12/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = [self calculateScore:[otherCards mutableCopy]];
    return score;
}

#define MATCH_BONUS 4
#define MATCH_PENALTY 2

- (int)calculateScore:(NSArray *)otherCards
{
    int score = -MATCH_PENALTY;
    
    if (otherCards.count > 0) {
        NSArray *cardsFeatures;
        BOOL isMatch = YES;
        
        for (NSString *feature in [SetCard features]) {
            cardsFeatures = [self fetchFeatures:feature from:otherCards];
            BOOL isSame = [self checkForSameFeaturesWith:cardsFeatures[0]
                                           secondFeature:cardsFeatures[1]
                                            thirdFeature:cardsFeatures[2]];
            BOOL isDifferent = [self checkForDifferentFeaturesWith:cardsFeatures[0]
                                                     secondFeature:cardsFeatures[1]
                                                      thirdFeature:cardsFeatures[2]];
            // If (isSame || isDifferent) is not satisfied break it
            if (!(isSame || isDifferent)) {
                isMatch = NO;
                break;
            }
        }
        if (isMatch) {
            score = 4 * MATCH_BONUS;
        }
    }
    
    return score;
}

- (NSArray *)fetchFeatures:(NSString *)feature from:(NSArray *)otherCards
{
    SetCard *firstCard = otherCards[0];
    SetCard *secondCard = otherCards[1];
    
    if ([feature isEqualToString:@"number"]) {
        return @[self.number, firstCard.number, secondCard.number];
    } else if ([feature isEqualToString:@"symbol"]) {
        return @[self.symbol, firstCard.symbol, secondCard.symbol];
    } else if ([feature isEqualToString:@"shading"]) {
        return @[self.shading, firstCard.shading, secondCard.shading];
    } else if ([feature isEqualToString:@"color"]) {
        return @[self.color, firstCard.color, secondCard.color];
    }
    
    return nil;
}

- (BOOL)checkForSameFeaturesWith:(NSString *)firstFeature
                   secondFeature:(NSString *)secondFeature
                    thirdFeature:(NSString *)thirdFeature
{
    return ([firstFeature isEqualToString:secondFeature]
            && [secondFeature isEqualToString:thirdFeature]);
}

- (BOOL)checkForDifferentFeaturesWith:(NSString *)firstFeature
                        secondFeature:(NSString *)secondFeature
                         thirdFeature:(NSString *)thirdFeature
{
    return !([firstFeature isEqualToString:secondFeature]
             || [secondFeature isEqualToString:thirdFeature]
             || [firstFeature isEqualToString:thirdFeature]);
}

- (NSString *)contents
{
    NSString *contents = @"";
    
    for (NSInteger i = 0; i < [self.number intValue]; i++) {
        contents = [contents stringByAppendingString:self.symbol];
    }
    
    return contents;
}

+ (NSArray *)validNumber
{
    return @[@"1",@"2",@"3"];
}

+ (NSArray *)validSymbol
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShading
{
    return @[@"solid",@"stripe",@"open"];
}

+ (NSArray *)validColor
{
    return @[@"red",@"purple",@"green"];
}

+ (NSArray *)features
{
    return @[@"number",@"symbol",@"shading", @"color"];
}

@end
