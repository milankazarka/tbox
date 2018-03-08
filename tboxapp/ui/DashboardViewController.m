//
//  DashboardViewController.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "DashboardViewController.h"
#import "State.h"
#import "Modules.h"
#import "ModuleTile.h"
#import "Module.h"
#import "ModuleSegues.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

-(void)showWelcome {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Message"
                                  message:@"Good day Swapnil"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [alert addAction:okAction];
    UIViewController *vc = self;
    [vc presentViewController:alert animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[ModuleTile class] forCellWithReuseIdentifier:@"ModuleTile"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat side = 150;
    CGFloat offset = 20;
    if (screenWidth<321) {
        side = 142.0f;
        offset = 7.0f;
    }
    [flowLayout setItemSize:CGSizeMake(side, side)];
    [flowLayout setMinimumLineSpacing:offset];
    [flowLayout setMinimumInteritemSpacing:1];
    [flowLayout setSectionInset:UIEdgeInsetsMake(offset, offset, offset, offset)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView.collectionViewLayout = flowLayout;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //[self showWelcome]; // in logout / login would need to be changed
    });
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onStateUpdated)
                                                 name:@"onLocationUpdated" object:nil];
    [self.collectionView reloadData];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** in high-sight this could be done in a simpler way - for the sake of simplicity I did it so that I do a blank refresh of all views
 */
-(void)onStateUpdated {
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [State shared].modules.modules.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ModuleTile";
    
    ModuleTile *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.module = [[State shared].modules.modules objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Module *module = [[State shared].modules.modules objectAtIndex:indexPath.row];
    NSString *pushs = [ModuleSegues detailScreenSequeForModule:module];
    if (pushs) {
        [self performSegueWithIdentifier:pushs sender:self];
    }
}

@end
