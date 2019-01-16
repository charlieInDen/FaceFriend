

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Member.h"

@interface Member_Tests : XCTestCase

@end

@implementation Member_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCount {
    XCTAssert([Member memberCount] == 100, @"Should have 100 members");
}

- (void)testLoadOne {
    NSArray *members = [Member membersInRange:NSMakeRange(0, 1)];
    XCTAssert(members.count == 1, @"Should return one member");
}

- (void)testLoadRange {
    NSArray *members = [Member membersInRange:NSMakeRange(10, 5)];
    XCTAssertEqual(5, members.count, @"Should return five members");
}

- (void)testLoadAll {
    NSArray *members = [Member membersInRange:NSMakeRange(0, [Member memberCount])];
    XCTAssertEqual([Member memberCount], members.count, @"Should return five members");
}

- (void)testLoadById {
    Member *member = [Member memberWithId:@"1"];
    XCTAssertEqualObjects(@"1", member.memberId, @"Should return one member");
}

- (void)testFriendsById {
    Member *member = [Member memberWithId:@"50"];
    XCTAssertEqualObjects(@"50", member.memberId, @"Should return one member");
    XCTAssert(member.friends.count > 0, @"Should have friends");
    for (NSString *friendId in member.friends) {
        Member *friend = [Member memberWithId:friendId];
        XCTAssert(friend, @"Should load friend with id");
    }
}

@end
