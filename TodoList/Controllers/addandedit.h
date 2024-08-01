

#import <UIKit/UIKit.h>
#import "Notes.h"
#import "VC1.h"
NS_ASSUME_NONNULL_BEGIN

@interface addandedit : UIViewController
@property NSMutableArray<Notes*>* todoes;
@property (weak, nonatomic) IBOutlet UIImageView *imgpriorty;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentPriority;
@property Notes *mytodo1;
@property Notes *mytodo2;
@property bool isCreating;
@property NSUserDefaults *defaults;
@property NSInteger index;

-(void) setSegmented;
-(void) setSegmented2;
-(void) setSegmented3;
@end

NS_ASSUME_NONNULL_END
