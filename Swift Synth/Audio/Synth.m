//
//  NSObject+Synth.m
//  Swift Synth
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "Synth.h"

@implementation Synth : NSObject

#pragma mark - Public Static Methods

+ (instancetype)shared
{
    static dispatch_once_t dispatcher_once;
    static id sharedInstance;
    dispatch_once(&dispatcher_once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
