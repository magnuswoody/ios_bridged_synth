//
//  NSObject+Oscillator.h
//  Swift Synth
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RANDOM_NUMF(MIN, MAX) MIN+arc4random_uniform(MAX-MIN+1)

// Waveform type enum
typedef NS_ENUM(NSUInteger, Waveform) {
    sine,
    triangle,
    sawtooth,
    square,
    whiteNoise
};

// Define callback type
typedef float (^Signal)(float);

NS_ASSUME_NONNULL_BEGIN

@interface Oscillator : NSObject

@property (class) float amplitude;
@property (class) float frequency;

@property (class, readonly) Signal sine;
@property (class, readonly) Signal triangle;
@property (class, readonly) Signal sawtooth;
@property (class, readonly) Signal square;
@property (class, readonly) Signal whiteNoise;

@end

NS_ASSUME_NONNULL_END
