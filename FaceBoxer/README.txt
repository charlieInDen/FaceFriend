*Setup:*

Assume a primitive social network. This social network has Members. (Full definition available in Member.h)

@interface Member : NSObject 
@property NSString *memberId;
@property NSString *name;
@property NSArray *friends;
@end

*Summary*

Display the list of available members in the MasterViewController.

Upon selecting a member, the DetailViewController should show a list of the member's friends, ordered by "degree".

Direct friends are degree 1, Friends of friends are degree 2, etc.
