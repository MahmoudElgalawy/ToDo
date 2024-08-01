

#import <UIKit/UIKit.h>
#import "Notes.h"
NS_ASSUME_NONNULL_BEGIN

@interface VC1 : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewVc1;
@property NSMutableArray<Notes*>* mytodoes1;
@end

NS_ASSUME_NONNULL_END
