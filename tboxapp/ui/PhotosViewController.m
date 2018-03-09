//
//  PhotosViewController.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoTile.h"
#import "State.h"
#import "Modules.h"
#import "PhotosModule.h"

@interface PhotosViewController () <UIImagePickerControllerDelegate>
@property (strong,nonatomic) PhotoTile *selectedCell;
@property (assign,nonatomic) NSUInteger selectedIndex;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedIndex = 0;
    
    [self.collectionView registerClass:[PhotoTile class] forCellWithReuseIdentifier:@"PhotoTile"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat side = 140;
    CGFloat offset = 20;
    if (screenWidth<321) {
        side = 120.0f;
        offset = 7.0f;
    }
    [flowLayout setItemSize:CGSizeMake(side, side)];
    [flowLayout setMinimumLineSpacing:offset];
    [flowLayout setMinimumInteritemSpacing:1];
    [flowLayout setSectionInset:UIEdgeInsetsMake(offset, offset, offset, offset)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView.collectionViewLayout = flowLayout;
}

/** in high-sight this could be done in a simpler way - for the sake of simplicity I did it so that I do a blank refresh of all views
 */
-(void)onStateUpdated {
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PhotoTile";
    
    PhotoTile *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImage *image = [(PhotosModule*)[[State shared].modules getModuleClass:[PhotosModule class]] imageAtCellIndex:indexPath.row];
    if (!image)
        image = [UIImage imageNamed:@"Plus_button.png"];
    cell.imageView.image = image;
    
    /**
    NSString* documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString* foofile = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"picked%ld.png",(long)indexPath.row]];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    if (fileExists) {
        cell.imageView.image = [UIImage imageWithContentsOfFile:foofile];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"Plus_button.png"];
    }
    */
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCell = (PhotoTile*)[self.collectionView cellForItemAtIndexPath:indexPath];
    self.selectedIndex = indexPath.row;
    [self library];
}

- (void)library {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    [picker setDelegate:self];
    
    [self presentViewController:picker animated:YES completion:nil];
}

/**
 #todo - should be in an independent class / extention - move
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"chose image");
    [picker dismissViewControllerAnimated:YES completion:nil];
    image = [PhotosViewController imageWithImage:image scaledToSize:CGSizeMake(280.0f, 280.0f)];
    self.selectedCell.imageView.image = image;
    
    // data processing & extract in the module - if there's instances where we do data operations here than that's a todo
    
    [(PhotosModule*)[[State shared].modules getModuleClass:[PhotosModule class]] storeImage:image atCellIndex:self.selectedIndex];
}

@end
