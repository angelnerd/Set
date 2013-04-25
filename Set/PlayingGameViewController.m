//
//  PlayingGameViewController.m
//  Set
//
//  Created by Angel on 4/15/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "PlayingGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface PlayingGameViewController ()

@end

@implementation PlayingGameViewController

- (int)numberOfCardsToMatch
{
    // We're matching 2 cards here
    return 2;
}

- (Deck *)createNewDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)updateCardButton:(UIButton *)cardButton card:(Card *)card
{
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    
    // set the background
    [cardButton setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
    if (card.isFaceUp) {
        [cardButton setImage:nil forState:UIControlStateNormal];
    }
}

@end
