//
//  AlertMenuController.h
//  ToDoList
//
//  Created by Nikolay Dementiev on 09.12.16.
//  Copyright © 2016 mc373. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertMenuController : NSObject

- (void)initAlertControllerForList;
- (instancetype)initWithOwnerViewController:(UIViewController *)viewController;

@end