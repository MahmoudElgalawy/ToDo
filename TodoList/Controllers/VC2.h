

#import <UIKit/UIKit.h>
#import "Notes.h"
NS_ASSUME_NONNULL_BEGIN

@interface VC2 : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property NSMutableArray<Notes*>* mytodoes2;

@end

NS_ASSUME_NONNULL_END
