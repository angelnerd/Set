//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Angel on 4/8/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController <UIAlertViewDelegate>

@property (readonly) int numberOfCardsToMatch;

- (Deck *)createNewDeck;
- (void)updateCardButton:(UIButton *)cardButton card:(Card *)card;

@end
