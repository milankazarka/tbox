//
//  SportViewController.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "SportViewController.h"
#import "State.h"
#import "SportModule.h"
#import "Modules.h"

@interface SportViewController ()

@property (strong,nonatomic) NSString *clubName;
@property (strong,nonatomic) NSMutableArray *beatenClubs;

@end

@implementation SportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.beatenClubs = [[NSMutableArray alloc] init];
}

-(IBAction)onSearch:(id)sender {
    self.clubName = self.textField.text;
}

/** #todo - looping this is ineffective
 */
-(BOOL)hasBeenBeaten:(NSString*)beaten {
    for(NSString *current in self.beatenClubs) {
        if ([current isEqualToString:beaten])
            return YES;
    }
    return NO;
}

-(void)setClubName:(NSString *)clubName {
    _clubName = clubName;
    if (_clubName) {
        
        SportModule *sm = (SportModule*)[[State shared].modules getModuleClass:[SportModule class]];
        if (sm) {
            [self.beatenClubs removeAllObjects];
            
            for(NSMutableDictionary *entry in sm.entries) {
                NSString *result = [[sm.entries objectAtIndex:0] objectForKey:@"FTR"];
                NSString *homeTeam = [entry objectForKey:@"HomeTeam"];
                NSString *awayTeam = [entry objectForKey:@"AwayTeam"];
                if (!result || !homeTeam || !awayTeam)
                    continue;
                
                if ([[homeTeam lowercaseString] isEqualToString:[self.textField.text lowercaseString]]) {
                    if ([result isEqualToString:@"H"]) {
                        if (![self hasBeenBeaten:awayTeam])
                            [self.beatenClubs addObject:awayTeam];
                    }
                } else if ([[awayTeam lowercaseString] isEqualToString:[self.textField.text lowercaseString]]) {
                    if ([result isEqualToString:@"A"]) {
                        if (![self hasBeenBeaten:homeTeam])
                            [self.beatenClubs addObject:homeTeam];
                    }
                }
            }
            
            [self.tableView reloadData];
            [self.textField resignFirstResponder];
        }
        
    }
}

/** best practive would be dequeing based on identifier
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init]; // #todo - reusable views
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [self.beatenClubs objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beatenClubs.count;
}

@end
