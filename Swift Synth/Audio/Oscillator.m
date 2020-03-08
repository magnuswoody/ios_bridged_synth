//
//  Oscillator.m
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
        return _amplitude * sin(2.0 * ((float)M_PI) * _frequency * time);
    };
}

+(Signal) triangle {
    return ^float(float time) {
        
        double period = 1.0 / (double)Oscillator.frequency;
        double currentTime = fmod((double)time, period);
        double value = currentTime / period;
        double result = 0.0;

        if (value < 0.25) {
            result = value * 4.0;
        } else if (value < 0.75) {
            result = 2.0 - (value * 4.0);
        } else {
            result = value * 4.0 - 4.0;
        }
        
        // Compact format, but how readable is it really?
        // result = value < 0.25 ? value * 4 : (value < 0.75 ? 2.0 - (value * 4.0) : value * 4 - 4.0);
        
        return Oscillator.amplitude * (float)result;
    };
}

+(Signal) sawtooth {
    return ^float(float time) {
        double period = 1.0 / (double)Oscillator.frequency;
        double currentTime = fmod((double)time, (double)period);
        return Oscillator.amplitude * ((((float)currentTime) / period) * 2 - 1.0);
    };
}

+(Signal) square {
    return ^float(float time) {
        double period = 1.0 / (double)Oscillator.frequency;
        double currentTime = fmod((double)time, period);
        return ((currentTime / period) < 0.5) ? Oscillator.amplitude : -1.0 * Oscillator.amplitude;
    };
}

+(Signal) whiteNoise {
    return ^float(float time) {
        return RANDOM_NUMF(-1.0f, 1.0f) * Oscillator.amplitude;
    };
}

@end
