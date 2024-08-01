

#import "Notes.h"

@implementation Notes

- (nonnull instancetype)initWithName:(nonnull NSString *)name WithDescription:(nonnull NSString *)desc WithPiriorty:(NSNumber*)piriorty WithType:(NSNumber*)type WithDate:(nonnull NSDate *)date {
    if(self = [super init]){
        self.name = name;
        self.desc = desc;
        self.priorty = piriorty;
        self.type = type;
        self.date = date;
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_desc forKey:@"description"];
    [encoder encodeObject:_priorty forKey:@"piriorty"];
    [encoder encodeObject:_type forKey:@"type"];
    [encoder encodeObject:_date forKey:@"date"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)decoder {
    if(self = [super init]){
        _name = [decoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _desc = [decoder decodeObjectOfClass:[NSString class] forKey:@"description"];
        _priorty = [decoder decodeObjectOfClass:[NSNumber class] forKey:@"piriorty"];
        _type = [decoder decodeObjectOfClass:[NSNumber class] forKey:@"type"];
        _date = [decoder decodeObjectOfClass:[NSDate class] forKey:@"date"];
    }
    return self;
    
}
+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
