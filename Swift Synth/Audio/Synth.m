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
@property (nonatomic, copy) Signal signal;

@end

@implementation Synth : NSObject

#pragma mark - Public Static Methods

+ (instancetype)shared
{
    static dispatch_once_t dispatcher_once;
    static id sharedInstance;
    dispatch_once(&dispatcher_once, ^{
        sharedInstance = [[self alloc] initWithSignal:[Oscillator sine]];
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

- (void)setWaveformTo: (Signal) signal {
    _signal = signal;
}

# pragma mark - Public Instance Methods

- (id)initWithSignal:(Signal)signal {
    if ( self = [super init] ) {
        _engine = [[AVAudioEngine alloc] init];
        
        AVAudioFormat* format = [_engine.outputNode inputFormatForBus:0];
        
        // Initialize and calculate synthesis parameters
        _time = 0.01f;
        _sampleRate = format.sampleRate;
        _deltaTime = 1.0f / ((float)self.sampleRate);
        _signal = signal != nil ? signal : ^float(float time) {
            return 0.0f;
        };
        
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
        
        // Prepare for audio start with allocation
        [_engine prepare];
        
        NSError *error = nil;
        BOOL didStart = [_engine startAndReturnError:&error];
        
        if (didStart == YES) {
            NSLog(@"Successfully started the audioEngine!");
        } else {
            NSLog(@"Could not start audioEngine: %@", [error debugDescription]);
        }
        
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
        
        __weak Synth* selfWeakRef = self;
        
        _sourceNode = [[AVAudioSourceNode alloc] initWithRenderBlock:
                       ^OSStatus(BOOL * _Nonnull isSilence,
                                 const AudioTimeStamp * _Nonnull timestamp,
                                 AVAudioFrameCount frameCount,
                                 AudioBufferList * _Nonnull outputData) {
            
            // Strong ownership for separate threaded callback reference
            __strong Synth* selfStrongRef = selfWeakRef;
            
            for (AVAudioFrameCount frame = 0; frame < frameCount; frame++) {
                
                // Caculate output waveform for frame and increment time
                float processedSample = self->_signal(selfStrongRef.time);
                selfStrongRef.time += selfStrongRef.deltaTime;
                
                for (int bufferIndex = 0; bufferIndex < outputData->mNumberBuffers; bufferIndex++) {
                    
                    // Locate buffer pointer and write calculated value to output buffer
                    float *data = outputData->mBuffers[bufferIndex].mData;
                    data[frame] = processedSample;
                }
            }

            return noErr;
        }];
    }

    return _sourceNode;
}
@end
