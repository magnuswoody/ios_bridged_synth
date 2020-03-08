//
//  NSObject+Oscillator.m
//  Swift Synth
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "Oscillator.h"

@implementation Oscillator : NSObject

#pragma mark - Public Properties Definition

static float _amplitude = 1.0f; // Linear gain
static float _frequency = 440.0f; // Hz

#pragma mark - Public Properties

+(float)amplitude {
    return _amplitude;
}

+(void)setAmplitude:(float)amplitude {
    _amplitude = amplitude;
}

+(float)frequency {
    return _frequency;
}

+(void)setFrequency:(float)frequency {
    _frequency = frequency;
}

#pragma mark - Public Static Methods

+(Signal) sine {
    return ^float(float time) {
        return 0.0f;
    };
}

+(Signal) triangle {
    return ^float(float time) {
        return 0.0f;
    };
}

+(Signal) sawtooth {
    return ^float(float time) {
        return 0.0f;
    };
}

+(Signal) square {
    return ^float(float time) {
        return 0.0f;
    };
}

+(Signal) whitenoise {
    return ^float(float time) {
        return 0.0f;
    };
}

@end
