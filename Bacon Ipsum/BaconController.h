//
//  BaconController.h
//  Bacon Ipsum
//
//  Created by Clayton Webb on 10/1/13.
//  Copyright (c) 2013 Clayton Webb. All rights reserved.
//
/*
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 */

#import <UIKit/UIKit.h>

@interface BaconController : UITableViewController
{
    int numberOfParagraphs;
    BOOL withFiller;
    BOOL startWithBacon;
    
    IBOutlet UITextView *baconView;
    UIImageView *pigView;
}

@property (nonatomic) int numberOfParagraphs;
@property (nonatomic) BOOL withFiller;
@property (nonatomic) BOOL startWithBacon;

@property (nonatomic, retain) IBOutlet UITextView *baconView;

- (NSArray *)getWordsWithFiller:(BOOL)type;

- (NSString *)makeSentenceWithFiller:(BOOL)withFiller;
- (NSString *)makeAParagraphWithFiller:(BOOL)withFiller;

- (NSString *)makeSomeBaconWithType:(BOOL)type paragraphs:(int)p startingWithBacon:(BOOL)b;

- (NSArray *)shuffleArray:(NSArray *)array;
- (NSString *)ucFirst:(NSString *)string;
- (NSString *)rTrim:(NSString *)string;

- (void)copyText;
- (void)showCopiedNotificationWithDelay:(double)delay;

@end