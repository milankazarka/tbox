//
//  NewsViewController.m
//  tboxapp
//
//  Created by Milan Kazarka on 3/8/18.
//  Copyright © 2018 Rendering Pixels Limited. All rights reserved.
//

#import "NewsViewController.h"
#import "State.h"
#import "NewsModule.h"
#import "Modules.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NewsModule *nm = (NewsModule*)[[State shared].modules getModuleClass:[NewsModule class]];
    if (nm) {
        
        MWFeedItem *item = [nm.items objectAtIndex:0];
        
        self.headerLabel.text = item.title;
        self.detailLabel.text = item.summary;
        /**
        [self downloadImageWithURL:[NSURL URLWithString:item.enclosures] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded && image) {
                self.imageView.image = image;
                NSData *pngData = UIImagePNGRepresentation(image);
                if (poi.wnid) {
                    [pngData writeToFile:filePath atomically:YES]; //Write the file
                }
            }
        }];
         */
    }
}

/** move to a generic place
 */
-(void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

@end
