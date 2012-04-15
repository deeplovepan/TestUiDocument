//
//  TestUiDocumentViewController.m
//  TestUiDocument
//
//  Created by Peter Pan on 12/4/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestUiDocumentViewController.h"
#import <CoreData/CoreData.h>

@interface TestUiDocumentViewController ()

@end

@implementation TestUiDocumentViewController

-(void)deleteObj:(NSManagedObject*)delObj
{
    [document.managedObjectContext deleteObject:delObj];
    
    [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];

}

-(void)createNewObj
{
    NSManagedObject *newObj = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:document.managedObjectContext];
    
    
    //[document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];

    
}

-(void)initDatabase
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"books"];
    document = [[UIManagedDocument alloc] initWithFileURL:url];

    if([[NSFileManager defaultManager] fileExistsAtPath:[url path]])
    {
        [document openWithCompletionHandler:^(BOOL success) {
            NSLog(@"open ok");
            [self createNewObj];

        }];
    }
    else
    {
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            NSLog(@"create %d", success); 
            [self createNewObj];
        }];
    }
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initDatabase];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
