

#import <UIKit/UIKit.h>
#import "Member.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Member * detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

