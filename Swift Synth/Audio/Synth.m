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
@property (nonatomic, strong) AVAudioSourceNode *sourceNode;
@property (nonatomic, assign) double sampleRate;
@property (nonatomic, assign) float deltaTime;
@property (nonatomic, assign) float time;

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
        
        AVAudioFormat* format = [_engine.outputNode inputFormatForBus:0];
        
        _time = 0.01f;
        _sampleRate = format.sampleRate;
        _deltaTime = 1.0f / ((float)self.sampleRate);
        
        return self;
    } else {
        return self;
    }
}

@end
