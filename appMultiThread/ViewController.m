//
//  ViewController.m
//  appMultiThread
//
//  Created by TNKHANH on 12/25/16.
//  Copyright © 2016 TNKHANH. All rights reserved.
//

#import "ViewController.h"

@interface UIView(Custom)
-(void)addConstraintsWithFormat:(NSString *)format andViews:(NSArray *)views;
@end

@interface ViewController ()

@end

@implementation ViewController
{
    UIButton *butStarLoadImage;
    UIImageView *imgV;
    UIImage *image;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    butStarLoadImage = [[UIButton alloc] init];
    [butStarLoadImage addTarget:self action:@selector(loadImage) forControlEvents:UIControlEventTouchUpInside];
    butStarLoadImage.backgroundColor = [UIColor yellowColor];
    

    
    imgV = [[UIImageView alloc] init];
    imgV.backgroundColor = [UIColor blackColor];
    
    //NSURL *url2 = [[NSURL alloc] initWithString:@"http://imbaggaarm.esy.es/ios_10_wallpaper-009.jpg"];
    
    //UIImage *image2 = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:url2]];
    
    //UIImageView *imgV2 = [[UIImageView alloc] initWithImage:image2];
    UIButton *checkButton = [[UIButton alloc] init];
    checkButton.backgroundColor = [UIColor whiteColor];
    [checkButton addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:imgV];
    [self.view addSubview:butStarLoadImage];
    [self.view addSubview:checkButton];
    //[self.view addSubview:imgV2];
    
    [self.view addConstraintsWithFormat:@"V:|-100-[v0(300)]-10-[v1(40)]-10-[v2(40)]"andViews:@[imgV, butStarLoadImage, checkButton]];
    [self.view addConstraintsWithFormat:@"H:|-20-[v0]-20-|"andViews:@[imgV]];
    [self.view addConstraintsWithFormat:@"H:|-20-[v0]-20-|"andViews:@[butStarLoadImage]];
    [self.view addConstraintsWithFormat:@"H:|-20-[v0]-20-|"andViews:@[checkButton]];
    //[self.view addConstraintsWithFormat:@"H:|-20-[v0]-20-|"andViews:@[imgV2]];
    
    
    
    

    
}
-(void)loadImage
{
    NSLog(@"CHECK");
    [NSThread detachNewThreadSelector:@selector(handleThreadLoadImage) toTarget:self withObject:nil];
}

-(void)handleThreadLoadImage
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://imbaggaarm.esy.es/image/Unknown.jpeg"];
    image = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:url]];
    //[self performSelector:@selector(mainTheardWithImage) withObject:nil afterDelay:0];
    [NSThread sleepForTimeInterval:3];
    [self performSelectorOnMainThread:@selector(mainTheardWithImage) withObject:nil waitUntilDone:false];
}
-(void)mainTheardWithImage
{
    imgV.image = image;
}

-(void)checkButtonClick
{
    NSLog(@"hefdksfjkldsjfklds");
}

/*-(void)handleLoadImageWithConcurrent: (BOOL) concurrent
{
    dispatch_queue_t aQueue;
    if (concurrent)
    {
        aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    else
    {
        aQueue = dispatch_queue_create("com.imbaggaarm.appMultiThread",
*/




#pragma mark operation queue

-(void)handleLoadImageWithBlock: (BOOL) block
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    if (!block)
    {
        
        // do something concurrently
        [queue addOperationWithBlock:^{
           
            
            
            
            
            if(true)
            {
                //update UI
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                   // update something;
                }];
            }
            
            
            //
            
            
            
            
        }];
    }
    else
    {
        
        
        NSOperation *operation0 = [NSBlockOperation blockOperationWithBlock:^{
            //
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               //update UI
                
                
                
                
                
            }];
            
            
        }];
        
        NSOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
          
            
            
        }];
        
        
        //[operation0 addDependency:operation1];
        // if waitUntilFinished is true, it just like ...
        [queue addOperations:@[operation0, operation1] waitUntilFinished:true];
    }
}
-(void) handleStopLoad
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //cancel all operations
    //[queue cancelAllOperations];
    
    
    
    //cancel operation
    NSArray *arrayOfOperation = [queue operations];
    NSOperation *temp = [arrayOfOperation objectAtIndex:2];
    [temp cancel];


}

@end
 


@implementation UIView(Custom)
-(void)addConstraintsWithFormat:(NSString *)format andViews:(NSArray *)views
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    for (UIView *view in views)
    {
        view.translatesAutoresizingMaskIntoConstraints = false;
        NSString *key = [NSString stringWithFormat:@"v%li",(long int)[views indexOfObject:view]];
        [dic setObject:view forKey: key];
    }
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:dic]];
}

@end
