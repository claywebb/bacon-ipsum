//
//  BaconController.m
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

#import "BaconController.h"

@interface BaconController ()

@end

@implementation BaconController
@synthesize baconView, withFiller, numberOfParagraphs, startWithBacon;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    baconView.frame = CGRectMake(baconView.frame.origin.x, baconView.frame.origin.y, baconView.frame.size.width, self.view.frame.size.height - 44);
    baconView.text = [self makeSomeBaconWithType:withFiller paragraphs:numberOfParagraphs startingWithBacon:startWithBacon];
    
    pigView = [[UIImageView alloc]initWithFrame:CGRectMake(((self.view.frame.size.width - 200)/2), (self.view.frame.size.height / 2)-50, 200, 100)];
    pigView.hidden = YES;
    pigView.image = [UIImage imageNamed:@"pig.png"];
    [self.view addSubview:pigView];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Bacon Generator

- (NSArray *)getWordsWithFiller:(BOOL)type
{
    NSArray *meat = [NSArray arrayWithObjects:@"beef", @"chicken", @"pork", @"bacon", @"chuck", @"short loin", @"sirloin", @"shank", @"flank", @"sausage", @"pork belly", @"shoulder", @"cow", @"pig", @"ground round", @"hamburger", @"meatball", @"tenderloin", @"strip steak", @"t-bone", @"ribeye", @"shankle", @"tongue", @"tail", @"pork chop", @"pastrami", @"corned beef", @"jerky", @"ham", @"fatback", @"ham hock", @"pancetta", @"pork loin", @"short ribs", @"spare ribs", @"beef ribs", @"drumstick", @"tri-tip", @"ball tip", @"venison", @"turkey", @"biltong", @"rump", @"jowl", @"salami", @"bresaola", @"meatloaf", @"brisket", @"boudin", @"andouille", @"capicola", @"swine", @"kielbasa", @"frankfurter", @"prosciutto", @"filet mignon", @"leberkas", @"turducken", @"doner", @"kevin", nil];
    NSArray *filler = [NSArray arrayWithObjects:@"consectetur", @"adipisicing", @"elit", @"sed", @"do", @"eiusmod", @"tempor", @"incididunt", @"ut", @"labore", @"et", @"dolore", @"magna", @"aliqua", @"ut", @"enim", @"ad", @"minim", @"veniam", @"quis", @"nostrud", @"exercitation", @"ullamco", @"laboris", @"nisi", @"ut", @"aliquip", @"ex", @"ea", @"commodo", @"consequat", @"duis", @"aute", @"irure", @"dolor", @"in", @"reprehenderit", @"in", @"voluptate", @"velit", @"esse", @"cillum", @"dolore", @"eu", @"fugiat", @"nulla", @"pariatur", @"excepteur", @"sint", @"occaecat", @"cupidatat", @"non", @"proident", @"sunt", @"in", @"culpa", @"qui", @"officia", @"deserunt", @"mollit", @"anim", @"id", @"est", @"laboru", nil];
    
    if (type == YES) {
        NSMutableSet *allWords = [NSMutableSet setWithArray:meat];
        [allWords addObjectsFromArray:filler];
        NSArray *orderedArray = [allWords allObjects];
        return [self shuffleArray:orderedArray];
        
    }else {
        return [self shuffleArray:meat];
    }
    
    
}

- (NSString *)makeSentenceWithFiller:(BOOL)withFiller
{
    NSString *sentence = [NSString stringWithFormat:@""];
    int length = (arc4random() % 12) + 4;
    BOOL includeComma = ((length >= 7) && ((arc4random() % 3) > 0));
    NSMutableArray *words = [NSMutableArray arrayWithArray:[self getWordsWithFiller:withFiller]];
    
    if ([words count] > 0) {
        [words replaceObjectAtIndex:0 withObject:[self ucFirst:[words objectAtIndex:0]]];
        
        for (int i = 0; i < length; i++) {
            if (i > 0) {
                if ((i >= 3) && (i != length-1) && includeComma) {
                    if ((arc4random() % 2)==1) {
                        sentence = [NSString stringWithFormat:@"%@, ",[self rTrim:sentence]];
                        includeComma = NO;
                    }else{
                        sentence = [NSString stringWithFormat:@"%@ ", sentence];
                    }
                }else{
                    sentence = [NSString stringWithFormat:@"%@ ", sentence];
                }
            }
            sentence = [NSString stringWithFormat:@"%@%@", sentence, [words objectAtIndex:i]];
        }
        sentence = [NSString stringWithFormat:@"%@. ", [self rTrim:sentence]];
    }
    return sentence;
}

- (NSString *)makeAParagraphWithFiller:(BOOL)withFiller
{
    NSString *para = [NSString stringWithFormat:@""];
    int length = (arc4random() % 4) + 4;
    
    for (int i = 0; i < length; i++) {
        para = [NSString stringWithFormat:@"%@%@ ", para, [self makeSentenceWithFiller:withFiller]];
    }
    return [self rTrim:para];
    
}

- (NSString *)makeSomeBaconWithType:(BOOL)type paragraphs:(int)p startingWithBacon:(BOOL)b
{
    NSMutableArray *paragraphs = [[NSMutableArray alloc]init];
    NSString *words = [NSString stringWithFormat:@""];
    
    for (int i = 0; i < p; i++) {
        words = [self makeAParagraphWithFiller:type];
        if ((i == 0) && startWithBacon && ([words length] > 0)) {
            words = [words lowercaseString];
            words = [NSString stringWithFormat:@"Bacon ipsum dolor sit amet %@", words];
        }
        [paragraphs addObject:words];
        words = @"";
    }
    NSString *text = [NSString stringWithFormat:@""];
    for (int x = 0; x < [paragraphs count]; x++) {
        text = [NSString stringWithFormat:@"%@%@\n\n", text, [paragraphs objectAtIndex:x]];
    }
    return text;
}

- (NSArray *)shuffleArray:(NSArray *)array
{
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithArray:array];
    NSUInteger count = [mArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [mArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return [NSArray arrayWithArray:mArray];
}

- (NSString *)ucFirst:(NSString *)string
{
    return [string stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[string substringToIndex:1] uppercaseString]];
}

- (NSString *)rTrim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:
     [NSCharacterSet whitespaceCharacterSet]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self copyText];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)copyText
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = baconView.text;
    [self showCopiedNotificationWithDelay:2.0];
}

- (void)showCopiedNotificationWithDelay:(double)delay
{
    pigView.hidden = NO;
    pigView.alpha = 1.0f;
    [UIView animateWithDuration:0.5 delay:delay options:0 animations:^{
        pigView.alpha = 0.0f;
    } completion:^(BOOL finished){
        pigView.hidden = YES;
    }];
}

@end
