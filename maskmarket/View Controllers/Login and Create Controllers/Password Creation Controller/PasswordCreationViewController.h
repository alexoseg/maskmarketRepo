//
//  PasswordCreationViewController.h
//  maskmarket
//
//  Created by Alex Oseguera on 8/4/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface PasswordCreationViewController : UIViewController

@property (nonatomic, strong) UserBuilder *userBuilder;

@end

NS_ASSUME_NONNULL_END
