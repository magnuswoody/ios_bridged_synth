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
        
        // Initialize and calculate synthesis parameters
        _time = 0.01f;
        _sampleRate = format.sampleRate;
        _deltaTime = 1.0f / ((float)self.sampleRate);
        
        // Setup input format as seen in Synth.swift
        AVAudioFormat* inputFormat = [[AVAudioFormat alloc] initWithCommonFormat:format.commonFormat sampleRate:_sampleRate channels:1 interleaved:format.isInterleaved];
        
        // Make sure Engine is reset
        [_engine reset];
        
        // Add source node to routing graph
        [_engine attachNode:[self sourceNode]];
        
        // Setup audio graph node routing
        [_engine connect:_sourceNode to:_engine.mainMixerNode format:inputFormat];
        [_engine connect:_engine.mainMixerNode to:_engine.outputNode format:nil];
        _engine.mainMixerNode.outputVolume = 0.0f; // Default Behaviour muted to begin with...
        
        return self;
    } else {
        return self;
    }
}

# pragma mark - Private Properties

- (AVAudioSourceNode*)sourceNode
{
    // Lazy instantiation style
    if (_sourceNode == nil) {
        
        _sourceNode = [[AVAudioSourceNode alloc] initWithRenderBlock:
                       ^OSStatus(BOOL * _Nonnull isSilence,
                                 const AudioTimeStamp * _Nonnull timestamp,
                                 AVAudioFrameCount frameCount,
                                 AudioBufferList * _Nonnull outputData) {
            
            for (AVAudioFrameCount frame = 0; frame < frameCount; frame++) {
                for (int bufferIndex = 0; bufferIndex < outputData->mNumberBuffers; bufferIndex++) {
                    float *data = outputData->mBuffers[bufferIndex].mData;
                    data[frame] = 0.0f;
                }
            }

            return noErr;
        }];
    }

    return _sourceNode;
}
@end
