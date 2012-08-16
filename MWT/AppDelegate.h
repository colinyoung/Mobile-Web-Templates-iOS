//
//  AppDelegate.h
//  NewFramework
//
//  Created by Colin Young on 6/11/12.
//  Copyright (c) 2012 Cloudbot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    WebController *_rootVC;
    NSDictionary *_config;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) WebController *rootVC;
@property (nonatomic, retain) NSDictionary *config;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (AppDelegate*)appDelegate;

@end
