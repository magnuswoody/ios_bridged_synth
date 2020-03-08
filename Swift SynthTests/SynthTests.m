//
//  SynthTests.m
//  Swift SynthTests
//
//  Created by Magnus Woodgate on 08/03/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Synth.h"

@interface SynthTests : XCTestCase

@end

@implementation SynthTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testSharedInstanceIsInstantiated {
    Synth* ref = [Synth shared];
    XCTAssertNotNil(ref);
}


@end
