//
//  NSObject+Synth.m
//  Swift Synth
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "Synth.h"

#import <AVFoundation/AVFoundation.h>

@interface Synth()

@property (nonatomic, strong) AVAudioEngine *engine;

@end

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

# pragma mark - Public Properties
- (void)setVolume:(float)volume {
    _engine.mainMixerNode.outputVolume = volume;
}

- (float)volume {
    return _engine.mainMixerNode.outputVolume;
}

# pragma mark - Public Instance Methods

- (id)init {
    if ( self = [super init] ) {
        _engine = [[AVAudioEngine alloc] init];        
        return self;
    } else {
        return self;
    }
}

@end
