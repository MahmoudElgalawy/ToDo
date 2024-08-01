

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Notes : NSObject<NSCoding,NSSecureCoding>

@property NSString *name;
@property NSString *desc;
@property NSNumber* priorty;
@property NSNumber* type;
@property NSDate *date;
-(instancetype)initWithName:(NSString*)name WithDescription:(NSString*)desc WithPiriorty:(NSNumber*)priorty WithType:(NSNumber*)type WithDate:(NSDate*)date;
- (void)encodeWithCoder:(nonnull NSCoder *)encoder;
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)decoder;
@end

NS_ASSUME_NONNULL_END
