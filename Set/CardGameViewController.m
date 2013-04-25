//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Angel on 4/8/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *recentMatchesLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createNewDeck]];
        _game.numberOfCardsToMatch = self.numberOfCardsToMatch;
    }
    return _game;
}

- (Deck *)createNewDeck
{
    // Must be implemented by derived class
    return nil;
}

- (void)updateCardButton:(UIButton *)cardButton card:(Card *)card
{
    // Must be implemented by derived class
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [self updateCardButton:cardButton card:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.recentMatchesLabel.text = self.game.matchLabelOutput;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealNewGame:(id)sender
{
    if (self.flipCount > 0) {
        UIAlertView *newGameWarning = [[UIAlertView alloc] initWithTitle:@"Start New Game"
                                                                 message:@"Are you sure you want to start over?"
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:@"Ok", nil];
        [newGameWarning show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    } else {
        [self createNewGame];
    }
}

- (void)createNewGame
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

@end
