//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Angel on 4/8/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (int)numberOfCardsToMatch
{
    return 3;
}

- (Deck *)createNewDeck
{
    return [[SetCardDeck alloc] init];
}

- (void)updateCardButton:(UIButton *)cardButton card:(Card *)card
{
    // Customize the button
    cardButton.backgroundColor = [UIColor whiteColor];
    
    // Set the label
    [cardButton setAttributedTitle:[self setCardFormattedString:card] forState:UIControlStateNormal];
    
    // Set state attributes
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = (card.isUnplayable) ? 0.3 : 1;
    
    if (card.isFaceUp) {
        cardButton.backgroundColor = [UIColor lightGrayColor];
    } else {
        cardButton.backgroundColor = nil;
    }
    
    if (card.isUnplayable) {
        cardButton.hidden = YES;
    } else {
        cardButton.hidden = NO;
    }
}
     
- (NSMutableAttributedString *)setCardFormattedString:(Card *)card
{
    NSString *cardButtonContents = card.contents;
    //NSRange rangeForString = NSMakeRange(0, [card.contents length]);
    NSMutableAttributedString *cardButtonTitle = [[NSMutableAttributedString alloc] initWithString:cardButtonContents attributes:[self cardAttributes:(SetCard *)card]];
    
    return cardButtonTitle;
}

- (NSDictionary *)cardAttributes:(SetCard *)card
{
    NSString *cardShade = card.shading;
    UIColor *cardColor = [[SetGameViewController colorScheme] objectForKey:card.color];
    UIColor *foreGroundColor = nil;
    
    // Set the proper shading using the colors
    if ([cardShade isEqualToString:@"solid"]) {
        foreGroundColor = cardColor;
    } else if ([cardShade isEqualToString:@"stripe"]) {
        foreGroundColor = [cardColor colorWithAlphaComponent:0.3];
    } else if ([cardShade isEqualToString:@"open"]) {
        foreGroundColor = [UIColor clearColor];
    }
    
    return @{NSFontAttributeName: [UIFont systemFontOfSize:18],
             NSForegroundColorAttributeName: foreGroundColor,
             NSStrokeWidthAttributeName: @-4,
             NSStrokeColorAttributeName: cardColor};
}

+ (NSDictionary *)colorScheme
{
    return @{@"red": [UIColor redColor],
             @"purple": [UIColor purpleColor],
             @"green": [UIColor greenColor]};
}

@end
