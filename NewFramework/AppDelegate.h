//
//  AppDelegate.h
//  NewFramework
//
//  Created by Colin Young on 6/11/12.
//  Copyright (c) 2012 Cloudbot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteWebViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    RemoteWebViewController *_rootVC;
    NSDictionary *_config;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) RemoteWebViewController *rootVC;
@property (nonatomic, retain) NSDictionary *config;

- (void)addSetupBlock:(Block)block;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
