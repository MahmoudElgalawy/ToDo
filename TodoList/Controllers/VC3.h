
#import <UIKit/UIKit.h>
#import "Notes.h"
NS_ASSUME_NONNULL_BEGIN

@interface VC3 : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property NSMutableArray<Notes*>*mytodoes3;
@end

NS_ASSUME_NONNULL_END
