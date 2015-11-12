//
//  RunMode.h
//  Treecycle
//
//  Created by Shane Rogers on 11/11/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunMode : NSObject

+ (BOOL)isDebug;
+ (BOOL)isProd;

@end
