//
//  OscillatorTests.m
//  Swift SynthTests
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Oscillator.h"

@interface OscillatorTests : XCTestCase

@end

@implementation OscillatorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testAmplitudeFrequencySettableGettable {
    
    float targetFrequency = 1000; // Hz
    float targetAmplitude = 0.5; // Linear Gain
    
    Oscillator.frequency = targetFrequency;
    
    XCTAssertEqual(Oscillator.frequency, targetFrequency);
    
    Oscillator.amplitude = targetAmplitude;
    
    XCTAssertEqual(Oscillator.amplitude, targetAmplitude);
}

- (void)testSignalsAreGenerated {
    
    Signal sine = [Oscillator sine];
    XCTAssertNotNil(sine);
    
    Signal triangle = [Oscillator triangle];
    XCTAssertNotNil(triangle);
    
    Signal sawtooth = [Oscillator sawtooth];
    XCTAssertNotNil(sawtooth);
    
    Signal square = [Oscillator square];
    XCTAssertNotNil(square);
    
    Signal whitenoise = [Oscillator whiteNoise];
    XCTAssertNotNil(whitenoise);
    
}

- (void)testSineSignalPerformance {
    // Sample implementation, can be implemented for all signal types as a basic performance measure of on device processing
    Signal signal = [Oscillator sine];
    NSUInteger sampleCount = 10000;
    NSMutableArray *samples = [[NSMutableArray alloc] initWithCapacity:0];
    
    float time = 0.0f;
    float delta = 1.0f / 44100.0f;
    
    for (NSUInteger index = 0; index < sampleCount; index++) {
        [samples addObject:[NSNumber numberWithFloat:time]];
        time += delta;
    }
    
    [self measureBlock:^{
        // Measure execution of iteration and processing
        for (NSNumber* sample in samples) {
            float outputSample = 0.0f;
            outputSample = signal([sample floatValue]);
        }
    }];
}

@end
