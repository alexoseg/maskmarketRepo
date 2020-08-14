//
//  UIColor+AppColors.m
//  maskmarket
//
//  Created by Alex Oseguera on 7/27/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "UIColor+AppColors.h"

@implementation UIColor (AppColors)

+ (UIColor *)primaryAppColor
{
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:38.0f/255.0f
                                green:184.0f/255.0f
                                 blue:153.0f/255.0f
                                alpha:1.0f];
    });
    
    return color;
}

+ (UIColor *)primaryAppColorAlpha0
{
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:38.0f/255.0f
                                green:184.0f/255.0f
                                 blue:153.0f/255.0f
                                alpha:0.0f];
    });
    
    return color;
}

+ (UIColor *)popUpViewBackgroundAlpha0
{
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:0.5
                                green:0.5
                                 blue:0.5
                                alpha:0.0];
    });
    
    return color;
}

+ (UIColor *)popUpViewBackgroundAlphaHalf
{
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:0.5
                                green:0.5
                                 blue:0.5
                                alpha:0.5];
    });
    
    return color;
}

+ (UIColor *)borderColorGrey
{
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:0.85
                                green:0.85
                                 blue:0.85
                                alpha:1.0];
    });
    
    return color;
}

+ (UIColor *)orangeViewBackgroundColor
{
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:255.0f/255.0f
                                green:204.0f/255.0f
                                 blue:153.0f/255.0f
                                alpha:1.0];
    });
    
    return color;
}

+ (UIColor *)orangeLabelColor
{
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:255.0f/255.0f
                                green:102.0f/255.0f
                                 blue:0.0f/255.0f
                                alpha:1.0];
    });
    
    return color;
}

+ (UIColor *)greenViewBackgroundColor
{
    
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:0.0f/255.0f
                                green:153.0f/255.0f
                                 blue:51.0f/255.0f
                                alpha:0.2];
    });
    
    return color;
}

+ (UIColor *)greenLabelColor
{
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:0.0f/255.0f
                                green:153.0f/255.0f
                                 blue:51.0f/255.0f
                                alpha:1.0];
    });
    
    return color;
}

+ (UIColor *)redViewBackgroundColor
{
    
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:219.0f/255.0f
                                green:22.0f/255.0f
                                 blue:47.0f/255.0f
                                alpha:0.2];;
    });
    
    return color;
}

+ (UIColor *)redLabelColor
{
    
    static UIColor *color = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        color = [UIColor colorWithRed:219.0f/255.0f
                                green:22.0f/255.0f
                                 blue:47.0f/255.0f
                                alpha:1.0];
    });
    
    return color;
}

@end
