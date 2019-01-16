

#import <Foundation/Foundation.h>

@interface Member : NSObject

/** the current number of members */
+(NSInteger)memberCount;

/** returns a set of members in a given range */
+(NSArray<Member *> *)membersInRange:(NSRange)range;

/** looks up a member by ID */
+(Member *)memberWithId:(NSString *)memberId;

/** the unique identifier for a given member */
@property NSString *memberId;

/** the display name for this member */
@property NSString *name;

/** contains the IDs of the member's friends */
@property NSArray<Member *> *friends;

@end
