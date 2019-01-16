

#import "Member.h"

static const NSString *kMemberIdKey = @"MemberId";
static const NSString *kMemberNameKey = @"MemberName";
static const NSString *kMemberFriendsKey = @"MemberFriends";

@implementation Member

static NSArray *_memberList;
static NSArray *_memberIds;

+(NSArray<Member *>*)memberList {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"member_list" ofType:@"plist"];
        NSArray *fileData = [[NSArray alloc] initWithContentsOfFile:filePath];
        NSAssert(fileData, @"Should always load file data");

        // loading all members
        NSMutableArray *memberList = [NSMutableArray arrayWithCapacity:fileData.count];
        for (NSDictionary *dict in fileData) {
            Member *member = [Member memberWithDictionary:dict];
            if (member) {
                [memberList addObject:member];
            }
        }

        // store them for later
        _memberList = memberList;
    });
    return _memberList;
}

+(NSInteger)memberCount {
    return [self memberList].count;
}

+(NSArray<Member *> *)membersInRange:(NSRange)range {
    NSAssert(range.location >= 0, @"Range must be positive");
    NSAssert(range.location+range.length <= [self memberCount], @"Range out of bounds");

    NSMutableArray *toReturn = [NSMutableArray arrayWithCapacity:range.length];
    NSArray *members = [self memberList];
    for (NSInteger i = range.location; i < range.location+range.length; i++) {
        [toReturn addObject: members[i]];
    }
    return toReturn;
}

+(Member *)memberWithId:(NSString *)memberId {
    // index them by ID
    static NSDictionary *_memberIds;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *memberIds = [NSMutableDictionary dictionaryWithCapacity:[self memberCount]];
        for (Member *member in [self memberList]) {
            memberIds[member.memberId] = member;
        }
        _memberIds = memberIds;
    });

    return _memberIds[memberId];
}

+(instancetype)memberWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.memberId = dict[kMemberIdKey];
        self.name = dict[kMemberNameKey];
        self.friends = dict[kMemberFriendsKey];
    }
    return self;
}

@end
