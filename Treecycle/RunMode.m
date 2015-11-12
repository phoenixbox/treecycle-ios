//
//  RunMode.m
//  Treecycle
//
//  Created by Shane Rogers on 11/11/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

#import "RunMode.h"

@implementation RunMode

+ (BOOL)isDebug {
    
#ifdef DEBUG
    return true;
#else
    return false;
#endif
}

+ (BOOL)isProd {
    return ![self isDebug];
}

@end